import 'package:flutter/foundation.dart';

/// Central logger. All output is suppressed in release builds.
///
/// Usage:
///   AppLogger.i('Auth', 'User logged in: ravi@dairy.com');
///   AppLogger.e('API',  'POST /staff failed', error);
class AppLogger {
  AppLogger._();

  // ─── Public API ────────────────────────────────────────────────────────────

  /// Verbose — fine-grained detail (request/response bodies, state internals).
  static void v(String module, String msg) =>
      _print('V', module, msg);

  /// Info — notable events (state transitions, successful API calls).
  static void i(String module, String msg) =>
      _print('I', module, msg);

  /// Warning — something unexpected but recovered (fallback used, retry, etc.).
  static void w(String module, String msg) =>
      _print('W', module, msg);

  /// Error — operation failed (caught exception, failed request).
  static void e(String module, String msg, [Object? error]) {
    _print('E', module, error != null ? '$msg — $error' : msg);
  }

  // ─── Internal ──────────────────────────────────────────────────────────────

  static void _print(String level, String module, String msg) {
    if (!kDebugMode) return;
    final ts = _timestamp();
    final prefix = _levelPrefix(level);
    debugPrint('$prefix [$ts] [$module] $msg');
  }

  static String _timestamp() {
    final now = DateTime.now();
    final h  = now.hour.toString().padLeft(2, '0');
    final mi = now.minute.toString().padLeft(2, '0');
    final s  = now.second.toString().padLeft(2, '0');
    final ms = now.millisecond.toString().padLeft(3, '0');
    return '$h:$mi:$s.$ms';
  }

  static String _levelPrefix(String level) {
    switch (level) {
      case 'V': return '🔍';
      case 'I': return '✅';
      case 'W': return '⚠️ ';
      case 'E': return '❌';
      default:  return '  ';
    }
  }
}
