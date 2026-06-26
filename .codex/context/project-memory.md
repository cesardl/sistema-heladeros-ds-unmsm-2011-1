# Project Memory

## Application

Sistema de Gestion de Venta de Helados (SIGEVH) is a legacy Java web application from a 2011 UNMSM systems design exercise. The current modernization goal is to keep the project useful as a developer training path: maintain the legacy stack enough to learn from it, close feature gaps, add tests, and progressively improve engineering quality.

## Current Focus

The core domain is the lifecycle of ice cream sellers (`heladeros`):

- maintain sellers, concessionaires, contracts, users, and ice cream inventory;
- assign inventory to a seller for the day;
- close the day by recording returned and sold ice creams;
- calculate payment from sold quantities and ice cream prices;
- preserve this as a real-world learning exercise where developers improve through incremental, test-backed changes.

## Stack Snapshot

- Frontend: JSP, JSF 1.2, RichFaces 3.3, JavaScript, CSS.
- Backend: Java, Hibernate 3.x, service/DAO style static helpers.
- Database: MySQL 5.7 target, local Docker workflow.
- Build: Maven WAR.
- Testing: JUnit 4, Mockito/PowerMock, JaCoCo.

## Modernization Principles

- Favor small, reversible improvements over large rewrites.
- Protect the daily assignment/payment lifecycle with tests before changing behavior.
- Move configuration and credentials out of committed runtime files.
- Reduce static/global coupling gradually, starting where tests are hardest.
- Keep documentation close to the code so future sessions can recover context quickly.
