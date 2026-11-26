import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// THE APP MUST PROMISE WHAT THE ALLOCATOR PAYS.
///
/// The referral screen tells a customer which tier their friend has to reach.
/// auth-service decides that from `referral_bonus_min_kyc_tier`, which an
/// operator switches between Tier 2 (BVN verified) and Tier 3 (full KYC). A
/// hardcoded number in the app would promise one thing while a different one
/// was paid — so this pins that the app reads the setting, and resolves the
/// same strict default when nothing is set.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> withSetting(String? value) async {
    SharedPreferences.setMockInitialValues({});
    // Reset FIRST — debugResetForTest clears the store, so seeding before it
    // would be wiped. Then deliver the value the way the app actually
    // receives it: through the admin snapshot. That also proves the key is
    // carried by applyRemoteSnapshot, which is the step that would silently
    // strand it on the server.
    await FeatureFlags.debugResetForTest();
    if (value != null) {
      await FeatureFlags.applyRemoteSnapshot(
          {FeatureFlags.referralMinKycTierKey: value});
    }
  }

  test('defaults to Tier 3 when nothing is configured', () async {
    await withSetting(null);
    expect(FeatureFlags.referralMinKycTier, 3,
        reason: 'matches DefaultReferralMinKYCTier in auth-service — with no '
            'row set, both sides must resolve the same strict answer');
  });

  test('follows the operator to Tier 2', () async {
    await withSetting('2');
    expect(FeatureFlags.referralMinKycTier, 2);
  });

  test('a nonsense value falls back to strict, never to a wider promise', () async {
    for (final bad in ['', '  ', 'two', '0', '-1']) {
      await withSetting(bad);
      expect(FeatureFlags.referralMinKycTier, 3,
          reason: 'an unreadable value must not widen what we promise ($bad)');
    }
  });

  test('tier 1 is never shown — it is the unverified baseline', () async {
    await withSetting('1');
    expect(FeatureFlags.referralMinKycTier, 3,
        reason: 'paying on tier 1 would pay for a bare signup with no BVN '
            'and no account number');
  });

  test('a tier above 3 is clamped — there is no tier 4', () async {
    await withSetting('4');
    expect(FeatureFlags.referralMinKycTier, 3);
  });
}
