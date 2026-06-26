# First Review And Improvement Opportunities

Reviewed on 2026-06-24.

## Priority Findings

1. `ManagerPago.pagarHeladero` can fail before showing the "missing assignment" message.
   - File: `src/main/java/pe/lamborgini/controller/modal/ManagerPago.java`
   - Line: 70
   - Why: `existeAsignacionParaHeladero(paramIceCreamManId).get(0)` is called before checking whether a result exists. If the list is empty, the UI gets an `IndexOutOfBoundsException` instead of the expected alert.
   - First fix: store the list, check `isEmpty()`, then read the first assignment.

2. Daily assignment is not atomic across stock deduction and assignment creation.
   - Files: `ManagerAsignacion.java`, `HeladoService.java`, `StockHeladoDAO.java`, `HeladosEntregadoRecibidoDAO.java`
   - Lines: `ManagerAsignacion.java:213-214`, `HeladoService.java:90`, `HeladosEntregadoRecibidoDAO.java:48`
   - Why: stock is updated in one transaction and the assignment header/details are saved in another. If the second save fails, stock remains deducted without an assignment.
   - First fix: introduce a service-level transaction that checks stock, deducts stock, and saves assignment together.

3. Duplicate daily assignments are race-prone.
   - File: `src/main/java/pe/lamborgini/controller/modal/ManagerAsignacion.java`
   - Lines: 121, 213-214
   - Why: the UI checks for today's assignment before saving, but there is no visible unique database constraint or transactional guard for `(id_heladero, fecha)`.
   - First fix: add a database unique constraint and handle duplicate-key failures with a friendly message.

4. Contract lifecycle is incomplete.
   - File: `src/main/java/pe/lamborgini/controller/ManagerHeladero.java`
   - Line: 106
   - Why: `saveOrUpdate` currently only logs. This blocks proper seller/contract maintenance, which is part of the stated core domain.
   - First fix: define the expected create/edit flow, then add service and controller tests before implementation.

5. Runtime configuration and secrets are committed.
   - Files: `src/main/resources/hibernate.cfg.xml`, `pom.xml`
   - Lines: `hibernate.cfg.xml:10-12`, `pom.xml:213`
   - Why: DB URL/user/password and keystore password are hardcoded; `show_sql=true` may expose data in logs.
   - First fix: parameterize via Maven profiles, environment variables, or external config. Disable SQL logging by default.

6. Session-scoped JSF managed beans hold mutable workflow state.
   - File: `src/main/webapp/WEB-INF/faces-config.xml`
   - Lines: 13, 18, 23, 28, 33
   - Why: assignment/payment form state can leak across browser tabs or stale sessions.
   - First fix: move modal workflow state toward request/view scope where possible, or add explicit reset paths and tests for stale state.

7. The current local test pathway is broken on Java 21.
   - Files: `pom.xml`, PowerMock-based controller tests, Hibernate 3/Javassist runtime.
   - Evidence: `mvn clean test` fails before/inside controller tests with PowerMock `IllegalAccessError` against `jdk.internal.reflect.MagicAccessorImpl`, and Hibernate/Javassist logs `InaccessibleObjectException` for `java.lang.ClassLoader.defineClass`.
   - Why: PowerMock 1.7.4 and Hibernate 3.x proxy generation are not friendly to the Java module system used by modern JDKs.
   - First fix: either pin the developer/test JDK to Java 8 for the legacy lane, or add explicit Surefire `--add-opens` flags as a temporary bridge while reducing PowerMock/static coupling.

## Engineering Opportunities

- Replace static service/DAO dependencies incrementally with injectable collaborators to reduce PowerMock reliance.
- Add integration tests around assignment and payment using a controlled database fixture.
- Add a Docker Compose workflow for MySQL plus schema/data bootstrap.
- Split business rules from JSF controllers so lifecycle behavior can be tested without UI event mocks.
- Add a dependency/security audit workflow, with legacy exceptions documented.
- Create ADRs for each modernization step so training developers can see the reasoning, not only the resulting code.

## Suggested Starting Slice

Start with the payment empty-assignment bug because it is small, user-visible, and easy to protect with a unit test. Then address assignment atomicity, because it protects inventory correctness and will force a useful service-layer design improvement.
