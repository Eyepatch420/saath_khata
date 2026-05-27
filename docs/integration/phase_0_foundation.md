# Phase 0 — Foundation

**Status:** ✅ Complete  
**Date:** 2026-05-27

## What was done

### 1. `lib/core/network/api_endpoints.dart`
Added endpoint constants for all 7 remaining modules:
- Links (`/links`, `/links/customers`, `/links/vendors`, `/links/:id`)
- Ledger (`/links/:id/entries`, `/links/:id/entries/balance`, confirm/dispute)
- Payments (`/links/:id/payments`, settle)
- Notifications (`/notifications`, unread-count, read-all, read one)
- Staff (all 10 staff sub-routes)
- Bookings (config, slots, vendor/customer views, update)
- Reports (summary, customers list, customer detail, monthly)

### 2. `lib/core/network/api_client.dart`
Added `delete<T>` method (needed by `VendorRepositoryImpl.deactivateLink`).

### 3. Shared models — `fromJson` factories added
All models needed to parse API responses. Added factory constructors and enum string parsers to:
- `lib/shared/models/link_model.dart`
- `lib/shared/models/ledger_entry.dart`
- `lib/shared/models/payment_transaction.dart`
- `lib/shared/models/notification_model.dart`
- `lib/shared/models/staff_model.dart`
- `lib/shared/models/booking_model.dart`

### 4. New shared models created
- `lib/shared/models/ledger_balance.dart` — balance + stats response from `/entries/balance`
- `lib/shared/models/paginated_result.dart` — generic `PaginatedResult<T>` wrapper
- `lib/shared/models/salary_transaction.dart` — staff salary/advance history entry
- `lib/shared/models/report_models.dart` — all four report response shapes

## Enum string mapping (backend → Flutter)

| Backend | Flutter |
|---|---|
| `auto_confirmed` | `EntryStatus.autoConfirmed` |
| `bank_transfer` | `PaymentMethod.bankTransfer` |
| `other` (payment) | `PaymentMethod.cheque` |
| `half_day` | `AttendanceStatus.halfDay` |
| `entry_added` | `NotificationType.entryAdded` |
| `entry_confirmed` | `NotificationType.entryConfirmed` |
| `entry_disputed` | `NotificationType.entryDisputed` |
| `payment_received` | `NotificationType.paymentReceived` |
| `booking_confirmed` | `NotificationType.bookingConfirmed` |
| `booking_cancelled` | `NotificationType.bookingCancelled` |
| `salary_paid` | `NotificationType.salaryPaid` |
| `reminder_due` | `NotificationType.reminderDue` |
| `monthly_summary` | `NotificationType.monthlySummary` |
