# SaathKhata — Backend Integration Plan

> **Status as of 2026-05-27**  
> Auth is fully integrated and working. Everything else uses mock repositories.  
> Backend is 100% implemented and deployed at `http://45.195.159.30:3001/api/v1`.  
> This document defines the exact order to replace mock repositories with real ones.

---

## Quick Overview

| Layer | Current State |
|---|---|
| Auth | Real (`AuthRepositoryImpl` + Dio interceptor with token refresh) |
| Links (vendor↔customer) | `MockVendorRepository` / `MockCustomerRepository` |
| Ledger | `MockLedgerRepository` |
| Payments | `MockPaymentRepository` |
| Notifications | `MockNotificationRepository` |
| Staff | `MockStaffRepository` |
| Bookings | `MockBookingRepository` |
| Reports | No repository yet — screen is a placeholder |
| Bill OCR / Voice Entry | No backend module exists; skip for now |

Every mock sits in `lib/core/di/injection.dart`. Replacing them one module at a time is the plan.

---

## Phase 0 — Foundation (do this before any phase)

These are one-time changes that every subsequent phase depends on.

### 0.1 Expand `ApiEndpoints`

Open `lib/core/network/api_endpoints.dart` and add the missing endpoint groups alongside the existing auth ones:

```dart
// Links
static const String links             = '/links';
static const String myCustomers       = '/links/customers';
static const String myVendors         = '/links/vendors';
static String linkById(String id)     => '/links/$id';

// Ledger (nested under link)
static String linkEntries(String linkId)             => '/links/$linkId/entries';
static String linkBalance(String linkId)             => '/links/$linkId/entries/balance';
static String confirmEntry(String linkId, String id) => '/links/$linkId/entries/$id/confirm';
static String disputeEntry(String linkId, String id) => '/links/$linkId/entries/$id/dispute';

// Payments (nested under link)
static String linkPayments(String linkId)            => '/links/$linkId/payments';
static String settleLink(String linkId)              => '/links/$linkId/payments/settle';

// Notifications
static const String notifications      = '/notifications';
static const String notifUnreadCount   = '/notifications/unread-count';
static const String notifReadAll       = '/notifications/read-all';
static String notifReadOne(String id)  => '/notifications/$id/read';

// Staff (vendor-only)
static const String staff                              = '/staff';
static String staffById(String id)                    => '/staff/$id';
static String staffAttendance(String id)              => '/staff/$id/attendance';
static String staffPay(String id)                     => '/staff/$id/pay';
static String staffAdvance(String id)                 => '/staff/$id/advance';
static String staffAccrue(String id)                  => '/staff/$id/accrue';
static String staffSalaryHistory(String id)           => '/staff/$id/salary-history';

// Bookings
static const String bookings             = '/bookings';
static const String bookingConfig        = '/bookings/config';
static String publicSlots(String vendorId) => '/bookings/slots/$vendorId';
static const String vendorBookings       = '/bookings/vendor';
static const String customerBookings     = '/bookings/customer';
static String bookingById(String id)     => '/bookings/$id';

// Reports (vendor-only)
static const String reportSummary        = '/reports/summary';
static const String reportCustomers      = '/reports/customers';
static String reportCustomerDetail(String linkId) => '/reports/customers/$linkId';
static const String reportMonthly        = '/reports/monthly';
```

### 0.2 Shared API response wrapper

Add a small helper (or confirm one exists) that unwraps the standard backend envelope:

```json
{ "success": true, "data": { ... } }
```

Every repository implementation will call `response.data['data']` — centralise it.

---

## Phase 1 — Links (Vendor↔Customer Relationships)

**Why first:** Every other feature (ledger, payments, reports) lives inside a link. Nothing else works without this.

**Screens that unlock:** Vendor dashboard customer list, Customer dashboard vendor list, `my_khatas_screen`.

### What to build

**`lib/features/vendor/data/repositories/vendor_repository_impl.dart`**

```dart
// Methods to implement against /api/v1/links
Future<List<CustomerLinkItem>> getLinkedCustomers();
Future<VendorLinkItem> createLink(String customerEmail);     // POST /links
Future<void> deactivateLink(String linkId);                  // DELETE /links/:id
Future<CustomerLinkItem> getLinkById(String linkId);         // GET /links/:id
```

**`lib/features/customer/data/repositories/customer_repository_impl.dart`**

```dart
Future<List<VendorLinkItem>> getLinkedVendors();
Future<VendorLinkItem> getLinkById(String linkId);
```

### DI change in `injection.dart`

```dart
// Replace:
sl.registerLazySingleton<VendorRepository>(() => MockVendorRepository());
sl.registerLazySingleton<CustomerRepository>(() => MockCustomerRepository());

// With:
sl.registerLazySingleton<VendorRepository>(() => VendorRepositoryImpl(sl<ApiClient>()));
sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Description |
|---|---|---|
| GET | `/links/customers` | Vendor: all linked customers with balances |
| GET | `/links/vendors` | Customer: all linked vendors with balances |
| GET | `/links/:linkId` | Either party: single link |
| POST | `/links` | Vendor: create link by customer email |
| DELETE | `/links/:linkId` | Vendor: deactivate link |

---

## Phase 2 — Ledger

**Why second:** The ledger is the core value proposition. Once links exist, showing the credit/payment history is the first thing a user will want.

**Screens that unlock:** `shared_ledger_screen` (both roles), vendor's per-customer ledger view, balance card.

### What to build

**`lib/features/shared_ledger/data/repositories/ledger_repository_impl.dart`**

```dart
Future<PaginatedResult<LedgerEntry>> getEntries(
  String linkId, {
  int page = 1,
  int limit = 20,
  EntryStatus? status,
  EntryType? type,
});

Future<LedgerBalance> getBalance(String linkId);

Future<LedgerEntry> addEntry(String linkId, {
  required EntryType type,
  required double amount,
  String? description,
  String? date,
});

// Customer-only:
Future<LedgerEntry> confirmEntry(String linkId, String entryId);
Future<LedgerEntry> disputeEntry(String linkId, String entryId);
```

**Entry status rules (mirror the backend):**

- Vendor adds `credit` / `adjustment` / `advance` → status is `pending`
- Customer can `confirm` (locks entry, cannot be changed) or `dispute` (reverts balance)
- Either party can add `payment` → status is `auto_confirmed` immediately
- Entries locked (`is_locked=true`) cannot be edited or deleted

### DI change

```dart
sl.registerLazySingleton<LedgerRepository>(() => LedgerRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Description |
|---|---|---|
| GET | `/links/:linkId/entries` | Paginated entries |
| GET | `/links/:linkId/entries/balance` | O(1) balance + stats |
| POST | `/links/:linkId/entries` | Add new entry |
| PATCH | `/links/:linkId/entries/:id/confirm` | Customer confirms |
| PATCH | `/links/:linkId/entries/:id/dispute` | Customer disputes |

---

## Phase 3 — Payments

**Why third:** Payments are recorded on top of the ledger. Completing ledger first means payments have context to display.

**Screens that unlock:** `upi_payment_screen`, `payments_screen` (customer), payment history in ledger view.

### What to build

**`lib/features/payments/data/repositories/payment_repository_impl.dart`**

```dart
Future<PaginatedResult<PaymentTransaction>> getPayments(String linkId, {int page = 1});
Future<PaymentTransaction> recordPayment(
  String linkId, {
  required double amount,
  required PaymentMethod method,
  String? upiTransactionId,
  String? notes,
});
Future<PaymentTransaction> settleBalance(String linkId);
```

**Important:** `POST /links/:linkId/payments` atomically creates an `auto_confirmed` ledger entry and a payment transaction in one backend transaction. Do not create a manual ledger entry before calling this.

### DI change

```dart
sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Description |
|---|---|---|
| GET | `/links/:linkId/payments` | Paginated history |
| POST | `/links/:linkId/payments` | Record payment (atomic) |
| POST | `/links/:linkId/payments/settle` | Settle full outstanding balance |

---

## Phase 4 — Notifications

**Why fourth:** Non-blocking for core flows but greatly improves the UX. After ledger + payments are real, the backend will already be firing notifications via BullMQ — the app just needs to read them.

**Screens that unlock:** `notifications_screen`, unread badge in app bar.

### What to build

**`lib/features/notifications/data/repositories/notification_repository_impl.dart`**

```dart
Future<PaginatedResult<AppNotification>> getNotifications({
  int page = 1,
  bool unreadOnly = false,
});
Future<int> getUnreadCount();
Future<void> markAsRead(String notificationId);
Future<void> markAllAsRead();
```

**Polling strategy:** The backend has no WebSocket yet. Implement a simple timer-based poll (every 30–60 seconds while the app is in foreground) for `getUnreadCount()`. Refresh the full list only when the user opens the notifications screen.

### DI change

```dart
sl.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Description |
|---|---|---|
| GET | `/notifications` | Paginated list |
| GET | `/notifications/unread-count` | Badge count |
| PATCH | `/notifications/read-all` | Mark all read |
| PATCH | `/notifications/:id/read` | Mark one read |

---

## Phase 5 — Staff (Vendor-only)

**Why fifth:** Staff management is a vendor-only feature and does not block the customer flow at all. It's also more complex (attendance + salary + advances) so do it after the shared features are stable.

**Screens that unlock:** `staff_management_screen`, `staff_detail_screen`.

### What to build

**`lib/features/staff/data/repositories/staff_repository_impl.dart`**

```dart
Future<List<StaffMember>> getStaff();
Future<StaffMember> addStaff(StaffInput input);
Future<StaffMember> updateStaff(String staffId, StaffInput input);
Future<void> deactivateStaff(String staffId);

// Attendance
Future<void> markAttendance(String staffId, String date, AttendanceStatus status);
Future<Map<String, AttendanceStatus>> getMonthlyAttendance(String staffId, int year, int month);

// Salary
Future<void> recordPayment(String staffId, double amount);
Future<void> recordAdvance(String staffId, double amount);
Future<void> accrueSalary(String staffId);
Future<List<SalaryTransaction>> getSalaryHistory(String staffId);
```

**Salary types (mirror backend):** `daily` / `weekly` / `monthly`  
- Daily staff: attendance mark auto-adjusts `unpaid_salary`
- Weekly/Monthly staff: call `accrue` to add one period's salary

### DI change

```dart
sl.registerLazySingleton<StaffRepository>(() => StaffRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Description |
|---|---|---|
| GET | `/staff` | All active staff + today's attendance |
| POST | `/staff` | Add staff member |
| GET/PATCH/DELETE | `/staff/:id` | Get / update / deactivate |
| PUT | `/staff/:id/attendance` | Upsert attendance |
| GET | `/staff/:id/attendance` | Monthly attendance map |
| POST | `/staff/:id/pay` | Record salary payment |
| POST | `/staff/:id/advance` | Record advance |
| POST | `/staff/:id/accrue` | Accrue one period |
| GET | `/staff/:id/salary-history` | Last 50 transactions |

---

## Phase 6 — Bookings

**Why sixth:** Bookings span both roles (customer books, vendor manages) but are independent of ledger/payments. Do it after the ledger flow is stable so the team can focus.

**Screens that unlock:** `vendor_bookings_screen`, `customer_bookings_screen`.

### What to build

**`lib/features/booking/data/repositories/booking_repository_impl.dart`**

```dart
// Vendor
Future<BookingConfig?> getConfig();
Future<void> saveConfig(BookingConfig config);
Future<List<Booking>> getVendorBookings(String date);    // date: YYYY-MM-DD
Future<void> updateBookingStatus(String bookingId, BookingStatus status);

// Customer
Future<List<TimeSlot>> getAvailableSlots(String vendorId, String date);
Future<Booking> createBooking(String vendorId, String date, String start, String end);
Future<List<Booking>> getCustomerBookings();

// Either
Future<void> cancelBooking(String bookingId);
```

**Slot generation is done server-side** — call `GET /bookings/slots/:vendorId?date=YYYY-MM-DD` and render the response. Do not replicate the slot logic on the client.

### DI change

```dart
sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Description |
|---|---|---|
| GET/PUT | `/bookings/config` | Vendor: get/save config |
| GET | `/bookings/slots/:vendorId` | Public: available slots |
| POST | `/bookings` | Customer: create booking |
| GET | `/bookings/vendor` | Vendor: bookings for a date |
| GET | `/bookings/customer` | Customer: full history |
| PATCH | `/bookings/:id` | Either: update status |

---

## Phase 7 — Reports (Vendor-only)

**Why last:** Reports are read-only aggregations on top of data that exists after phases 1–3. The backend has Redis caching (5 min for summaries, 1 hr for revenue trends) so these calls are cheap.

**Screens that unlock:** `reports_screen`, `all_customers_report_screen`, `customer_detail_report_screen`.

### What to build

**`lib/features/reports/data/repositories/report_repository_impl.dart`**

```dart
Future<ReportSummary> getSummary();
Future<List<CustomerReportItem>> getAllCustomers();
Future<CustomerDetailReport> getCustomerDetail(String linkId);
Future<List<MonthlyRevenue>> getMonthlyTrend({int? year});
```

No repository abstraction existed before — register it fresh:

```dart
sl.registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(sl<ApiClient>()));
```

### Backend endpoints used

| Method | Path | Cache |
|---|---|---|
| GET | `/reports/summary` | Redis 5 min |
| GET | `/reports/customers` | Redis 5 min |
| GET | `/reports/customers/:linkId` | No cache |
| GET | `/reports/monthly?year=YYYY` | Redis 1 hr |

---

## Not Planned (no backend)

| Feature | Reason |
|---|---|
| **Bill OCR** (`scan_bill_screen`) | No backend OCR module. Would need a third-party service (Google Vision, Textract). Deprioritise. |
| **Voice Entry** (`voice_entry_screen`) | No backend transcription module. Would need speech-to-text integration. Deprioritise. |
| **Real-time push notifications** | Backend uses BullMQ async queue, not WebSockets. Current architecture is polling-only. WebSocket/FCM integration is a later milestone. |

---

## Summary Timeline

| Phase | Feature | Roles | Blocker for |
|---|---|---|---|
| 0 | Endpoints + response wrapper | — | Everything |
| 1 | Links | Both | Phases 2, 3, 7 |
| 2 | Ledger | Both | Phase 3 |
| 3 | Payments | Both | Phase 7 |
| 4 | Notifications | Both | Nothing |
| 5 | Staff | Vendor | Nothing |
| 6 | Bookings | Both | Nothing |
| 7 | Reports | Vendor | Phases 1–3 |

Phases 4, 5, and 6 can be done in any order (or in parallel on separate branches) once Phase 3 is done.

---

## Checklist

- [ ] Phase 0 — expand `ApiEndpoints`, add response unwrapper
- [ ] Phase 1 — `VendorRepositoryImpl` + `CustomerRepositoryImpl` (links)
- [ ] Phase 2 — `LedgerRepositoryImpl`
- [ ] Phase 3 — `PaymentRepositoryImpl`
- [ ] Phase 4 — `NotificationRepositoryImpl` + polling timer
- [ ] Phase 5 — `StaffRepositoryImpl`
- [ ] Phase 6 — `BookingRepositoryImpl`
- [ ] Phase 7 — `ReportRepositoryImpl`
- [ ] Remove all `Mock*Repository` classes and their imports
- [ ] End-to-end test on both vendor and customer flows
