import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../services/lock_funds_pdf_service.dart';
import 'package:lazervault/core/types/app_routes.dart';

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

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return currency;
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
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.lockFunds),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        title: Text(
          'Lock Confirmation',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.h),
                    _buildSuccessIcon(),
                    SizedBox(height: 24.h),
                    Text(
                      'Funds Locked Successfully!',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Your funds are now earning interest',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _buildAmountCard(),
                    SizedBox(height: 24.h),
                    _buildLockDetails(),
                    if (interestCalculation != null) ...[
                      SizedBox(height: 24.h),
                      _buildExpectedReturns(),
                    ],
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

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
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
        Icons.lock_rounded,
        color: const Color(0xFF10B981),
        size: 50.sp,
      ),
    );
  }

  Widget _buildAmountCard() {
    final currencySymbol = _getCurrencySymbol(lockFund.currency);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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
          SizedBox(height: 8.h),
          Text(
            '$currencySymbol${lockFund.amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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

  Widget _buildLockDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lock Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Lock Type', lockFund.lockType.displayName),
          SizedBox(height: 12.h),
          _buildDetailRow('Duration', lockFund.durationText),
          SizedBox(height: 12.h),
          _buildDetailRow('Interest Rate', lockFund.formattedInterestRate),
          SizedBox(height: 12.h),
          _buildDetailRow('Locked On', _formatDate(lockFund.lockedAt)),
          SizedBox(height: 12.h),
          _buildDetailRow('Matures On', _formatDate(lockFund.unlockAt)),
          if (lockFund.goalName != null && lockFund.goalName!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Goal', lockFund.goalName!),
          ],
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Auto-Renew',
            lockFund.autoRenew ? 'Enabled' : 'Disabled',
          ),
          if (lockFund.transactionId != null &&
              lockFund.transactionId!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Reference', lockFund.transactionId!),
          ],
          SizedBox(height: 12.h),
          _buildDetailRow('Status', lockFund.status.displayName),
        ],
      ),
    );
  }

  Widget _buildExpectedReturns() {
    final currencySymbol = _getCurrencySymbol(lockFund.currency);
    final calc = interestCalculation!;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                color: const Color(0xFF10B981),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Expected Returns',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildReturnRow(
            'Principal',
            '$currencySymbol${calc.principalAmount.toStringAsFixed(2)}',
            isHighlighted: false,
          ),
          SizedBox(height: 12.h),
          _buildReturnRow(
            'Interest Earned',
            '+$currencySymbol${calc.estimatedInterest.toStringAsFixed(2)}',
            isHighlighted: true,
          ),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
          SizedBox(height: 12.h),
          _buildReturnRow(
            'Total at Maturity',
            '$currencySymbol${calc.totalReturn.toStringAsFixed(2)}',
            isHighlighted: false,
            isBold: true,
          ),
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

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Share and Download buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _shareReceipt,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF6366F1),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: const Color(0xFF6366F1),
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Share',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: _downloadReceipt,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF6366F1),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isDownloading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Color(0xFF6366F1),
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                Icons.download,
                                color: const Color(0xFF6366F1),
                                size: 20.sp,
                              ),
                        SizedBox(width: 8.w),
                        Text(
                          'Download',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // View My Locks button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => Get.offAllNamed(AppRoutes.lockFunds),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'View My Locks',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Back to Home button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => Get.offAllNamed(AppRoutes.home),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Back to Home',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
