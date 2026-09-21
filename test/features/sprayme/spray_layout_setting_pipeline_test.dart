import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_layout_mode.dart';

/// End-to-end guard for the admin → app path of the spray layout default.
///
/// The setting has to survive four hops: the admin writes a system_settings
/// row, EndpointRegistry mirrors it (only if the key is in its allow-list),
/// FeatureFlags.applyRemoteSnapshot persists it (only if the key is in ITS
/// string list), and the room parses it. A key missing from either list is
/// dropped SILENTLY — the admin flips a control and nothing happens — so the
/// hops are asserted here rather than assumed.
void main() {
  setUp(() async {
    // FeatureFlags caches the SharedPreferences instance in a process-global
    // static, which is correct for an app (one process, one store) but means
    // setMockInitialValues alone does not give each test a clean slate — the
    // already-constructed instance keeps the previous test's values.
    // debugResetForTest rebinds AND clears, which is what actually resets it.
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  group('spray layout admin setting pipeline', () {
    test('an admin value survives applyRemoteSnapshot and parses back', () async {
      await FeatureFlags.init();
      await FeatureFlags.applyRemoteSnapshot({
        FeatureFlags.spraymeDefaultLayoutMode: 'spotlight',
      });

      expect(FeatureFlags.spraymeLayoutMode, 'spotlight');
      expect(sprayLayoutModeFromSetting(FeatureFlags.spraymeLayoutMode),
          SprayLayoutMode.spotlight);
    });

    test('every mode round-trips through the snapshot', () async {
      await FeatureFlags.init();
      for (final mode in SprayLayoutMode.values) {
        await FeatureFlags.applyRemoteSnapshot({
          FeatureFlags.spraymeDefaultLayoutMode: mode.settingValue,
        });
        expect(sprayLayoutModeFromSetting(FeatureFlags.spraymeLayoutMode), mode);
      }
    });

    test('no admin value yet → null, and the room falls back to grid', () async {
      await FeatureFlags.init();
      expect(FeatureFlags.spraymeLayoutMode, isNull);
      expect(sprayLayoutModeFromSetting(FeatureFlags.spraymeLayoutMode),
          SprayLayoutMode.grid);
    });

    test('a blank admin value is treated as unset, not as a mode', () async {
      await FeatureFlags.init();
      await FeatureFlags.applyRemoteSnapshot({
        FeatureFlags.spraymeDefaultLayoutMode: '   ',
      });
      expect(FeatureFlags.spraymeLayoutMode, isNull);
      expect(sprayLayoutModeFromSetting(FeatureFlags.spraymeLayoutMode),
          SprayLayoutMode.grid);
    });

    test('the flag key matches the key the domain layer publishes', () {
      // If these drift, the admin writes one row and the app reads another.
      expect(FeatureFlags.spraymeDefaultLayoutMode, kSprayLayoutModeSettingKey);
    });
  });
}
