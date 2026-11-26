import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A SERVICE TURNED OFF MUST BE OFF AT EVERY ENTRANCE.
///
/// A quick service has two switches. `_visible` withdraws it — off the grid,
/// off the search corpus, off every per-account-type list. `_available` leaves
/// the tile up and explains itself on tap, which is the outage affordance.
///
/// Tapping a tile goes through openAppService → quickServiceEntryBlocked,
/// which honours BOTH plus the whitelist. But the ROUTE guard called
/// gateAllowed, which reads `_available` alone — so an operator who turned a
/// service off the natural way (hiding the tile) left every other door open:
/// a deep link, a shared URL, an AI-chat Get.toNamed, a notification tap. The
/// service vanished from the dashboard and stayed completely usable.
///
/// Ticketing made this concrete: it ships with public `/tickets/:id` deep
/// links and an AASA/assetlinks entry, so "hidden" would have meant "hidden
/// from the grid and reachable by anyone with the link".
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  Future<void> apply(Map<String, String> rows) =>
      FeatureFlags.applyRemoteSnapshot(rows);

  const gate = 'quick_service_ticketing';

  group('route gate matches the tile', () {
    test('ON BY DEFAULT — nothing needs seeding', () {
      expect(FeatureFlags.quickServiceShown('ticketing'), isTrue);
      expect(FeatureFlags.routeGateAllowed(gate), isTrue,
          reason: 'an unseeded install must ship the feature live');
    });

    test('REGRESSION: hiding the tile also closes the routes', () async {
      await apply({'quick_service_ticketing_visible': 'false'});
      expect(FeatureFlags.quickServiceShown('ticketing'), isFalse,
          reason: 'the tile should be gone');
      expect(FeatureFlags.routeGateAllowed(gate), isFalse,
          reason: 'the route stayed open — a deep link, a shared ticket URL, '
              'an AI-chat navigation or a notification tap would still reach '
              'a service the operator had switched off');
    });

    test('the outage switch still leaves the route closed too', () async {
      await apply({'quick_service_ticketing_available': 'false'});
      expect(FeatureFlags.routeGateAllowed(gate), isFalse);
    });

    test('WHITELIST OVERRIDES BOTH, which is the point of it', () async {
      await apply({
        'quick_service_ticketing_visible': 'false',
        'quick_service_ticketing_available': 'false',
        'quick_service_ticketing_whitelist': 'tester@lazervault.app',
      });
      expect(
          FeatureFlags.routeGateAllowed(gate, email: 'tester@lazervault.app'),
          isTrue,
          reason: 'a whitelisted tester must still reach the feature while it '
              'is off for everyone else — that is what the list is for');
      expect(
          FeatureFlags.routeGateAllowed(gate, email: 'someone@else.com'),
          isFalse);
      // Case and padding are an operator typing into a text field.
      expect(
          FeatureFlags.routeGateAllowed(gate, email: ' Tester@LazerVault.app '),
          isTrue);
    });

    test('an EXPLICITLY disabled whitelist does not leak the feature', () async {
      // whitelistActive defaults TRUE when the flag is absent, so withdrawing
      // a list means setting it false — not merely clearing the enabled key.
      await apply({
        'quick_service_ticketing_visible': 'false',
        'quick_service_ticketing_whitelist': 'tester@lazervault.app',
        'quick_service_ticketing_whitelist_enabled': 'false',
      });
      expect(
          FeatureFlags.routeGateAllowed(gate, email: 'tester@lazervault.app'),
          isFalse,
          reason: 'a list switched off must not keep granting access');
    });

    test('an empty whitelist grants nobody, even while active', () async {
      await apply({
        'quick_service_ticketing_visible': 'false',
        'quick_service_ticketing_whitelist': '',
      });
      expect(
          FeatureFlags.routeGateAllowed(gate, email: 'tester@lazervault.app'),
          isFalse);
    });

    test('the route decision EQUALS the tile decision, for every service', () async {
      // The invariant, not just ticketing: the two must not drift again.
      await apply({
        'quick_service_crypto_visible': 'false',
        'quick_service_giftCards_available': 'false',
      });
      for (final s in ['ticketing', 'crypto', 'giftCards', 'sendFunds']) {
        expect(FeatureFlags.routeGateAllowed('quick_service_$s'),
            !FeatureFlags.quickServiceEntryBlocked(s),
            reason: '$s: the route and the tile disagree');
      }
    });

    test('non-quick-service gates are untouched', () async {
      // routeGateAllowed must not change behaviour for the other gate family.
      await apply({'giftcard_sell_available': 'false'});
      expect(FeatureFlags.routeGateAllowed('giftcard_sell'),
          FeatureFlags.gateAllowed('giftcard_sell'));
    });
  });
}
