import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'flutter_flow_widgets.dart';
import 'lat_lng.dart';
import 'place.dart';

class FlutterFlowPlacePicker extends StatefulWidget {
  const FlutterFlowPlacePicker({
    Key? key,
    required this.iOSGoogleMapsApiKey,
    required this.androidGoogleMapsApiKey,
    required this.webGoogleMapsApiKey,
    required this.defaultText,
    this.icon,
    required this.buttonOptions,
    required this.onSelect,
    this.proxyBaseUrl,
  }) : super(key: key);

  final String iOSGoogleMapsApiKey;
  final String androidGoogleMapsApiKey;
  final String webGoogleMapsApiKey;
  final String? defaultText;
  final Widget? icon;
  final FFButtonOptions buttonOptions;
  final Function(FFPlace place) onSelect;
  final String? proxyBaseUrl;

  @override
  _FFPlacePickerState createState() => _FFPlacePickerState();
}

class _FFPlacePickerState extends State<FlutterFlowPlacePicker> {
  String? _selectedPlace;
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  String get googleMapsApiKey {
    if (kIsWeb) {
      return widget.webGoogleMapsApiKey;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.iOS:
        return widget.iOSGoogleMapsApiKey;
      case TargetPlatform.android:
        return widget.androidGoogleMapsApiKey;
      default:
        return widget.webGoogleMapsApiKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? languageCode = Localizations.localeOf(context).languageCode;
    return FFButtonWidget(
      text: _selectedPlace ?? widget.defaultText ?? 'Search places',
      icon: widget.icon,
      onPressed: () async {
        await _handlePlaceSelection(context, languageCode);
      },
      options: widget.buttonOptions,
    );
  }

  Future<void> _handlePlaceSelection(
      BuildContext context, String? languageCode) async {
    // Quick preflight: if Places is unavailable (e.g., billing disabled) skip
    // straight to the fallback search to avoid showing an empty list.
    final googleAvailable = await _isGooglePlacesAvailable(languageCode);
    if (!googleAvailable) {
      final fallback = await _showFallbackSearch(languageCode);
      if (fallback != null) {
        _updateSelectionFromPlace(fallback);
      }
      return;
    }

    bool googleError = false;
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleMapsApiKey,
      onError: (response) {
        googleError = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.errorMessage ??
                'Nao foi possivel buscar enderecos com o Google.'),
          ),
        );
      },
      mode: Mode.overlay,
      types: [],
      components: [],
      strictbounds: false,
      proxyBaseUrl: widget.proxyBaseUrl,
      language: languageCode,
    );

    if (p != null) {
      await displayPrediction(p, languageCode);
      return;
    }

    if (googleError) {
      final fallback = await _showFallbackSearch(languageCode);
      if (fallback != null) {
        _updateSelectionFromPlace(fallback);
      }
    }
  }

  Future<bool> _isGooglePlacesAvailable(String? languageCode) async {
    if (googleMapsApiKey.isEmpty) {
      return false;
    }
    try {
      final places = GoogleMapsPlaces(
        apiKey: googleMapsApiKey,
        baseUrl: widget.proxyBaseUrl,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final resp = await places.autocomplete(
        'rua',
        language: languageCode,
        sessionToken: const Uuid().v4(),
      );
      return resp.isOkay && resp.predictions.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<FFPlace?> _showFallbackSearch(String? languageCode) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    final results = <_FallbackSuggestion>[];
    var isLoading = false;
    return showModalBottomSheet<FFPlace>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        final mediaQuery = MediaQuery.of(sheetContext);
        return Padding(
          padding: EdgeInsets.only(
            bottom: mediaQuery.viewInsets.bottom + 16.0,
            left: 16.0,
            right: 16.0,
            top: 12.0,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Digite um endereco',
                    ),
                    onChanged: (value) {
                      _searchDebounce?.cancel();
                      _searchDebounce =
                          Timer(const Duration(milliseconds: 350), () async {
                        setModalState(() {
                          isLoading = true;
                        });
                        final suggestions = await _fetchFallbackSuggestions(
                          value,
                          languageCode,
                        );
                        setModalState(() {
                          results
                            ..clear()
                            ..addAll(suggestions);
                          isLoading = false;
                        });
                      });
                    },
                  ),
                  const SizedBox(height: 12.0),
                  if (isLoading) const LinearProgressIndicator(minHeight: 2.0),
                  if (results.isEmpty && controller.text.trim().length >= 3)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Nenhum endereco encontrado.'),
                      ),
                    ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final suggestion = results[index];
                        return ListTile(
                          leading: const Icon(Icons.place_outlined),
                          title: Text(suggestion.title),
                          subtitle: suggestion.subtitle != null
                              ? Text(suggestion.subtitle!)
                              : null,
                          onTap: () {
                            final place = _ffPlaceFromSuggestion(
                                suggestion, languageCode);
                            Navigator.of(sheetContext).pop(place);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    ).whenComplete(() {
      controller.dispose();
      focusNode.dispose();
    });
  }

  Future<List<_FallbackSuggestion>> _fetchFallbackSuggestions(
    String query,
    String? languageCode,
  ) async {
    final trimmed = query.trim();
    if (trimmed.length < 3) {
      return const [];
    }
    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
        'q': trimmed,
        'format': 'json',
        'addressdetails': '1',
        'limit': '8',
        'accept-language': languageCode ?? 'en',
      });
      final response = await http.get(
        uri,
        headers: const {
          'User-Agent': 'mh-personal-trainer-app/1.0 (autocomplete)',
        },
      );
      if (response.statusCode != 200) {
        return const [];
      }
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map(
            (item) => _FallbackSuggestion.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .whereNotNull()
          .toList();
    } catch (_) {
      return const [];
    }
  }

  FFPlace _ffPlaceFromSuggestion(
    _FallbackSuggestion suggestion,
    String? languageCode,
  ) {
    final addr = suggestion.address;
    final city = (addr['city'] ??
            addr['town'] ??
            addr['village'] ??
            addr['municipality'] ??
            '')
        .toString();
    final state = (addr['state'] ?? '').toString();
    final country = (addr['country_code'] ?? addr['country'] ?? '')
        .toString()
        .toUpperCase();
    final zipCode = (addr['postcode'] ?? '').toString();

    return FFPlace(
      latLng: LatLng(suggestion.lat, suggestion.lng),
      name: suggestion.title,
      address: suggestion.displayName,
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
    );
  }

  void _updateSelectionFromPlace(FFPlace place) {
    if (mounted) {
      setState(() {
        _selectedPlace = place.name.isNotEmpty ? place.name : place.address;
      });
    }
    widget.onSelect(place);
  }

  Future displayPrediction(Prediction? p, String? languageCode) async {
    if (p == null) {
      return;
    }
    final placeId = p.placeId;
    if (placeId == null) {
      return;
    }
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: googleMapsApiKey,
      baseUrl: widget.proxyBaseUrl,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(placeId, language: languageCode);
    if (mounted) {
      setState(() {
        _selectedPlace = detail.result.name;
      });
    }

    widget.onSelect(
      FFPlace(
        latLng: LatLng(
          detail.result.geometry?.location.lat ?? 0,
          detail.result.geometry?.location.lng ?? 0,
        ),
        name: detail.result.name,
        address: detail.result.formattedAddress ?? '',
        city: detail.result.addressComponents
                .firstWhereOrNull((e) => e.types.contains('locality'))
                ?.shortName ??
            detail.result.addressComponents
                .firstWhereOrNull((e) => e.types.contains('sublocality'))
                ?.shortName ??
            '',
        state: detail.result.addressComponents
                .firstWhereOrNull(
                    (e) => e.types.contains('administrative_area_level_1'))
                ?.shortName ??
            '',
        country: detail.result.addressComponents
                .firstWhereOrNull((e) => e.types.contains('country'))
                ?.shortName ??
            '',
        zipCode: detail.result.addressComponents
                .firstWhereOrNull((e) => e.types.contains('postal_code'))
                ?.shortName ??
            '',
      ),
    );
  }
}

class _FallbackSuggestion {
  const _FallbackSuggestion({
    required this.title,
    required this.subtitle,
    required this.displayName,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory _FallbackSuggestion.fromJson(Map<String, dynamic> json) {
    final address =
        Map<String, dynamic>.from(json['address'] as Map? ?? const {});
    final displayName = json['display_name']?.toString() ?? '';
    final title = (json['name'] ?? '').toString().isNotEmpty
        ? json['name'].toString()
        : displayName.split(',').first.trim();
    return _FallbackSuggestion(
      title: title.isNotEmpty ? title : displayName,
      subtitle: _buildSubtitle(address, displayName),
      displayName: displayName,
      lat: double.tryParse(json['lat']?.toString() ?? '') ?? 0,
      lng: double.tryParse(json['lon']?.toString() ?? '') ?? 0,
      address: address,
    );
  }

  static String? _buildSubtitle(
    Map<String, dynamic> address,
    String displayName,
  ) {
    final pieces = [
      address['road'],
      address['neighbourhood'],
      address['city'] ?? address['town'] ?? address['village'],
      address['state'],
    ].where((e) => (e ?? '').toString().isNotEmpty).map((e) => e.toString());
    final subtitle = pieces.join(', ');
    if (subtitle.isNotEmpty) {
      return subtitle;
    }
    final parts = displayName.split(',');
    if (parts.length > 1) {
      return parts.skip(1).take(2).map((e) => e.trim()).join(', ');
    }
    return null;
  }

  final String title;
  final String? subtitle;
  final String displayName;
  final double lat;
  final double lng;
  final Map<String, dynamic> address;
}
