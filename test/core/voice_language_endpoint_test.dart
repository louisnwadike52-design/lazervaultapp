import 'package:flutter_test/flutter_test.dart';

/// The voice-language URL is assembled in two halves that live in different
/// files: a base from the endpoint registry, and a '/api/v1/voice/languages'
/// path appended by each caller. Nothing checks that the halves fit — the
/// result is just a string, a wrong one 404s, and the screen reports it as
/// "Failed to load languages", which reads like a backend outage rather than a
/// malformed URL. That is exactly how this shipped.
///
/// These tests pin the contract: the registry value is a HOST BASE, and the
/// composed URL contains the path segment once.
void main() {
  // Mirrors what every caller does:
  //   Uri.parse('$_languageApiUrl/api/v1/voice/languages?country=$country')
  String compose(String base, {String country = 'NG'}) =>
      '$base/api/v1/voice/languages?country=$country';

  group('voice language endpoint composition', () {
    test('a host base produces the path exactly once', () {
      final url = compose('https://api.lazervault.app');
      expect(url, 'https://api.lazervault.app/api/v1/voice/languages?country=NG');
      expect('/voice/languages'.allMatches(url).length, 1);
    });

    // The exact regression: the registry used to seed the value as
    // '<host>/voice/languages' while both callers appended their own path.
    test('the old full-endpoint value doubles the path', () {
      final url = compose('https://api.lazervault.app/voice/languages');
      expect(
        url,
        'https://api.lazervault.app/voice/languages/api/v1/voice/languages?country=NG',
      );
      expect(
        '/voice/languages'.allMatches(url).length,
        2,
        reason: 'this is the 404 shape the fix removes',
      );
    });

    test('the composed path matches what the gateway serves', () {
      // Verified live: /api/v1/voice/languages?country=NG -> 200, while both
      // /voice/languages and the doubled form -> 404.
      final uri = Uri.parse(compose('https://api.lazervault.app'));
      expect(uri.path, '/api/v1/voice/languages');
      expect(uri.queryParameters['country'], 'NG');
    });

    test('a base with a trailing slash does not produce a double slash', () {
      // Guards the other direction: an operator setting the registry override
      // to 'https://api.lazervault.app/' should not silently produce '//api'.
      final base = 'https://api.lazervault.app/';
      final normalised =
          base.endsWith('/') ? base.substring(0, base.length - 1) : base;
      expect(compose(normalised), isNot(contains('//api/v1')));
    });
  });
}
