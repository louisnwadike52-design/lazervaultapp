import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../controllers/exchange_controller.dart';
import 'widgets/currency_selector_sheet.dart';
import 'exchange_recipient_screen.dart';
import 'exchange_history_screen.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    // Load recent transaction history
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ExchangeController>().loadRecentTransactions();
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showCurrencySelector(bool isFromCurrency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CurrencySelectorSheet(
        isFromCurrency: isFromCurrency,
      ),
    );
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
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          _buildExchangeCard(controller),
                          SizedBox(height: 20.h),
                          // Always show rate info (even when loading)
                          _buildRateInfo(controller),
                          if (controller.errorMessage.value.isNotEmpty)
                            _buildErrorMessage(controller),
                          SizedBox(height: 20.h),
                          _buildRecentTransactions(controller),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
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
            onTap: () => Navigator.of(context).pop(),
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
                  'Currency Exchange',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Send money worldwide',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          MicroserviceChatIcon(
            serviceName: 'Exchange',
            sourceContext: 'investments',
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => Get.to(() => const ExchangeHistoryScreen()),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Icon(
                Icons.history,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeCard(ExchangeController controller) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // From Currency
          _buildCurrencyInput(
            label: 'You send',
            currency: controller.fromCurrency.value,
            controller: _amountController,
            onCurrencyTap: () => _showCurrencySelector(true),
            onAmountChanged: (value) {
              final amount = double.tryParse(value) ?? 0.0;
              controller.setAmount(amount);
            },
            isEditable: true,
          ),

          SizedBox(height: 16.h),

          // Swap Button
          GestureDetector(
            onTap: () {
              controller.swapCurrencies();
              // Update amount display
              _amountController.text = controller.amount.value > 0
                  ? controller.amount.value.toStringAsFixed(2)
                  : '';
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.swap_vert,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // To Currency
          _buildCurrencyInput(
            label: 'They receive',
            currency: controller.toCurrency.value,
            amount: controller.convertedAmount,
            onCurrencyTap: () => _showCurrencySelector(false),
            isEditable: false,
            isLoading: controller.isLoadingRate.value,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyInput({
    required String label,
    Currency? currency,
    TextEditingController? controller,
    double? amount,
    required VoidCallback onCurrencyTap,
    ValueChanged<String>? onAmountChanged,
    bool isEditable = false,
    bool isLoading = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              // Currency selector
              GestureDetector(
                onTap: onCurrencyTap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (currency != null) ...[
                        Container(
                          width: 24.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: CachedNetworkImage(
                              imageUrl: currency.flagUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: const Color(0xFF2F2F2F),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: const Color(0xFF2F2F2F),
                                child: Icon(Icons.flag, size: 12.sp, color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          currency.code,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF3B82F6),
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Amount
              Expanded(
                child: isLoading
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                          ),
                        ),
                      )
                    : isEditable
                        ? TextField(
                            controller: controller,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0.00',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.grey[600],
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onChanged: onAmountChanged,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                          )
                        : Text(
                            amount != null && amount > 0
                                ? amount.toStringAsFixed(2)
                                : '0.00',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRateInfo(ExchangeController controller) {
    final bool hasRate = controller.currentRate.value != null;
    final bool isLoading = controller.isLoadingRate.value;
    final fromCode = controller.fromCurrency.value?.code ?? 'USD';
    final toCode = controller.toCurrency.value?.code ?? 'GBP';
    final fromSymbol = controller.fromCurrency.value?.symbol ?? '\$';

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
        children: [
          _buildInfoRow(
            'Exchange Rate',
            isLoading
                ? 'Loading...'
                : hasRate
                    ? '1 $fromCode = ${controller.currentRate.value!.rate.toStringAsFixed(4)} $toCode'
                    : '1 $fromCode = --- $toCode',
            Icons.sync_alt,
            isLoading: isLoading,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Transfer Fee',
            isLoading
                ? 'Loading...'
                : hasRate
                    ? '$fromSymbol${controller.fees.toStringAsFixed(2)}'
                    : '${fromSymbol}0.00',
            Icons.receipt,
            isLoading: isLoading,
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
              isLoading
                  ? SizedBox(
                      height: 16.h,
                      width: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                      ),
                    )
                  : Text(
                      hasRate
                          ? '$fromSymbol${controller.totalCost.toStringAsFixed(2)}'
                          : '${fromSymbol}0.00',
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

  Widget _buildInfoRow(String label, String value, IconData icon, {bool isLoading = false}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3B82F6), size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
        isLoading
            ? SizedBox(
                height: 14.h,
                width: 14.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              )
            : Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ],
    );
  }

  Widget _buildErrorMessage(ExchangeController controller) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEF4444)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              controller.errorMessage.value,
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.clearError(),
            child: Icon(Icons.close, color: const Color(0xFFEF4444), size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(ExchangeController controller) {
    final bool canContinue = controller.amount.value > 0 &&
        controller.fromCurrency.value != null &&
        controller.toCurrency.value != null &&
        controller.fromCurrency.value?.code != controller.toCurrency.value?.code &&
        controller.currentRate.value != null;

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
          color: canContinue ? const Color(0xFF3B82F6) : const Color(0xFF374151),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: canContinue
              ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: canContinue
                ? () {
                    // Navigate to recipient selection screen
                    Get.to(() => const ExchangeRecipientScreen());
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(
                    color: canContinue ? Colors.white : const Color(0xFF9CA3AF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(ExchangeController controller) {
    if (controller.isLoadingHistory.value) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        ),
      );
    }

    final recentTransactions = controller.recentTransactions.take(3).toList();

    if (recentTransactions.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
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
          children: [
            Icon(
              Icons.history,
              color: const Color(0xFF6B7280),
              size: 48.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'No recent transactions',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
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
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const ExchangeHistoryScreen()),
                  child: Text(
                    'View All',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...recentTransactions.map((transaction) => _buildTransactionItem(transaction, controller)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(CurrencyTransaction transaction, ExchangeController controller) {
    return InkWell(
      onTap: () => controller.repeatTransaction(transaction, _amountController),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.swap_horiz,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.fromCurrency} → ${transaction.toCurrency}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    transaction.recipientName,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.fromAmount.toStringAsFixed(2)} ${transaction.fromCurrency}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(transaction.status.toString().split('.').last).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    transaction.status.toString().split('.').last,
                    style: GoogleFonts.inter(
                      color: _getStatusColor(transaction.status.toString().split('.').last),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return const Color(0xFF10B981);
      case 'pending':
      case 'processing':
        return const Color(0xFFFB923C);
      case 'failed':
      case 'cancelled':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
