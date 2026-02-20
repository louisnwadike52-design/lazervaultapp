import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/types/app_routes.dart';
import '../controllers/exchange_controller.dart';

class ExchangeReceiptScreen extends StatefulWidget {
  const ExchangeReceiptScreen({super.key});

  @override
  State<ExchangeReceiptScreen> createState() => _ExchangeReceiptScreenState();
}

class _ExchangeReceiptScreenState extends State<ExchangeReceiptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: GetX<ExchangeController>(
          builder: (controller) {
            final transaction = controller.lastTransaction.value;
            final isConversion = controller.isConversionMode.value;

            return Column(
              children: [
                _buildHeader(isConversion),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: _buildSuccessIcon(),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            isConversion ? 'Conversion Successful!' : 'Transfer Successful!',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          if (transaction != null) ...[
                            Text(
                              isConversion
                                  ? 'Your ${transaction.fromCurrency} has been converted to ${transaction.toCurrency}'
                                  : 'Your money is on its way to ${transaction.recipient.name}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32.h),
                            _buildSuccessDetails(controller, transaction, isConversion),
                            SizedBox(height: 24.h),
                            _buildTransactionDetails(controller, transaction, isConversion),
                          ],
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomActions(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isConversion) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Text(
        isConversion ? 'Conversion Complete' : 'Transfer Complete',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 50.sp,
      ),
    );
  }

  Widget _buildSuccessDetails(ExchangeController controller, transaction, bool isConversion) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF10B981),
            Color(0xFF059669),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Transaction ID',
            transaction.id.length > 16
                ? '${transaction.id.substring(0, 16)}...'
                : transaction.id,
            isWhite: true,
          ),
          _buildDetailRow(
            isConversion ? 'Amount Converted' : 'Amount Sent',
            '${controller.fromCurrency.value?.symbol}${transaction.fromAmount.toStringAsFixed(2)} ${transaction.fromCurrency}',
            isWhite: true,
          ),
          _buildDetailRow(
            'Amount Received',
            '${controller.toCurrency.value?.symbol}${transaction.toAmount.toStringAsFixed(2)} ${transaction.toCurrency}',
            isWhite: true,
          ),
          if (!isConversion)
            _buildDetailRow(
              'Recipient',
              transaction.recipient.name,
              isWhite: true,
            ),
          _buildDetailRow(
            'Estimated Arrival',
            isConversion ? 'Instant' : '1-3 business days',
            isWhite: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(ExchangeController controller, transaction, bool isConversion) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Date & Time',
            dateFormat.format(transaction.createdAt),
          ),
          _buildDetailRow(
            'Exchange Rate',
            _formatTransactionRate(transaction.exchangeRate, transaction.fromCurrency, transaction.toCurrency),
          ),
          if (controller.featureConfig.showServiceFee)
            _buildDetailRow(
              isConversion ? 'Conversion Fee' : 'Transfer Fee',
              '${controller.fromCurrency.value?.symbol}${transaction.fees.toStringAsFixed(2)}',
            )
          else
            _buildDetailRow('Service Fee', 'Free'),
          _buildDetailRow(
            'Type',
            isConversion ? 'Wallet Conversion' : 'International Transfer',
          ),
          if (!isConversion) ...[
            _buildDetailRow(
              'Bank Name',
              transaction.recipient.bankName,
            ),
            _buildDetailRow(
              'Account Number',
              transaction.recipient.accountNumber,
            ),
            if (transaction.recipient.swiftCode != null &&
                transaction.recipient.swiftCode!.isNotEmpty)
              _buildDetailRow(
                'SWIFT Code',
                transaction.recipient.swiftCode!,
              ),
          ],
          if (transaction.referenceNumber != null &&
              transaction.referenceNumber!.isNotEmpty)
            _buildDetailRow(
              'Reference',
              transaction.referenceNumber!,
            ),
          Divider(color: const Color(0xFF2D2D2D), height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Cost',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${controller.fromCurrency.value?.symbol}${controller.featureConfig.showServiceFee ? transaction.totalCost.toStringAsFixed(2) : transaction.fromAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isWhite = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: isWhite ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: isWhite ? Colors.white : Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: _shareReceipt,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Share Receipt',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: _goToHome,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Center(
                  child: Text(
                    'Back to Home',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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

  void _shareReceipt() {
    // TODO: Implement receipt sharing
    Get.snackbar(
      'Share Receipt',
      'Receipt sharing feature coming soon',
      backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _goToHome() {
    // Clear the exchange data
    final controller = Get.find<ExchangeController>();
    controller.reset();

    // Navigate to home
    Get.offAllNamed(AppRoutes.dashboard);
  }

  /// Format rate for display on receipt, always showing "1 FROM = X TO" format.
  String _formatTransactionRate(double rate, String fromCurrency, String toCurrency) {
    if (rate >= 0.01) {
      return '1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency';
    }
    // For very small rates, show more decimal places for precision
    return '1 $fromCurrency = ${rate.toStringAsFixed(6)} $toCurrency';
  }
}
