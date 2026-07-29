import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// A single dashboard advert card. Admin-configured (system_settings key
/// `dashboard_adverts`, a JSON array), so images + deep-links are never
/// hardcoded and can change with no redeploy.
class DashboardAdvert {
  final String imageUrl; // remote image; empty rows are dropped
  final String link; // GetX route path (e.g. "/bills") or full https URL; may be empty
  final String title; // optional accessibility / overlay label
  final int sort; // ascending display order

  const DashboardAdvert({
    required this.imageUrl,
    required this.link,
    required this.title,
    required this.sort,
  });
}

/// Fetches + caches the dashboard adverts list from the admin settings endpoint
/// (`/api/v1/internal/voice-agents/settings`, the same no-auth poll the URL
/// registry + Help config use). Never throws — an unreachable backend or a
/// malformed value yields an EMPTY list, and the carousel widget renders a
/// single bundled default advert so the dashboard is never broken/blank.
///
/// Loading is async and independent of dashboard boot: the carousel calls
/// [ensure] after first frame and shows the bundled default until config lands,
/// so this can never block dashboard load.
class DashboardAdvertsService {
  DashboardAdvertsService._();
  static final DashboardAdvertsService instance = DashboardAdvertsService._();

  List<DashboardAdvert> _adverts = const <DashboardAdvert>[];
  DateTime? _fetchedAt;
  static const _ttl = Duration(minutes: 15);

  List<DashboardAdvert> get adverts => _adverts;

  Future<List<DashboardAdvert>> ensure() async {
    if (_fetchedAt != null && DateTime.now().difference(_fetchedAt!) < _ttl) {
      return _adverts;
    }
    try {
      final res = await http
          .get(Uri.parse(endpointRegistry.adminSettingsEndpoint))
          .timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body is Map<String, dynamic> ? body['settings'] : null;
        if (list is List) {
          String? raw;
          for (final s in list) {
            if (s is Map && s['key'] == 'dashboard_adverts' && s['value'] is String) {
              raw = s['value'] as String;
              break;
            }
          }
          _adverts = _parse(raw);
          _fetchedAt = DateTime.now();
        }
      }
    } catch (_) {
      // Keep last good / empty — the carousel falls back to the bundled default.
    }
    return _adverts;
  }

  List<DashboardAdvert> _parse(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const <DashboardAdvert>[];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const <DashboardAdvert>[];
      final out = <DashboardAdvert>[];
      for (final item in decoded) {
        if (item is! Map) continue;
        final imageUrl = (item['image_url'] ?? item['imageUrl'] ?? '').toString().trim();
        if (imageUrl.isEmpty) continue; // a row with no image is not renderable
        // active defaults to true; drop only when explicitly disabled.
        final active = item['active'];
        if (active == false) continue;
        final sortRaw = item['sort'];
        final sort = sortRaw is int
            ? sortRaw
            : int.tryParse('${sortRaw ?? ''}') ?? out.length;
        out.add(DashboardAdvert(
          imageUrl: imageUrl,
          link: (item['link'] ?? '').toString().trim(),
          title: (item['title'] ?? '').toString().trim(),
          sort: sort,
        ));
      }
      out.sort((a, b) => a.sort.compareTo(b.sort));
      return out;
    } catch (_) {
      return const <DashboardAdvert>[];
    }
  }
}
