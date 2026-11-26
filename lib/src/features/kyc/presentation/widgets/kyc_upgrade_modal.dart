import 'package:flutter/material.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';

/// Modal bottom sheet shown when a financial operation is blocked by KYC tier limits.
///
/// Explains why the operation was blocked and offers the user a path to upgrade.
class KYCUpgradeModal extends StatelessWidget {
  final int currentTier;
  final int requiredTier;
  final String operationName;

  /// Canonical KYC status (auth-service `users.kyc_status`). When
  /// `pending_review` the user has already submitted and is awaiting approval,
  /// so we show a "under review" acknowledgement instead of routing them to
  /// re-submit. Defaults to '' for callers that only know the tier (the
  /// reactive `kyc_error_handler` path).
  final String kycStatus;

  /// True when VERIFYING IS NOT THE REMEDY.
  ///
  /// Two situations reach here, and both used to render as "verify your
  /// identity" over a button leading to a flow that could not help:
  ///
  ///  * **The ledger is behind the profile.** accounts-service refused at
  ///    Tier [currentTier] while auth-service has the customer approved at
  ///    Tier [profileTier]. They have already done the work; the upgrade has
  ///    not reached their account row. Sending them back to BVN re-submits a
  ///    verification that is already approved and lifts nothing.
  ///  * **They are at the top of the ladder.** There is no Tier 4, and Tier 3
  ///    is Unlimited in the canonical matrix, so a cap applied to a Tier-3
  ///    holder is a limit somebody set — not a regulatory ceiling identity
  ///    verification removes.
  ///
  /// The honest copy says the transfer was refused, says nothing was sent, and
  /// offers the one route that can actually fix it.
  final bool limitsOutOfSync;

  /// What the auth-service profile believes the customer's tier is.
  ///
  /// Shown alongside [currentTier] in the out-of-sync case so the customer is
  /// told both numbers rather than asked to accept one that contradicts the
  /// tier badge they can see elsewhere in the app.
  final int profileTier;

  const KYCUpgradeModal({
    super.key,
    required this.currentTier,
    required this.requiredTier,
    required this.operationName,
    this.kycStatus = '',
    this.limitsOutOfSync = false,
    this.profileTier = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Shared predicate, not an inline compare. This recognised exactly one of
    // the wordings the backend can send, so a holder whose documents were
    // already with us saw "verify now" and was invited to submit them twice.
    //
    // currentTier is passed too: a holder can reach a verified tier while the
    // status still reads pending, and the pair resolves that consistently
    // everywhere rather than each surface guessing.
    final inReview = !limitsOutOfSync &&
        resolveKycState(status: kycStatus, tier: currentTier) ==
            KycState.inReview;

    // Out-of-sync takes the whole sheet: a different icon, different copy and
    // a different route. It is checked before `inReview` above for the same
    // reason — a customer whose limits are stale must not be told their
    // documents are still being looked at.
    if (limitsOutOfSync) return _buildOutOfSync(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Shield icon
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              color: const Color(0xFFFB923C),
              size: 32.w,
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            inReview ? 'Verification in review' : 'Verify to continue',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            inReview
                ? "Your identity verification is being reviewed. We'll unlock the ability to $operationName as soon as it's approved."
                : 'You need Tier $requiredTier verification to $operationName. '
                    "You're currently Tier $currentTier, verify your identity to unlock it.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.h),

          // Tier comparison — hidden while a submission is under review: the user
          // already provided their details, so limits would only distract.
          if (!inReview) ...[
            _buildTierComparison(),
            SizedBox(height: 24.h),
          ] else
            SizedBox(height: 16.h),

          if (inReview)
            // Under review: a single acknowledge CTA. Routing to re-verify would
            // make the user resubmit an in-flight verification.
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Got it',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else ...[
            // Verify button — routes to the identity-verification flow.
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () async {
                  Get.back();
                  await Future.delayed(const Duration(milliseconds: 150));
                  Get.toNamed(AppRoutes.kycBVNVerification);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Verify Now',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Maybe later button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Maybe Later',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// The sheet for "verifying cannot fix this".
  ///
  /// Deliberately carries no tier comparison: the two columns exist to show
  /// what an upgrade would buy, and there is no upgrade on offer here. What a
  /// customer needs instead is (a) reassurance that their money did not move,
  /// and (b) the one route that can resolve it.
  Widget _buildOutOfSync(BuildContext context) {
    final behind = profileTier > currentTier;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              behind ? Icons.sync_problem_outlined : Icons.flag_outlined,
              color: const Color(0xFFFB923C),
              size: 32.w,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            behind ? 'Your limits are out of date' : 'Limit reached',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            behind
                ? 'Your verification is approved at Tier $profileTier, but this '
                    'account is still on Tier $currentTier limits — which is why '
                    "we couldn't $operationName. Nothing was sent and nothing "
                    'was charged. Support can refresh your limits.'
                : "You're already fully verified, so this was a limit set on "
                    "your account rather than a verification step. Nothing was "
                    'sent and nothing was charged — support can review it with '
                    'you.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              // POP BEFORE NAVIGATING. Pushing the support screen while this
              // sheet is still mounted strands the sheet over it — the same
              // ordering the Verify button below uses.
              onPressed: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 150));
                Get.toNamed(AppRoutes.supportTickets);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Contact support',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Got it',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierComparison() {
    final currentLimits = _getTierLimits(currentTier);
    final upgradeLimits = _getTierLimits(requiredTier);

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Current tier
          Expanded(
            child: Column(
              children: [
                Text(
                  'Tier $currentTier',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  currentLimits,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Arrow
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(
              Icons.arrow_forward,
              color: const Color(0xFF3B82F6),
              size: 20.w,
            ),
          ),
          // Upgrade tier
          Expanded(
            child: Column(
              children: [
                Text(
                  'Tier $requiredTier',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF10B981),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  upgradeLimits,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tier daily-limit labels, READ FROM THE APP'S ONE CONFIG rather than typed
  // here.
  //
  // These were three hardcoded strings, with a comment instructing whoever
  // edited them to keep them in lock-step with the backend by hand. That is
  // the same arrangement that let the enforced caps drift to a hundred times
  // the displayed ones without anything failing: the app said ₦50,000/day and
  // accounts-service enforced ₦5,000,000/day, because the two numbers were
  // written in different places in different units and nothing compared them.
  //
  // CountryConfig.dailyLimits already holds the per-tier figures in naira and
  // is documented as tracking the canonical shared/kyctiers Matrix, so it is
  // the single place the app states a tier cap. kyc_tier_limits_test.dart
  // pins those values against the published CBN figures, so a drift fails the
  // build rather than reaching a customer as a wrong promise.
  //
  // Still display-only: the backend enforces, and a label is never a cap.
  String _getTierLimits(int tier) {
    final limits = CountryConfigs.nigeria.dailyLimits;
    final level = switch (tier) {
      1 => KycLevel.basic,
      2 => KycLevel.standard,
      3 => KycLevel.advanced,
      _ => null,
    };
    if (level == null) return 'N/A';
    final amount = limits[level];
    if (amount == null) return 'N/A';
    // 0 is the canonical encoding of Unlimited (kyctiers.IsUnlimited), not a
    // cap of nothing — rendering it as ₦0/day would tell a fully verified
    // customer they may send nothing at all.
    if (amount == 0) return 'Unlimited';
    // Explicitly NGN, not the viewer's current display currency: a CBN tier
    // cap is a naira figure, and rendering it with a dollar sign because the
    // user is browsing in USD would state a limit that does not exist.
    return '${CurrencySymbols.formatAmountWithCurrency(amount.toDouble(), 'NGN')}/day';
  }
}
