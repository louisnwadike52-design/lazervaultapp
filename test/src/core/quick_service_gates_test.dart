import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Admin-tunable quick-service gates. Two SEPARATE ideas that must not be
// conflated:
//
//   hidden_for  — this service is not for this account type. It never appears.
//   available   — this service exists but is down right now. It appears and
//                 explains itself, because a service that silently vanishes
//                 during an outage looks like a bug.

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
  });

  group('defaults', () {
    test('an unconfigured service is visible everywhere and available', () {
      expect(FeatureFlags.quickServiceHiddenFor('lazerspray'), isEmpty);
      expect(FeatureFlags.quickServiceAvailable('lazerspray'), isTrue);
    });

    test('a service added later is live by default, not invisible', () {
      // The safe direction: a NEW service silently missing from the grid is
      // much harder to notice than one that is present.
      expect(FeatureFlags.quickServiceHiddenFor('serviceInventedTomorrow'),
          isEmpty);
      expect(FeatureFlags.quickServiceAvailable('serviceInventedTomorrow'),
          isTrue);
    });

    test('an unconfigured message is never blank', () {
      expect(FeatureFlags.quickServiceMessage('lazerspray').trim(),
          isNotEmpty);
    });
  });

  group('hidden_for', () {
    test('hides only the listed account types', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_lazerspray_hidden_for': 'savings,business',
      });
      final hidden = FeatureFlags.quickServiceHiddenFor('lazerspray');
      expect(hidden, containsAll(<String>['savings', 'business']));
      expect(hidden.contains('personal'), isFalse);
    });

    test('tolerates an admin typing spaces and capitals', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_rmb_hidden_for': ' Savings , Business ',
      });
      expect(FeatureFlags.quickServiceHiddenFor('rmb'),
          containsAll(<String>['savings', 'business']));
    });

    test('an EMPTY value clears the gate rather than restoring a default',
        () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_rmb_hidden_for': 'savings',
      });
      expect(FeatureFlags.quickServiceHiddenFor('rmb'), isNotEmpty);
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_rmb_hidden_for': '',
      });
      expect(FeatureFlags.quickServiceHiddenFor('rmb'), isEmpty,
          reason: 'clearing a gate must actually clear it');
    });

    test('gates are per service and do not leak', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_lazerspray_hidden_for': 'savings',
      });
      expect(FeatureFlags.quickServiceHiddenFor('rmb'), isEmpty);
    });
  });

  group('availability', () {
    test('only "false" marks a service unavailable', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_lazerspray_available': 'false',
      });
      expect(FeatureFlags.quickServiceAvailable('lazerspray'), isFalse);
    });

    test('a malformed value leaves the service AVAILABLE', () async {
      // Fail-open on purpose: a typo must not take a working service off the
      // grid, and the backend still refuses whatever it would refuse anyway.
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_rmb_available': 'nope',
      });
      expect(FeatureFlags.quickServiceAvailable('rmb'), isTrue);
    });

    test('the admin message is surfaced when one is set', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_lazerspray_available': 'false',
        'quick_service_lazerspray_message': 'Back on Monday.',
      });
      expect(FeatureFlags.quickServiceMessage('lazerspray'), 'Back on Monday.');
    });

    test('hiding and unavailability are independent', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'quick_service_rmb_hidden_for': 'savings',
        'quick_service_rmb_available': 'false',
      });
      // Hidden from savings AND down everywhere — both hold at once.
      expect(FeatureFlags.quickServiceHiddenFor('rmb'), contains('savings'));
      expect(FeatureFlags.quickServiceAvailable('rmb'), isFalse);
    });
  });
}
