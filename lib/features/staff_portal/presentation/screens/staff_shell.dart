import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/animations/rive/app_rive_icon.dart';
import '../../../../shared/widgets/app_bottom_nav_bar.dart';
import '../../../../core/router/app_router.dart';
import '../cubit/staff_portal_cubit.dart';

/// Bottom-nav shell for the staff (labour) experience.
/// Only three tabs — Home, Customers, My Pay. No staff management, reports,
/// settings, or add-customer affordances. Provides a shared [StaffPortalCubit].
class StaffMainWrapper extends StatelessWidget {
  final Widget child;
  const StaffMainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          StaffPortalCubit(getIt(), getIt())..load(),
      child: Scaffold(
        extendBody: true,
        body: child,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: _selectedIndex(context),
          onTap: (i) => _onTap(context, i),
          items: const [
            AppNavItem(riveIcon: AppRiveIcon.home, label: 'Home'),
            AppNavItem(riveIcon: AppRiveIcon.message, label: 'Customers'),
            AppNavItem(riveIcon: AppRiveIcon.zap, label: 'My Pay'),
          ],
        ),
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    if (loc == AppRouter.staffCustomers) return 1;
    if (loc == AppRouter.staffPay) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.staffHome);
        break;
      case 1:
        context.go(AppRouter.staffCustomers);
        break;
      case 2:
        context.go(AppRouter.staffPay);
        break;
    }
  }
}
