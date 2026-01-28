import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controllers/exchange_controller.dart';
import 'exchange_processing_screen.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class ExchangeConfirmationScreen extends StatefulWidget {
  const ExchangeConfirmationScreen({super.key});

  @override
  State<ExchangeConfirmationScreen> createState() =>
      _ExchangeConfirmationScreenState();
}

class _ExchangeConfirmationScreenState
    extends State<ExchangeConfirmationScreen>
    with SingleTickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

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

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _confirmAndSubmit() async {
    final controller = Get.find<ExchangeController>();

    // Get exchange details for PIN validation
    final fromCurrency = controller.fromCurrency.value!.code;
    final toCurrency = controller.toCurrency.value!.code;
    final amount = controller.amount.value;

    // Generate unique transaction ID
    final transactionId = 'currency_exchange_${DateTime.now().millisecondsSinceEpoch}_${fromCurrency}_to_$toCurrency';

    // Validate PIN before processing currency exchange
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'currency_exchange',
      amount: amount,
      currency: fromCurrency,
      title: 'Confirm Currency Exchange',
      message: 'Confirm exchange of $amount $fromCurrency to $toCurrency?',
      onPinValidated: (verificationToken) async {
        // PIN is valid, proceed with exchange
        _executeExchangeWithToken(transactionId, verificationToken, controller);
      },
    );

    if (!success) {
      // PIN validation failed or was cancelled
      // User has already been notified via the mixin
    }
  }

  /// Execute currency exchange with verification token
  Future<void> _executeExchangeWithToken(
    String transactionId,
    String verificationToken,
    ExchangeController controller,
  ) async {
    // Store verification token in controller for backend use
    controller.setVerificationToken(verificationToken);
    controller.setTransactionId(transactionId);

    final success = await controller.submitTransfer();

    if (success) {
      // Navigate to processing screen
      Get.off(() => const ExchangeProcessingScreen());
    } else {
      // Show error dialog
      Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Transfer Failed',
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1D1F),
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            controller.errorMessage.value,
            style: GoogleFonts.inter(color: const Color(0xFF6F767E)),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'OK',
                style: GoogleFonts.inter(color: const Color(0xFF3B82F6)),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: GetX<ExchangeController>(
          builder: (controller) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildReviewContent(controller),
                        ),
                      );
                    },
                  ),
                ),
                _buildBottomButton(controller),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Transfer',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Confirm your transfer details',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewContent(ExchangeController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          _buildTransferSummaryCard(controller),
          SizedBox(height: 16.h),
          if (controller.selectedRecipient.value != null)
            _buildRecipientCard(controller),
          SizedBox(height: 16.h),
          _buildTransactionDetails(controller),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildTransferSummaryCard(ExchangeController controller) {
    final fromCurrency = controller.fromCurrency.value!;
    final toCurrency = controller.toCurrency.value!;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E3A8A),
            Color(0xFF3B82F6),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Send Section
          _buildAmountSection(
            title: 'You Send',
            amount: controller.amount.value,
            currency: fromCurrency,
            alignment: CrossAxisAlignment.start,
          ),

          SizedBox(height: 20.h),

          // Arrow Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_downward_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),

          SizedBox(height: 20.h),

          // Receive Section
          _buildAmountSection(
            title: 'They Receive',
            amount: controller.convertedAmount,
            currency: toCurrency,
            alignment: CrossAxisAlignment.end,
          ),

          SizedBox(height: 24.h),

          // Total Deducted Section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total deducted from your account',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '${fromCurrency.symbol}${controller.totalCost.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection({
    required String title,
    required double amount,
    required currency,
    required CrossAxisAlignment alignment,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: alignment == CrossAxisAlignment.start
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              if (alignment == CrossAxisAlignment.start) ...[
                _buildCurrencyFlag(currency.flagUrl, size: 28),
                SizedBox(width: 12.w),
              ],
              Text(
                '${currency.symbol}${amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              if (alignment == CrossAxisAlignment.end) ...[
                SizedBox(width: 12.w),
                _buildCurrencyFlag(currency.flagUrl, size: 28),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              currency.code,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(ExchangeController controller) {
    final recipient = controller.selectedRecipient.value!;

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
            'Recipient Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    recipient.initials,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipient.name,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${recipient.bankName} • ${recipient.accountNumber}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(ExchangeController controller) {
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
            'Exchange Rate',
            '1 ${controller.fromCurrency.value?.code} = ${controller.currentRate.value?.rate.toStringAsFixed(4)} ${controller.toCurrency.value?.code}',
          ),
          _buildDetailRow(
            'Transfer Fee',
            '${controller.fromCurrency.value?.symbol}${controller.fees.toStringAsFixed(2)}',
          ),
          _buildDetailRow('Estimated Arrival', '1-3 business days'),
          _buildDetailRow('Transfer Method', 'Bank Transfer'),
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
                '${controller.fromCurrency.value?.symbol}${controller.totalCost.toStringAsFixed(2)}',
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyFlag(String flagUrl, {double size = 24}) {
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: CachedNetworkImage(
          imageUrl: flagUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: const Color(0xFFF5F7FA),
          ),
          errorWidget: (context, url, error) => Container(
            color: const Color(0xFFF5F7FA),
            child: Icon(Icons.flag, size: size * 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(ExchangeController controller) {
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
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF10B981),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: controller.isSubmitting.value ? null : _confirmAndSubmit,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(
                child: controller.isSubmitting.value
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.security, color: Colors.white, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Confirm & Send',
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
      ),
    );
  }
}
