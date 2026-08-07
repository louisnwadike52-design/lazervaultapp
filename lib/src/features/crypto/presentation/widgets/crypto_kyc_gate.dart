import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_upgrade_modal.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';

/// Proactive KYC gate for crypto money flows. Returns true when the user may
/// proceed, or shows the identity-verification upgrade modal and returns false.
///
/// Quidax does not enforce KYC tiers per sub-account, so our own tier is the
/// gate (backend `crypto.min_kyc_tier`, default 2). The crypto-service also
/// enforces this preventively on the swap/withdraw RPCs, so this is the
/// friendly up-front check that saves the user from failing deep in a flow.
///
/// On an eligibility-lookup failure we DO NOT block: the backend gate remains
/// the authoritative backstop, so a transient outage never wrongly locks a
/// verified user out of trading.
Future<bool> ensureCryptoTradeAllowed(
  BuildContext context, {
  String operation = 'trade crypto',
}) async {
  try {
    final el = await GetIt.I<CryptoGrpcClient>().getCryptoEligibility();
    if (el.canTrade) return true;
    if (!context.mounted) return false;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => KYCUpgradeModal(
        currentTier: el.currentTier <= 0 ? 1 : el.currentTier,
        requiredTier: el.requiredTier <= 0 ? 2 : el.requiredTier,
        operationName: operation,
        kycStatus: el.kycStatus,
      ),
    );
    return false;
  } catch (_) {
    return true;
  }
}

/// A prominent, non-blocking banner on the crypto landing that appears only when
/// the user's verification tier is too low to trade. Tapping "Verify now" opens
/// the identity-verification flow; on return it re-checks and hides itself once
/// the user is verified (so the UI updates without a crash or manual refresh).
class CryptoVerifyBanner extends StatefulWidget {
  const CryptoVerifyBanner({super.key});

  @override
  State<CryptoVerifyBanner> createState() => _CryptoVerifyBannerState();
}

class _CryptoVerifyBannerState extends State<CryptoVerifyBanner> {
  bool _blocked = false;
  bool _loaded = false;
  int _currentTier = 1;
  int _requiredTier = 2;
  String _kycStatus = '';

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    try {
      final el = await GetIt.I<CryptoGrpcClient>().getCryptoEligibility();
      if (!mounted) return;
      setState(() {
        _blocked = !el.canTrade;
        _currentTier = el.currentTier <= 0 ? 1 : el.currentTier;
        _requiredTier = el.requiredTier <= 0 ? 2 : el.requiredTier;
        _kycStatus = el.kycStatus;
        _loaded = true;
      });
    } catch (_) {
      if (mounted) setState(() => _loaded = true);
    }
  }

  Future<void> _verify() async {
    // Route to identity verification, then re-check on return so the banner
    // disappears the moment the user reaches the required tier.
    await Get.toNamed(AppRoutes.kycBVNVerification);
    await _check();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded || !_blocked) return const SizedBox.shrink();
    final inReview = _kycStatus == 'pending_review';
    const accent = Color(0xFFFB923C);
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accent.withValues(alpha: 0.18), accent.withValues(alpha: 0.06)],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shield_outlined, color: accent, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inReview
                      ? 'Identity verification under review'
                      : 'Verify your identity to trade crypto',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  inReview
                      ? "We'll unlock buy, sell, swap and send once your verification is approved."
                      : 'You can browse freely. To buy, sell, swap or send, complete tier $_requiredTier verification (you are tier $_currentTier).',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          if (inReview)
            // Awaiting approval — a non-interactive status pill (routing to
            // re-verify would make the user resubmit an in-flight verification).
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.hourglass_top, color: accent, size: 13.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'In review',
                    style: GoogleFonts.inter(
                      color: accent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          else
            Material(
              color: accent,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                onTap: _verify,
                borderRadius: BorderRadius.circular(10.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Text(
                    'Verify',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
