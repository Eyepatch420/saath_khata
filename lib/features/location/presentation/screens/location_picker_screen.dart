import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../features/location/data/services/location_iq_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/location_model.dart';

class LocationPickerScreen extends StatefulWidget {
  /// Pre-seed the map on an existing location (e.g. previously saved address).
  final LocationData? initialLocation;

  const LocationPickerScreen({super.key, this.initialLocation});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  // ── Map ──────────────────────────────────────────────────────────────────
  final _mapController = MapController();
  LatLng _center = const LatLng(28.6139, 77.2090); // default: New Delhi

  // ── Search ───────────────────────────────────────────────────────────────
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  List<LocationSuggestion> _suggestions = [];
  bool _showSuggestions = false;

  // ── Location details ─────────────────────────────────────────────────────
  LocationData? _location;
  bool _geocoding = false;

  // ── Timers ───────────────────────────────────────────────────────────────
  Timer? _mapDebounce;
  Timer? _searchDebounce;

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      final il = widget.initialLocation!;
      _center = LatLng(il.lat, il.lng);
      _location = il;
    } else {
      _tryCurrentLocation();
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    _mapDebounce?.cancel();
    _searchDebounce?.cancel();
    super.dispose();
  }

  // ── Current location ─────────────────────────────────────────────────────

  Future<void> _tryCurrentLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) { return; }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      final latLng = LatLng(pos.latitude, pos.longitude);
      if (!mounted) return;
      setState(() => _center = latLng);
      _mapController.move(latLng, 16);
      _reverseGeocode(latLng);
    } catch (_) {
      // Fall back to default center; reverse-geocode it
      _reverseGeocode(_center);
    }
  }

  // ── Map events ───────────────────────────────────────────────────────────

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    _center = camera.center;
    _mapDebounce?.cancel();
    _mapDebounce = Timer(const Duration(milliseconds: 700), () {
      _reverseGeocode(_center);
    });
  }

  // ── Geocoding ────────────────────────────────────────────────────────────

  Future<void> _reverseGeocode(LatLng latLng) async {
    if (!mounted) return;
    setState(() => _geocoding = true);
    final result =
        await LocationIQService.reverseGeocode(latLng.latitude, latLng.longitude);
    if (!mounted) return;
    setState(() {
      _location = result;
      _geocoding = false;
    });
  }

  // ── Search ───────────────────────────────────────────────────────────────

  void _onSearchChanged(String query) {
    _searchDebounce?.cancel();
    if (query.trim().length < 3) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await LocationIQService.autocomplete(query);
      if (!mounted) return;
      setState(() {
        _suggestions = results;
        _showSuggestions = results.isNotEmpty;
      });
    });
  }

  void _onSuggestionTap(LocationSuggestion s) {
    final latLng = LatLng(s.lat, s.lng);
    _mapController.move(latLng, 16);
    _searchController.text = s.displayName;
    _searchFocus.unfocus();
    setState(() {
      _center = latLng;
      _suggestions = [];
      _showSuggestions = false;
    });
    _reverseGeocode(latLng);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _suggestions = [];
      _showSuggestions = false;
    });
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── 1. Full-screen map ──────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
              onPositionChanged: _onPositionChanged,
            ),
            children: [
              TileLayer(
                urlTemplate: LocationIQService.tileUrlTemplate(),
                userAgentPackageName: 'com.saathkhata.app',
                maxZoom: 19,
              ),
              SimpleAttributionWidget(
                source: Text(AppLocalizations.of(context)!.mapAttribution),
              ),
            ],
          ),

          // ── 2. Top gradient for search bar readability ──────────────────
          IgnorePointer(
            child: Container(
              height: safeTop + 140,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
          ),

          // ── 3. Stationary center pin ────────────────────────────────────
          IgnorePointer(
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: AppColors.primary,
                      size: 52,
                      shadows: const [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    // Shadow dot at exact center
                    Container(
                      width: 10,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── 4. Back button + search bar ─────────────────────────────────
          Positioned(
            top: safeTop + 8,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    // Back button
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      elevation: 3,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.arrow_back_rounded, size: 22),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Search field
                    Expanded(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocus,
                          onChanged: _onSearchChanged,
                          style: AppTypography.bodyMedium
                              .copyWith(color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.searchPlaceHint,
                            hintStyle: AppTypography.bodySmall
                                .copyWith(color: Colors.black38),
                            prefixIcon: const Icon(Icons.search_rounded,
                                color: Colors.black45),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.close_rounded,
                                        color: Colors.black45, size: 20),
                                    onPressed: _clearSearch,
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Suggestions dropdown
                if (_showSuggestions) ...[
                  const SizedBox(height: 6),
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _suggestions.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, indent: 52),
                        itemBuilder: (_, i) {
                          final s = _suggestions[i];
                          return ListTile(
                            leading: const Icon(Icons.place_rounded,
                                color: AppColors.primary, size: 20),
                            title: Text(
                              s.displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodySmall
                                  .copyWith(color: Colors.black87),
                            ),
                            dense: true,
                            onTap: () => _onSuggestionTap(s),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── 5. FAB + bottom details card ────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // "My location" FAB — always glued right above the card
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 10),
                  child: FloatingActionButton(
                    heroTag: 'myLocation',
                    onPressed: _tryCurrentLocation,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    mini: false,
                    child: const Icon(Icons.my_location_rounded,
                        color: AppColors.primary),
                  ),
                ),

                // Details card
                _LocationCard(
                  location: _location,
                  geocoding: _geocoding,
                  lat: _center.latitude,
                  lng: _center.longitude,
                  onConfirm: _location == null
                      ? null
                      : () => Navigator.of(context).pop(_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Location details card ────────────────────────────────────────────────────

class _LocationCard extends StatelessWidget {
  final LocationData? location;
  final bool geocoding;
  final double lat;
  final double lng;
  final VoidCallback? onConfirm;

  const _LocationCard({
    required this.location,
    required this.geocoding,
    required this.lat,
    required this.lng,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.of(context).viewPadding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 16, 20, safeBottom + 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, -4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          if (geocoding) ...[
            const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 16),
          ] else if (location != null) ...[
            // Place name
            Row(
              children: [
                const Icon(Icons.location_on_rounded,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location!.shortAddress.isNotEmpty
                        ? location!.shortAddress
                        : location!.displayName,
                    style: AppTypography.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Full address
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                location!.displayName,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 14),
            // Lat / Lng chips
            Row(
              children: [
                _CoordChip(
                  label: 'LAT',
                  value: lat.toStringAsFixed(6),
                ),
                const SizedBox(width: 10),
                _CoordChip(
                  label: 'LNG',
                  value: lng.toStringAsFixed(6),
                ),
              ],
            ),
            if (location!.state != null || location!.country != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.flag_rounded,
                      color: AppColors.textHint, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    [location!.state, location!.country]
                        .whereType<String>()
                        .join(', '),
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textHint),
                  ),
                ],
              ),
            ],
          ] else ...[
            Text(AppLocalizations.of(context)!.moveMapToSelectLocation,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
          ],

          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onConfirm,
              icon: const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.white, size: 20),
              label: Text(AppLocalizations.of(context)!.confirmLocation,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoordChip extends StatelessWidget {
  final String label;
  final String value;
  const _CoordChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Text(value,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
