import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// THE LEADERBOARD IS HIDDEN UNTIL AN OPERATOR SAYS OTHERWISE.
///
/// It publishes other customers' names and referral counts to every user, so
/// the dangerous direction is "visible when nobody chose that". The cases
/// below are the ones where a flag quietly reads as true: no snapshot yet
/// (first launch), the key absent from the snapshot, and the value arriving
/// as a string rather than a bool.
void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('hidden before any snapshot has been applied', () async {
    await FeatureFlags.init();
    expect(FeatureFlags.referralLeaderboardEnabled, isFalse,
        reason: 'a cold start must not publish customer names');
  });

  test('hidden when the snapshot does not mention the key', () async {
    await FeatureFlags.init();
    await FeatureFlags.applyRemoteSnapshot({'some_other_flag': 'true'});
    expect(FeatureFlags.referralLeaderboardEnabled, isFalse);
  });

  test('visible only when the operator turns it on', () async {
    await FeatureFlags.init();
    await FeatureFlags.applyRemoteSnapshot({'referral_leaderboard_visible': 'true'});
    expect(FeatureFlags.referralLeaderboardEnabled, isTrue);

    // And it can be turned back off without a release.
    await FeatureFlags.applyRemoteSnapshot({'referral_leaderboard_visible': 'false'});
    expect(FeatureFlags.referralLeaderboardEnabled, isFalse);
  });

  test('an empty value is not a yes', () async {
    await FeatureFlags.init();
    await FeatureFlags.applyRemoteSnapshot({'referral_leaderboard_visible': 'true'});
    await FeatureFlags.applyRemoteSnapshot({'referral_leaderboard_visible': ''});
    expect(FeatureFlags.referralLeaderboardEnabled, isTrue,
        reason: 'an empty value means "not set", so the last real value stands '
            'rather than being read as false');
  });

  test('flipping it bumps the revision so a live session repaints', () async {
    await FeatureFlags.init();
    final before = FeatureFlags.revision.value;
    await FeatureFlags.applyRemoteSnapshot({'referral_leaderboard_visible': 'true'});
    expect(FeatureFlags.revision.value, greaterThan(before),
        reason: 'the gated widget listens to revision; without a bump the '
            'flip would only appear after an app restart');
  });
}
