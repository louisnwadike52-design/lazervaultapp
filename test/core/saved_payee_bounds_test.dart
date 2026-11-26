import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The two bounds on saved-payee matching in the send-funds account field,
/// and the wiring that lets an operator actually move them.
///
/// Both are INTEGERS. The thing that quietly breaks a numeric setting in this
/// app is putting it in applyRemoteSnapshot's BOOLEAN list, where every value
/// is coerced with `v == 'true'` — "3" stores as false, the getter reads
/// nothing, and the app runs its compiled default while the dashboard shows
/// the operator a saved value. That has happened to referral_min_kyc_tier and
/// to the bill fees; this pins it for these two.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    prefs = await SharedPreferences.getInstance();
  });

  tearDown(() async {
    await prefs.remove(FeatureFlags.savedPayeeMinDigitsKey);
    await prefs.remove(FeatureFlags.savedPayeeMaxRowsKey);
  });

  group('defaults', () {
    test('matching starts at three digits, not one', () {
      expect(FeatureFlags.savedPayeeMinDigits, 3,
          reason: 'the list floats over the form — at one digit a payer with '
              'a full payee book shows a slice of it to whoever is behind them');
    });

    test('the overlay shows at most five matches', () {
      expect(FeatureFlags.savedPayeeMaxRows, 5);
    });
  });

  group('the operator value is honoured', () {
    test('an admin-set minimum is used', () async {
      await prefs.setString(FeatureFlags.savedPayeeMinDigitsKey, '5');
      expect(FeatureFlags.savedPayeeMinDigits, 5);
    });

    test('an admin-set row cap is used', () async {
      await prefs.setString(FeatureFlags.savedPayeeMaxRowsKey, '8');
      expect(FeatureFlags.savedPayeeMaxRows, 8);
    });

    test('a malformed value degrades to the default, it does not throw', () async {
      await prefs.setString(FeatureFlags.savedPayeeMinDigitsKey, 'three');
      await prefs.setString(FeatureFlags.savedPayeeMaxRowsKey, '');
      expect(FeatureFlags.savedPayeeMinDigits, 3);
      expect(FeatureFlags.savedPayeeMaxRows, 5);
    });

    test('a value past the ceiling is capped, not obeyed', () async {
      await prefs.setString(FeatureFlags.savedPayeeMaxRowsKey, '500');
      expect(FeatureFlags.savedPayeeMaxRows, 20,
          reason: 'the overlay is anchored under the field — a 500-row list '
              'covers the form rather than scrolling it');
    });
  });

  group('the snapshot chain reaches them', () {
    late final String flags;
    late final String registry;

    setUpAll(() {
      flags = File('lib/core/config/feature_flags.dart').readAsStringSync();
      registry = File('lib/core/services/endpoint_registry.dart').readAsStringSync();
    });

    test('both survive a cold start', () {
      for (final key in const [
        'send_funds_saved_payee_min_digits',
        'send_funds_saved_payee_max_rows',
      ]) {
        expect(registry.contains("'$key'"), isTrue,
            reason: '$key is missing from EndpointRegistry, so an operator '
                'value is lost the moment the app restarts');
      }
    });

    test('neither sits in the BOOLEAN coercion list', () {
      // Anchored on the DEFINITION, not the first mention: the method is
      // named in a doc comment two hundred lines above it, and slicing from
      // there swallows the key declarations themselves.
      final apply = flags.substring(
          flags.indexOf('static Future<void> applyRemoteSnapshot('));
      final boolLoop = apply.substring(0, apply.indexOf('setBool(key,'));
      for (final key in const [
        'savedPayeeMinDigitsKey',
        'savedPayeeMaxRowsKey',
      ]) {
        expect(boolLoop.contains(key), isFalse,
            reason: '$key is a number. In the bool loop `v == \'true\'` '
                'stores it as false and the getter silently falls back.');
      }
      expect(apply.contains('savedPayeeMinDigitsKey'), isTrue,
          reason: 'it must still be mirrored somewhere, or it never arrives');
      expect(apply.contains('savedPayeeMaxRowsKey'), isTrue);
    });
  });
}
