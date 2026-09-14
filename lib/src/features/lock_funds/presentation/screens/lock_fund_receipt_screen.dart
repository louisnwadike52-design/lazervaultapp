import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../services/lock_funds_pdf_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Receipt screen displayed after successfully creating a lock fund.
///
/// Shows confirmation of the locked amount, lock details, and
/// expected returns. Follows the same pattern as TagPaymentReceiptScreen.
class LockFundReceiptScreen extends StatefulWidget {
  const LockFundReceiptScreen({super.key});

  @override
  State<LockFundReceiptScreen> createState() => _LockFundReceiptScreenState();
}

class _LockFundReceiptScreenState extends State<LockFundReceiptScreen> {
  late final LockFund lockFund;
  late final InterestCalculation? interestCalculation;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    lockFund = args['lockFund'];
    interestCalculation = args['interestCalculation'];
  }

  Future<void> _downloadReceipt() async {
    HapticFeedback.lightImpact();
    setState(() => _isDownloading = true);

    try {
      final filePath = await LockFundsPdfService.downloadLockConfirmation(
        lockFund: lockFund,
        // Use the backend's own CalculateInterest figures when we have them
        // (post-create) so the PDF matches the on-screen numbers instead of
        // printing the accrued-so-far (0 at creation).
        expectedInterest: interestCalculation?.estimatedInterest,
        expectedTotal: interestCalculation?.totalReturn,
      );

      if (mounted) {
        setState(() => _isDownloading = false);
        Get.snackbar(
          'Receipt Downloaded',
          'Saved to $filePath',
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDownloading = false);
        Get.snackbar(
          'Download Failed',
          e.toString(),
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  Future<void> _shareReceipt() async {
    HapticFeedback.lightImpact();

    try {
      await LockFundsPdfService.shareLockConfirmation(
        lockFund: lockFund,
        expectedInterest: interestCalculation?.estimatedInterest,
        expectedTotal: interestCalculation?.totalReturn,
        sharePositionOrigin:
            LockFundsPdfService.shareOriginFromContext(context),
      );
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        e.toString(),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // The top-left back button is the ONLY navigation affordance now — it
        // returns to the locks landing, so the old "View My Locks" / "Back to
        // Home" CTAs are gone (they duplicated this).
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.lockFunds),
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFFA78BFA),
            size: 24.sp,
          ),
        ),
        // Lazervault brand lockup, top-right — same pattern as the send-funds
        // receipt so every receipt carries the wordmark.
        actions: [
          _buildBrandLockup(),
          SizedBox(width: 16.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Compact, glance-able receipt. A scroll view remains as a safety
            // net for very small screens, but the content is consolidated so it
            // fits without scrolling on a normal device — success header,
            // amount, and ONE merged details+returns card.
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSuccessHeader(),
                    SizedBox(height: 16.h),
                    _buildAmountCard(),
                    SizedBox(height: 14.h),
                    _buildDetailsAndReturns(),
                  ],
                ),
              ),
            ),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  /// Lazervault brand lockup (logo + wordmark) for the app-bar's top-right —
  /// mirrors the send-funds receipt so every receipt carries the wordmark.
  Widget _buildBrandLockup() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26.w,
          height: 26.w,
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Image.asset(
            'assets/images/logo.png',
            errorBuilder: (_, __, ___) => Icon(
              Icons.lock_rounded,
              color: const Color(0xFFA78BFA),
              size: 14.sp,
            ),
          ),
        ),
        SizedBox(width: 7.w),
        Text(
          'Lazervault',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  /// Compact success header: a small circular icon beside the headline, instead
  /// of the old 100px circle + 24sp title stack that pushed content off-screen.
  Widget _buildSuccessHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF10B981).withValues(alpha: 0.2),
                const Color(0xFF059669).withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_rounded,
            color: const Color(0xFF10B981),
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Funds Locked Successfully',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Your funds are now earning interest',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountCard() {
    final currencySymbol = CurrencySymbols.getSymbol(lockFund.currency);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Amount Locked',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '$currencySymbol${lockFund.amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lockFund.lockType.icon,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(width: 8.w),
                Text(
                  lockFund.lockType.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// One consolidated card merging Lock Details + Expected Returns so the whole
  /// receipt fits at a glance without scrolling. The returns block only renders
  /// when we have a calculation (post-create). Upfront-vs-accrual is driven by
  /// the ACTUAL per-plan config (calc.qualifiesForUpfrontInterest, which now
  /// reflects supports_upfront_interest) — accrual locks never claim an upfront
  /// payout; they show interest as earned AT MATURITY.
  Widget _buildDetailsAndReturns() {
    final currencySymbol = CurrencySymbols.getSymbol(lockFund.currency);
    final calc = interestCalculation;
    final isUpfront = calc != null && calc.qualifiesForUpfrontInterest;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lock Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow('Lock Type', lockFund.lockType.displayName),
          SizedBox(height: 8.h),
          _buildDetailRow('Duration', lockFund.durationText),
          SizedBox(height: 8.h),
          _buildDetailRow('Interest Rate', lockFund.formattedInterestRate),
          SizedBox(height: 8.h),
          _buildDetailRow('Matures On', _formatDate(lockFund.unlockAt)),
          if (lockFund.status == LockStatus.active &&
              lockFund.daysRemaining > 0) ...[
            SizedBox(height: 8.h),
            _buildDetailRow('Matures In', lockFund.daysRemainingText),
          ],
          if (lockFund.goalName != null && lockFund.goalName!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildDetailRow('Goal', lockFund.goalName!),
          ],
          SizedBox(height: 8.h),
          _buildDetailRow(
            'Auto-Renew',
            lockFund.autoRenew ? 'Enabled' : 'Disabled',
          ),
          if (lockFund.transactionId != null &&
              lockFund.transactionId!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildDetailRow('Reference', lockFund.transactionId!),
          ],
          SizedBox(height: 8.h),
          _buildDetailRow('Status', lockFund.status.displayName),

          // Returns — merged into the same card. Only shown post-create.
          if (calc != null) ...[
            SizedBox(height: 14.h),
            Divider(
              color: const Color(0xFF10B981).withValues(alpha: 0.25),
              height: 1,
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Icon(
                  Icons.trending_up_rounded,
                  color: const Color(0xFF10B981),
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  isUpfront ? 'Interest' : 'Expected Returns',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _buildReturnRow(
              'Principal',
              '$currencySymbol${calc.principalAmount.toStringAsFixed(2)}',
            ),
            SizedBox(height: 8.h),
            _buildReturnRow(
              isUpfront ? 'Interest Paid Upfront' : 'Interest at Maturity',
              '+$currencySymbol${calc.estimatedInterest.toStringAsFixed(2)}',
              isHighlighted: true,
            ),
            SizedBox(height: 8.h),
            _buildReturnRow(
              isUpfront ? 'Total Value' : 'Total at Maturity',
              '$currencySymbol${calc.totalReturn.toStringAsFixed(2)}',
              isBold: true,
            ),
            // Upfront-only confirmation note (accrual plans omit this — the
            // money has NOT been credited yet).
            if (isUpfront) ...[
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: const Color(0xFF10B981),
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'Interest credited to your savings account immediately',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReturnRow(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isHighlighted
                ? const Color(0xFF10B981)
                : const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: isHighlighted ? const Color(0xFF10B981) : Colors.white,
            fontSize: isBold ? 18.sp : 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Bottom actions — Share + Download ONLY. The old "View My Locks" and "Back
  /// to Home" CTAs are gone: the top-left back button returns to the locks
  /// landing, which is the same destination, so those buttons were redundant
  /// clutter that forced the receipt to scroll.
  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _actionButton(Icons.share, 'Share', _shareReceipt)),
          SizedBox(width: 12.w),
          Expanded(
            child: _actionButton(
              Icons.download,
              'Download',
              _downloadReceipt,
              isLoading: _isDownloading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF8B5CF6), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? LazerVaultLoader.small()
                : Icon(icon, color: const Color(0xFFA78BFA), size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFA78BFA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
