import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// Outside NGN, only the account types the region can actually service are
/// offered.
///
/// Every type other than personal rests on a rail that stops at the Nigerian
/// border — a business account settles to a Nigerian corporate payout,
/// savings and investments are NGN-denominated products, family and group
/// pots are contributed to in Naira. A card the user can swipe to and then
/// not spend from is worse than no card.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    // init() binds once with `??=`, so a later setMockInitialValues would not
    // be seen. debugResetForTest rebinds and clears.
    await FeatureFlags.debugResetForTest();
  });

  Future<void> setKey(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(FeatureFlags.localeNonNgnAccountTypes, value);
  }

  test('personal only, by default', () async {
    expect(FeatureFlags.localeNonNgnAccountTypeNames, {'personal'});
  });

  test('an admin can open another type without an app release', () async {
    await setKey('personal,business');
    expect(
      FeatureFlags.localeNonNgnAccountTypeNames,
      {'personal', 'business'},
    );
  });

  test('EMPTY is a deliberate "none", not "use the default"', () async {
    // Absent and empty are different instructions: conflating them would hand
    // an admin who cleared the field the built-in list back.
    await setKey('');
    expect(FeatureFlags.localeNonNgnAccountTypeNames, isEmpty);
  });

  test('entries are matched case- and space-insensitively', () async {
    // The same value arrives as 'Personal', 'personal' and ' personal ' from
    // the proto, the picker and the cached summary.
    await setKey(' Personal , Business ');
    expect(
      FeatureFlags.localeNonNgnAccountTypeNames,
      {'personal', 'business'},
    );
  });
}
