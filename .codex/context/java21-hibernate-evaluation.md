# Java 21 And Hibernate Modernization Evaluation

Reviewed on 2026-06-24.

## Recommendation

Use a staged migration:

1. Stabilize a Java 21 developer/test lane while keeping the existing JSF 1.2 UI unchanged.
2. Remove Java 21 blockers from tests and runtime, especially PowerMock and Hibernate 3/Javassist.
3. Upgrade Hibernate behind the current service/DAO boundary.
4. Rewrite the small DAO query set to modern Hibernate APIs.
5. Only after backend stability, evaluate whether the UI should remain JSF 1.2 or move to a newer presentation layer.

This is a reasonable project because the application is small and the persistence surface is limited.

## Why Java 21 First Is Plausible

JSF 1.2 and Hibernate are not directly coupled in this codebase. The UI talks to managed beans/controllers, controllers call services, and services call DAOs. That boundary lets the backend persistence layer evolve without rewriting JSP/RichFaces pages first.

The risk is runtime compatibility, not application design. JSF 1.2, RichFaces 3.3, Tomcat 7 tooling, Hibernate 3, Javassist, and PowerMock are all old enough to run into Java module-system and reflection restrictions on Java 21.

## Current Java 21 Blockers Observed

- `mvn clean test` runs on Java 21.0.8 but fails in PowerMock controller tests with `IllegalAccessError` involving `jdk.internal.reflect.MagicAccessorImpl`.
- Hibernate 3/Javassist logs `InaccessibleObjectException` while trying to access `ClassLoader.defineClass`.
- The POM still uses `tomcat7-maven-plugin`, which is not a good Java 21 runtime target.

## Hibernate Upgrade Options

### Option A: Hibernate 5.6 Bridge

Pros:
- Closer to current `javax.*` era.
- Smaller conceptual jump from Hibernate 3.
- Can be useful as an intermediate step if we want less migration shock.

Cons:
- End-of-life according to Hibernate release listings.
- Still not the target architecture for a long-lived Java 21 lane.
- May still require query and bootstrapping changes.

### Option B: Hibernate 6.6 Bridge

Pros:
- Official compatibility matrix lists Hibernate ORM 6.6 with Java 11, 17, 21, and newer supported JDKs depending on patch level.
- Current limited-support line.
- Good target if we want Java 21 without jumping to the newest Hibernate 7 APIs.

Cons:
- Jakarta Persistence 3.1 means `jakarta.persistence` rather than `javax.persistence` if annotations/JPA APIs are introduced.
- Legacy Hibernate Criteria API is gone, so DAOs must move to HQL, JPA Criteria, or modern native queries.

### Option C: Hibernate 7.x Target

Pros:
- Newest stable line according to Hibernate releases.
- Java 17+ baseline and Jakarta Persistence 3.2.

Cons:
- Bigger jump from Hibernate 3.
- Less conservative for a training modernization path.
- More likely to introduce unrelated migration noise before the core lifecycle is protected.

## Local DAO Migration Surface

Legacy APIs found:

- `org.hibernate.Criteria`
- `org.hibernate.criterion.Restrictions`
- `org.hibernate.classic.Session`
- `Session#createCriteria`
- `Session#createSQLQuery`
- `org.hibernate.Query`
- `Hibernate.INTEGER` / `Hibernate.STRING` scalar types

Primary DAO files:

- `ConcesionarioDAO`
- `ContratoHeladeroDAO`
- `DetalleHeladoDAO`
- `HeladeroDAO`
- `HeladoDAO`
- `HeladosEntregadoRecibidoDAO`
- `UsuarioDAO`

The query count is small enough to rewrite manually and test well.

## Migration Shape

1. Establish a reliable build lane:
   - Either use Java 8 for the legacy baseline and Java 21 for modernization, or make Java 21 the only lane and immediately remove/replace the incompatible test/runtime pieces.

2. Reduce PowerMock dependency:
   - Static services and static DAOs force heavy mocking.
   - Refactor one workflow at a time to injectable collaborators.
   - Start with `ManagerPago` because the empty-assignment bug is small and high-signal.

3. Introduce a persistence boundary:
   - Keep the UI/controller signatures stable.
   - Move transaction ownership into service/application operations.
   - Make assignment stock deduction plus assignment creation atomic.

4. Upgrade Hibernate:
   - Prefer Hibernate 6.6 as the first serious Java 21 target.
   - Replace Criteria API calls with HQL or JPA Criteria.
   - Keep XML mappings temporarily if possible, then migrate to annotations only if it reduces friction.

5. Replace runtime tooling:
   - Move away from `tomcat7-maven-plugin`.
   - Use a modern servlet container compatible with Java 21 for the WAR smoke test.

## Suggested First Technical Spike

Create a branch that does not change UI pages and tries to make `mvn clean test` pass on Java 21 by addressing the test/runtime blockers. The spike should answer:

- Can JSF 1.2 dependencies stay on the classpath under Java 21 for unit tests?
- How many PowerMock tests can be converted to plain Mockito/JUnit without changing behavior?
- Does Hibernate 3 need to be removed before a useful Java 21 test lane is possible?

If the answer to the last question is yes, move directly to the Hibernate 6.6 bridge.
