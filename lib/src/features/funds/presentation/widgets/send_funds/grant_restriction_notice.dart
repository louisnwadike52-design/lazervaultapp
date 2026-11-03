import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/funds/domain/min_balance_policy.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/spendable_service_links.dart';

/// "₦2,000 of this is a Lazervault bonus" — said BEFORE the amount is typed.
///
/// THE GAP THIS CLOSES. Every layer of the onboarding-grant restriction was
/// already correct and none of it was visible until it fired. accounts-service
/// refuses the hold, core-payments and banking-service refuse the payout ahead
/// of it, and [showMinBalanceRefusal] explains the refusal well. But the
/// customer met all of that only AFTER choosing a recipient, typing an amount
/// and tapping through — at which point a perfectly-worded explanation still
/// lands as a dead end, because the work is already done and it is being
/// undone.
///
/// The balance on screen said "₦3,000 available". Two thousand of it could
/// never leave. Nothing said so.
///
/// WHY IT IS NOT A WARNING. There is no error here and nothing to fix: the
/// money is real, it is theirs to spend, and the only thing that is untrue is
/// the unqualified word "available". So this is a LABEL on a figure, in the
/// quiet tone the rest of a balance row uses — not a red banner, and
/// deliberately not an interruption. A warning would teach the customer that
/// receiving a bonus is a problem.
///
/// WHAT IT MUST GET RIGHT. The grant DEPLETES as they spend on the platform
/// (see `grant_restriction.go`), so the figure moves and this must be computed
/// from the live restricted balance each build, never cached or derived from
/// the original grant size. And it must name what the bonus IS good for in
/// the same breath, because "₦2,000 can't be withdrawn" alone reads as money
/// being withheld — the exact misreading the refusal copy was rewritten to
/// avoid.
///
/// Tap opens the full explanation with the service shortcuts, reusing the
/// refusal sheet's own links so the proactive and reactive paths cannot
/// disagree about what the bonus buys.

/// Where the notice is being drawn, which decides its palette.
///
/// Two surfaces, far apart: the send sheet is white with dark text, and the
/// withdraw screen's balance card is a saturated gradient with white text. A
/// single palette is unreadable on one of them, and a notice nobody can read
/// is the same as no notice.
enum GrantNoticeTone {
  /// Dark text on a light surface — the send/amount sheets.
  light,

  /// White text on a translucent scrim — over the withdraw screen's gradient
  /// balance card.
  onDark,
}

/// The grant label, or null when there is nothing to label.
///
/// Returns NULL rather than an empty [SizedBox] for the ordinary case (no
/// grant, which is almost every customer): a caller can then drop it from its
/// children list and not pay for the spacing around it. A zero-size widget
/// still leaves the `SizedBox(height: …)` beside it behind, which shows up as
/// an unexplained gap.
///
/// [policy] must already have the grant folded in via
/// [MinBalancePolicy.withRestricted]; this reads
/// [MinBalancePolicy.grantRestricted] and renders nothing when the operator's
/// floor is what binds. That is deliberate — the floor is a different rule
/// about the customer's own money and labelling it as a bonus would be a lie.
// WHY THE COPY SAYS "a Lazervault bonus" AND NOT "your welcome bonus".
//
// Two programmes fund `restricted_balance`: the signup grant
// (accounts-service, on KYC tier-up) and the tester allocation
// (admin-gateway, on the register tick). The column is a bare number — nothing
// in it records which one put it there, and the app has no way to ask.
//
// So a tester was reading "Tester Allocation" in their history and "your
// welcome bonus" against the same money, two names for one thing. Neutral
// wording is true for both; guessing would be wrong half the time.

Widget? grantRestrictionNotice({
  required BuildContext context,
  required MinBalancePolicy policy,
  required int availableMinor,
  required String currencySymbol,
  MinBalanceAction action = MinBalanceAction.transfer,
  GrantNoticeTone tone = GrantNoticeTone.light,
}) {
  final restrictedMinor = policy.reservedForGrantMinor(availableMinor);
  if (restrictedMinor <= 0) return null;

  final movableMinor = policy.maxSendableMinor(availableMinor: availableMinor);
  return _GrantNotice(
    bonus: '$currencySymbol${formatMinorForCopy(restrictedMinor)}',
    movable: movableMinor > 0
        ? '$currencySymbol${formatMinorForCopy(movableMinor)}'
        : null,
    action: action,
    tone: tone,
  );
}

class _GrantNotice extends StatelessWidget {
  const _GrantNotice({
    required this.bonus,
    required this.movable,
    required this.action,
    required this.tone,
  });

  final String bonus;

  /// What they CAN move, already formatted. Null when the answer is nothing —
  /// in which case the copy says so plainly instead of offering "up to 0",
  /// which reads as a bug (the same judgement the refusal sheet makes).
  final String? movable;
  final MinBalanceAction action;
  final GrantNoticeTone tone;

  bool get _dark => tone == GrantNoticeTone.onDark;

  Color get _fg => _dark ? Colors.white : const Color(0xFF111827);
  Color get _fgMuted =>
      _dark ? Colors.white.withValues(alpha: 0.82) : const Color(0xFF6B7280);
  Color get _surface => _dark
      ? Colors.white.withValues(alpha: 0.14)
      : const Color(0xFFF59E0B).withValues(alpha: 0.10);
  Color get _border => _dark
      ? Colors.white.withValues(alpha: 0.22)
      : const Color(0xFFF59E0B).withValues(alpha: 0.30);
  Color get _accent => _dark ? Colors.white : const Color(0xFFB45309);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$bonus of this balance is a Lazervault bonus. '
          'Tap to see what it can be spent on.',
      child: InkWell(
        onTap: () => _explain(context),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.card_giftcard_rounded, size: 15.sp, color: _accent),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The figure leads. It is the one fact the customer needs
                    // in order to read the balance above correctly, and it has
                    // to survive being skimmed.
                    Text(
                      '$bonus of this is a Lazervault bonus',
                      style: GoogleFonts.inter(
                        color: _fg,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      movable == null
                          // Nothing of their own in the wallet yet. Do not
                          // offer a figure; say what the bonus buys and that
                          // adding money is what unlocks a payout.
                          ? 'Spend it on airtime, data, bills, gift cards or '
                              'crypto. Add money to ${action.verb} out.'
                          : 'Spends on airtime, data, bills, gift cards and '
                              'crypto · $movable free to ${action.verb}',
                      style: GoogleFonts.inter(
                        color: _fgMuted,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.chevron_right_rounded, size: 16.sp, color: _fgMuted),
            ],
          ),
        ),
      ),
    );
  }

  /// The full explanation, with somewhere to go.
  ///
  /// Uses [showServerRefusal] with [ServerRefusalTone.refusal]'s sibling
  /// wording but NO action button: nothing is being refused yet, so an
  /// "Withdraw X instead" button here would rewrite an amount the customer has
  /// not typed. The service links are the real content — they are what turns
  /// "this can't be withdrawn" into something the customer can act on, and
  /// they come from [buildSpendableServiceLinks] so this list and the
  /// refusal's list are literally the same list.
  Future<void> _explain(BuildContext context) async {
    await showServerRefusal(
      context,
      title: 'Your Lazervault bonus',
      message: movable == null
          ? 'We added $bonus to your wallet to get you started. It is for '
              "spending on Lazervault, so it can't be moved out — but "
              'everything below works with it.\n\n'
              'Anything you add yourself stays free to '
              '${action.verb} whenever you like.'
          : 'We added $bonus to your wallet to get you started. It is for '
              "spending on Lazervault, so it can't be moved out — but "
              'everything below works with it.\n\n'
              'Your own money is unaffected: $movable is free to '
              '${action.verb} right now.',
      // Not framed as a refusal, because nothing has been refused. This is the
      // customer asking a question about their balance and getting an answer.
      hint: 'The bonus shrinks as you spend it, and whatever is left stays '
          'spendable on Lazervault.',
      links: <RefusalLink>[
        ...buildSpendableServiceLinks(context),
        depositLink(),
      ],
      dismissLabel: 'Got it',
    );
  }
}
