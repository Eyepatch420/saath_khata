import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/animations/rive/app_rive_icon.dart';
import '../../../../shared/widgets/app_bottom_nav_bar.dart';
import '../../../../core/router/app_router.dart';

/// Bottom-nav shell for the staff (labour) experience.
/// Only three tabs — Home, Customers, My Pay. No staff management, reports,
/// settings, or add-customer affordances.
class StaffMainWrapper extends StatelessWidget {
  final Widget child;
  const StaffMainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

/// Placeholder used until the full staff screens land (Part 2).
class StaffPlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  const StaffPlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.primary.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text('$title — coming soon',
                style: const TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
