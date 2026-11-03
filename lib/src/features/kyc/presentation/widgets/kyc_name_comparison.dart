import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// THE TWO NAMES, SIDE BY SIDE, WHEN A VERIFICATION IS HELD BECAUSE THEY
/// DISAGREE.
///
/// WHY THIS EXISTS. The server already says what differs, inside its
/// `message` — a sentence with two quoted names in it. That reaches every
/// build, including ones already on customers' phones, and it is the reason
/// `message` keeps carrying them. But a paragraph is the wrong shape for the
/// one question the customer is actually asking: *which* of these is wrong,
/// and which do I change? Two labelled rows answer that at a glance; a
/// sentence makes them parse it.
///
/// SHOWN ONLY FOR A REVIEW, never a refusal. A refusal means nothing in the
/// two records agreed, so the server has evidence the asker is not the BVN
/// holder and deliberately sends no names — rendering a comparison there
/// would be asking the UI to display a disclosure the backend refused to
/// make. [ProveKycStatus.nameUnderReview] is the gate, and it requires both
/// names to be present so an older server degrades to the message instead.
///
/// IT DOES NOT OFFER A RENAME, AND THE FIRST VERSION OF THIS WRONGLY DID.
///
/// Names are IMMUTABLE on this platform: `UpdateProfile` silently discards
/// first_name/last_name, deliberately — "a first and last name are whatever
/// KYC verified ... changing a name is a support request with evidence
/// attached, not a text field" (auth_profile.go:54). So an "Update my profile
/// name" button routed the customer to a Settings field that accepted their
/// edit and threw it away, and the copy promised an automatic re-check that
/// could never happen. That is the exact dead end `kyc_profile_fix.dart` was
/// written to stop, rebuilt by hand.
///
/// What the platform actually offers is the support request — so this raises
/// one, against the verification an operator is already reviewing. It changes
/// no name and grants no tier: a correction that cleared its own review would
/// be an unreviewed approval, and because the operator queue filters on the
/// LIVE comparator the row would vanish from it rather than show as approved.
///
/// IT DOES NOT PROMISE AN OUTCOME. A human decides, so the copy says what we
/// will do and what they can tell us — never that it will be approved.
class KycNameComparison extends StatelessWidget {
  const KycNameComparison({
    super.key,
    required this.bvnName,
    required this.profileName,
    required this.onRaiseCorrection,
    required this.onAdoptBvnName,
    this.correctionReceived = false,
    this.textPrimary = const Color(0xFF111827),
    this.textSecondary = const Color(0xFF6B7280),
    this.accent = const Color(0xFF4E03D0),
    this.divider = const Color(0xFFE5E7EB),
    this.surface = Colors.white,
  });

  /// The name on the BVN record, as the identity provider returned it.
  final String bvnName;

  /// The name on this account's profile.
  final String profileName;

  /// Opens the correction sheet. The caller owns that navigation and the
  /// status re-read afterwards — this widget knows nothing about routes.
  final VoidCallback onRaiseCorrection;

  /// Adopts the BVN record's spelling. THE PRIMARY ACTION, because it
  /// resolves the overwhelming majority of these — a typo, a missing middle
  /// name, a reversed order — in one tap and with no human involved. The
  /// customer is taking the authoritative value, not asserting one.
  final VoidCallback onAdoptBvnName;

  /// True once a correction is already on file. The affordance becomes a
  /// statement: without this the only feedback was the request disappearing,
  /// which is how a customer ends up sending the same thing five times.
  final bool correctionReceived;

  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color divider;

  /// The card's own background.
  ///
  /// A PARAMETER BECAUSE IT WAS HARDCODED WHITE and the host screen is dark
  /// (`_bg` 0xFF0A0A0A, `_textPrimary` Colors.white) — so the first version
  /// rendered white-on-white and the comparison, the entire point of the
  /// card, was invisible. Defaulted for a light host; the KYC screen passes
  /// its own `_card`.
  final Color surface;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hourglass_top_rounded, size: 15.sp, color: accent),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Being reviewed',
                  style: GoogleFonts.inter(
                    color: textPrimary,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _row('BVN record', bvnName, emphasised: true),
          SizedBox(height: 8.h),
          _row('Your profile', profileName),
          SizedBox(height: 10.h),
          Text(
            // States who acts next, so "reviewed" does not read as "stuck",
            // and never claims the customer can fix it themselves.
            correctionReceived
                ? 'We have your correction and someone is reviewing it. '
                    'We\'ll update you as soon as it\'s done.'
                : 'Someone is checking this. If either name is wrong, tell '
                    'us which one and we\'ll pass it to them.',
            style: GoogleFonts.inter(
              color: textSecondary,
              fontSize: 11.5.sp,
              height: 1.45,
            ),
          ),
          SizedBox(height: 10.h),
          // ONE TAP FIRST. "My BVN record is right, my profile has the typo"
          // is the common case by a wide margin, and it needs no human: the
          // profile takes the spelling the provider already gave us.
          SizedBox(
            width: double.infinity,
            height: 42.h,
            child: ElevatedButton(
              onPressed: onAdoptBvnName,
              child: Text(
                'Use my BVN name',
                style: GoogleFonts.inter(
                    fontSize: 12.5.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          if (!correctionReceived) ...[
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onRaiseCorrection,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  // 48dp minimum: this is the one action on the card.
                  minimumSize: Size(0, 44.h),
                  tapTargetSize: MaterialTapTargetSize.padded,
                ),
                child: Text(
                  'No — something else is wrong',
                  style: GoogleFonts.inter(
                    color: accent,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// One labelled row. The label is fixed-width so the two VALUES line up and
  /// the difference is what the eye lands on — the whole point of the card.
  Widget _row(String label, String value, {bool emphasised = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 86.w,
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: textSecondary,
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            // Never truncated: a name is the thing being compared, so it
            // wraps rather than ending in an ellipsis that could hide the
            // very part that differs.
            softWrap: true,
            style: GoogleFonts.inter(
              color: textPrimary,
              fontSize: 12.5.sp,
              height: 1.35,
              fontWeight: emphasised ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
