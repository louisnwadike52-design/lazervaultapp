import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A boolean flag row that exists but carries NO value must not read as `false`.
//
// The hydration loop stored `v.toLowerCase() == 'true'`, which turns '' into a
// hard false. The getters defend themselves with `?? true`, but that fallback
// only fires when NOTHING is stored — once an empty value has been written as
// `false` it is indistinguishable from an operator choosing to withdraw the
// feature. For group_funds_enabled that is the whole service vanishing from
// every phone because a dashboard field was cleared.
//
// Measured against prod on 2026-10-13: four rows are live with empty values
// (dashboard_adverts, three reminders_*). None are booleans today, so nothing
// was broken — the trap was one cleared field away.
void main() {
  setUp(() async {
    // Clear through the live instance: setMockInitialValues is a no-op after
    // the first getInstance(), so state would otherwise leak between tests.
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  group('an empty value leaves the declared default alone', () {
    test('Group Funds stays available when the row is empty', () async {
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': ''});
      expect(FeatureFlags.groupFundsAvailable, isTrue);
    });

    test('whitespace is empty too', () async {
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': '   '});
      expect(FeatureFlags.groupFundsAvailable, isTrue);
    });

    test('both contribution types survive an empty row', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'group_funds_one_time_enabled': '',
        'group_funds_esusu_enabled': '',
      });
      expect(FeatureFlags.groupFundsOneTimeAvailable, isTrue);
      expect(FeatureFlags.groupFundsEsusuAvailable, isTrue);
      expect(FeatureFlags.groupFundsCanCreateContribution, isTrue);
    });

    test('an absent key behaves the same as an empty one', () async {
      await FeatureFlags.applyRemoteSnapshot({});
      expect(FeatureFlags.groupFundsAvailable, isTrue);
    });
  });

  group('a real choice is still honoured', () {
    test('an explicit false withdraws the service', () async {
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': 'false'});
      expect(FeatureFlags.groupFundsAvailable, isFalse);
    });

    test('an explicit true restores it', () async {
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': 'false'});
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': 'true'});
      expect(FeatureFlags.groupFundsAvailable, isTrue);
    });

    test('case and padding do not change a real value', () async {
      await FeatureFlags.applyRemoteSnapshot({'group_funds_esusu_enabled': ' FALSE '});
      expect(FeatureFlags.groupFundsEsusuAvailable, isFalse);
    });

    test('an emptied row keeps the last recorded choice, it does not flip it',
        () async {
      // The conservative half of the fix: a degraded read that returns no
      // value must not quietly restore a feature an operator withdrew.
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': 'false'});
      await FeatureFlags.applyRemoteSnapshot({'group_funds_enabled': ''});
      expect(FeatureFlags.groupFundsAvailable, isFalse);
    });

    test('withdrawing the whole service blocks creation regardless of types',
        () async {
      await FeatureFlags.applyRemoteSnapshot({
        'group_funds_enabled': 'false',
        'group_funds_one_time_enabled': 'true',
        'group_funds_esusu_enabled': 'true',
      });
      expect(FeatureFlags.groupFundsCanCreateContribution, isFalse);
    });
  });
}
