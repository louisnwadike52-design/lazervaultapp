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

/// Bundled seed adverts. Shown when the admin hasn't configured any
/// (`dashboard_adverts` unset / unreachable) so the carousel launches with real
/// imagery instead of a single painted placeholder. Admin config fully replaces
/// these the moment it lands. Images depict our services in an African context
/// (royalty-free, hotlink-permitted Pexels CDN); each links to a real in-app
/// route and degrades to the painted card if the URL fails.
const List<DashboardAdvert> kSeedDashboardAdverts = <DashboardAdvert>[
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/4560063/pexels-photo-4560063.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/bills',
    title: 'Pay bills in seconds',
    sort: 0,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/19518397/pexels-photo-19518397.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/send-funds',
    title: 'Send money instantly',
    sort: 1,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/5991144/pexels-photo-5991144.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/exchange',
    title: 'Send money home',
    sort: 2,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/4559676/pexels-photo-4559676.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/rmb',
    title: 'Trade across borders',
    sort: 3,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/6744352/pexels-photo-6744352.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/crypto',
    title: 'Buy and sell crypto',
    sort: 4,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/8475146/pexels-photo-8475146.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/contactless-pay',
    title: 'Tap to pay',
    sort: 5,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/5727909/pexels-photo-5727909.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/insurance',
    title: 'Protect your family',
    sort: 6,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/30220079/pexels-photo-30220079.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/lock-funds',
    title: 'Save towards your goals',
    sort: 7,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/33749805/pexels-photo-33749805.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/group-account',
    title: 'Save with your group',
    sort: 8,
  ),
  DashboardAdvert(
    imageUrl:
        'https://images.pexels.com/photos/30677594/pexels-photo-30677594.jpeg?auto=compress&cs=tinysrgb&w=1200',
    link: '/whatsapp-banking',
    title: 'Bank right from chat',
    sort: 9,
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
