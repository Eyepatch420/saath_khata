# SaathKhata — UI Component Map
**Last Updated:** 2026-05-14  
**Purpose:** Catalog of all reusable widgets, shared components, screens, and design patterns

---

## Shared Widgets (`lib/shared/widgets/`)

| Widget | File | Props | Status | Usage |
|--------|------|-------|--------|-------|
| `EmptyStateWidget` | `empty_state_widget.dart` | `icon, title, subtitle, actionLabel?, onAction?` | ✅ Done | Empty list/error screens across all features |
| `ErrorStateWidget` | `error_state_widget.dart` | `message, onRetry` | ✅ Done | BLoC error states across all features |
| `SectionHeader` | `section_header.dart` | `title, actionLabel?, onAction?` | ✅ Done | Section titles with optional "View All" |
| `AppCard` | `app_card.dart` | `child, padding?, onTap?` | ✅ Done | Standard card container with InkWell |

**Still to create:**
| Widget | File | Props | Notes |
|--------|------|-------|-------|
| `LoadingWidget` | `loading_widget.dart` | `message?` | Currently inline `CircularProgressIndicator` everywhere |
| `StatusChip` | `status_chip.dart` | `status (EntryStatus)` | Currently inline in SharedLedgerScreen |
| `AmountText` | `amount_text.dart` | `amount, isCredit, style?` | Colored rupee amounts |
| `ConfirmDialog` | `confirm_dialog.dart` | `title, message, confirmLabel, onConfirm` | Reusable confirm |

---

## Core Widgets (`lib/core/widgets/`)

| Widget | File | Props | Status |
|--------|------|-------|--------|
| `PrimaryButton` | `primary_button.dart` | `label, onPressed, isLoading, backgroundColor` | ✅ Done |
| `CustomTextField` | `custom_text_field.dart` | `label, hintText, prefixIcon, keyboardType, isPassword, controller` | ✅ Done |

---

## Feature-Specific Widgets

### Vendor Feature (`lib/features/vendor/presentation/widgets/`)
| Widget | File | Status | Notes |
|--------|------|--------|-------|
| `StatCard` | `stat_card.dart` | ✅ Done | Summary stats (outstanding, collected) |
| `_QuickAction` | inline in `vendor_dashboard.dart` | ✅ Done | Icon + label quick action |
| `_CustomerTile` | inline in `vendor_dashboard.dart` | ⚠️ Partial | Uses `dynamic` type — needs `UserModel` |

### Customer Feature (`lib/features/customer/presentation/widgets/`)
| Widget | File | Status | Notes |
|--------|------|--------|-------|
| `TotalDueCard` | `total_due_card.dart` | ✅ Done | Dark card showing total outstanding + Pay All button |
| `VendorTile` | `vendor_tile.dart` | ✅ Done | Vendor row with outstanding amount |

### Shared Ledger (`lib/features/shared_ledger/presentation/screens/shared_ledger_screen.dart`)
All widgets are private classes within the screen file:
| Widget | Notes |
|--------|-------|
| `_BalanceHeader` | Balance amount + credit direction text + Statement button |
| `_FilterBar` | Animated chip filter (All/Pending/Confirmed/Disputed) |
| `_StatusChip` | Status + icon chip |
| `_EntryCard` | Full entry card with confirm/dispute buttons |
| `_AddEntrySheet` | Bottom sheet — credit or payment form |
| `_DisputeSheet` | Bottom sheet — reason text field |
| `_EntryDetailSheet` | Bottom sheet — full entry details |

### Staff Feature (`lib/features/staff/presentation/screens/`)
All widgets are private classes within the screen files:

**staff_management_screen.dart:**
| Widget | Notes |
|--------|-------|
| `_StaffSummaryBar` | Present count + unpaid salary bar |
| `_StaffCard` | Avatar, role, salary type, attendance status, attendance popup |
| `_AttendanceTodayButton` | `PopupMenuButton` for marking today's attendance |

**staff_detail_screen.dart:**
| Widget | Notes |
|--------|-------|
| `_ProfileCard` | Name, role, phone, join date, active badge |
| `_SalaryCard` | Rate, days present, earned, unpaid, advance |
| `_SalaryStat` | Individual stat cell |
| `_AttendanceCalendar` | Month grid with prev/next navigation |
| `_DayCell` | Single calendar day — color-coded by status |
| `_CalendarLegend` | Present/Absent/Half Day legend |
| `_ActionButtons` | Add Advance + Pay Salary buttons |

### Booking Feature (`lib/features/booking/presentation/screens/`)
All widgets are private classes within the screen files:

**vendor_bookings_screen.dart:**
| Widget | Notes |
|--------|-------|
| `_DateSelector` | 7-day horizontal scrollable date strip |
| `_BookingCard` | Left-border color card with time, customer, service |
| `_StatusBadge` | Confirmed/Pending/Cancelled/Done pill |

**customer_bookings_screen.dart:**
| Widget | Notes |
|--------|-------|
| `_BookingsList` | Separates upcoming vs past bookings |
| `_CustomerBookingCard` | Full booking card with vendor name, time, cancel |
| `_StatusChip` | Status pill (mirrors vendor badge) |

### Notifications (`lib/features/notifications/presentation/screens/notifications_screen.dart`)
| Widget | Notes |
|--------|-------|
| `_NotificationsList` | Date-grouped list using `_groupByDate()` |
| `_NotificationCard` | Read/unread styling, icon, time, blue dot indicator |

### Payments (`lib/features/customer/presentation/screens/payments_screen.dart`)
| Widget | Notes |
|--------|-------|
| `_SummaryRow` | Total Paid + Pending stat cards |
| `_SummaryStat` | Individual stat cell with icon |
| `_QuickPayCard` | QR icon + SCAN & PAY button |
| `_PaymentTile` | Transaction row with status badge |

### UPI Payment (`lib/features/payments/presentation/screens/upi_payment_screen.dart`)
| Widget | Notes |
|--------|-------|
| `_AmountDisplay` | Avatar + recipient name + large amount |
| `_UpiAppsRow` | GPay / PhonePe / Paytm / BHIM app icons |
| `_OrDivider` | Divider with "OR" label |
| `_SuccessView` | Full-screen success state (green check) |
| `_FailureView` | Full-screen failure state (retry button) |

### Reports (`lib/features/reports/presentation/screens/`)
| Widget | File | Notes |
|--------|------|-------|
| `RevenueBarChart` | inline in `reports_screen.dart` | Custom bar chart (no external lib) |

---

## Screen Inventory

| Screen | Route | Role | Status | BLoC | Notes |
|--------|-------|------|--------|------|-------|
| SplashScreen | `/` | Both | ✅ Done | — | Auto-navigates 2s |
| LanguageSelectionScreen | `/language-selection` | Both | ✅ Done | — | 12 languages |
| OnboardingScreen | `/onboarding` | Both | ✅ Done | — | 3-page PageView |
| RoleSelectionScreen | `/role-selection` | Both | ✅ Done | — | Vendor/Customer |
| LoginScreen | `/login` | Both | ✅ Done | — | Phone + OTP simulation |
| ProfileSetupScreen | `/profile-setup` | Both | ✅ Done | — | Role-aware form |
| VendorDashboard | `/vendor` | Vendor | ✅ Done | VendorBloc | Notification bell + FAB wired |
| StaffManagementScreen | `/staff` | Vendor | ✅ Done | StaffBloc | Full BLoC rebuild |
| StaffDetailScreen | `Navigator.push` | Vendor | ✅ Done | StaffBloc | Calendar + salary |
| VendorBookingsScreen | `/booking` | Vendor | ✅ Done | BookingBloc | 7-day date strip |
| ReportsScreen | `/reports` | Vendor | ⚠️ Stub | — | Fake chart |
| AllCustomersReportScreen | `/reports/all-customers` | Vendor | ✅ Done | — | Static data |
| CustomerDetailReportScreen | `/reports/customer-detail` | Vendor | ✅ Done | — | Static data |
| SettingsScreen | `/settings` | Both | ⚠️ Stub | — | Hardcoded strings |
| NotificationsScreen | `/notifications` | Both | ✅ Done | NotificationBloc | Date-grouped |
| CustomerDashboard | `/customer` | Customer | ✅ Done | CustomerBloc | — |
| MyKhatasScreen | `/customer/khatas` | Customer | ✅ Done | — | Vendor list |
| PaymentsScreen | `/customer/payments` | Customer | ✅ Done | PaymentBloc | Transaction history |
| CustomerBookingsScreen | `/customer/booking` | Customer | ✅ Done | BookingBloc | Upcoming/past |
| CustomerProfileScreen | `/customer/profile` | Customer | ⚠️ Static | — | Hardcoded "John Doe" |
| SharedLedgerScreen | `/ledger` | Both | ✅ Done | LedgerBloc | Full feature |
| VoiceEntryScreen | `/voice-entry` | Vendor | ✅ Done | — | Placeholder |
| ScanBillScreen | `/scan-bill` | Vendor | ✅ Done | — | Camera placeholder |
| BillDetailsFormScreen | `/bill-details` | Vendor | ⚠️ Partial | — | Broken NetworkImage |
| UpiPaymentScreen | `/upi-payment` | Both | ✅ Done | — | Success/fail states |

---

## Design System Reference

### Colors (`AppColors`) — `lib/core/constants/app_colors.dart`
| Token | Value | Usage |
|-------|-------|-------|
| `primary` | `#00C896` | Primary teal green — buttons, active states |
| `secondary` | `#0F2027` | Deep navy — dark gradient, secondary actions |
| `background` | `#F8F9FA` | Screen background |
| `surface` | `#FFFFFF` | Card and sheet background |
| `error` | `#E53935` | Errors, disputed entries, absent |
| `success` | `#4CAF50` | Success, confirmed entries, present |
| `warning` | `#FFB300` | Pending states, half-day, advance taken |
| `textPrimary` | `#1A1A1A` | Primary text |
| `textSecondary` | `#757575` | Secondary/body text |
| `textHint` | `#BDBDBD` | Hints, placeholders, captions |
| `divider` | `#EEEEEE` | Separators |
| `vendorAccent` | `#00C896` | Vendor-specific highlights |
| `customerAccent` | `#2196F3` | Customer-specific highlights |

### Typography (`AppTypography`) — `lib/core/constants/app_typography.dart`
| Style | Font | Size | Weight | Usage |
|-------|------|------|--------|-------|
| `h1` | Poppins | 24sp | Bold | Page titles, large amounts |
| `h2` | Poppins | 20sp | SemiBold | Section titles |
| `h3` | Poppins | 18sp | SemiBold | Card titles, sheet headers |
| `bodyLarge` | Inter | 16sp | Regular | Body text |
| `bodyMedium` | Inter | 14sp | Regular | Descriptions, form fields |
| `bodySmall` | Inter | 12sp | Regular | Captions, metadata, chips |
| `labelLarge` | Inter | 14sp | Medium | Labels, list item names |
| `button` | Poppins | 16sp | SemiBold | Button text |

### Spacing Guidelines
```dart
const double spacingXS = 4;
const double spacingS = 8;
const double spacingM = 12;
const double spacingL = 16;
const double spacingXL = 20;
const double spacingXXL = 24;
const double spacingSection = 32;
```

### Border Radius
```dart
const double radiusS = 8;
const double radiusM = 12;
const double radiusL = 16;
const double radiusXL = 20;
const double radiusRound = 100; // chips/pills
```

---

## State Management Patterns

### BLoC Pattern (all feature screens)
```dart
// Screen creates BLoC with DI
BlocProvider(
  create: (context) => SomeBloc(getIt())..add(LoadEvent()),
  child: const SomeView(),
)

// View reacts to states
BlocBuilder<SomeBloc, SomeState>(
  builder: (context, state) {
    if (state is SomeLoading) return const Center(child: CircularProgressIndicator());
    if (state is SomeError) return ErrorStateWidget(message: state.message, onRetry: ...);
    if (state is SomeLoaded) return SomeContent(state: state);
    return const SizedBox();
  },
)

// ActionLoading overlay pattern (used in Ledger + Staff)
if (state is SomeActionLoading) {
  return Stack(children: [
    SomeContent(state: lastLoadedState),
    const Center(child: CircularProgressIndicator()),
  ]);
}

// Dispatching events
context.read<SomeBloc>().add(SomeEvent(params));
```

### Bottom Sheet Pattern
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  ),
  builder: (ctx) => Padding(
    padding: EdgeInsets.only(
      left: 24, right: 24, top: 24,
      bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
    ),
    child: Column(mainAxisSize: MainAxisSize.min, ...),
  ),
);
```

### GoRouter Navigation Pattern
```dart
// Tab navigation (no back stack)
context.go(AppRouter.staffManagement);

// Detail navigation (with back stack)
context.push(AppRouter.notifications);

// With extras
context.push(AppRouter.upiPayment, extra: {
  'amount': 1250.0,
  'recipientName': 'Mohan Lal',
  'upiId': null,
});

// Navigator.push for screens without GoRouter route
Navigator.push(context, MaterialPageRoute(
  builder: (_) => StaffDetailScreen(staff: staff),
));
```

### L10n Pattern
```dart
// Always resolve l10n at the start of build()
final l10n = AppLocalizations.of(context)!;

// Use in widget tree
Text(l10n.staffAndLabour)
```

---

*Last updated: 2026-05-14 — post-MVP UI implementation pass*
