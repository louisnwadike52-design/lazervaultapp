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

class SellGiftCardScreen extends StatefulWidget {
  const SellGiftCardScreen({super.key});

  @override
  State<SellGiftCardScreen> createState() => _SellGiftCardScreenState();
}

class _SellGiftCardScreenState extends State<SellGiftCardScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  SellableCard? _selectedCard;
  double? _selectedDenomination;
  final _cardNumberController = TextEditingController();
  final _cardPinController = TextEditingController();
  SellRate? _currentRate;

  @override
  void initState() {
    super.initState();
    context.read<GiftCardCubit>().loadSellableCards();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        title: Text(
          'Sell Gift Card',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.mySales),
            icon: Icon(Icons.history, color: const Color(0xFF3B82F6), size: 22.sp),
          ),
        ],
      ),
      body: BlocConsumer<GiftCardCubit, GiftCardState>(
        listener: (context, state) {
          if (state is SellRateLoaded) {
            setState(() => _currentRate = state.rate);
          } else if (state is SellSubmitted) {
            Get.snackbar(
              'Submitted',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.offNamed(AppRoutes.mySales);
          } else if (state is SellError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          if (state is SellableCardsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is SellProcessing) {
            return _buildProcessingView(state);
          }

          if (_selectedCard == null) {
            if (state is SellableCardsLoaded) {
              return _buildCardSelection(state.cards);
            }
            if (state is SellableCardsEmpty) {
              return _buildEmptyState();
            }
            if (state is GiftCardNetworkError) {
              return _buildErrorState(state.message);
            }
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          return _buildSellForm();
        },
      ),
    );
  }

  Widget _buildCardSelection(List<SellableCard> cards) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GiftCardCubit>().loadSellableCards();
      },
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.95,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return GestureDetector(
            onTap: () => setState(() {
              _selectedCard = card;
              _selectedDenomination = null;
              _currentRate = null;
            }),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: card.logoUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Icon(
                          Icons.image_rounded,
                          color: Colors.grey.shade400,
                          size: 24.sp,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.card_giftcard_rounded,
                          color: Colors.grey.shade400,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    card.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    card.currencies.join(', '),
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${card.minDenomination.toStringAsFixed(0)} - \$${card.maxDenomination.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSellForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected card header
          _buildSelectedCardHeader(),
          SizedBox(height: 24.h),

          // Denomination selection
          Text(
            'Select Denomination',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildDenominationChips(),
          SizedBox(height: 24.h),

          // Rate display
          if (_currentRate != null) ...[
            _buildRateCard(),
            SizedBox(height: 24.h),
          ],

          // Card number
          Text(
            'Card Number',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _cardNumberController,
            hintText: 'Enter gift card number',
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16.h),

          // Card PIN
          Text(
            'Card PIN',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _cardPinController,
            hintText: 'Enter gift card PIN',
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 32.h),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: _canSubmit() ? _onSubmitSell : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor: const Color(0xFF2D2D2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                _currentRate != null
                    ? 'Sell for ${_formatCurrency(_currentRate!.payoutAmount)}'
                    : 'Sell Gift Card',
                style: GoogleFonts.inter(
                  color: _canSubmit() ? Colors.white : const Color(0xFF6B7280),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildSelectedCardHeader() {
    return GestureDetector(
      onTap: () => setState(() {
        _selectedCard = null;
        _selectedDenomination = null;
        _currentRate = null;
        _cardNumberController.clear();
        _cardPinController.clear();
        context.read<GiftCardCubit>().loadSellableCards();
      }),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: _selectedCard!.logoUrl,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Icon(
                    Icons.card_giftcard_rounded,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedCard!.displayName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Tap to change',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.swap_horiz, color: const Color(0xFF3B82F6), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildDenominationChips() {
    final denominations = _selectedCard!.denominations;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: denominations.map((denom) {
        final isSelected = _selectedDenomination == denom;
        return GestureDetector(
          onTap: () {
            setState(() => _selectedDenomination = denom);
            context.read<GiftCardCubit>().getSellRate(
              cardType: _selectedCard!.cardType,
              denomination: denom,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
              ),
            ),
            child: Text(
              '\$${denom.toStringAsFixed(0)}',
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRateCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rate',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '${_currentRate!.ratePercentage.toStringAsFixed(0)}%',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You receive',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              Text(
                _formatCurrency(_currentRate!.payoutAmount),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildProcessingView(SellProcessing state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: CircularProgressIndicator(
              value: state.progress,
              strokeWidth: 4,
              backgroundColor: const Color(0xFF2D2D2D),
              color: const Color(0xFF3B82F6),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            state.currentStep,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${(state.progress * 100).toInt()}%',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sell_outlined, size: 48.sp, color: const Color(0xFF6B7280)),
          SizedBox(height: 16.h),
          Text(
            'No Cards Available',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No gift card types are available for selling right now',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFFEF4444)),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<GiftCardCubit>().loadSellableCards(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canSubmit() {
    return _selectedCard != null &&
        _selectedDenomination != null &&
        _currentRate != null &&
        _cardNumberController.text.trim().isNotEmpty &&
        _cardPinController.text.trim().isNotEmpty;
  }

  void _onSubmitSell() async {
    final transactionId = 'SELL-${DateTime.now().millisecondsSinceEpoch}';
    final payoutAmount = _currentRate?.payoutAmount ?? _selectedDenomination!;

    await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'gift_card_sell',
      amount: payoutAmount,
      currency: 'NGN',
      title: 'Confirm Gift Card Sale',
      message: 'Sell ${_selectedCard!.displayName} \$${_selectedDenomination!.toStringAsFixed(0)} card for ${_formatCurrency(payoutAmount)}?',
      onPinValidated: (verificationToken) async {
        context.read<GiftCardCubit>().sellGiftCard(
          cardType: _selectedCard!.cardType,
          cardNumber: _cardNumberController.text.trim(),
          cardPin: _cardPinController.text.trim(),
          denomination: _selectedDenomination!,
          transactionId: transactionId,
          verificationToken: verificationToken,
        );
      },
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000) {
      return 'NGN ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      )}';
    }
    return 'NGN ${amount.toStringAsFixed(2)}';
  }
}
