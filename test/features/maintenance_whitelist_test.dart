import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE WHITELIST LETS PEOPLE PAST A DECLARED WINDOW — AND NOTHING ELSE.
///
/// Two rules are pinned here, both easy to break later.
///
/// 1. It is read inside the `maintenanceModeEnabled` branch of the startup
///    gate and nowhere else, so it can never suppress a MEASURED outage. An
///    allow-list cannot conjure a working backend, and hiding a real outage
///    would hand a tester a broken app with no explanation.
///
/// 2. WHAT COMES DOWN THE WIRE IS DIGESTS. The settings poll this key rides on
///    answers unauthenticated callers, so admin-gateway hashes every entry
///    before serving the app. These tests therefore store digests, exactly as
///    the server sends them, and one test asserts that a PLAINTEXT entry does
///    not match — because accepting plaintext here would silently undo the
///    server-side change the first time a stale value was cached.
void main() {
  // FeatureFlags.init() is `_prefs ??=`, so it binds ONCE per process and a
  // later setMockInitialValues is invisible to it. debugResetForTest exists
  // for exactly this — it rebinds and clears — and the value is then written
  // through the same singleton rather than through a fresh mock.
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  /// The server's transform, mirrored: lowercase, SHA-256, hex, comma-joined.
  String digestsOf(Iterable<String> entries) => entries
      .map((e) => sha256.convert(utf8.encode(e.trim().toLowerCase())).toString())
      .join(',');

  Future<void> setRaw(String raw) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(FeatureFlags.maintenanceWhitelistKey, raw);
  }

  Future<void> setList(Iterable<String> entries) => setRaw(digestsOf(entries));

  test('nobody is whitelisted by default, so the notice applies to everyone',
      () async {
    expect(FeatureFlags.maintenanceWhitelist, isEmpty);
    expect(
      FeatureFlags.maintenanceAllows(['someone@lazervault.app']),
      isFalse,
      reason: 'an empty list must never match — that would invert the feature '
          'and let the whole user base past a declared window',
    );
  });

  test('an email on the list matches, case- and space-insensitively', () async {
    await setList(['Tester@Lazervault.APP', 'someone-else@example.com']);
    expect(FeatureFlags.maintenanceAllows(['tester@lazervault.app']), isTrue);
    expect(
        FeatureFlags.maintenanceAllows(['  TESTER@LAZERVAULT.APP  ']), isTrue);
    expect(FeatureFlags.maintenanceAllows(['nobody@lazervault.app']), isFalse);
  });

  test('a user id matches too, so an account with no cached email still works',
      () async {
    const id = '04595c14-bff2-4ffc-9d83-513b12caf63c';
    await setList([id]);
    expect(FeatureFlags.maintenanceAllows([null, '', id]), isTrue);
  });

  test('a phone number matches, for a phone-first signup with no email',
      () async {
    const phone = '+2348031234567';
    await setList([phone]);
    expect(FeatureFlags.maintenanceAllows([null, phone]), isTrue);
  });

  test('any one identity matching is enough', () async {
    await setList(['tester@lazervault.app']);
    // Email absent from storage, user id present but not listed — and the
    // email that IS listed arrives third.
    expect(
      FeatureFlags.maintenanceAllows(
          [null, 'some-user-id', 'tester@lazervault.app']),
      isTrue,
    );
  });

  test('blank and null identities never match a non-empty list', () async {
    await setList(['tester@lazervault.app']);
    expect(FeatureFlags.maintenanceAllows([null, '', '   ']), isFalse,
        reason: 'a device with no cached identity must see the notice, not '
            'slip through on an empty string');
  });

  test('separators are forgiving because the server joins with commas and a '
      'cached value may carry whitespace', () async {
    final d = digestsOf(['a@b.com', 'c@d.com', 'e@f.com', 'g@h.com']).split(',');
    await setRaw('${d[0]},${d[1]}\n${d[2]}  ${d[3]}');
    expect(FeatureFlags.maintenanceWhitelist, hasLength(4));
    for (final e in ['a@b.com', 'c@d.com', 'e@f.com', 'g@h.com']) {
      expect(FeatureFlags.maintenanceAllows([e]), isTrue, reason: e);
    }
  });

  test('A PLAINTEXT ENTRY DOES NOT MATCH — the privacy change stays made',
      () async {
    // If this ever passes, somebody has made the matcher fall back to a raw
    // compare, and the server is free to go back to shipping addresses to
    // every handset without any test noticing.
    await setRaw('tester@lazervault.app');
    expect(
      FeatureFlags.maintenanceAllows(['tester@lazervault.app']),
      isFalse,
      reason: 'the app must only ever compare digests; a plaintext entry is '
          'not a whitelist entry',
    );
  });

  test('a malformed digest is ignored, not treated as a match-all', () async {
    await setRaw('not-a-digest,zzzz,${"a" * 64}');
    expect(FeatureFlags.maintenanceAllows(['tester@lazervault.app']), isFalse);
  });
}
