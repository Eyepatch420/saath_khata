# SaathKhata — MVP Implementation Tracker
**Last Updated:** 2026-05-14  
**Overall MVP Progress:** ~79% UI | ~75% BLoC | ~72% Repository | 0% Backend-Ready

---

## How to read this tracker
- ✅ Complete
- 🔄 In Progress / Partial
- ❌ Not Started
- ⚠️ Exists but broken/incomplete

---

## MODULE 1: AUTH FLOW

| Task | Status | Notes |
|------|--------|-------|
| SplashScreen UI | ✅ | Done |
| LanguageSelectionScreen UI | ✅ | Done |
| OnboardingScreen UI | ✅ | Done |
| RoleSelectionScreen UI | ✅ | Done |
| LoginScreen (phone + OTP) UI | ✅ | Done |
| ProfileSetupScreen UI | ✅ | Done |
| AuthBloc (session management) | ❌ | Not started |
| Auth repository abstraction | ❌ | Not started |
| Mock auth repository | ❌ | Not started |
| Session persistence (HydratedBloc/Hive) | ❌ | Not started |
| OTP verification placeholder logic | ❌ | Not started — simulated only |

---

## MODULE 2: VENDOR DASHBOARD

| Task | Status | Notes |
|------|--------|-------|
| VendorDashboard UI | ✅ | Done |
| VendorBloc | ✅ | Done |
| VendorRepository abstraction | ✅ | Done |
| MockVendorRepository | ✅ | Done |
| StatCard widget | ✅ | Done |
| ShellRoute bottom nav (4 tabs) | ✅ | Home / Staff / Reports / Settings |
| Notifications bell → NotificationsScreen | ✅ | Wired via `context.push` |
| FAB → Add Customer sheet | ✅ | Bottom sheet with l10n |
| Quick Action: Scan Bill | ✅ | Wired to `/scan-bill` |
| Quick Action: Remind All | ❌ | Button present, no action |
| Quick Action: Add New | ✅ | Opens add customer sheet |
| Add Customer bottom sheet (l10n) | ✅ | Name + mobile fields |
| Real outstanding amounts per customer | ❌ | `₹1,250` hardcoded in `_CustomerTile` |
| Customer tile type safety (`dynamic` → `UserModel`) | ❌ | Still uses `dynamic` |
| Booking tab in vendor nav | ❌ | VendorBookingsScreen exists but not in nav |

---

## MODULE 3: SHARED LEDGER

| Task | Status | Notes |
|------|--------|-------|
| SharedLedgerScreen full rebuild | ✅ | Complete BLoC-driven screen |
| Balance header with credit direction | ✅ | "You Will Get / Give" text |
| Filter bar (All/Pending/Confirmed/Disputed) | ✅ | Animated chips |
| Entry cards with inline actions | ✅ | Confirm/Dispute for pending entries |
| Add Entry bottom sheet (credit + payment) | ✅ | Two-type form |
| Confirm entry flow | ✅ | Dispatches `ConfirmLedgerEntry` |
| Dispute entry flow | ✅ | Reason input bottom sheet |
| Entry detail bottom sheet | ✅ | Full details with metadata |
| Locked entry enforcement (no actions) | ✅ | `isLocked` hides action buttons |
| LedgerActionLoading overlay | ✅ | Spinner during async ops |
| LedgerRepository abstraction | ✅ | Fixed — own interface |
| MockLedgerRepository (5 entries, mutations) | ✅ | In-memory list with confirm/dispute |
| LedgerBloc — LoadLedger | ✅ | Done |
| LedgerBloc — AddLedgerEntry | ✅ | Done |
| LedgerBloc — ConfirmLedgerEntry | ✅ | Done |
| LedgerBloc — DisputeLedgerEntry | ✅ | Done |
| LedgerBloc — FilterLedger | ✅ | Done |
| EmptyStateWidget (no entries) | ✅ | Uses shared widget |
| ErrorStateWidget + retry | ✅ | Uses shared widget |
| Search entries | ❌ | Not implemented |
| Attachment / photo placeholder | ❌ | Not implemented |
| PDF/Statement export | ❌ | Button exists, not wired |

---

## MODULE 4: CUSTOMER FEATURES

| Task | Status | Notes |
|------|--------|-------|
| CustomerDashboard UI | ✅ | Done |
| CustomerBloc | ✅ | Done |
| CustomerRepository | ✅ | Done |
| MockCustomerRepository | ✅ | Done |
| TotalDueCard | ✅ | Done |
| VendorTile | ✅ | Done |
| MyKhatasScreen | ✅ | Done |
| PaymentsScreen (BLoC-driven) | ✅ | Rebuilt — PaymentBloc, transaction history |
| Payment summary (total paid / pending) | ✅ | BLoC-computed stats |
| SCAN & PAY → UpiPaymentScreen | ✅ | Wired via GoRouter push |
| CustomerProfileScreen (static) | ⚠️ | Shows "John Doe" — not wired to real data |
| Customer dashboard error state | ❌ | No error handling in UI |
| Customer amounts in VendorTile from ledger | ❌ | Hardcoded `₹850` |
| Settings accessible from customer shell | ❌ | Not in customer bottom nav |

---

## MODULE 5: STAFF MANAGEMENT

| Task | Status | Notes |
|------|--------|-------|
| StaffManagementScreen (full BLoC rebuild) | ✅ | Summary bar, staff cards, attendance popup |
| StaffModel + AttendanceRecord | ✅ | Equatable, copyWith |
| SalaryType enum (daily/weekly/monthly) | ✅ | Done |
| AttendanceStatus enum (present/absent/halfDay/holiday) | ✅ | Done |
| StaffRepository abstraction (7 methods) | ✅ | Done |
| MockStaffRepository (3 staff, realistic attendance) | ✅ | Done |
| StaffBloc — LoadStaff | ✅ | Done |
| StaffBloc — AddStaff | ✅ | Done |
| StaffBloc — MarkAttendance | ✅ | Done |
| StaffBloc — LoadAttendance (detail) | ✅ | Done |
| StaffBloc — PaySalary | ✅ | Done |
| StaffBloc — AddAdvance | ✅ | Done |
| Staff summary bar (present count / unpaid salary) | ✅ | Done |
| Attendance popup menu (Present/Absent/Half Day) | ✅ | Done |
| Add Staff bottom sheet (role + salary type dropdowns) | ✅ | l10n wired |
| DropdownButtonFormField `value` → `initialValue` fix | ✅ | Fixed |
| StaffDetailScreen | ✅ | Created |
| Monthly attendance calendar (color-coded grid) | ✅ | Done |
| Month prev/next navigation | ✅ | Dispatches `LoadAttendance` |
| Salary summary (rate, days, earned, unpaid, advance) | ✅ | Half-day = 0.5 multiplier |
| Pay salary bottom sheet (amount + UPI ID) | ✅ | Done |
| Add advance bottom sheet (amount + note) | ✅ | Done |
| Staff detail route (`/staff` uses Navigator.push) | ✅ | Navigator.push from card tap |
| Pay salary → navigate to UpiPaymentScreen | ❌ | Pay button doesn't go to `/upi-payment` |
| Staff profile active/inactive badge | ✅ | Done |

---

## MODULE 6: REPORTS

| Task | Status | Notes |
|------|--------|-------|
| ReportsScreen (stub) | ⚠️ | Fake bar chart, hardcoded numbers |
| AllCustomersReportScreen | ✅ | Static mock data, navigation to detail |
| CustomerDetailReportScreen | ✅ | Static mock data |
| ReportsBloc | ❌ | Not created |
| ReportsRepository abstraction | ❌ | Not created |
| Time range filter (This Month/Last Month/Custom) | ❌ | Not implemented |
| Revenue cards with real data | ❌ | Hardcoded |
| Export PDF placeholder | ❌ | Not implemented |
| l10n: all strings | ❌ | Mostly hardcoded |

---

## MODULE 7: NOTIFICATIONS

| Task | Status | Notes |
|------|--------|-------|
| NotificationsScreen | ✅ | Full BLoC-driven screen |
| AppNotification model (9 types) | ✅ | Equatable, copyWith |
| NotificationType enum (9 values) | ✅ | Done |
| NotificationRepository abstraction | ✅ | Done |
| MockNotificationRepository (6 items) | ✅ | Done |
| NotificationBloc — LoadNotifications | ✅ | Done |
| NotificationBloc — MarkNotificationRead | ✅ | Done |
| NotificationBloc — MarkAllNotificationsRead | ✅ | Done |
| Date grouping (Today / Yesterday / date string) | ✅ | Done |
| Read/unread styling (blue dot, bold title) | ✅ | Done |
| Mark All Read button (visible only when unread > 0) | ✅ | Done |
| Type-specific icons and colors (9 types) | ✅ | Done |
| Relative time display ("5m ago", "2h ago") | ✅ | Done |
| Route `/notifications` | ✅ | In router, accessible from vendor bell |
| Bell icon wired to NotificationsScreen | ✅ | Done |
| l10n: notifications, markAllRead, empty state | ✅ | Done |
| Notification tap → deep link to relevant screen | ❌ | Not implemented |
| Unread badge count on bell icon | ❌ | Not implemented |

---

## MODULE 8: BOOKING / APPOINTMENTS

| Task | Status | Notes |
|------|--------|-------|
| VendorBookingsScreen | ✅ | 7-day date strip, booking cards, status badges |
| CustomerBookingsScreen | ✅ | Upcoming/past split, cancel confirm dialog |
| BookingModel + AppointmentSlot | ✅ | Equatable, copyWith |
| BookingStatus enum (pending/confirmed/cancelled/completed) | ✅ | Done |
| BookingRepository abstraction (5 methods) | ✅ | Done |
| MockBookingRepository (3 bookings, slot generation) | ✅ | 30-min intervals, 09:00–17:00 |
| BookingBloc — LoadVendorBookings | ✅ | Done |
| BookingBloc — LoadCustomerBookings | ✅ | Done |
| BookingBloc — LoadAvailableSlots | ✅ | Done |
| BookingBloc — CreateBooking | ✅ | Done |
| BookingBloc — CancelBooking | ✅ | Done |
| BookingBloc — SelectBookingDate | ✅ | Done |
| 7-day date selector strip (vendor) | ✅ | Scrollable, today/selected highlight |
| Booking cards with left-border status color | ✅ | Done |
| Upcoming/past grouped list (customer) | ✅ | Done |
| Cancel booking AlertDialog | ✅ | Done |
| Route `/booking` (vendor, in ShellRoute) | ✅ | In router |
| Route `/customer/booking` (in ShellRoute) | ✅ | In router |
| l10n: appointments, myAppointments, empty states | ✅ | Done |
| Booking entry point in vendor bottom nav | ❌ | Tab not in nav bar |
| New booking form (customer side) | ❌ | No UI for creating a booking |
| Slot picker UI | ❌ | BLoC handler exists, no screen/widget |
| Booking detail screen | ❌ | No dedicated detail view |

---

## MODULE 9: UPI / PAYMENTS

| Task | Status | Notes |
|------|--------|-------|
| PaymentsScreen (BLoC-driven) | ✅ | Full rebuild with PaymentBloc |
| Payment summary stats (total paid / pending) | ✅ | BLoC-computed |
| Transaction history list | ✅ | Status badges, dates, vendor names |
| Quick Pay card | ✅ | SCAN & PAY button wired |
| UpiPaymentScreen | ✅ | Created |
| UPI app row (GPay/PhonePe/Paytm/BHIM) | ✅ | "Coming soon" snackbar |
| UPI ID text entry + simulated 2s flow | ✅ | Done |
| Payment success full-screen view | ✅ | Done |
| Payment failed full-screen view + retry | ✅ | Done |
| PaymentTransaction model (4 statuses) | ✅ | Done |
| PaymentRepository abstraction | ✅ | Done |
| MockPaymentRepository (3 transactions, recordPayment) | ✅ | Done |
| PaymentBloc — LoadPayments | ✅ | Done |
| PaymentBloc — RecordPayment | ✅ | Done |
| Route `/upi-payment` (global, with extras) | ✅ | amount + recipientName + upiId? |
| l10n: payments, totalPaid, pending, quickPay, scanAndPay | ✅ | Done |
| Salary payment from StaffDetailScreen | ❌ | Pay button doesn't push to `/upi-payment` |
| UPI deep link to payment app | ❌ | Requires `url_launcher` / `upi_pay` plugin |
| Settlement summary after payment | ❌ | Not implemented |

---

## MODULE 10: SETTINGS

| Task | Status | Notes |
|------|--------|-------|
| SettingsScreen (stub) | ✅ | Present |
| Language switcher wired to LocaleProvider | ❌ | Tile present, not wired |
| UPI management screen | ❌ | Not implemented |
| Notification settings | ❌ | Not implemented |
| Security / PIN screen | ❌ | Not implemented |
| Logout → navigates to splash | ❌ | Not wired |
| l10n all strings | ❌ | Fully hardcoded |

---

## MODULE 11: SHARED INFRASTRUCTURE

| Task | Status | Notes |
|------|--------|-------|
| LedgerRepository abstraction + Mock | ✅ | Done |
| StaffRepository abstraction + Mock | ✅ | Done |
| BookingRepository abstraction + Mock | ✅ | Done |
| NotificationRepository abstraction + Mock | ✅ | Done |
| PaymentRepository abstraction + Mock | ✅ | Done |
| DI: all 7 repositories registered | ✅ | Done |
| EmptyStateWidget (shared) | ✅ | `lib/shared/widgets/empty_state_widget.dart` |
| ErrorStateWidget (shared) | ✅ | `lib/shared/widgets/error_state_widget.dart` |
| SectionHeader widget (shared) | ✅ | `lib/shared/widgets/section_header.dart` |
| AppCard widget (shared) | ✅ | `lib/shared/widgets/app_card.dart` |
| API endpoint constants file | ❌ | Not created |
| Generic ApiResponse wrapper | ❌ | Not created |
| Pagination model | ❌ | Not created |
| AppError model | ❌ | Not created |
| StorageService (Hive) | ❌ | Empty skeleton only |
| LoadingWidget (shared) | ❌ | Not created (inline CircularProgressIndicator used) |

---

## MODULE 12: LOCALIZATION

| Task | Status | Notes |
|------|--------|-------|
| English (en) ARB base | ✅ | ~90 keys |
| Hindi (hi) translations | ✅ | ~90 keys, full parity |
| Abstract getters in AppLocalizations | ✅ | All new keys added |
| EN implementation | ✅ | All new keys added |
| HI implementation | ✅ | All new keys added |
| l10n in VendorDashboard | ✅ | Fully wired |
| l10n in SharedLedgerScreen | 🔄 | Mostly wired; some labels hardcoded |
| l10n in NotificationsScreen | ✅ | Fully wired |
| l10n in PaymentsScreen | ✅ | Fully wired |
| l10n in VendorBookingsScreen | ✅ | AppBar + empty states wired |
| l10n in CustomerBookingsScreen | ✅ | AppBar + empty states wired |
| l10n in UpiPaymentScreen | ✅ | Title, amountToPay, securedByUpi, success/fail wired |
| l10n in StaffManagementScreen | 🔄 | Add staff sheet strings hardcoded |
| l10n in StaffDetailScreen | 🔄 | Key labels hardcoded internally |
| l10n in SettingsScreen | ❌ | Fully hardcoded |
| l10n in CustomerDashboard | ❌ | "Customer Mode" hardcoded |
| l10n in ReportsScreen | ❌ | Fully hardcoded |
| l10n in BillDetailsFormScreen | ❌ | Fully hardcoded |
| l10n in VoiceEntryScreen | ❌ | Fully hardcoded |

---

## REMAINING SPRINT WORK

### Critical Wiring (Pre-Demo)
1. Staff pay salary → push to `/upi-payment` with amount + staff name
2. Add Booking tab/entry point in vendor bottom nav
3. Settings logout → navigate to splash
4. Settings language → wire to `LocaleProvider.setLocale()`

### Feature Gaps (Nice-to-Have Before Backend)
5. New booking flow for customer (vendor selection + slot picker)
6. Notification tap → deep link to relevant screen
7. Fix `BillDetailsFormScreen` broken `NetworkImage`
8. Replace `dynamic` in `_CustomerTile`

### Backend Integration Prep
9. Create API endpoint constants file
10. Create `ApiResponse<T>` generic wrapper + pagination model
11. Create `AppError` model for error handling
12. Create DTO layer for each model with `fromJson`/`toJson`

---

*Continuously updated during implementation. Last sprint: 2026-05-14.*
