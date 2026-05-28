import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/animations/rive/app_rive_icon.dart';
import '../../shared/widgets/app_bottom_nav_bar.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/role_selection_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_colors.dart';
import '../../features/vendor/presentation/bloc/vendor_bloc.dart';
import '../../features/vendor/presentation/bloc/vendor_event.dart';
import '../../features/vendor/presentation/screens/vendor_dashboard.dart';
import '../../features/customer/presentation/screens/customer_dashboard.dart';

import '../../features/shared_ledger/presentation/screens/shared_ledger_screen.dart';

import '../../features/voice_entry/presentation/screens/voice_entry_screen.dart';

import '../../features/staff/presentation/screens/staff_management_screen.dart';

import '../../features/reports/presentation/screens/reports_screen.dart';

import '../../features/settings/presentation/screens/settings_screen.dart';

import '../../features/customer/presentation/screens/my_khatas_screen.dart';
import '../../features/customer/presentation/screens/payments_screen.dart';
import '../../features/customer/presentation/screens/customer_profile_screen.dart';

import '../../features/reports/presentation/screens/all_customers_report_screen.dart';
import '../../features/vendor/presentation/screens/all_customers_screen.dart';
import '../../features/reports/presentation/screens/customer_detail_report_screen.dart';

import '../../features/bill_ocr/presentation/screens/scan_bill_screen.dart';
import '../../features/bill_ocr/presentation/screens/bill_details_form_screen.dart';

import '../../features/auth/presentation/screens/language_selection_screen.dart';
import '../../features/auth/presentation/screens/profile_setup_screen.dart';
import '../../features/auth/presentation/screens/edit_profile_screen.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/booking/presentation/screens/vendor_bookings_screen.dart';
import '../../features/booking/presentation/screens/customer_bookings_screen.dart';
import '../../features/booking/presentation/screens/book_appointment_screen.dart';
import '../../features/location/presentation/screens/location_picker_screen.dart';
import '../../shared/models/location_model.dart';
import '../../features/payments/presentation/screens/upi_payment_screen.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../di/injection.dart';
import 'auth_state_notifier.dart';

class AppRouter {
  static const String splash = '/';
  static const String languageSelection = '/language-selection';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String profileSetup = '/profile-setup';
  static const String vendorHome = '/vendor';
  static const String customerHome = '/customer';
  static const String customerKhatas = '/customer/khatas';
  static const String customerPayments = '/customer/payments';
  static const String customerProfile = '/customer/profile';
  static const String sharedLedger = '/ledger';
  static const String voiceEntry = '/voice-entry';
  static const String scanBill = '/scan-bill';
  static const String billDetailsForm = '/bill-details';
  static const String staffManagement = '/staff';
  static const String notifications = '/notifications';
  static const String vendorBookings = '/booking';
  static const String customerBookings = '/customer/booking';
  static const String upiPayment = '/upi-payment';
  static const String reports = '/reports';
  static const String allCustomers = '/vendor/customers';
  static const String allCustomersReport = '/reports/all-customers';
  static const String customerDetailReport = '/reports/customer-detail';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String bookAppointment = '/book-appointment';
  static const String locationPicker = '/location-picker';

  // Routes accessible without authentication
  static const _publicRoutes = {
    splash,
    languageSelection,
    onboarding,
    roleSelection,
    login,
    profileSetup,
  };

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    refreshListenable: getIt<AuthStateNotifier>(),
    redirect: (context, state) {
      final authState = getIt<AuthStateNotifier>().authState;
      final location = state.uri.path;
      final isPublic = _publicRoutes.contains(location) ||
          location.startsWith(profileSetup);

      if (authState is AuthAuthenticated) {
        // Send authenticated users away from public auth screens
        if (isPublic && location != splash) {
          return authState.user.isVendor ? vendorHome : customerHome;
        }
      }

      if (authState is AuthUnauthenticated) {
        // Block protected routes for unauthenticated users
        if (!isPublic) return roleSelection;
      }

      return null; // no redirect
    },
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: languageSelection,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: roleSelection,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: profileSetup,
        builder: (context, state) {
          final role = state.extra as String? ?? 'vendor';
          return ProfileSetupScreen(role: role);
        },
      ),
      // Vendor Flow with ShellRoute
      ShellRoute(
        builder: (context, state, child) {
          return VendorMainWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: vendorHome,
            builder: (context, state) => const VendorDashboard(),
          ),
          GoRoute(
            path: reports,
            builder: (context, state) => const ReportsScreen(),
          ),
          GoRoute(
            path: allCustomers,
            builder: (context, state) => const AllCustomersScreen(),
          ),
          GoRoute(
            path: allCustomersReport,
            builder: (context, state) => const AllCustomersReportScreen(),
          ),
          GoRoute(
            path: customerDetailReport,
            builder: (context, state) {
              final customer = state.extra as Map<String, dynamic>;
              return CustomerDetailReportScreen(customer: customer);
            },
          ),
          GoRoute(
            path: staffManagement,
            builder: (context, state) => const StaffManagementScreen(),
          ),
          GoRoute(
            path: vendorBookings,
            builder: (context, state) => const VendorBookingsScreen(),
          ),
          GoRoute(
            path: settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      // Customer Flow with ShellRoute
      ShellRoute(
        builder: (context, state, child) {
          return CustomerMainWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: customerHome,
            builder: (context, state) => const CustomerDashboard(),
          ),
          GoRoute(
            path: customerKhatas,
            builder: (context, state) => const MyKhatasScreen(),
          ),
          GoRoute(
            path: customerPayments,
            builder: (context, state) => const PaymentsScreen(),
          ),
          GoRoute(
            path: customerProfile,
            builder: (context, state) => const CustomerProfileScreen(),
          ),
          GoRoute(
            path: customerBookings,
            builder: (context, state) => const CustomerBookingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: sharedLedger,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          return SharedLedgerScreen(
            linkId: extras['linkId'] as String,
            customerName: extras['name'] as String,
            isVendorView: extras['isVendorView'] as bool? ?? true,
          );
        },
      ),
      GoRoute(
        path: notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: upiPayment,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          return UpiPaymentScreen(
            amount: (extras['amount'] as num).toDouble(),
            recipientName: extras['recipientName'] as String,
            upiId: extras['upiId'] as String?,
          );
        },
      ),
      GoRoute(
        path: voiceEntry,
        builder: (context, state) => const VoiceEntryScreen(),
      ),
      GoRoute(
        path: scanBill,
        builder: (context, state) => const ScanBillScreen(),
      ),
      GoRoute(
        path: billDetailsForm,
        builder: (context, state) => const BillDetailsFormScreen(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) {
          final user = state.extra as UserModel;
          return EditProfileScreen(user: user);
        },
      ),
      GoRoute(
        path: bookAppointment,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          return BookAppointmentScreen(
            vendorId: extras['vendorId'] as String,
            vendorName: extras['vendorName'] as String,
          );
        },
      ),
      GoRoute(
        path: locationPicker,
        builder: (context, state) => LocationPickerScreen(
          initialLocation: state.extra as LocationData?,
        ),
      ),
    ],
  );
}

class VendorMainWrapper extends StatelessWidget {
  final Widget child;
  const VendorMainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VendorBloc(getIt())..add(LoadVendorDashboard()),
      child: Builder(builder: (ctx) {
        final location = GoRouterState.of(ctx).uri.path;
        return Scaffold(
          extendBody: true,
          body: child,
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: _calculateSelectedIndex(ctx),
            onTap: (index) => _onTap(ctx, index),
            items: const [
              AppNavItem(riveIcon: AppRiveIcon.home,  label: 'Home'),
              AppNavItem(riveIcon: AppRiveIcon.user,  label: 'Staff'),
              AppNavItem(riveIcon: AppRiveIcon.clock, label: 'Booking'),
              AppNavItem(riveIcon: AppRiveIcon.stars, label: 'Reports'),
              AppNavItem(riveIcon: AppRiveIcon.gear,  label: 'Settings'),
            ],
          ),
          floatingActionButton: location == AppRouter.vendorHome
              ? FloatingActionButton.extended(
                  onPressed: () => showVendorAddCustomerSheet(ctx),
                  backgroundColor: AppColors.primary,
                  icon: const Icon(Icons.person_add_rounded, color: Colors.white),
                  label: const Text(
                    'ADD CUSTOMER',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              : null,
        );
      }),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == AppRouter.vendorHome) return 0;
    if (location == AppRouter.staffManagement) return 1;
    if (location == AppRouter.vendorBookings) return 2;
    if (location.startsWith(AppRouter.reports)) return 3;
    if (location == AppRouter.settings) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.vendorHome);
        break;
      case 1:
        context.go(AppRouter.staffManagement);
        break;
      case 2:
        context.go(AppRouter.vendorBookings);
        break;
      case 3:
        context.go(AppRouter.reports);
        break;
      case 4:
        context.go(AppRouter.settings);
        break;
    }
  }
}

class CustomerMainWrapper extends StatelessWidget {
  final Widget child;
  const CustomerMainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onTap(context, index),
        items: const [
          AppNavItem(riveIcon: AppRiveIcon.home,     label: 'Home'),
          AppNavItem(riveIcon: AppRiveIcon.message,  label: 'My Khatas'),
          AppNavItem(riveIcon: AppRiveIcon.clock,    label: 'Bookings'),
          AppNavItem(riveIcon: AppRiveIcon.zap,      label: 'Payments'),
          AppNavItem(riveIcon: AppRiveIcon.user,     label: 'Profile'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == AppRouter.customerHome) return 0;
    if (location == AppRouter.customerKhatas) return 1;
    if (location == AppRouter.customerBookings) return 2;
    if (location == AppRouter.customerPayments) return 3;
    if (location == AppRouter.customerProfile) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.customerHome);
        break;
      case 1:
        context.go(AppRouter.customerKhatas);
        break;
      case 2:
        context.go(AppRouter.customerBookings);
        break;
      case 3:
        context.go(AppRouter.customerPayments);
        break;
      case 4:
        context.go(AppRouter.customerProfile);
        break;
    }
  }
}
