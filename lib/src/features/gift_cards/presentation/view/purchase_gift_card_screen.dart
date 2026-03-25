import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../../../core/types/app_routes.dart';

class PurchaseGiftCardScreen extends StatefulWidget {
  final GiftCardBrand brand;

  const PurchaseGiftCardScreen({
    super.key,
    required this.brand,
  });

  @override
  State<PurchaseGiftCardScreen> createState() => _PurchaseGiftCardScreenState();
}

class _PurchaseGiftCardScreenState extends State<PurchaseGiftCardScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double? _selectedAmount;

  List<double> get _denominations {
    if (widget.brand.fixedDenominations.isNotEmpty) {
      return widget.brand.fixedDenominations.map((d) => d.price).toList();
    }
    // Range-based: generate smart suggestions within min/max
    if (widget.brand.minAmount > 0 && widget.brand.maxAmount > 0) {
      return _generateRangeDenominations(widget.brand.minAmount, widget.brand.maxAmount);
    }
    return [25, 50, 100, 250, 500];
  }

  List<double> _generateRangeDenominations(double min, double max) {
    final suggestions = <double>[];
    // Start from min, add mid-points up to max
    suggestions.add(min);
    final mid = ((min + max) / 2).roundToDouble();
    if (mid > min && mid < max) suggestions.add(mid);
    if (max > min) suggestions.add(max.floorToDouble());
    // Add a couple round numbers in between if range is wide
    for (final round in [25.0, 50.0, 75.0, 100.0, 150.0, 200.0]) {
      if (round > min && round < max && !suggestions.contains(round)) {
        suggestions.add(round);
      }
    }
    suggestions.sort();
    return suggestions.take(6).toList();
  }

  bool get _isRangeBased =>
      widget.brand.fixedDenominations.isEmpty &&
      widget.brand.minAmount > 0 &&
      widget.brand.maxAmount > 0;

  bool get _hasCustomAmount => _isRangeBased;

  /// For range-based products, calculate the local currency price using backend-provided fee config.
  /// Uses: (recipientAmount * fxRate) + margin% + flatFee
  /// The FX rate is derived from backend's minSenderAmount/minAmount (real Reloadly rate + fees).
  /// At purchase time, the backend recalculates with live rates — this is display-only.
  double? _estimateSenderAmount(double recipientAmount) {
    if (!_isRangeBased) return null;
    if (widget.brand.minAmount <= 0 || widget.brand.minSenderAmount <= 0) return null;
    // The ratio already includes margin + flat fee (baked in by the backend retail pricing)
    final rateWithFees = widget.brand.minSenderAmount / widget.brand.minAmount;
    return recipientAmount * rateWithFees;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildBrandCard(),
                      SizedBox(height: 28.h),
                      _buildAmountSelection(),
                      SizedBox(height: 28.h),
                      _buildPriceSummary(),
                      SizedBox(height: 32.h),
                      _buildPurchaseButton(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
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
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18.sp),
            ),
          ),
          Expanded(
            child: Text(
              'Purchase Gift Card',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 44.w),
        ],
      ),
    );
  }

  Widget _buildBrandCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            height: 64.h,
            width: 64.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: CachedNetworkImage(
                imageUrl: widget.brand.logoUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Icon(
                  Icons.image_rounded,
                  color: Colors.grey.shade400,
                  size: 28.sp,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.card_giftcard_rounded,
                  color: Colors.grey.shade400,
                  size: 28.sp,
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
                  widget.brand.name,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.brand.description,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.brand.discountPercentage > 0) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '${widget.brand.discountPercentage.toStringAsFixed(0)}% OFF',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get the sender currency label for display
  String get _senderCurrency =>
      widget.brand.senderCurrencyCode.isNotEmpty ? widget.brand.senderCurrencyCode : 'NGN';

  /// Get the recipient currency label for display
  String get _recipientCurrency =>
      widget.brand.currencyCode.isNotEmpty ? widget.brand.currencyCode : 'NGN';

  /// Get the sender (payment) amount for the currently selected denomination
  double? get _currentSenderAmount {
    if (_selectedAmount == null) return null;
    // Try fixed denomination lookup first
    final fixed = widget.brand.getSenderAmountForDenomination(_selectedAmount!);
    if (fixed != null) return fixed;
    // For range-based products, estimate using min ratio
    return _estimateSenderAmount(_selectedAmount!);
  }

  Widget _buildAmountSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Amount',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 14.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: _denominations.asMap().entries.map((entry) {
            final idx = entry.key;
            final amount = entry.value;
            final isSelected = _selectedAmount == amount;
            // Always show local currency price below the card value
            // For fixed denominations: use the matching senderDenominations entry
            // For range-based: estimate using min sender/recipient ratio
            double? senderPrice;
            if (widget.brand.senderDenominations.isNotEmpty &&
                idx < widget.brand.senderDenominations.length) {
              senderPrice = widget.brand.senderDenominations[idx];
            } else if (_isRangeBased) {
              senderPrice = _estimateSenderAmount(amount);
            }
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAmount = amount;
                  _amountController.text = amount.toStringAsFixed(0);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$_recipientCurrency ${amount.toStringAsFixed(0)}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (senderPrice != null && _senderCurrency != _recipientCurrency) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '$_senderCurrency ${_formatAmount(senderPrice)}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.8)
                              : const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        if (_hasCustomAmount) ...[
          SizedBox(height: 16.h),
          Text(
            'Or enter custom amount',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _selectedAmount = double.tryParse(value);
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter amount',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.attach_money_rounded,
                  color: const Color(0xFF6B7280),
                  size: 22.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                if (widget.brand.minAmount > 0 && amount < widget.brand.minAmount) {
                  return 'Minimum amount is ${widget.brand.minAmount.toStringAsFixed(0)}';
                }
                if (widget.brand.maxAmount > 0 && amount > widget.brand.maxAmount) {
                  return 'Maximum amount is ${widget.brand.maxAmount.toStringAsFixed(0)}';
                }
                return null;
              },
            ),
          ),
        ],
      ],
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      return amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
    }
    return amount.toStringAsFixed(2);
  }

  Widget _buildPriceSummary() {
    final amount = _selectedAmount ?? 0;
    final senderAmountNullable = _currentSenderAmount;
    final hasSenderPrice = senderAmountNullable != null && _senderCurrency != _recipientCurrency;
    final total = senderAmountNullable ?? amount;

    // Fee breakdown: flat service fee only (no percentage markup)
    final flatFee = widget.brand.senderFee;
    double subtotal = 0;
    if (hasSenderPrice && total > 0 && flatFee > 0) {
      subtotal = total - flatFee;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          // Card face value
          _buildPriceRow(
            'Gift Card Value',
            '$_recipientCurrency ${_formatAmount(amount)}',
          ),
          if (hasSenderPrice && subtotal > 0 && flatFee > 0) ...[
            SizedBox(height: 10.h),
            _buildPriceRow(
              'Subtotal',
              '$_senderCurrency ${_formatAmount(subtotal)}',
            ),
            SizedBox(height: 10.h),
            _buildPriceRow(
              'Service Fee',
              '$_senderCurrency ${_formatAmount(flatFee)}',
            ),
          ],
          if (widget.brand.discountPercentage > 0) ...[
            SizedBox(height: 10.h),
            _buildPriceRow(
              'Discount (${widget.brand.discountPercentage.toStringAsFixed(0)}%)',
              '-${widget.brand.discountPercentage.toStringAsFixed(0)}%',
              isDiscount: true,
            ),
          ],
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D), height: 1),
          SizedBox(height: 12.h),
          // Total in local currency
          _buildPriceRow(
            'Total',
            hasSenderPrice
                ? '$_senderCurrency ${_formatAmount(total)}'
                : '$_recipientCurrency ${_formatAmount(amount)}',
            isTotal: true,
          ),
          if (hasSenderPrice && amount > 0) ...[
            SizedBox(height: 4.h),
            Text(
              'Payment in $_senderCurrency for a $_recipientCurrency ${_formatAmount(amount)} card',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 15.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isDiscount
                ? const Color(0xFF10B981)
                : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseButton() {
    final isValid = _selectedAmount != null && _selectedAmount! > 0;
    final senderAmt = _currentSenderAmount;
    final isMultiCur = widget.brand.isMultiCurrency && senderAmt != null;
    final displayCurrency = isMultiCur ? _senderCurrency : _recipientCurrency;
    final displayAmount = isMultiCur ? senderAmt : (_selectedAmount ?? 0.0);

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: isValid && !_isPurchasing ? _purchaseGiftCard : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            gradient: isValid
                ? const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: isValid ? null : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: _isPurchasing
                ? SizedBox(
                    height: 22.h,
                    width: 22.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Purchase Gift Card',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isValid ? Colors.white : const Color(0xFF6B7280),
                        ),
                      ),
                      if (isValid && displayAmount > 0) ...[
                        SizedBox(height: 2.h),
                        Text(
                          '$displayCurrency ${_formatAmount(displayAmount)}',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isValid ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  bool _isPurchasing = false;

  void _purchaseGiftCard() async {
    if (_selectedAmount == null || _selectedAmount! <= 0) return;
    if (_formKey.currentState!.validate() || widget.brand.fixedDenominations.isNotEmpty) {
      final amount = _selectedAmount!;
      final transactionId = 'giftcard_${DateTime.now().millisecondsSinceEpoch}_${widget.brand.id}';
      // For PIN confirmation, show the payment amount in sender currency
      final senderAmt = _currentSenderAmount;
      final isMultiCur = widget.brand.isMultiCurrency && senderAmt != null;
      final displayCurrency = isMultiCur ? _senderCurrency : _recipientCurrency;
      final displayAmount = isMultiCur ? senderAmt : amount;
      final confirmMessage = isMultiCur
          ? 'Purchase ${widget.brand.name} $_recipientCurrency ${_formatAmount(amount)} gift card for $_senderCurrency ${_formatAmount(senderAmt)}?'
          : 'Confirm purchase of $displayCurrency ${_formatAmount(displayAmount)} ${widget.brand.name} gift card?';

      await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'gift_card_purchase',
        amount: displayAmount,
        currency: displayCurrency,
        title: 'Confirm Gift Card Purchase',
        message: confirmMessage,
        onPinValidated: (verificationToken) async {
          setState(() => _isPurchasing = true);
          Get.offNamed(
            AppRoutes.giftCardPurchaseProcessing,
            arguments: GiftCardPurchaseArgs(
              brand: widget.brand,
              amount: amount,
              transactionId: transactionId,
              verificationToken: verificationToken,
              productId: widget.brand.productId > 0 ? widget.brand.productId : null,
              countryCode: widget.brand.countryCode.isNotEmpty ? widget.brand.countryCode : null,
              providerName: widget.brand.providerName.isNotEmpty ? widget.brand.providerName : null,
              senderAmount: senderAmt,
              senderCurrency: isMultiCur ? _senderCurrency : null,
            ),
          );
        },
      );
    }
  }
}
