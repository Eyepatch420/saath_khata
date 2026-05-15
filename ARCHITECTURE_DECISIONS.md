# SaathKhata — Architecture Decisions
**Version:** 1.1 | **Last Updated:** 2026-05-14

---

## 1. State Management: BLoC

**Decision:** `flutter_bloc ^8.1.6`

**Why:**
- Scales well for complex state with multiple async operations
- Clear separation: Event → BLoC → State → UI
- Equatable states enable efficient rebuilds
- Testable in isolation
- Applied consistently across all 7 feature BLoCs

**Current BLoCs:**
| BLoC | Feature | Events |
|------|---------|--------|
| `VendorBloc` | Vendor dashboard | `LoadVendorDashboard` |
| `CustomerBloc` | Customer dashboard | `LoadCustomerDashboard` |
| `LedgerBloc` | Shared ledger | `LoadLedger, AddEntry, ConfirmEntry, DisputeEntry, FilterLedger` |
| `StaffBloc` | Staff management | `LoadStaff, AddStaff, MarkAttendance, LoadAttendance, PaySalary, AddAdvance` |
| `NotificationBloc` | Notifications | `LoadNotifications, MarkRead, MarkAllRead` |
| `BookingBloc` | Appointments | `LoadVendorBookings, LoadCustomerBookings, LoadSlots, CreateBooking, CancelBooking, SelectDate` |
| `PaymentBloc` | Payments | `LoadPayments, RecordPayment` |

**Pattern:**
- One BLoC per feature screen (not shared across routes)
- BLoC created via `BlocProvider` at screen level, scoped to route
- Events use `abstract class ... extends Equatable`
- States use `abstract class ... extends Equatable`
- `ActionLoading` state (separate from `Loading`) preserves previous data during mutations

**ActionLoading pattern** (used in Ledger, Staff):
```dart
// Keep showing data while async action runs
class SomeActionLoading extends SomeState {}
// BLoC emits this before mutation, then refreshes
```

**HydratedBloc:** Available in pubspec (`hydrated_bloc: ^9.1.5`) — reserved for auth session persistence post-MVP.

---

## 2. Navigation: GoRouter

**Decision:** `go_router ^14` with `ShellRoute` for bottom navigation

**Why:**
- Deep link support from day one
- `ShellRoute` cleanly separates vendor/customer bottom nav shells
- Named route constants prevent typos

**Route Structure:**
```
/ → SplashScreen
/language-selection → LanguageSelectionScreen
/onboarding → OnboardingScreen
/role-selection → RoleSelectionScreen
/login → LoginScreen
/profile-setup → ProfileSetupScreen (+ extra: role string)

ShellRoute (VendorMainWrapper)
  /vendor → VendorDashboard
  /staff → StaffManagementScreen
  /booking → VendorBookingsScreen
  /reports → ReportsScreen
  /reports/all-customers → AllCustomersReportScreen
  /reports/customer-detail → CustomerDetailReportScreen (+ extra: customer map)
  /settings → SettingsScreen

ShellRoute (CustomerMainWrapper)
  /customer → CustomerDashboard
  /customer/khatas → MyKhatasScreen
  /customer/payments → PaymentsScreen
  /customer/profile → CustomerProfileScreen
  /customer/booking → CustomerBookingsScreen

Global push routes (no shell)
  /notifications → NotificationsScreen
  /upi-payment → UpiPaymentScreen (+ extra: amount, recipientName, upiId?)
  /ledger → SharedLedgerScreen (+ extra: id, name)
  /voice-entry → VoiceEntryScreen
  /scan-bill → ScanBillScreen
  /bill-details → BillDetailsFormScreen
```

**Navigation conventions:**
- `context.go()` — tab switching (replaces stack)
- `context.push()` — detail views (preserves back stack)
- `Navigator.push()` — screens not in GoRouter (e.g. `StaffDetailScreen`)

---

## 3. Dependency Injection: GetIt

**Decision:** `get_it ^8.0.2` with manual registration (no `injectable` codegen)

**Why:**
- Simple, no code generation required
- Lazy singleton for repositories
- All 7 repositories registered

**Current registrations (`lib/core/di/injection.dart`):**
```dart
getIt.registerLazySingleton<VendorRepository>(() => MockVendorRepository());
getIt.registerLazySingleton<CustomerRepository>(() => MockCustomerRepository());
getIt.registerLazySingleton<LedgerRepository>(() => MockLedgerRepository());
getIt.registerLazySingleton<StaffRepository>(() => MockStaffRepository());
getIt.registerLazySingleton<NotificationRepository>(() => MockNotificationRepository());
getIt.registerLazySingleton<BookingRepository>(() => MockBookingRepository());
getIt.registerLazySingleton<PaymentRepository>(() => MockPaymentRepository());
```

**Pattern:**
- Repositories → `lazySingleton` (single instance, app lifetime)
- BLoCs → instantiated in widget tree via `BlocProvider` (ephemeral, scoped to route)
- Only repositories live in DI — BLoCs are never registered in GetIt

---

## 4. Repository Pattern

**Decision:** Abstract interface + Mock implementation layer; API implementation future

**Directory structure per feature:**
```
domain/repositories/foo_repository.dart       ← Abstract interface (4–7 methods)
data/repositories/mock_foo_repository.dart    ← In-memory mock (current)
data/repositories/api_foo_repository.dart     ← REST implementation (future)
```

**All 7 current abstract repositories:**
| Repository | Methods |
|-----------|---------|
| `VendorRepository` | `getVendorData`, `getCustomers` |
| `CustomerRepository` | `getCustomerData`, `getVendors` |
| `LedgerRepository` | `getEntries`, `addEntry`, `confirmEntry`, `disputeEntry` |
| `StaffRepository` | `getStaffList`, `addStaff`, `markAttendance`, `getAttendanceForMonth`, `paySalary`, `addAdvance`, `updateStaff` |
| `NotificationRepository` | `getNotifications`, `markAsRead`, `markAllAsRead`, `getUnreadCount` |
| `BookingRepository` | `getVendorBookings`, `getCustomerBookings`, `getAvailableSlots`, `createBooking`, `updateBookingStatus` |
| `PaymentRepository` | `getCustomerTransactions`, `recordPayment` |

**Backend swap strategy:** Change one line per repository in `injection.dart` — zero UI or BLoC changes needed.

---

## 5. Data Models

**Decision:** Domain models in `lib/shared/models/` used by BLoCs and UI; DTOs deferred to backend integration

**Current models:**
| Model | File | Key Fields |
|-------|------|-----------|
| `UserModel` | `user_model.dart` | id, name, mobile, role, businessName, upiId |
| `LedgerEntry` | `ledger_entry.dart` | id, linkId, vendorId, customerId, amount, type, status, isLocked, disputeReason, attachmentUrl |
| `StaffModel` | `staff_model.dart` | id, vendorId, name, phone, role, salaryType, salaryAmount, presentToday, unpaidSalary, advanceTaken |
| `AttendanceRecord` | `staff_model.dart` | staffId, date, status |
| `AppNotification` | `notification_model.dart` | id, title, body, type, isRead, createdAt |
| `BookingModel` | `booking_model.dart` | id, vendorId, customerId, date, startTime, serviceType, status, notes |
| `AppointmentSlot` | `booking_model.dart` | id, vendorId, startTime, endTime, isAvailable |
| `PaymentTransaction` | `payment_transaction.dart` | id, vendorId, customerId, amount, upiTransactionId, status, note |

**Enums:**
| Enum | Values |
|------|--------|
| `EntryType` | credit, payment |
| `EntryStatus` | pending, confirmed, disputed, autoConfirmed |
| `SalaryType` | daily, weekly, monthly |
| `AttendanceStatus` | present, absent, halfDay, holiday |
| `NotificationType` | entryAdded, entryConfirmed, entryDisputed, paymentReceived, salaryPaid, bookingConfirmed, bookingCancelled, reminderDue, monthlySummary |
| `BookingStatus` | pending, confirmed, cancelled, completed |
| `PaymentStatus` | pending, success, failed, refunded |

**All models** have `Equatable` props and `copyWith` methods.

---

## 6. Localization: Flutter Gen-L10n

**Decision:** ARB files with `flutter gen-l10n` (manually maintained, not auto-generated during development)

**Current state:**
- `lib/l10n/app_en.arb` — ~90 keys (English)
- `lib/l10n/app_hi.arb` — ~90 keys (Hindi), full parity with EN
- `lib/l10n/app_localizations.dart` — abstract class with all getters
- `lib/l10n/app_localizations_en.dart` — EN implementations
- `lib/l10n/app_localizations_hi.dart` — HI implementations

**Important:** The generated Dart files are manually maintained alongside the ARB files during mock phase. When running `flutter gen-l10n` against the ARB files, the generated output must match the manually maintained files.

**Pattern:**
```dart
// Always at the top of build()
final l10n = AppLocalizations.of(context)!;
Text(l10n.someKey)
```

**Pitfall to avoid:** Adding a new import before wiring actual usage causes "unused import" warnings. Always add import AND usage in the same edit.

---

## 7. Theme System

**Decision:** Central `AppTheme`, `AppColors`, `AppTypography`

**Files:**
- `lib/core/constants/app_colors.dart` — all color tokens
- `lib/core/constants/app_typography.dart` — all text styles with `.sp` scaling
- `lib/core/theme/app_theme.dart` — `ThemeData` with InputDecoration, AppBar, Button themes

**Dark theme:** Skeleton in `AppTheme.dark` — not implemented for MVP.

---

## 8. Offline-First Strategy

**Decision:** No offline-first for MVP

**Rationale:**
- App targets users with basic smartphones and basic connectivity
- Mock repositories simulate network delays with `Future.delayed(const Duration(milliseconds: 300–600))`
- Conflict resolution adds significant complexity

**Future:** `hive` and `hive_flutter` in pubspec for potential offline caching. `StorageService` skeleton exists at `lib/core/storage/storage_service.dart`.

---

## 9. Backend Integration Swap Strategy

**Current (Mock):**
```dart
class MockLedgerRepository implements LedgerRepository {
  final List<LedgerEntry> _entries = [...mockData];

  @override
  Future<List<LedgerEntry>> getEntries(String linkId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _entries.where((e) => e.linkId == linkId).toList();
  }
}
```

**Future (REST API):**
```dart
class ApiLedgerRepository implements LedgerRepository {
  final ApiClient _client;
  ApiLedgerRepository(this._client);

  @override
  Future<List<LedgerEntry>> getEntries(String linkId) async {
    final response = await _client.get('/ledger/$linkId');
    return (response.data['items'] as List)
        .map((e) => LedgerEntryDto.fromJson(e).toDomain())
        .toList();
  }
}
```

**Swap:** Change one line per feature in `injection.dart`:
```dart
// Before
getIt.registerLazySingleton<LedgerRepository>(() => MockLedgerRepository());
// After
getIt.registerLazySingleton<LedgerRepository>(() => ApiLedgerRepository(getIt()));
```

**What needs to be built for backend integration:**
1. `ApiClient` wrapper (Dio-based, with JWT interceptor)
2. DTO layer for each model with `fromJson`/`toJson`
3. `ApiResponse<T>` generic wrapper
4. Pagination model
5. `AppError` model for error codes

---

## 10. UI Responsiveness

**Decision:** `flutter_screenutil` for font/size scaling

**Design base:** 390×844 (iPhone 14 Pro)

**Pattern:**
- Use `.sp` for font sizes (in `AppTypography`)
- Prefer flexible layouts (`Expanded`, `Flexible`, `double.infinity`)
- Fixed paddings (`const EdgeInsets.all(16/20/24)`) are acceptable for MVP
- Minimum 48×48 touch targets

**Note:** `responsive_framework` is in pubspec but not used. Post-MVP consideration for tablet layouts.

---

## 11. Security Assumptions (MVP)

- All screens assume authenticated user — no auth guard on routes
- JWT tokens will go in secure storage (Hive encrypted) — post-MVP
- No biometrics in MVP
- PIN not implemented
- All API calls will be HTTPS

---

## 12. What Is Intentionally Not Used

| Package / Pattern | Reason |
|-------------------|--------|
| `provider` (except `LocaleProvider`) | BLoC preferred for all feature state |
| `injectable` codegen | Not worth for current manual DI scale |
| `fl_chart` / `syncfusion` | Custom simple chart avoids extra dependency |
| `firebase_auth` | Backend will use Twilio/MSG91 OTP, not Firebase Auth |
| `url_launcher` / `upi_pay` | UPI deep link integration is post-MVP |
| Real `camera` plugin | `ScanBillScreen` is placeholder |
| Real `speech_to_text` | `VoiceEntryScreen` is placeholder |
| `freezed` for models | Manual `copyWith` is sufficient for current model count |
| `dio` / `retrofit` | No real API calls yet — reserved for backend integration |

---

*Last updated: 2026-05-14 — post-MVP UI implementation pass. Version bumped to 1.1.*
