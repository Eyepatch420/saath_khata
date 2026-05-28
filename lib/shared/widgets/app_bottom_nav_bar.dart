import 'package:flutter/material.dart';
import '../animations/rive/app_rive_icon.dart';
import '../animations/rive/tap_animated_rive_icon.dart';
import '../../core/constants/app_colors.dart';

/// Pill background — dark navy matching the floating-bar design.
const _kPillColor = Color(0xFF252A41);

/// A single item definition for [AppBottomNavBar].
class AppNavItem {
  const AppNavItem({
    required this.riveIcon,
    required this.label,
  });

  final AppRiveIcon riveIcon;
  final String label;
}

/// Floating pill-shaped bottom navigation bar.
///
/// Each item holds a [GlobalKey<TapAnimatedRiveIconState>] so the Rive
/// animation can be fired **immediately on tap** — before the GoRouter
/// rebuild cycle begins — eliminating the timing gap that previously caused
/// animations to be dropped.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavItem> items;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(20, 8, 20, 16 + bottomPadding),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: _kPillColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            return Expanded(
              child: _PillNavItem(
                item: items[index],
                isActive: index == currentIndex,
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ── Private nav item ──────────────────────────────────────────────────────────

class _PillNavItem extends StatefulWidget {
  const _PillNavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final AppNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_PillNavItem> createState() => _PillNavItemState();
}

class _PillNavItemState extends State<_PillNavItem> {
  /// Direct handle to the Rive widget — lets us fire the animation
  /// synchronously on tap, before the GoRouter rebuild cycle.
  final _iconKey = GlobalKey<TapAnimatedRiveIconState>();

  void _handleTap() {
    _iconKey.currentState?.playAnimation();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isActive;

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Active indicator bar ──────────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              height: 3,
              width: isActive ? 24 : 0,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // ── Rive icon ─────────────────────────────────────────────
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isActive ? 1.12 : 1.0,
              child: TapAnimatedRiveIcon(
                key: _iconKey,
                icon: widget.item.riveIcon,
                size: 26,
                // No internal onTap — parent's GestureDetector owns the tap.
                fallbackColor: isActive
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
