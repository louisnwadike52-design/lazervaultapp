import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';

/// Resolves the Terms of Service / Privacy Policy / Gift-card T&C URLs shown
/// across the app. The URLs are admin-configurable and now come from a single
/// source of truth: the unified admin settings endpoint
/// (`/api/v1/internal/voice-agents/settings`), which returns fully-resolved
/// `*_url` values (base domain + per-link path concatenated server-side). The
/// legacy banking `GET /api/v1/legal/links` endpoint is kept only as a
/// resilience fallback for older backends. Built-in defaults are the last
/// fallback used when everything is unreachable, so the links always open.
class LegalLinksService {
  LegalLinksService._();
  static final LegalLinksService instance = LegalLinksService._();

  static const String _defaultTerms = 'https://lazervault.app/legal/terms';
  static const String _defaultPrivacy = 'https://lazervault.app/legal/privacy';
  // Gift-card-specific T&C surfaced on the gift-cards dashboard + sell flow.
  // Defaults to the generic terms so the link always resolves; admins can
  // repoint it (banking Configuration → legal_giftcard_terms_url) to a
  // dedicated gift-card page once published.
  static const String _defaultGiftcardTerms =
      'https://lazervault.app/legal/giftcards';

  // Endpoint the app fetches the admin-configured legal links from. A non-empty
  // TEST_BACKEND_HOST (compile-time) pins the legacy host:port shape (:8073 =
  // banking-service HTTP) for test harnesses; otherwise route through the
  // central registry's BANKING gateway base (already ends in /api/v1) so
  // there's no hardcoded host literal. /api/v1/legal/links is served by
  // banking-service's HTTP mux (see banking-service/cmd/main.go), NOT the core
  // gateway — use httpBanking so a local/dev build (distinct host:port) and any
  // admin repoint of the banking URL resolve to the right backend.
  static const String _testHost =
      String.fromEnvironment('TEST_BACKEND_HOST');
  static String get _legalUrl {
    if (_testHost.isNotEmpty) {
      return 'http://$_testHost:8073/api/v1/legal/links';
    }
    final banking = endpointRegistry.httpBanking.replaceAll(RegExp(r'/+$'), '');
    return '$banking/legal/links';
  }

  String _terms = _defaultTerms;
  String _privacy = _defaultPrivacy;
  String _giftcardTerms = _defaultGiftcardTerms;
  DateTime? _fetchedAt;
  static const _ttl = Duration(minutes: 30);

  String get termsUrl => _terms;
  String get privacyUrl => _privacy;
  String get giftcardTermsUrl => _giftcardTerms;

  /// Apply admin-configured URLs (empty values keep the current/default).
  void setUrls({String? terms, String? privacy, String? giftcardTerms}) {
    if (terms != null && terms.trim().isNotEmpty) _terms = terms.trim();
    if (privacy != null && privacy.trim().isNotEmpty) _privacy = privacy.trim();
    if (giftcardTerms != null && giftcardTerms.trim().isNotEmpty) {
      _giftcardTerms = giftcardTerms.trim();
    }
  }

  /// Fetches the latest admin-configured URLs (cached for [_ttl]). Safe to call
  /// on screen entry; never throws — falls back to the last good / default URLs
  /// so the legal links always open. Tries the unified settings endpoint first
  /// (single source of truth, server-resolved base+path), then the legacy
  /// banking endpoint.
  Future<void> refresh() async {
    if (_fetchedAt != null && DateTime.now().difference(_fetchedAt!) < _ttl) {
      return;
    }
    if (await _refreshFromUnified()) {
      _fetchedAt = DateTime.now();
      return;
    }
    await _refreshFromBanking();
  }

  /// Primary source: the unified admin settings list. Reads the fully-resolved
  /// `help_terms_url` / `help_privacy_url` / `giftcard_terms_url` values.
  Future<bool> _refreshFromUnified() async {
    try {
      final res = await http
          .get(Uri.parse(endpointRegistry.adminSettingsEndpoint))
          .timeout(const Duration(seconds: 6));
      if (res.statusCode != 200) return false;
      final body = jsonDecode(res.body);
      final list = body is Map<String, dynamic> ? body['settings'] : null;
      if (list is! List) return false;
      final m = <String, String>{};
      for (final raw in list) {
        if (raw is Map && raw['key'] is String && raw['value'] is String) {
          m[raw['key'] as String] = raw['value'] as String;
        }
      }
      setUrls(
        terms: m['help_terms_url'],
        privacy: m['help_privacy_url'],
        giftcardTerms: m['giftcard_terms_url'],
      );
      // Consider it a hit only if the unified list actually carried a legal link.
      return m.containsKey('giftcard_terms_url') || m.containsKey('help_terms_url');
    } catch (_) {
      return false;
    }
  }

  /// Fallback source: the legacy banking `/legal/links` endpoint.
  Future<void> _refreshFromBanking() async {
    try {
      final res =
          await http.get(Uri.parse(_legalUrl)).timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        setUrls(
          terms: body['terms_url']?.toString(),
          privacy: body['privacy_url']?.toString(),
          giftcardTerms: body['giftcard_terms_url']?.toString(),
        );
        _fetchedAt = DateTime.now();
      }
    } catch (_) {
      // Keep last good / default URLs — the legal links must always work.
    }
  }
}
