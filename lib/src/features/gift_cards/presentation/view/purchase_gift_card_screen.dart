import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
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
    return [25, 50, 100, 250, 500];
  }

  bool get _hasCustomAmount =>
      widget.brand.fixedDenominations.isEmpty &&
      widget.brand.minAmount > 0 &&
      widget.brand.maxAmount > 0;

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
              child: BlocListener<GiftCardCubit, GiftCardState>(
                listener: (context, state) {
                  if (state is GiftCardPurchaseCompleted) {
                    Get.offNamed(AppRoutes.giftCardPurchaseProcessing);
                  } else if (state is GiftCardPurchaseError) {
                    _showErrorSnackbar(state.message);
                  } else if (state is GiftCardInsufficientFunds) {
                    _showErrorSnackbar(
                      'Insufficient balance. Need ${state.required.toStringAsFixed(2)}, have ${state.available.toStringAsFixed(2)}',
                    );
                  } else if (state is GiftCardValidationError) {
                    _showErrorSnackbar(state.message);
                  }
                },
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
          children: _denominations.map((amount) {
            final isSelected = _selectedAmount == amount;
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
                child: Text(
                  '${widget.brand.currencyCode.isNotEmpty ? widget.brand.currencyCode : 'NGN'} ${amount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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

  Widget _buildPriceSummary() {
    final amount = _selectedAmount ?? 0;
    final discount = amount * (widget.brand.discountPercentage / 100);
    final finalPrice = amount - discount;
    final currency = widget.brand.currencyCode.isNotEmpty ? widget.brand.currencyCode : 'NGN';

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
          _buildPriceRow('Gift Card Value', '$currency ${amount.toStringAsFixed(2)}'),
          if (discount > 0) ...[
            SizedBox(height: 10.h),
            _buildPriceRow(
              'Discount (${widget.brand.discountPercentage.toStringAsFixed(0)}%)',
              '-$currency ${discount.toStringAsFixed(2)}',
              isDiscount: true,
            ),
          ],
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D), height: 1),
          SizedBox(height: 12.h),
          _buildPriceRow(
            'You Pay',
            '$currency ${finalPrice.toStringAsFixed(2)}',
            isTotal: true,
          ),
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
    return BlocBuilder<GiftCardCubit, GiftCardState>(
      builder: (context, state) {
        final isLoading = state is GiftCardPurchasing || state is GiftCardPurchaseProcessing;
        final isValid = _selectedAmount != null && _selectedAmount! > 0;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isValid && !isLoading ? _purchaseGiftCard : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isValid ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
              disabledBackgroundColor: const Color(0xFF1F1F1F),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    height: 22.h,
                    width: 22.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Purchase Gift Card',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isValid ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _purchaseGiftCard() async {
    if (_formKey.currentState!.validate() || widget.brand.fixedDenominations.isNotEmpty) {
      final amount = _selectedAmount!;
      final transactionId = 'giftcard_${DateTime.now().millisecondsSinceEpoch}_${widget.brand.id}';
      final currency = widget.brand.currencyCode.isNotEmpty ? widget.brand.currencyCode : 'NGN';

      await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'gift_card_purchase',
        amount: amount,
        currency: currency,
        title: 'Confirm Gift Card Purchase',
        message: 'Confirm purchase of $currency ${amount.toStringAsFixed(2)} ${widget.brand.name} gift card?',
        onPinValidated: (verificationToken) async {
          _executePurchaseWithToken(
            brandId: widget.brand.id,
            amount: amount,
            transactionId: transactionId,
            verificationToken: verificationToken,
          );
        },
      );
    }
  }

  void _executePurchaseWithToken({
    required String brandId,
    required double amount,
    required String transactionId,
    required String verificationToken,
  }) {
    context.read<GiftCardCubit>().purchaseGiftCardWithToken(
      brandId: brandId,
      amount: amount,
      brand: widget.brand,
      userBalance: 0.0,
      transactionId: transactionId,
      verificationToken: verificationToken,
      productId: widget.brand.productId > 0 ? widget.brand.productId : null,
      countryCode: widget.brand.countryCode.isNotEmpty ? widget.brand.countryCode : null,
      providerName: widget.brand.providerName.isNotEmpty ? widget.brand.providerName : null,
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Purchase Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
      colorText: Colors.white,
      borderRadius: 12.r,
      margin: EdgeInsets.all(16.w),
      duration: const Duration(seconds: 3),
    );
  }
}
