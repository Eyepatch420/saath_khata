import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _boxName = 'saath_khata_prefs';
  static const String _roleKey = 'app_role';
  static const String _localeKey = 'app_locale';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiresAtKey = 'token_expires_at';

  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  // ─── Role ──────────────────────────────────────────────────────────────────

  String? getRole() => _box.get(_roleKey) as String?;

  Future<void> setRole(String role) => _box.put(_roleKey, role);

  Future<void> clearRole() => _box.delete(_roleKey);

  // ─── Locale ────────────────────────────────────────────────────────────────

  String? getLocale() => _box.get(_localeKey) as String?;

  Future<void> setLocale(String localeCode) => _box.put(_localeKey, localeCode);

  // ─── JWT tokens ───────────────────────────────────────────────────────────

  String? getAccessToken() => _box.get(_accessTokenKey) as String?;

  String? getRefreshToken() => _box.get(_refreshTokenKey) as String?;

  /// Returns the UTC millisecond timestamp at which the access token expires.
  int? getTokenExpiresAt() => _box.get(_tokenExpiresAtKey) as int?;

  bool get isAccessTokenExpired {
    final expiresAt = getTokenExpiresAt();
    if (expiresAt == null) return true;
    // Consider expired 30 seconds early to avoid race conditions.
    return DateTime.now().millisecondsSinceEpoch >= expiresAt - 30000;
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresIn, // seconds from now
  }) async {
    final expiresAt =
        DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000);
    await Future.wait([
      _box.put(_accessTokenKey, accessToken),
      _box.put(_refreshTokenKey, refreshToken),
      _box.put(_tokenExpiresAtKey, expiresAt),
    ]);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _box.delete(_accessTokenKey),
      _box.delete(_refreshTokenKey),
      _box.delete(_tokenExpiresAtKey),
    ]);
  }

  Future<void> clearAll() async {
    await Future.wait([
      clearRole(),
      clearTokens(),
    ]);
  }
}
