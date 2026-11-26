import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/referral/domain/referral_programme_copy.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE REFERRAL SCREEN PROMISED MONEY NOBODY WAS PAYING.
///
/// "Your bonus lands in your personal wallet automatically once the person you
/// referred completes their KYC" was compiled into four widgets and shown
/// unconditionally. The console offers two states in which it is false:
///
///   * the per-country reward set to 0 — referrals still recorded and
///     attributed, nothing earned. The kill switch stays TRUE, so nothing the
///     app read even hinted at it.
///   * `referral_programme_enabled = false` — new referrals refused outright.
///
/// A referrer shared their code on the strength of that sentence.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
  });

  ReferralProgrammeCopy resolve({
    bool active = true,
    String notice = '',
    int referrer = 20000,
    int referee = 0,
    bool loaded = true,
  }) =>
      ReferralProgrammeCopy.resolve(
        programmeActive: active,
        programmeNotice: notice,
        referrerRewardMinor: referrer,
        refereeRewardMinor: referee,
        rewardConfigLoaded: loaded,
      );

  test('a zero reward is a paused programme, not a running one', () {
    final c = resolve(referrer: 0, referee: 0);
    expect(c.state, ReferralProgrammeState.rewardsPaused);
    expect(c.earns, isFalse);
    expect(c.body, isNot(contains('lands in your personal wallet')),
        reason: 'this is the state the bug lived in: the kill switch is still '
            'true and nothing is being paid');
  });

  test('the kill switch reads as closed', () {
    final c = resolve(active: false);
    expect(c.state, ReferralProgrammeState.closed);
    expect(c.earns, isFalse);
  });

  test("the operator's own notice wins for a closed programme", () {
    final c = resolve(active: false, notice: 'We have ended referrals.');
    expect(c.notice, 'We have ended referrals.');
    expect(c.body, 'We have ended referrals.');
  });

  test('a closed programme with no notice still says something', () {
    final c = resolve(active: false);
    expect(c.notice.trim(), isNotEmpty,
        reason: 'a blank banner is worse than a plain one');
    expect(c.notice, isNot(contains('lands in your personal wallet')));
  });

  test('every sentence comes from the console when one is set', () async {
    // Through applyRemoteSnapshot, which is how a console edit actually
    // reaches the app — the settings poll, not a restart.
    await FeatureFlags.applyRemoteSnapshot({
      FeatureFlags.referralEarnMessageKey: 'Earn copy from the console.',
      FeatureFlags.referralEarnPendingMessageKey: 'Pending copy.',
      FeatureFlags.referralRewardsPausedMessageKey: 'Paused copy.',
      FeatureFlags.referralEmptyPromptKey: 'Empty copy.',
    });

    final running = resolve();
    expect(running.body, 'Earn copy from the console.');
    expect(running.pendingBody, 'Pending copy.');
    expect(running.emptyPrompt, 'Empty copy.');

    final paused = resolve(referrer: 0, referee: 0);
    expect(paused.body, 'Paused copy.');
    expect(paused.notice, 'Paused copy.');
  });

  test('an unloaded reward config is not reported as paused', () {
    // Both figures are 0 before the country config arrives. Treating that as
    // paused would flash "rewards are paused" at every referrer on open.
    final c = resolve(referrer: 0, referee: 0, loaded: false);
    expect(c.state, ReferralProgrammeState.running);
  });

  test('no referral widget still hardcodes the earning promise', () {
    // ANCHORED on the sentence itself. The only place it may appear is the
    // fallback inside ReferralProgrammeCopy, which is what the console
    // overrides.
    final offenders = <String>[];
    for (final f in Directory('lib/src/features/referral')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))) {
      if (f.path.endsWith('referral_programme_copy.dart')) continue;
      final src = f.readAsStringSync();
      for (final phrase in const [
        'lands in your personal wallet',
        'a bonus is paid once they do',
        'you earn once they sign up',
      ]) {
        if (!src.contains(phrase)) continue;
        // A doc comment quoting the old wording is not a promise.
        final i = src.indexOf(phrase);
        final lineStart = src.lastIndexOf('\n', i) + 1;
        if (src.substring(lineStart, i).trimLeft().startsWith('//')) continue;
        // A promise the programme state already governs is not a hardcoded
        // one — the KYC summary keeps its interpolated counts and swaps the
        // clause on `copy.earns`.
        final from = lineStart - 200 < 0 ? 0 : lineStart - 200;
        if (src.substring(from, i).contains('copy.earns')) continue;
        offenders.add('\${f.path}: "\$phrase"');
      }
    }
    expect(offenders, isEmpty,
        reason: 'this sentence is only true while the programme is running:\n'
            '${offenders.join('\n')}');
  });
}
