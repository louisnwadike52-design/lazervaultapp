import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';

/// Resolves the Terms of Service / Privacy Policy URLs shown across the app
/// (e.g. the BVN verification screen). The URLs are admin-configurable: the
/// backend stores them in system_settings (banking config) and exposes them at
/// GET /api/v1/legal/links. This service fetches + caches them so the app uses
/// the admin-set values rather than hardcoded ones. The built-in defaults are
/// only a fallback used when the backend is unreachable, so the links always open.
class LegalLinksService {
  LegalLinksService._();
  static final LegalLinksService instance = LegalLinksService._();

  static const String _defaultTerms = 'https://lazervault.app/legal/terms';
  static const String _defaultPrivacy = 'https://lazervault.app/legal/privacy';

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
  DateTime? _fetchedAt;
  static const _ttl = Duration(minutes: 30);

  String get termsUrl => _terms;
  String get privacyUrl => _privacy;

  /// Apply admin-configured URLs (empty values keep the current/default).
  void setUrls({String? terms, String? privacy}) {
    if (terms != null && terms.trim().isNotEmpty) _terms = terms.trim();
    if (privacy != null && privacy.trim().isNotEmpty) _privacy = privacy.trim();
  }

  /// Fetches the latest admin-configured URLs from system_settings (cached for
  /// [_ttl]). Safe to call on screen entry; never throws — falls back to the last
  /// good / default URLs so the legal links always open.
  Future<void> refresh() async {
    if (_fetchedAt != null && DateTime.now().difference(_fetchedAt!) < _ttl) {
      return;
    }
    try {
      final res =
          await http.get(Uri.parse(_legalUrl)).timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        setUrls(
          terms: body['terms_url']?.toString(),
          privacy: body['privacy_url']?.toString(),
        );
        _fetchedAt = DateTime.now();
      }
    } catch (_) {
      // Keep last good / default URLs — the legal links must always work.
    }
  }
}
