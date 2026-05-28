import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'app_rive_icon.dart';
import 'app_rive_icon_mapper.dart';

/// A Rive icon that plays its HOVER artboard as a one-shot tap animation,
/// then automatically returns to the static idle artboard.
///
/// Architecture — artboard swapping:
///  • At rest   : renders the idle artboard (e.g. "Home").
///  • On tap    : switches to the HOVER artboard (e.g. "Home-HOVER").
///  • After [animationDuration] : switches back to the idle artboard.
///
/// No state machine inputs, no SMI triggers, no deprecated APIs.
///
/// Fallback safety:
///  • Material icon is shown while Rive loads.
///  • If idle artboard never calls [onInit] within 4 s, Material icon
///    stays permanently — the app never crashes or shows a blank space.
///
/// Public [TapAnimatedRiveIconState.playAnimation] lets parent widgets
/// (e.g. a bottom nav item) fire the animation programmatically.
class TapAnimatedRiveIcon extends StatefulWidget {
  const TapAnimatedRiveIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
    this.fallbackColor,
    this.animationDuration = const Duration(milliseconds: 700),
    this.onTap,
  });

  final AppRiveIcon icon;
  final double size;

  /// Color applied to the fallback Material icon only.
  final Color? fallbackColor;

  /// How long the HOVER artboard plays before returning to idle.
  final Duration animationDuration;

  /// Optional tap callback (animation fires regardless).
  final VoidCallback? onTap;

  @override
  TapAnimatedRiveIconState createState() => TapAnimatedRiveIconState();
}

/// Public state — exposes [playAnimation] for external triggering via
/// `GlobalKey<TapAnimatedRiveIconState>`.
class TapAnimatedRiveIconState extends State<TapAnimatedRiveIcon> {
  bool _showHover  = false;
  bool _idleReady  = false;
  bool _failed     = false;

  @override
  void initState() {
    super.initState();
    // Safety net: if idle artboard's onInit never fires, fall back
    // to Material icon so nothing is ever blank.
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && !_idleReady && !_failed) {
        setState(() => _failed = true);
      }
    });
  }

  // ── Idle artboard callbacks ───────────────────────────────────────────────

  void _onIdleInit(Artboard _) {
    // Idempotent — may be called again if idle widget is recreated.
    if (!_idleReady && mounted) setState(() => _idleReady = true);
  }

  // ── Public API ────────────────────────────────────────────────────────────

  /// Play the HOVER animation once, then return to idle.
  /// Safe to call even before Rive has finished loading.
  void playAnimation() {
    if (!mounted || _showHover) return;
    final hoverBoard = AppRiveIconMapper.hoverArtboard(widget.icon);
    if (hoverBoard == null) return; // Nothing to animate.
    setState(() => _showHover = true);
    Future.delayed(widget.animationDuration, () {
      if (mounted) setState(() => _showHover = false);
    });
  }

  // ── Internal tap handler ──────────────────────────────────────────────────

  void _handleTap() {
    playAnimation();
    widget.onTap?.call();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Permanent failure → Material icon stays.
    if (_failed) {
      return _FallbackIcon(
        icon: widget.icon,
        size: widget.size,
        color: widget.fallbackColor,
      );
    }

    final idleArtboard  = AppRiveIconMapper.idleArtboard(widget.icon);
    final hoverArtboard = AppRiveIconMapper.hoverArtboard(widget.icon);

    Widget riveContent;
    if (_showHover && hoverArtboard != null) {
      // HOVER artboard: add fresh to the tree → autoplay fires from frame 0.
      riveContent = RiveAnimation.asset(
        kRiveIconAsset,
        key: ValueKey('${widget.icon.name}_hover'),
        artboard: hoverArtboard,
        fit: BoxFit.contain,
      );
    } else {
      // IDLE artboard: static or gentle loop.
      riveContent = RiveAnimation.asset(
        kRiveIconAsset,
        key: ValueKey('${widget.icon.name}_idle'),
        artboard: idleArtboard,
        onInit: _onIdleInit,
        fit: BoxFit.contain,
      );
    }

    return GestureDetector(
      onTap: widget.onTap != null ? _handleTap : null,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            // Material fallback visible until idle artboard is ready.
            if (!_idleReady)
              _FallbackIcon(
                icon: widget.icon,
                size: widget.size,
                color: widget.fallbackColor,
              ),

            // Rive content — invisible until idle has loaded, then
            // crossfades between idle ↔ hover on each tap.
            AnimatedOpacity(
              opacity: _idleReady ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 130),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: child,
                ),
                child: riveContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private helpers ───────────────────────────────────────────────────────────

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({
    required this.icon,
    required this.size,
    this.color,
  });

  final AppRiveIcon icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      AppRiveIconMapper.fallback(icon),
      size: size,
      color: color,
    );
  }
}
