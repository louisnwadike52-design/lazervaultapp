import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// HIDE AND "TEMPORARILY UNAVAILABLE" ARE DIFFERENT, AND BOTH ARE WANTED.
///
/// Every quick service already had `_available`, which deliberately leaves the
/// tile on the grid and explains itself on tap — a service that silently
/// vanishes during an outage reads to the user as a bug, and that reasoning is
/// recorded at the call site. What was missing was a way to WITHDRAW a service:
/// take it off the grid, off the swipe-down search corpus and off every
/// per-account-type list, for everyone except a whitelist.
///
/// So `_visible` was added rather than repurposing `_available`. These tests
/// exist because the two are easy to "simplify" into one, which would either
/// lose the outage affordance or make withdrawal impossible.
void main() {
  setUp(() async {
    // `init()` is `_prefs ??=`, so it KEEPS the instance from the first test
    // and setMockInitialValues alone does not empty it — a value written by an
    // earlier test survives, and a test asserting a key is unset then passes
    // or fails depending on what ran before it. debugResetForTest exists for
    // exactly this: it rebinds AND clears.
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  Future<void> apply(Map<String, String> rows) =>
      FeatureFlags.applyRemoteSnapshot(rows);

  group('the withdrawal switch', () {
    test('unset means visible — nothing needs seeding', () {
      expect(FeatureFlags.quickServiceVisible('crypto'), isTrue);
      expect(FeatureFlags.quickServiceShown('crypto'), isTrue);
    });

    test('"false" withdraws the service', () async {
      await apply({'quick_service_crypto_visible': 'false'});
      expect(FeatureFlags.quickServiceVisible('crypto'), isFalse);
    });

    test('a blank value is unset, not false', () async {
      // `upsertSystemSetting(key, "")` is how a cleared field saves. Reading
      // "" as "false" would make clearing a field withdraw a service — a kill
      // switch firing without anyone pulling it. That exact shape took a
      // service off every phone once already.
      await apply({'quick_service_crypto_visible': ''});
      expect(FeatureFlags.quickServiceVisible('crypto'), isTrue);
    });

    test('a typo leaves the service up', () async {
      // Only the exact string "false" hides. An admin fat-fingering a field
      // must not take a working service off every phone; the backend still
      // refuses whatever it would refuse anyway.
      // NOT in this list: "FALSE ", "False" and the like. Those are a real
      // "false" — the value is trimmed and case-folded on purpose, matching
      // the rest of the family, because an admin typing "False" means it.
      for (final junk in ['no', 'off', '0', 'disabled', 'hidden']) {
        await apply({'quick_service_crypto_visible': junk});
        expect(FeatureFlags.quickServiceVisible('crypto'), isTrue,
            reason: '$junk should not hide a service');
      }
      // ...but the real value does, in any case and with any whitespace.
      for (final real in ['false', 'False', 'FALSE', ' false ']) {
        await apply({'quick_service_crypto_visible': real});
        expect(FeatureFlags.quickServiceVisible('crypto'), isFalse,
            reason: '$real is a deliberate "false" and must hide');
      }
    });
  });

  group('it is NOT the same switch as _available', () {
    test('unavailable does not withdraw', () async {
      await apply({'quick_service_crypto_available': 'false'});
      expect(FeatureFlags.quickServiceAvailable('crypto'), isFalse);
      expect(FeatureFlags.quickServiceVisible('crypto'), isTrue,
          reason: 'an outage must leave the tile where the user can see it '
              'and read why');
    });

    test('withdrawn does not read as unavailable', () async {
      await apply({'quick_service_crypto_visible': 'false'});
      expect(FeatureFlags.quickServiceAvailable('crypto'), isTrue);
    });

    test('either one blocks entry', () async {
      // Both entry points — tapping the tile and following a notification or
      // deep link — ask ONE question, so they cannot drift apart. A withdrawn
      // service has no tile, but a push can still name its route.
      await apply({'quick_service_crypto_visible': 'false'});
      expect(FeatureFlags.quickServiceEntryBlocked('crypto'), isTrue);

      await apply({
        'quick_service_crypto_visible': 'true',
        'quick_service_crypto_available': 'false',
      });
      expect(FeatureFlags.quickServiceEntryBlocked('crypto'), isTrue);

      await apply({
        'quick_service_crypto_visible': 'true',
        'quick_service_crypto_available': 'true',
      });
      expect(FeatureFlags.quickServiceEntryBlocked('crypto'), isFalse);
    });
  });

  group('the whitelist overrides both', () {
    test('a listed address keeps a withdrawn service', () async {
      await apply({
        'quick_service_crypto_visible': 'false',
        'quick_service_crypto_whitelist': 'tester@lazervault.app, two@x.com',
      });
      expect(
          FeatureFlags.quickServiceShown('crypto',
              email: 'tester@lazervault.app'),
          isTrue);
      expect(
          FeatureFlags.quickServiceEntryBlocked('crypto',
              email: 'tester@lazervault.app'),
          isFalse,
          reason: 'a tester must be able to ENTER, not just see the tile');
    });

    test('and an unlisted one does not', () async {
      await apply({
        'quick_service_crypto_visible': 'false',
        'quick_service_crypto_whitelist': 'tester@lazervault.app',
      });
      expect(FeatureFlags.quickServiceShown('crypto', email: 'other@x.com'),
          isFalse);
    });

    test('a parked list lets nobody through', () async {
      // Parking keeps the addresses without granting them, so a pilot can be
      // paused and resumed without retyping the list.
      await apply({
        'quick_service_crypto_visible': 'false',
        'quick_service_crypto_whitelist': 'tester@lazervault.app',
        'quick_service_crypto_whitelist_enabled': 'false',
      });
      expect(
          FeatureFlags.quickServiceShown('crypto',
              email: 'tester@lazervault.app'),
          isFalse);
    });

    test('an empty list grants nobody, rather than everyone', () async {
      // Fail-closed: a whitelist that accidentally matched everyone would
      // publish a service that was deliberately withdrawn, which is the one
      // outcome worse than the list not working at all.
      await apply({
        'quick_service_crypto_visible': 'false',
        'quick_service_crypto_whitelist': '',
      });
      expect(FeatureFlags.quickServiceShown('crypto', email: 'anyone@x.com'),
          isFalse);
      expect(FeatureFlags.quickServiceShown('crypto', email: ''), isFalse);
    });
  });

  group('transport', () {
    test('the key survives a remote snapshot as a readable string', () async {
      // The failure that has bitten this codebase three times is a key that is
      // declared, hydrated and consulted but never TRANSPORTED — dropped
      // between the registry cache and FeatureFlags, so the hardcoded default
      // wins on every launch and the operator's toggle does nothing.
      //
      // `quick_service_` is prefix-covered in EndpointRegistry and the
      // hydration branch stores the whole family verbatim, so a new suffix
      // needs no app change. This asserts that end of it.
      await apply({
        'quick_service_betting_visible': 'false',
        'quick_service_betting_message': 'Paused while we re-license.',
      });
      expect(FeatureFlags.quickServiceVisible('betting'), isFalse);
      expect(FeatureFlags.quickServiceMessage('betting'),
          'Paused while we re-license.');
    });

    test('a service nobody has configured is live', () async {
      // A new service must be present by default. An unconfigured new service
      // silently missing from the grid is far harder to notice than one that
      // is there.
      await apply({'quick_service_crypto_visible': 'false'});
      expect(FeatureFlags.quickServiceVisible('aiScanToPay'), isTrue);
      expect(FeatureFlags.quickServiceEntryBlocked('aiScanToPay'), isFalse);
    });
  });
}
