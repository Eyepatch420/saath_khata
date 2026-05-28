import 'package:flutter/material.dart';
import 'app_rive_icon.dart';

/// Maps every [AppRiveIcon] to its Rive artboard names and a Material fallback.
///
/// Artboard names are taken directly from the binary of
/// 6477-12649-animated-icon-set.riv — do NOT change them.
///
///  idleArtboard   : the static / gently-looping artboard shown at rest.
///  hoverArtboard  : the animated artboard played on tap; null = no animation.
///  fallback       : Material icon used when Rive fails to load.
abstract final class AppRiveIconMapper {
  // ── Artboard name tables ──────────────────────────────────────────────────

  static const Map<AppRiveIcon, String> _idle = {
    AppRiveIcon.home:        'Home',
    AppRiveIcon.gear:        'Gear',
    AppRiveIcon.user:        'User',
    AppRiveIcon.edit:        'Edit',
    AppRiveIcon.download:    'Download',
    AppRiveIcon.refresh:     'Refresh',
    AppRiveIcon.stars:       'Stars',
    AppRiveIcon.dots:        'Dots',
    AppRiveIcon.message:     'Message',
    AppRiveIcon.mail:        'Mail',
    AppRiveIcon.clock:       'Clock',
    AppRiveIcon.diamond:     'Diamond',
    AppRiveIcon.arrow:       'Arrow',
    AppRiveIcon.fingerprint: 'Fingerprint',
    AppRiveIcon.sun:         'Sun',
    AppRiveIcon.wifi:        'Wifi',
    AppRiveIcon.zap:         'Zap',
    AppRiveIcon.atSign:      'At-sign',
    AppRiveIcon.eye:         'eye',
  };

  /// Every idle artboard has a confirmed HOVER variant in the .riv file.
  static const Map<AppRiveIcon, String> _hover = {
    AppRiveIcon.home:        'Home-HOVER',
    AppRiveIcon.gear:        'Gear-HOVER',
    AppRiveIcon.user:        'User-HOVER',
    AppRiveIcon.edit:        'Edit-HOVER',
    AppRiveIcon.download:    'Download-HOVER',
    AppRiveIcon.refresh:     'Refresh-HOVER',
    AppRiveIcon.stars:       'Stars-HOVER',
    AppRiveIcon.dots:        'Dots-HOVER',
    AppRiveIcon.message:     'Message-HOVER',
    AppRiveIcon.mail:        'Mail-HOVER',
    AppRiveIcon.clock:       'Clock-HOVER',
    AppRiveIcon.diamond:     'Diamond-HOVER',
    AppRiveIcon.arrow:       'Arrow-HOVER',
    AppRiveIcon.fingerprint: 'Fingerprint-HOVER',
    AppRiveIcon.sun:         'Sun-HOVER',
    AppRiveIcon.wifi:        'Wifi-HOVER',
    AppRiveIcon.zap:         'Zap-HOVER',
    AppRiveIcon.atSign:      'At-sign-HOVER',
    AppRiveIcon.eye:         'eye-HOVER',
  };

  static const Map<AppRiveIcon, IconData> _fallbacks = {
    AppRiveIcon.home:        Icons.home_rounded,
    AppRiveIcon.gear:        Icons.settings_rounded,
    AppRiveIcon.user:        Icons.person_rounded,
    AppRiveIcon.edit:        Icons.edit_rounded,
    AppRiveIcon.download:    Icons.download_rounded,
    AppRiveIcon.refresh:     Icons.refresh_rounded,
    AppRiveIcon.stars:       Icons.auto_awesome_rounded,
    AppRiveIcon.dots:        Icons.more_horiz_rounded,
    AppRiveIcon.message:     Icons.chat_bubble_outline_rounded,
    AppRiveIcon.mail:        Icons.mail_outline_rounded,
    AppRiveIcon.clock:       Icons.schedule_rounded,
    AppRiveIcon.diamond:     Icons.diamond_outlined,
    AppRiveIcon.arrow:       Icons.arrow_forward_rounded,
    AppRiveIcon.fingerprint: Icons.fingerprint_rounded,
    AppRiveIcon.sun:         Icons.wb_sunny_rounded,
    AppRiveIcon.wifi:        Icons.wifi_rounded,
    AppRiveIcon.zap:         Icons.flash_on_rounded,
    AppRiveIcon.atSign:      Icons.alternate_email_rounded,
    AppRiveIcon.eye:         Icons.visibility_rounded,
  };

  // ── Public API ────────────────────────────────────────────────────────────

  /// Artboard name for the idle / rest state.
  static String idleArtboard(AppRiveIcon icon) =>
      _idle[icon] ?? icon.name;

  /// Artboard name for the tap animation. Returns null if none mapped.
  static String? hoverArtboard(AppRiveIcon icon) => _hover[icon];

  /// Material icon used as fallback when Rive cannot load.
  static IconData fallback(AppRiveIcon icon) =>
      _fallbacks[icon] ?? Icons.circle_rounded;
}
