import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../services/lock_funds_pdf_service.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

class LockWithdrawalSuccessScreen extends StatefulWidget {
  final LockFund lockFund;
  final double amountReturned;
  final double penaltyAmount;
  final double interestEarned;

  const LockWithdrawalSuccessScreen({
    super.key,
    required this.lockFund,
    required this.amountReturned,
    required this.penaltyAmount,
    required this.interestEarned,
  });

  @override
  State<LockWithdrawalSuccessScreen> createState() => _LockWithdrawalSuccessScreenState();
}

class _LockWithdrawalSuccessScreenState extends State<LockWithdrawalSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _navigateBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A3E),
                Color(0xFF0A0E27),
                Color(0xFF0F0F23),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        _buildSuccessIcon(),
                        SizedBox(height: 24.h),
                        _buildAmountCard(),
                        SizedBox(height: 20.h),
                        _buildReceiptCard(),
                        SizedBox(height: 24.h),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: _navigateBack,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Withdrawal Complete',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50.sp,
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF10B981).withValues(alpha: 0.2),
              const Color(0xFF10B981).withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Text(
              'Amount Credited',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${CurrencySymbols.getSymbol(widget.lockFund.currency)}${widget.amountReturned.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Funds have been added to your account',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F2E),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Transaction Details',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildReceiptRow('Lock Type', widget.lockFund.lockType.displayName),
            _buildReceiptRow('Lock Name', widget.lockFund.displayName),
            _buildReceiptRow(
              'Principal',
              '${CurrencySymbols.getSymbol(widget.lockFund.currency)}${widget.lockFund.amount.toStringAsFixed(2)}',
            ),
            _buildReceiptRow(
              'Interest Earned',
              '+${CurrencySymbols.getSymbol(widget.lockFund.currency)}${widget.interestEarned.toStringAsFixed(2)}',
              valueColor: const Color(0xFF10B981),
            ),
            if (widget.penaltyAmount > 0)
              _buildReceiptRow(
                'Penalty',
                '-${CurrencySymbols.getSymbol(widget.lockFund.currency)}${widget.penaltyAmount.toStringAsFixed(2)}',
                valueColor: const Color(0xFFEF4444),
              ),
            _buildReceiptRow(
              'Date',
              DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now()),
            ),
            if (widget.lockFund.transactionId != null)
              _buildReceiptRow('Reference', widget.lockFund.transactionId!),
            Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Received',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${CurrencySymbols.getSymbol(widget.lockFund.currency)}${widget.amountReturned.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: valueColor ?? Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
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
          GestureDetector(
            onTap: _navigateBack,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  'Done',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadReceipt() async {
    HapticFeedback.lightImpact();
    setState(() => _isDownloading = true);

    try {
      final filePath = await LockFundsPdfService.downloadWithdrawalReceipt(
        lockFund: widget.lockFund,
        amountReturned: widget.amountReturned,
        penaltyAmount: widget.penaltyAmount,
        interestEarned: widget.interestEarned,
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
      await LockFundsPdfService.shareWithdrawalReceipt(
        lockFund: widget.lockFund,
        amountReturned: widget.amountReturned,
        penaltyAmount: widget.penaltyAmount,
        interestEarned: widget.interestEarned,
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

  void _navigateBack() {
    HapticFeedback.lightImpact();
    // Navigate back to lock funds list
    Get.until((route) => route.isFirst || route.settings.name == '/lock-funds');
  }
}
