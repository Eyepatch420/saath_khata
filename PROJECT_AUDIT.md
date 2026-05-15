# SaathKhata — Project Audit Report
**Audit Date:** 2026-05-14  
**Last Updated:** 2026-05-14 (post-implementation pass)  
**Status:** MVP UI Complete — Backend Integration Pending

---

## 1. Project Overview

SaathKhata is a two-sided shared ledger app for India. Vendors manage customers, ledger entries, staff, and appointments. Customers track dues, view their shared ledger, pay via UPI, and book appointments. The project uses Flutter with BLoC state management, GoRouter navigation, GetIt DI, and ARB-based localization. All MVP screens are now built with mock repositories; the app is ready for real backend integration.

---

## 2. Architecture Quality

### Strengths
- Clean Architecture (`presentation/domain/data`) applied consistently across all 7 features
- BLoC pattern used throughout — every feature has its own Bloc, event, and state files
- Repository pattern: abstract domain interface + mock data implementation in every feature
- GoRouter `ShellRoute` for vendor and customer bottom nav shells
- GetIt DI: all 7 repositories registered as lazy singletons
- `flutter_screenutil` integrated; `.sp` scaling in `AppTypography`
- ARB-based localization with EN and HI — ~90 keys, both languages complete
- `AppColors`, `AppTypography` as design token system — consistently applied
- `equatable` on all models and BLoC states
- Shared widget library: `EmptyStateWidget`, `ErrorStateWidget`, `SectionHeader`, `AppCard`

### Known Weaknesses / Remaining Technical Debt
- `BillDetailsFormScreen` uses `NetworkImage('https://placeholder.com/bill')` — will throw at runtime
- `_CustomerTile` and `VendorTile` in vendor dashboard use `dynamic` type — no type safety on customer object
- Vendor dashboard outstanding amounts per customer are hardcoded (`₹1,250`) — not computed from ledger
- `hydrated_bloc` in pubspec but not used — reserved for auth session persistence
- `responsive_framework` in pubspec but not used
- `StorageService` (Hive) is an empty skeleton
- No auth BLoC — session not persisted across app restarts
- OTP verification is simulated only — no real SMS gateway stub
- Profile setup data not persisted anywhere

---

## 3. Feature Inventory

### 3.1 Auth Flow
| Screen | Status | Quality | Notes |
|--------|--------|---------|-------|
| SplashScreen | ✅ Done | Good | Auto-navigates after 2s |
| LanguageSelectionScreen | ✅ Done | Good | 12 languages listed; unsupported fallback to 'hi' |
| OnboardingScreen | ✅ Done | Good | 3-page PageView, fully localized |
| RoleSelectionScreen | ✅ Done | Good | Properly localized |
| LoginScreen | ✅ Done | Good | Phone + OTP flow simulated |
| ProfileSetupScreen | ✅ Done | Good | Vendor/customer differentiation |

**Gap:** No auth BLoC, no session persistence, no real OTP integration

---

### 3.2 Vendor Dashboard
| Screen/Component | Status | Quality | Notes |
|-----------------|--------|---------|-------|
| VendorDashboard | ✅ Done | Good | BLoC-driven, loading/error/loaded states |
| Notification bell → NotificationsScreen | ✅ Done | Good | Wired via `context.push(AppRouter.notifications)` |
| FAB → Add Customer sheet | ✅ Done | Good | Bottom sheet with l10n strings |
| Quick Action: Scan Bill | ✅ Done | Good | Pushes to `/scan-bill` |
| Quick Action: Remind All | ⚠️ Partial | — | Button present, no action implemented |
| Quick Action: Add New | ✅ Done | Good | Opens add customer sheet |
| StatCard widget | ✅ Done | Good | Reusable |
| ShellRoute bottom nav (4 tabs) | ✅ Done | Good | Home / Staff / Reports / Settings |
| Outstanding amounts per customer | ⚠️ Hardcoded | Poor | `₹1,250` hardcoded in `_CustomerTile` |
| Customer tile type safety | ⚠️ Weak | Poor | Uses `dynamic` type |

---

### 3.3 Shared Ledger
| Screen/Component | Status | Quality | Notes |
|-----------------|--------|---------|-------|
| SharedLedgerScreen | ✅ Done | Good | Full rebuild with BLoC |
| Balance header (credit direction) | ✅ Done | Good | Shows "You Will Get / Give" direction |
| Filter bar (All/Pending/Confirmed/Disputed) | ✅ Done | Good | Animated chips with active state |
| Entry cards with status chips | ✅ Done | Good | Confirm / Dispute inline for pending |
| Add Entry bottom sheet | ✅ Done | Good | Credit and payment forms |
| Confirm entry flow | ✅ Done | Good | Dispatches `ConfirmLedgerEntry` |
| Dispute entry flow | ✅ Done | Good | Bottom sheet with reason input |
| Entry detail bottom sheet | ✅ Done | Good | Full entry details shown |
| Immutable lock enforcement | ✅ Done | Good | Locked entries hide action buttons |
| LedgerRepository abstraction | ✅ Done | Good | Fixed — no longer uses VendorRepository |
| MockLedgerRepository | ✅ Done | Good | 5 in-memory entries, mutations work |
| LedgerBloc events (Load/Add/Confirm/Dispute/Filter) | ✅ Done | Good | All 5 handlers implemented |
| LedgerActionLoading overlay | ✅ Done | Good | Shows spinner during async actions |
| EmptyStateWidget | ✅ Done | Good | Used for empty ledger |
| ErrorStateWidget + retry | ✅ Done | Good | Used for load errors |
| Search entries | ❌ Missing | — | Not implemented |
| Attachment placeholder | ❌ Missing | — | Not implemented |
| PDF export placeholder | ❌ Missing | — | Button exists but not wired |

---

### 3.4 Customer Features
| Screen | Status | Quality | Notes |
|--------|--------|---------|-------|
| CustomerDashboard | ✅ Done | Fair | BLoC-driven |
| MyKhatasScreen | ✅ Done | Fair | Shows vendor list |
| PaymentsScreen | ✅ Done | Good | Rebuilt — BLoC-driven, PaymentBloc, mock data |
| SCAN & PAY → UpiPaymentScreen | ✅ Done | Good | Wired via GoRouter push with extras |
| CustomerProfileScreen | ⚠️ Static | Poor | Shows hardcoded "John Doe" |
| Settings accessible from customer shell | ❌ Missing | — | Not in customer bottom nav |

---

### 3.5 Staff Management
| Screen/Component | Status | Quality | Notes |
|-----------------|--------|---------|-------|
| StaffManagementScreen | ✅ Done | Good | Full BLoC rebuild, summary bar, staff cards |
| Staff cards with attendance popup | ✅ Done | Good | Present/Absent/Half Day popup menu |
| Add Staff bottom sheet | ✅ Done | Good | Role + salary type dropdowns, l10n |
| DropdownButtonFormField deprecation | ✅ Fixed | Good | `value` → `initialValue` |
| StaffDetailScreen | ✅ Done | Good | Created; monthly calendar, salary summary |
| Attendance calendar | ✅ Done | Good | Month-based grid with color-coded days |
| Month navigation (prev/next) | ✅ Done | Good | Dispatches `LoadAttendance` per month |
| Salary summary (rate × effective days) | ✅ Done | Good | Half-day = 0.5 |
| Pay salary bottom sheet | ✅ Done | Good | Amount + UPI transaction ID |
| Add advance bottom sheet | ✅ Done | Good | Amount + optional note |
| StaffModel, AttendanceRecord | ✅ Done | Good | Equatable, copyWith |
| StaffRepository abstraction | ✅ Done | Good | 7 methods |
| MockStaffRepository | ✅ Done | Good | 3 staff, realistic attendance map |
| StaffBloc (all 6 events) | ✅ Done | Good | Load/Add/MarkAttendance/LoadDetail/Pay/Advance |
| UPI salary payment deep link | ❌ Missing | — | Pay button doesn't navigate to UpiPaymentScreen |

---

### 3.6 Reports
| Screen | Status | Quality | Notes |
|--------|--------|---------|-------|
| ReportsScreen | ⚠️ Stub | Fair | Fake bar chart, hardcoded numbers |
| AllCustomersReportScreen | ✅ Done | Good | Static mock data |
| CustomerDetailReportScreen | ✅ Done | Fair | Static mock data |
| ReportsBloc | ❌ Missing | — | No state management |
| Time range filter | ❌ Missing | — | Not implemented |
| Revenue with real data | ❌ Missing | — | Hardcoded |
| Export PDF placeholder | ❌ Missing | — | Not wired |

---

### 3.7 Notifications
| Screen/Component | Status | Quality | Notes |
|-----------------|--------|---------|-------|
| NotificationsScreen | ✅ Done | Good | Full BLoC rebuild |
| Date grouping (Today/Yesterday/date) | ✅ Done | Good | Ordered sections |
| Read/unread styling + dot indicator | ✅ Done | Good | Tap to mark read |
| Mark All Read button | ✅ Done | Good | Shows only when unread > 0 |
| Type-specific icons and colors | ✅ Done | Good | 9 notification types handled |
| Relative time display | ✅ Done | Good | "5m ago", "2h ago", hh:mm fallback |
| NotificationModel (9 types) | ✅ Done | Good | Equatable, copyWith |
| NotificationRepository + Mock | ✅ Done | Good | 6 mock notifications |
| NotificationBloc | ✅ Done | Good | Load/MarkRead/MarkAllRead |
| Route `/notifications` | ✅ Done | Good | In router; accessible from vendor bell |
| Action navigation per type | ❌ Missing | — | Tapping notification doesn't deep-link |

---

### 3.8 Booking / Appointments
| Screen/Component | Status | Quality | Notes |
|-----------------|--------|---------|-------|
| VendorBookingsScreen | ✅ Done | Good | 7-day strip date selector, booking cards |
| CustomerBookingsScreen | ✅ Done | Good | Upcoming/past split, cancel confirm dialog |
| Booking cards with status badge | ✅ Done | Good | Colour-coded left border |
| Date selector strip | ✅ Done | Good | Scrollable, highlights today/selected |
| Cancel booking flow | ✅ Done | Good | AlertDialog with confirm |
| BookingModel, AppointmentSlot | ✅ Done | Good | Equatable, copyWith |
| BookingRepository + Mock | ✅ Done | Good | 3 bookings; 30-min slot generation |
| BookingBloc (all 6 events) | ✅ Done | Good | LoadVendor/Customer/Slots/Create/Cancel/Date |
| Route `/booking` (vendor) | ✅ Done | Good | In vendor ShellRoute |
| Route `/customer/booking` | ✅ Done | Good | In customer ShellRoute |
| Book new appointment UI | ❌ Missing | — | No new booking form from customer side |
| Slot picker UI | ❌ Missing | — | `LoadAvailableSlots` works but no UI |
| Booking in vendor bottom nav | ❌ Missing | — | Not in vendor nav tabs |

---

### 3.9 UPI / Payments
| Screen/Component | Status | Quality | Notes |
|-----------------|--------|---------|-------|
| UpiPaymentScreen | ✅ Done | Good | Amount display, UPI app row, success/failure states |
| UPI app row (GPay/PhonePe/Paytm/BHIM) | ✅ Done | Good | Shows "coming soon" snackbar |
| UPI ID text input + simulated flow | ✅ Done | Good | 2s delay → success |
| Payment success / failure views | ✅ Done | Good | Full-screen states |
| PaymentsScreen (customer) | ✅ Done | Good | Rebuilt with PaymentBloc, transaction history |
| Payment summary stats (paid/pending) | ✅ Done | Good | BLoC-driven |
| SCAN & PAY wired to UpiPaymentScreen | ✅ Done | Good | GoRouter push with extras |
| PaymentTransaction model | ✅ Done | Good | 4 status values |
| PaymentRepository + Mock | ✅ Done | Good | 3 transactions, recordPayment mutates list |
| PaymentBloc | ✅ Done | Good | Load/Record events |
| Route `/upi-payment` | ✅ Done | Good | Receives amount/recipientName/upiId via extras |
| Deep link from Pay Salary | ❌ Missing | — | StaffDetailScreen pay doesn't navigate here |

---

### 3.10 Settings
| Screen | Status | Quality | Notes |
|--------|--------|---------|-------|
| SettingsScreen | ⚠️ Stub | Fair | All strings hardcoded |
| Language switcher | ❌ Missing | — | Tile present, not wired to LocaleProvider |
| UPI management | ❌ Missing | — | Tile present, no screen |
| Logout action | ❌ Missing | — | Button not wired |

---

### 3.11 OCR / Voice Entry
| Screen | Status | Quality | Notes |
|--------|--------|---------|-------|
| ScanBillScreen | ✅ Done | Good | Camera placeholder |
| BillDetailsFormScreen | ⚠️ Partial | Fair | Pre-filled mock; uses broken NetworkImage URL |
| VoiceEntryScreen | ✅ Done | Good | Waveform placeholder |

---

## 4. Localization Status

### Current coverage
- **~90 keys** defined in both `app_en.arb` and `app_hi.arb`
- All new screens (notifications, staff, booking, payments, UPI) have l10n keys
- Keys are wired into: VendorDashboard, NotificationsScreen, PaymentsScreen, VendorBookingsScreen, CustomerBookingsScreen, UpiPaymentScreen, SharedLedgerScreen
- Abstract getters in `AppLocalizations`, EN in `AppLocalizationsEn`, HI in `AppLocalizationsHi`

### Still hardcoded (not yet wired)
- `SettingsScreen` — all strings
- `CustomerDashboard` — "Customer Mode", "My Vendors"
- `CustomerProfileScreen` — all strings
- `ReportsScreen` — date labels, "May 2024", chart labels
- `BillDetailsFormScreen` — "Verify Bill Details", "Save to Khata"
- `VoiceEntryScreen` — "Listening...", "Thinking...", "Detected Entry"
- Staff detail / management screens — partially wired; many internal strings still hardcoded

---

## 5. Navigation Map

### Vendor Shell Routes (`/vendor`, `/staff`, `/reports`, `/settings`, `/booking`)
- All in `VendorMainWrapper` ShellRoute
- Bottom nav: Home / Staff / Reports / Settings (Booking tab not yet in nav)

### Customer Shell Routes (`/customer`, `/customer/khatas`, `/customer/payments`, `/customer/profile`, `/customer/booking`)
- All in `CustomerMainWrapper` ShellRoute

### Global Push Routes (no shell)
- `/notifications` → NotificationsScreen
- `/upi-payment` → UpiPaymentScreen (requires extras: `amount`, `recipientName`, `upiId?`)
- `/ledger` → SharedLedgerScreen (requires extras: `id`, `name`)
- `/voice-entry` → VoiceEntryScreen
- `/scan-bill` → ScanBillScreen → `/bill-details`

### Remaining navigation gaps
- Staff pay salary does not navigate to `/upi-payment`
- Customer booking screen has no route into new booking flow
- Notifications do not deep-link to relevant screen
- Settings logout not wired to `/`
- Booking not in vendor bottom nav tabs

---

## 6. Dependency Injection

All 7 repositories registered in `lib/core/di/injection.dart`:

| Repository | Implementation |
|------------|---------------|
| `VendorRepository` | `MockVendorRepository` |
| `CustomerRepository` | `MockCustomerRepository` |
| `LedgerRepository` | `MockLedgerRepository` |
| `StaffRepository` | `MockStaffRepository` |
| `NotificationRepository` | `MockNotificationRepository` |
| `BookingRepository` | `MockBookingRepository` |
| `PaymentRepository` | `MockPaymentRepository` |

---

## 7. MVP Readiness Summary

| Module | UI Complete | BLoC Ready | Repository Ready | l10n | Backend-Ready |
|--------|------------|------------|-----------------|------|---------------|
| Auth | 90% | 0% | 0% | 90% | 0% |
| Vendor Dashboard | 90% | 80% | 60% | 85% | 0% |
| Shared Ledger | 85% | 100% | 100% | 75% | 0% |
| Customer Dashboard | 70% | 70% | 60% | 70% | 0% |
| Staff Management | 95% | 100% | 100% | 70% | 0% |
| Reports | 50% | 0% | 0% | 50% | 0% |
| Settings | 40% | 0% | 0% | 30% | 0% |
| Notifications | 95% | 100% | 100% | 90% | 0% |
| Booking | 80% | 100% | 100% | 80% | 0% |
| Payments/UPI | 90% | 100% | 100% | 85% | 0% |
| **Overall** | **~79%** | **~75%** | **~72%** | **~73%** | **0%** |

---

## 8. Remaining Work Before Backend Integration

### High Priority
1. Wire staff pay salary → navigate to `/upi-payment`
2. Add booking to vendor bottom nav (replace a tab or add booking entry point)
3. Wire settings language switcher to `LocaleProvider`
4. Wire settings logout to navigate to splash

### Medium Priority
5. Notification tap → deep link to relevant screen
6. Add new appointment booking UI (customer side: vendor selection + slot picker)
7. Fix `BillDetailsFormScreen` broken `NetworkImage` URL
8. Replace `dynamic` type in `_CustomerTile` with proper `UserModel`

### Low Priority (Post-Backend)
9. Auth BLoC + session persistence (HydratedBloc)
10. Real OTP via SMS gateway
11. Settings UPI management screen
12. Reports BLoC + real data
13. Customer profile dynamic data

---

*Last updated: 2026-05-14 — post-MVP UI implementation pass*
