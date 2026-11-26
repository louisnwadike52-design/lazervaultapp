import 'package:lazervault/core/config/feature_flags.dart';

/// WHICH REFERRAL PROGRAMME THE USER IS ACTUALLY LOOKING AT.
///
/// The console offers four programme states, built from two independent
/// levers, and the app only ever knew about one of them:
///
///   * `referral_programme_enabled = false` — a code entered at signup is
///     REFUSED. Nothing is recorded and the attribution is lost. This is the
///     one the app knew, as `programmeActive` on the bonus balance.
///   * `country_reward_configs.referrer_reward = 0` — referrals are still
///     recorded and attributed and earn NOTHING. The kill switch above stays
///     true, so to the app everything looked normal.
///
/// In that second state the referral screen went on saying "your bonus lands
/// in your personal wallet automatically once the person you referred
/// completes their KYC" — in four separate places, in compiled text. A
/// referrer shared their code on the strength of it and earned nothing.
///
/// So the state is derived from BOTH levers, and every sentence that follows
/// from it is CMS copy. An operator who pauses the rewards can say so, in
/// their own words, without an app release — which is the only way the
/// wording can keep up with a commercial decision.
enum ReferralProgrammeState {
  /// Referrals are accepted and a reward is configured.
  running,

  /// Referrals are still recorded and attributed; the reward is zero.
  rewardsPaused,

  /// New referrals are refused outright.
  closed,
}

class ReferralProgrammeCopy {
  const ReferralProgrammeCopy._(
      this.state, this.body, this.pendingBody, this.emptyPrompt, this.notice);

  final ReferralProgrammeState state;

  /// The one-line explanation under the stats.
  final String body;

  /// The variant for a referrer who already has something waiting on somebody
  /// else's KYC — only meaningful while [running].
  final String pendingBody;

  /// Shown where a referrer with no referrals yet is invited to share.
  final String emptyPrompt;

  /// The operator's own notice, shown as a banner when the programme is not
  /// running. Never empty for a non-running state.
  final String notice;

  bool get earns => state == ReferralProgrammeState.running;

  /// True when the screen must NOT promise money.
  bool get paused => !earns;

  /// Resolves from what the server actually said.
  ///
  /// [programmeActive] and [programmeNotice] come from the bonus balance;
  /// the two reward figures from the country reward config the screen already
  /// loads to render "How it works".
  ///
  /// Reward figures of zero only mean "paused" when the config has been READ.
  /// Before it loads both are zero, and treating that as a paused programme
  /// would flash "rewards are paused" at every referrer on every open — so an
  /// unloaded config is reported as running and corrected a frame later.
  factory ReferralProgrammeCopy.resolve({
    required bool programmeActive,
    required String programmeNotice,
    required int referrerRewardMinor,
    required int refereeRewardMinor,
    required bool rewardConfigLoaded,
  }) {
    final state = !programmeActive
        ? ReferralProgrammeState.closed
        : (rewardConfigLoaded &&
                referrerRewardMinor <= 0 &&
                refereeRewardMinor <= 0)
            ? ReferralProgrammeState.rewardsPaused
            : ReferralProgrammeState.running;

    final notice = programmeNotice.trim();
    switch (state) {
      case ReferralProgrammeState.running:
        return ReferralProgrammeCopy._(
          state,
          FeatureFlags.referralCopy(
            FeatureFlags.referralEarnMessageKey,
            'Your bonus lands in your personal wallet automatically once '
            'the person you referred completes their KYC.',
          ),
          FeatureFlags.referralCopy(
            FeatureFlags.referralEarnPendingMessageKey,
            'Paid out lands in your personal wallet automatically. '
            'On KYC is not yet due — it is released when the person you '
            'referred completes their KYC.',
          ),
          FeatureFlags.referralCopy(
            FeatureFlags.referralEmptyPromptKey,
            'Share your code — you earn once they sign up and complete KYC.',
          ),
          '',
        );
      case ReferralProgrammeState.rewardsPaused:
        // NO AMOUNT, AND NO PROMISE. The referral is still worth making —
        // attribution is recorded and the operator can restore the reward —
        // so this says what is true rather than hiding the programme.
        final body = FeatureFlags.referralCopy(
          FeatureFlags.referralRewardsPausedMessageKey,
          'Referral rewards are paused. Your referrals are still recorded, '
          'and anything already earned stays in your wallet.',
        );
        return ReferralProgrammeCopy._(
            state, body, body, body, notice.isEmpty ? body : notice);
      case ReferralProgrammeState.closed:
        // The operator's own wording wins; the fallback is neutral and makes
        // no claim about when, or whether, it returns.
        final body = notice.isEmpty
            ? 'The referral programme is closed to new referrals. Anything '
                'you have already earned stays in your wallet.'
            : notice;
        return ReferralProgrammeCopy._(state, body, body, body, body);
    }
  }
}
