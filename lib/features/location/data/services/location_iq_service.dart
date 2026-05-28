import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/models/location_model.dart';

class LocationIQService {
  static String get _key => dotenv.env['LOCATIONIQ_API_KEY'] ?? '';

  static const _baseUrl = 'https://us1.locationiq.com/v1';
  static const _headers = {'User-Agent': 'SaathKhata/1.0'};

  /// Tile URL template for flutter_map.
  static String tileUrlTemplate() =>
      'https://tiles.locationiq.com/v3/streets/r/{z}/{x}/{y}.png?key=$_key';

  /// Forward autocomplete — returns up to 6 suggestions for [query].
  static Future<List<LocationSuggestion>> autocomplete(String query) async {
    if (_key.isEmpty || query.trim().length < 3) return [];
    try {
      final uri = Uri.parse('$_baseUrl/autocomplete').replace(
        queryParameters: {
          'key': _key,
          'q': query.trim(),
          'limit': '6',
          'dedupe': '1',
          'normalizecity': '1',
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

  /// Reverse geocode [lat]/[lng] → [LocationData].
  static Future<LocationData?> reverseGeocode(double lat, double lng) async {
    if (_key.isEmpty) return null;
    try {
      final uri = Uri.parse('$_baseUrl/reverse').replace(
        queryParameters: {
          'key': _key,
          'lat': lat.toStringAsFixed(7),
          'lon': lng.toStringAsFixed(7),
          'format': 'json',
          'normalizecity': '1',
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
