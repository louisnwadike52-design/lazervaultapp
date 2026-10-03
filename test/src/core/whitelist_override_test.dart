import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A whitelist is an OVERRIDE, not a filter: an email on an enabled list sees
// the thing even when it is hidden from their account type or switched off
// for everyone. That is the point — ship to a few testers while it stays
// invisible to the rest.
//
// Everything here fails CLOSED. A whitelist that accidentally matched
// everyone would publish a service that was deliberately hidden, which is
// strictly worse than the feature not working.

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  group('matching', () {
    test('an email on an enabled list is whitelisted', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': 'a@x.com,b@y.com',
      });
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'a@x.com'), isTrue);
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'b@y.com'), isTrue);
    });

    test('case and surrounding spaces do not matter', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': '  A@X.com , b@Y.COM ',
      });
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'a@x.com'), isTrue);
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'B@y.com'), isTrue);
    });

    test('someone not on the list is not whitelisted', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': 'a@x.com',
      });
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'c@z.com'), isFalse);
    });
  });

  group('fails closed', () {
    test('an EMPTY list whitelists nobody', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': '',
      });
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'a@x.com'), isFalse);
    });

    test('an absent list whitelists nobody', () {
      expect(FeatureFlags.whitelisted('quick_service_never_set', 'a@x.com'),
          isFalse);
    });

    test('an unknown email is never whitelisted', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': 'a@x.com',
      });
      for (final e in <String?>[null, '', '   ']) {
        expect(FeatureFlags.whitelisted('quick_service_stocks', e), isFalse);
      }
    });

    test('a DISABLED list grants nothing but is not forgotten', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': 'a@x.com,b@y.com',
        'quick_service_stocks_whitelist_enabled': 'false',
      });
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'a@x.com'),
          isFalse);
      // The addresses survive: pausing a pilot must not mean retyping them.
      expect(FeatureFlags.whitelistEmails('quick_service_stocks').length, 2);
    });

    test('re-enabling restores the same list', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': 'a@x.com',
        'quick_service_stocks_whitelist_enabled': 'false',
      });
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist_enabled': 'true',
      });
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'a@x.com'), isTrue);
    });
  });

  group('lists are per surface', () {
    test('one service\'s list does not leak to another', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_stocks_whitelist': 'a@x.com',
      });
      expect(FeatureFlags.whitelisted('quick_service_crypto', 'a@x.com'),
          isFalse);
    });

    test('a nav list is independent of a service list', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'bottom_nav_beam_whitelist': 'a@x.com',
      });
      expect(FeatureFlags.whitelisted('bottom_nav_beam', 'a@x.com'), isTrue);
      expect(FeatureFlags.whitelisted('quick_service_stocks', 'a@x.com'),
          isFalse);
    });
  });

  group('bottom nav', () {
    test('enabled by default', () {
      expect(FeatureFlags.bottomNavEnabled('Beam'), isTrue);
    });

    test('an admin can switch a destination off', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'bottom_nav_beam_enabled': 'false',
      });
      expect(FeatureFlags.bottomNavEnabled('Beam'), isFalse);
    });

    test('a whitelisted email still reaches a disabled destination', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'bottom_nav_beam_enabled': 'false',
        'bottom_nav_beam_whitelist': 'tester@x.com',
      });
      expect(FeatureFlags.bottomNavEnabled('Beam', email: 'tester@x.com'),
          isTrue);
      expect(FeatureFlags.bottomNavEnabled('Beam', email: 'other@x.com'),
          isFalse);
    });

    test('the label is slugged, so casing and spaces do not matter', () {
      expect(FeatureFlags.bottomNavPrefix('AI analytics'),
          FeatureFlags.bottomNavPrefix('aianalytics'));
    });
  });
}
