# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

SIGEVH (Sistema de Gestión de Venta de Helados) — a 2011 UNMSM "Diseño de Sistemas" course project, now kept alive as a legacy-modernization training ground. Domain: managing ice cream sellers (`heladeros`) who get a daily inventory assignment from a concessionaire (`concesionario`), sell through the day, return what's unsold, and get paid for what sold.

Stack: JSF 1.2 + RichFaces 3.3 (JSP views), Hibernate 6.6 (JPA annotations on the entity classes, no `.hbm.xml` — migrated off XML mappings) over MySQL 8, static service/DAO layers, Maven WAR packaging, Tomcat 7 (via `tomcat7-maven-plugin`).

Modernization principle for this repo: favor small, reversible improvements over rewrites; protect the daily assignment/payment lifecycle with tests before changing its behavior; reduce static/global coupling gradually.

## Commands

```
mvn clean verify              # full build: compile, test, jacoco coverage report
mvn test                      # run all tests
mvn test -Dtest=HeladoServiceTest                       # single test class
mvn test -Dtest=HeladoServiceTest#obtenerHeladoPorNombreWithFilterTest  # single test method
mvn org.apache.tomcat.maven:tomcat7-maven-plugin:run    # run the app locally (deploys at /SIGEVH, HTTPS on 8443 via tomcat/keystore)
```

Database (required for the app and for several tests that hit a real DB instead of mocking — see Testing below):

```
docker run --name mysql-ice-creams-providers -p 3306:3306 -e MYSQL_DATABASE=heladeros -e MYSQL_ROOT_PASSWORD=rootroot -e TZ='America/Lima' -d mysql:8.0
docker exec -i mysql-ice-creams-providers mysql -uroot -prootroot < database/heladeros.sql
docker exec mysql-ice-creams-providers mysql -uroot -prootroot -e "CREATE USER IF NOT EXISTS 'travis'@'%'; GRANT ALL PRIVILEGES ON *.* TO 'travis'@'%'; FLUSH PRIVILEGES;"
```

`src/main/resources/hibernate.cfg.xml` points at `jdbc:mysql://localhost:3306/heladeros` with user `travis` and no password — this is CI-era config checked into source (see Known legacy issues). The schema/data dump (`database/heladeros.sql`) is a MySQL Workbench export that runs cleanly on MySQL 8 (only harmless deprecation warnings: `ZEROFILL`, integer display widths, `utf8`-as-alias-for-`utf8mb3`) — don't assume it needs fixing before loading it.

CI (`.travis.yml`) runs `mvn clean verify` against JDK 8 and provisions the DB from `database/heladeros.sql` via Travis's own hosted MySQL service (not Docker) — that service's MySQL version is independent of the local Docker setup above.

## Architecture

Layering is strict and one-directional: **JSF managed bean (controller) → static service → static DAO → Hibernate `Session`**. There is no DI container; services and DAOs are plain classes with `private static final` collaborator instances, instantiated directly (e.g. `HeladeroService` holds its own `HeladeroDAO` and `ContratoHeladeroDAO`).

- `controller/` — JSF managed beans, registered in `src/main/webapp/WEB-INF/faces-config.xml`, all session-scoped. `BaseManager` is the common superclass providing the concessionaire dropdown. `controller/modal/` holds the two workflow beans (`ManagerAsignacion`, `ManagerPago`) that back the daily assignment/payment modals.
- `service/` — business logic as `final` classes with only static methods; reads the logged-in user out of the HTTP session via `SessionUtils` to scope queries by role (`RoleType.ADMIN` sees everything, `RoleType.MANAGER` is scoped to their own `Concesionario`).
- `dao/` — one Hibernate `Session` opened and closed per method call (`AppUtil.getSessionFactory().openSession()` in a try/finally); queries are built as HQL strings, not Criteria or JPQL typed queries.
- `domain/mapping/` — Hibernate entity classes, mapped with `jakarta.persistence` annotations directly on the fields (field-based access), registered in `hibernate.cfg.xml` via `<mapping class="..."/>` entries. Field names (not column names) are what HQL strings in the DAOs reference, so renaming a field means updating every HQL string that touches it. Watch for two non-obvious carryovers from the old `.hbm.xml` mappings: JPA's `@ManyToOne` defaults to `EAGER` where the legacy mapping defaulted to `LAZY` unless it said `lazy="false"` — every `@ManyToOne` here sets `fetch` explicitly to match the original behavior, don't let a new association silently default to eager. And `DetalleHelado.position`/`DetalleHelado.hasStock` are `@Transient` — they were never mapped in the old `.hbm.xml` either, they're UI-only scratch fields.
- `domain/dto/` — view-facing DTOs assembled by services (e.g. `ContratoHeladeroDTO` bundles a contract with a computed `active` flag).
- `util/` — `AppUtil` (SessionFactory singleton + date helpers), `SessionUtils` (HttpSession accessor), `HibernateListener` (`ServletContextListener` that opens/closes the SessionFactory with the webapp lifecycle).

### Daily assignment/payment lifecycle (the core domain flow — handle with care)

1. `ManagerHeladero` lists/selects a seller.
2. `ManagerAsignacion.loadAssignation` opens the assignment modal when the seller has no assignment for today.
3. `ManagerAsignacion.addIceCream` builds in-memory `DetalleHelado` rows, including pending quantities carried over from the previous day.
4. `ManagerAsignacion.saveAssignations` checks stock, deducts stock, and creates a `HeladosEntregadoRecibido` header with detail rows — **stock deduction and assignment creation are not currently atomic** (separate transactions); don't assume a DB-level guarantee here.
5. `ManagerPago.pagarHeladero` loads today's assignment and opens the payment modal if it hasn't been paid yet.
6. `ManagerPago.realizarPago` validates returned quantities (≤ assigned), computes sold = assigned − returned, and creates the `PagoHelado` (sold × price per item).

Invariants to preserve when touching this flow: one open assignment per `heladero` per day; assigned ≤ available stock; returned ≤ assigned; payment = Σ(sold × price). There's no visible unique DB constraint on `(id_heladero, fecha)` backing the "one assignment per day" rule — it's enforced only in application code.

Domain vocabulary: `Heladero` seller · `Concesionario` concessionaire/branch owner · `ContratoHeladero` seller-concessionaire contract · `Helado` product · `StockHelado` inventory quantity · `HeladosEntregadoRecibido` daily assignment header · `DetalleHelado` per-product assigned/returned/sold quantities · `PagoHelado` computed payment.

## Testing

JUnit 4 + Mockito (`MockitoJUnitRunner`), JaCoCo for coverage. PowerMock has been removed from the dependency set (it conflicted with modern JDKs via its static/final mocking hooks) — new tests should use plain Mockito; don't reintroduce PowerMock.

Two different styles coexist, don't assume one:
- Controller tests (`controller/**/*Test.java`) mock JSF plumbing (`ActionEvent`, `UIComponent`, `UIParameter`) and stub domain objects via `pe.lamborgini.DomainStubs`.
- Some service tests (e.g. `HeladoServiceTest`) call the static service directly with **no mocking** and assert against real row counts — these require the seeded `heladeros` database to be reachable per the hibernate config above, or they'll fail/return empty results rather than erroring clearly.

`DomainStubs` is the shared fixture factory for domain objects (users by role, ice cream details, etc.) — extend it instead of hand-rolling entity setup in new tests.

**Known flaky test tied to a freshly-seeded DB:** `database/heladeros.sql` includes a script block (`-- begin attached script 'script'`) that inserts a `helados_entregado_recibido` row dated `CURDATE()` for *every* seller at import time — so right after loading the dump, every seller appears to have "an assignment for today." `ManagerPagoTest.openModalForIceCreamsPaymentWithoutAssignationTest` assumes seller 200 has *no* assignment today and asserts null; it only passes on a DB that was seeded on a previous day. On a same-day fresh load (new contributor, CI, a rebuilt container) it fails — this is pre-existing and not something introduced by the MySQL 8/JPA migration; don't try to silently patch it unless asked.

## Known legacy issues (don't "fix" silently — these are tracked modernization targets)

- `src/main/resources/hibernate.cfg.xml` has hardcoded DB connection info and `hibernate.show_sql=true` committed to source; the keystore password in `pom.xml`'s tomcat plugin config is likewise hardcoded.
- `ManagerHeladero`'s contract save/update is a stub that only logs — contract lifecycle (create/edit) is intentionally incomplete.
- Assignment/payment session beans are session-scoped and hold mutable workflow state, which can leak across tabs/stale sessions.
- CI (`.travis.yml`) still targets JDK 8; locally the project needs JDK 14+ (the compiler is pinned to `--release 14` in `pom.xml`) — JDK 11 fails the build with "release version 14 not supported." Hibernate is already on 6.6 and PowerMock has been removed, so the Java-21-incompatibility concerns from early modernization notes (Hibernate 3/Javassist reflection, PowerMock) no longer apply; JDK 14 or 21 both build and test cleanly against MySQL 8.
- After an interrupted/second `mvn test` run, JaCoCo can fail with "Cannot process instrumented class ... supply original non-instrumented classes" because `target/classes` still holds instrumented `.class` files from a prior run — use `mvn clean test`, not bare `mvn test`, when re-running.
