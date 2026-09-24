import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// A single dashboard advert card. Admin-configured (system_settings key
/// `dashboard_adverts`, a JSON array), so images + deep-links are never
/// hardcoded and can change with no redeploy.
class DashboardAdvert {
  final String imageUrl; // remote image; empty rows are dropped
  final String
      link; // GetX route path (e.g. "/bills") or full https URL; may be empty
  final String title; // headline drawn OVER the image by the carousel
  final String subtitle; // supporting line under the headline; may be empty
  final int sort; // ascending display order

  const DashboardAdvert({
    required this.imageUrl,
    required this.link,
    required this.title,
    this.subtitle = '',
    required this.sort,
  });
}

/// Bundled seed adverts. Shown when the admin hasn't configured any
/// (`dashboard_adverts` unset / unreachable) so the carousel launches with real
/// art instead of a single painted placeholder. Admin config fully replaces
/// these the moment it lands.
///
/// The art is served from OUR OWN storage service on api.lazervault.app. It
/// replaced five HOTLINKED images.pexels.com URLs — same photographs, but a
/// third party controlled whether they loaded at all, and the raw frames were
/// 3:2 so the card's ~3.3:1 crop threw away 45% of every one.
///
/// Each slide is now a composite: the photograph, a brand-colour wash, and a
/// left-weighted scrim, flattened to exactly 1242x376 so nothing is lost to
/// BoxFit. The wash is what lets five photos from five different shoots read as
/// one strip, and the scrim is what guarantees the overlaid copy stays legible
/// no matter how bright the frame behind it is. Regenerate with
/// scripts/compose_slides.py.
///
/// The art deliberately carries NO baked-in text. Copy lives in `title` /
/// `subtitle` and is drawn by Flutter over the image, so it stays crisp at every
/// pixel density and marketing can reword a slide from the admin dashboard
/// without re-exporting artwork.
///
/// Keep this list in step with AFRICAN_STARTER_ADVERTS in the admin dashboard's
/// DashboardAdvertsTab.tsx — they are two copies of the same defaults.
const List<DashboardAdvert> kSeedDashboardAdverts = <DashboardAdvert>[
  DashboardAdvert(
    imageUrl:
        'https://api.lazervault.app/v1/storage/objects/dashboard-adverts/brand/32fbc5ab-c5a9-4631-9cbb-e1e4ac05f731.webp',
    link: '/bills',
    title: 'Pay bills in seconds',
    subtitle: 'Electricity, data, TV and more',
    sort: 0,
  ),
  DashboardAdvert(
    imageUrl:
        'https://api.lazervault.app/v1/storage/objects/dashboard-adverts/brand/f7428d3c-daef-468b-9da2-b44db25c9336.webp',
    link: '/send-funds',
    title: 'Send money instantly',
    subtitle: 'To any bank in Nigeria, free',
    sort: 1,
  ),
  DashboardAdvert(
    imageUrl:
        'https://api.lazervault.app/v1/storage/objects/dashboard-adverts/brand/ac0d3e4d-4cfb-4791-801e-07d4b10290b0.webp',
    link: '/exchange',
    title: 'Send money home',
    subtitle: 'Great rates across borders',
    sort: 2,
  ),
  DashboardAdvert(
    imageUrl:
        'https://api.lazervault.app/v1/storage/objects/dashboard-adverts/brand/9c1414e7-964b-4259-93c9-5eceaaa62cce.webp',
    link: '/crypto',
    title: 'Buy and sell crypto',
    subtitle: 'Live rates, settled to your wallet',
    sort: 3,
  ),
  DashboardAdvert(
    imageUrl:
        'https://api.lazervault.app/v1/storage/objects/dashboard-adverts/brand/337d56d1-4ac6-492c-92fe-baea35392861.webp',
    link: '/lock-funds',
    title: 'Save towards your goals',
    subtitle: 'Lock funds and earn as you save',
    sort: 4,
  ),
];

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
            if (s is Map &&
                s['key'] == 'dashboard_adverts' &&
                s['value'] is String) {
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
        final imageUrl =
            (item['image_url'] ?? item['imageUrl'] ?? '').toString().trim();
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
          subtitle:
              (item['subtitle'] ?? item['sub_title'] ?? '').toString().trim(),
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
