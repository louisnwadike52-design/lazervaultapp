import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The pilot whitelist arrives as SHA-256 digests, never addresses — the
/// settings poll that carries it answers unauthenticated callers.
///
/// Both identifiers must be compared. The user id is the one to prefer: a
/// digest of a random UUID is opaque, while a digest of an email address only
/// hides the list, not a name someone already suspects. This used to hash the
/// email ONLY, so an operator following that advice was silently never
/// matched.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String digest(String v) =>
      sha256.convert(utf8.encode(v.trim().toLowerCase())).toString();

  // The repo's established pattern: a clean store per case, then push the
  // operator's values through the same path the settings poll uses. Setting
  // mock values alone does not work — FeatureFlags pins its SharedPreferences
  // instance on first use, so the first test's values would persist into every
  // later one and the suite would pass or fail on ORDER.
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    await FeatureFlags.debugResetForTest();
  });

  Future<void> withSettings(Map<String, String> values) async {
    await FeatureFlags.applyRemoteSnapshot(values);
  }

  const email = 'pilot@example.com';
  const userId = '6f1b2c3d-4e5f-6071-8293-a4b5c6d7e8f9';

  test('a whitelisted USER ID is matched', () async {
    await withSettings({
      'feature_cryptopay_available': 'false',
      'feature_cryptopay_whitelist': digest(userId),
    });
    expect(
      FeatureFlags.payWithCryptoAvailable(email: email, userId: userId),
      isTrue,
      reason: 'the id is the identifier operators are told to prefer',
    );
  });

  test('a whitelisted EMAIL is still matched', () async {
    await withSettings({
      'feature_cryptopay_available': 'false',
      'feature_cryptopay_whitelist': digest(email),
    });
    expect(
      FeatureFlags.payWithCryptoAvailable(email: email, userId: userId),
      isTrue,
    );
  });

  test('someone outside the pilot is not matched', () async {
    await withSettings({
      'feature_cryptopay_available': 'false',
      'feature_cryptopay_whitelist': digest('someone.else@example.com'),
    });
    expect(
      FeatureFlags.payWithCryptoAvailable(email: email, userId: userId),
      isFalse,
    );
  });

  test('case and spacing in the identity do not decide a lockout', () async {
    await withSettings({
      'feature_cryptopay_available': 'false',
      'feature_cryptopay_whitelist': digest(email),
    });
    expect(
      FeatureFlags.payWithCryptoAvailable(
          email: '  PILOT@Example.COM ', userId: null),
      isTrue,
    );
  });

  test('PLAINTEXT entries are ignored, not compared raw', () async {
    // Accepting plaintext would quietly undo the server-side hashing the
    // first time a stale value was cached.
    await withSettings({
      'feature_cryptopay_available': 'false',
      'feature_cryptopay_whitelist': email,
    });
    expect(
      FeatureFlags.payWithCryptoAvailable(email: email, userId: userId),
      isFalse,
    );
  });

  test('with the switch off and no list, nobody sees it', () async {
    await withSettings({'feature_cryptopay_available': 'false'});
    expect(
      FeatureFlags.payWithCryptoAvailable(email: email, userId: userId),
      isFalse,
    );
  });

  test('with the switch on, everyone sees it', () async {
    await withSettings({'feature_cryptopay_available': 'true'});
    expect(FeatureFlags.payWithCryptoAvailable(), isTrue);
  });

  test('absent settings default to OFF — the feature ships dark', () async {
    await withSettings({});
    expect(FeatureFlags.payWithCryptoAvailable(), isFalse);
  });
}
