import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Insurance is HIDDEN before any admin value arrives', () async {
    // The property that matters: hidden must be the answer on a cold start,
    // offline, or when the settings call fails. A default of true would flash
    // Insurance on every launch until the network replied.
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    expect(FeatureFlags.insuranceVisible, isFalse,
        reason: 'unset must mean hidden');
  });

  test('follows the admin value once it arrives', () async {
    // FeatureFlags caches its SharedPreferences instance (init() is `??=`),
    // so write through that same instance rather than re-mocking, which is
    // also how the live snapshot hydrates it.
    await FeatureFlags.init();
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(FeatureFlags.insuranceEnabled, true);
    expect(FeatureFlags.insuranceVisible, isTrue,
        reason: 'an explicit true reveals the service');

    await prefs.setBool(FeatureFlags.insuranceEnabled, false);
    expect(FeatureFlags.insuranceVisible, isFalse,
        reason: 'an explicit false hides it again');

    await prefs.remove(FeatureFlags.insuranceEnabled);
    expect(FeatureFlags.insuranceVisible, isFalse,
        reason: 'clearing the value falls back to hidden, never to visible');
  });
}
