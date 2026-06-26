# Heladero Lifecycle Notes

## Primary Flow

1. A heladero is listed and selected from `ManagerHeladero`.
2. `ManagerAsignacion.loadAssignation` opens the daily assignment modal when no assignment exists for the selected seller today.
3. `ManagerAsignacion.addIceCream` builds in-memory `DetalleHelado` rows and includes pending quantities from the previous day.
4. `ManagerAsignacion.saveAssignations` checks stock, deducts stock, and creates `HeladosEntregadoRecibido` with detail rows.
5. `ManagerPago.pagarHeladero` loads today's assignment and opens the payment modal if it has not been paid.
6. `ManagerPago.realizarPago` validates returned quantities, calculates sold quantities, creates payment data, and updates detail rows.

## Important Classes

- `pe.lamborgini.controller.ManagerHeladero`: seller list, contract load, currently missing save/update implementation.
- `pe.lamborgini.controller.modal.ManagerAsignacion`: UI workflow for daily assignment.
- `pe.lamborgini.controller.modal.ManagerPago`: UI workflow for close-day payment.
- `pe.lamborgini.service.HeladosEntregadoRecibidoService`: assignment header creation and payment existence check.
- `pe.lamborgini.service.DetalleHeladoService`: pending quantity, returned/sold validation, payment calculation.
- `pe.lamborgini.service.HeladoService`: ice cream search, stock checks, stock updates.

## Domain Terms

- `Heladero`: seller.
- `Concesionario`: concessionaire/branch-like owner context.
- `ContratoHeladero`: contract between seller and concessionaire.
- `Helado`: ice cream product.
- `StockHelado`: inventory quantity for a product.
- `HeladosEntregadoRecibido`: daily assignment header for delivered/received inventory.
- `DetalleHelado`: assigned, returned, and sold quantities per ice cream.
- `PagoHelado`: payment generated from sold quantities.

## High-Value Behavior To Preserve

- One open assignment per heladero per day.
- Assigned quantity cannot exceed available stock.
- Returned quantity cannot exceed assigned quantity.
- Sold quantity equals assigned quantity minus returned quantity.
- Payment equals sum of sold quantity times product price.
- Pending returned inventory from the previous day is considered in the next assignment.
