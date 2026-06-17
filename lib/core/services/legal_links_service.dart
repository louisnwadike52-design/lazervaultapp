import 'dart:convert';

import 'package:http/http.dart' as http;

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

  // Host the app talks to (emulator maps the dev host to 10.0.2.2). The legal
  // links endpoint lives on banking-service's public HTTP port.
  static const String _host =
      String.fromEnvironment('TEST_BACKEND_HOST', defaultValue: '10.0.2.2');
  static const String _legalUrl = 'http://$_host:8073/api/v1/legal/links';

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
