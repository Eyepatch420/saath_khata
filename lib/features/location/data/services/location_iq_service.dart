import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/models/location_model.dart';

/// Geocoding via Nominatim (OpenStreetMap) — free, no API key required.
/// Tiles via openstreetmap.org — free for reasonable usage.
///
/// Nominatim usage policy: max 1 req/sec, must set a meaningful User-Agent.
class LocationIQService {
  static const _userAgent = 'SaathKhata/1.0 (wwwamaanansari0@gmail.com)';
  static const _nominatimBase = 'https://nominatim.openstreetmap.org';

  static const _headers = {
    'User-Agent': _userAgent,
    'Accept-Language': 'en',
  };

  /// OSM tile URL template for flutter_map — no API key needed.
  static String tileUrlTemplate() =>
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  /// Forward search/autocomplete via Nominatim — returns up to 6 suggestions.
  /// Caller MUST debounce (≥500 ms) — Nominatim forbids keystroke-by-keystroke calls.
  static Future<List<LocationSuggestion>> autocomplete(String query) async {
    if (query.trim().length < 3) return [];
    try {
      final uri = Uri.parse('$_nominatimBase/search').replace(
        queryParameters: {
          'q': query.trim(),
          'format': 'jsonv2',
          'limit': '6',
          'addressdetails': '1',
        },
      );
      final response = await http
          .get(uri, headers: _headers)
          .timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return [];
      final data = jsonDecode(response.body);
      if (data is! List) return [];
      return data
          .map((e) => LocationSuggestion.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Reverse geocode [lat]/[lng] → [LocationData] via Nominatim.
  static Future<LocationData?> reverseGeocode(double lat, double lng) async {
    try {
      final uri = Uri.parse('$_nominatimBase/reverse').replace(
        queryParameters: {
          'lat': lat.toStringAsFixed(7),
          'lon': lng.toStringAsFixed(7),
          'format': 'jsonv2',
          'addressdetails': '1',
          'zoom': '18',
        },
      );
      final response = await http
          .get(uri, headers: _headers)
          .timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return LocationData.fromReverseJson(data);
    } catch (_) {
      return null;
    }
  }
}
