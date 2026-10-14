import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  const gate = 'feature_bill_education';

  // An EMPTY value is the third state between "absent" and "false", and it is
  // the one that has bitten before: a cleared dashboard field once stored a
  // hard OFF for a flag whose declared default was ON, and the getter's `??`
  // could not save it because a value WAS stored.
  //
  // Four such rows are live on prod right now (cleared whitelists and
  // messages), so this is not hypothetical.
  test('an empty value falls back to the default, it does not disable', () async {
    await FeatureFlags.applyRemoteSnapshot({
      '${gate}_available': '',
      '${gate}_message': '',
      '${gate}_whitelist': '',
    });
    expect(FeatureFlags.gateAvailable(gate), isTrue,
        reason: 'a blanked field must not take a live service off every phone');
    expect(FeatureFlags.gateMessage(gate), isNotEmpty,
        reason: 'and must not render an empty modal');
    expect(FeatureFlags.whitelistEmails(gate), isEmpty);
  });

  test('an empty bottom-nav switch leaves the destination enabled', () async {
    await FeatureFlags.applyRemoteSnapshot({'bottom_nav_beam_enabled': ''});
    expect(FeatureFlags.bottomNavEnabled('Beam'), isTrue,
        reason: 'clearing a field must not remove a nav destination');
  });

  test('an empty whitelist does not grant everyone', () async {
    await FeatureFlags.applyRemoteSnapshot({
      '${gate}_available': 'false',
      '${gate}_whitelist': '',
    });
    expect(FeatureFlags.gateAllowed(gate, email: 'anyone@example.com'), isFalse);
  });
}
