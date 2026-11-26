import 'package:flutter/material.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HowItWorksCard extends StatelessWidget {
  final String currency;
  final int referrerReward;
  final int refereeReward;

  const HowItWorksCard({
    super.key,
    // NO DEFAULTS. These were 'GBP' / 10000 / 5000, and the dashboard built the
    // card with `const HowItWorksCard()` — no arguments — so every user on
    // every platform was promised "You get £100, they get £50" regardless of
    // what their country actually pays. A Nigerian user saw that above a stats
    // panel reading ₦0.
    //
    // Required, so the next caller cannot reintroduce it by omission. When the
    // real figures are unknown the screen omits the card rather than guessing.
    required this.currency,
    required this.referrerReward,
    required this.refereeReward,
  });

  /// Delegates to the shared resolver.
  ///
  /// This was a local switch whose DEFAULT was a dollar sign, so any currency
  /// string it did not match EXACTLY — a lowercase code, a display name like
  /// 'Nigerian Naira', an empty value — rendered a naira amount as DOLLARS.
  /// CurrencyUtils normalises first and falls back to the CODE, so an
  /// unrecognised currency is labelled, never mislabelled as another one.
  String _getCurrencySymbol() => CurrencyUtils.getSymbol(currency);

  String _formatAmount(int amount) {
    return '${_getCurrencySymbol()}${(amount / 100).toStringAsFixed(0)}';
  }

  /// "Both get rewarded" is only true when both actually are.
  String get _rewardTitle =>
      refereeReward > 0 ? 'Both get rewarded' : 'You get rewarded';

  /// Names the referee only when they are paid.
  ///
  /// The referrer-only case is the live configuration, so it is the one that
  /// has to read well: a plain statement of what the sharer earns, with no
  /// mention of a friend who gets nothing.
  String get _rewardDescription {
    if (refereeReward > 0 && referrerReward > 0) {
      return 'You get ${_formatAmount(referrerReward)}, '
          'they get ${_formatAmount(refereeReward)} instantly!';
    }
    if (referrerReward > 0) {
      return 'You get ${_formatAmount(referrerReward)} instantly!';
    }
    // Referee-only: possible if an operator funds the joiner and not the
    // sharer. Still true, still worth saying, and never phrased as the
    // sharer's reward.
    return 'Your friend gets ${_formatAmount(refereeReward)} instantly!';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3B82F6),
            ),
          ),
          SizedBox(height: 12.h),
          _buildStep(
            '1',
            'Share your code',
            'Send your unique referral code to friends',
            Icons.share_rounded,
          ),
          SizedBox(height: 10.h),
          _buildStep(
            '2',
            'They sign up',
            'Your friend creates an account with your code',
            Icons.person_add_rounded,
          ),
          // THE REWARD STEP ONLY EXISTS IF THERE IS A REWARD.
          //
          // It read "You get ₦200, they get ₦0 instantly!" in production,
          // because the referee reward is legitimately zero on this
          // programme. Announcing a reward of nothing is worse than saying
          // nothing: it reads as a bug to a customer and as a broken promise
          // to the friend they just sent it to.
          //
          // So the referee is named ONLY when they are actually paid, and
          // when neither side earns anything the step is omitted entirely
          // rather than inviting someone to share a code for no reward.
          if (referrerReward > 0 || refereeReward > 0) ...[
            SizedBox(height: 10.h),
            _buildStep(
              '3',
              _rewardTitle,
              _rewardDescription,
              Icons.celebration_rounded,
            ),
          ],
          SizedBox(height: 14.h),
          // THE QUALIFYING TIER, READ FROM THE SETTING.
          //
          // An outline, not a paragraph: one line stating the single condition
          // a referrer actually needs to know. The tier is NEVER hardcoded —
          // an operator switches between Tier 2 (BVN verified) and Tier 3
          // (full KYC) from the dashboard, and the allocator pays on the same
          // key. A number written in here would promise one thing while a
          // different one was paid.
          _buildConditions(),
        ],
      ),
    );
  }

  /// The conditions a referral must meet, read from the dashboard CMS.
  ///
  /// THE COPY IS NOT IN THIS FILE. It was — a single hardcoded sentence about
  /// the tier — and it omitted the other condition the allocator actually
  /// enforces: the referee must sign up on a device no other account has used
  /// (`IneligibleSharedDevice` in referral-service). A referrer reading only
  /// the tier rule would believe a referral on a shared handset would pay,
  /// and it never would.
  ///
  /// Now both come from `feature_referral_terms_message`, so a condition can
  /// be reworded, added or removed without an app release. `{tier}` inside the
  /// copy is substituted from the enforced setting, so the number shown cannot
  /// drift from the number paid.
  ///
  /// Nothing configured renders NOTHING, deliberately: an invented condition
  /// is worse than a missing one, because the referrer acts on it.
  Widget _buildConditions() {
    final terms = FeatureFlags.referralTerms();
    if (terms.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border:
            Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            terms.length == 1 ? 'Condition' : 'Conditions',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              color: const Color(0xFF3B82F6),
            ),
          ),
          SizedBox(height: 7.h),
          for (final line in terms)
            Padding(
              padding: EdgeInsets.only(bottom: line == terms.last ? 0 : 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Icon(Icons.check_circle_outline,
                        size: 13.sp, color: const Color(0xFF3B82F6)),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      line,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        height: 1.35,
                        color: const Color(0xFFD1D5DB),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStep(
      String number, String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4E03D0), Color(0xFF6B21E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
