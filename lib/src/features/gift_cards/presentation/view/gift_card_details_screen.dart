import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../services/gift_card_pdf_service.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../../../core/types/app_routes.dart';
import 'gift_card_user_search_screen.dart';
import 'widgets/gift_card_error_widget.dart';

class GiftCardDetailsScreen extends StatefulWidget {
  final GiftCard giftCard;

  const GiftCardDetailsScreen({
    super.key,
    required this.giftCard,
  });

  @override
  State<GiftCardDetailsScreen> createState() => _GiftCardDetailsScreenState();
}

class _GiftCardDetailsScreenState extends State<GiftCardDetailsScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _recipientEmailController = TextEditingController();
  final _recipientNameController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isTransferring = false;
  bool _isSharing = false;
  bool _isDownloading = false;
  bool _showRedemptionCode = false;
  bool _showRedemptionPin = false;
  bool _redeemInstructionsExpanded = false;

  @override
  void dispose() {
    _recipientEmailController.dispose();
    _recipientNameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GiftCardCubit, GiftCardState>(
      listener: (context, state) {
        if (state is GiftCardTransferred) {
          setState(() => _isTransferring = false);
          Get.snackbar(
            'Transferred',
            'Gift card transferred successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
          );
          Get.back();
        } else if (state is GiftCardTransferError) {
          setState(() => _isTransferring = false);
          Get.snackbar(
            'Transfer Failed',
            friendlyGiftCardError(state.message),
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
          );
        } else if (state is GiftCardRedeemError) {
          // Close bottom sheet if open, then show error
          if (Get.isBottomSheetOpen == true) Get.back();
          Get.snackbar(
            'Error',
            friendlyGiftCardError(state.message),
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
          );
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _navigateToGiftCards();
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        _buildReceiptHeader(),
                        SizedBox(height: 10.h),
                        _buildReceiptDetails(),
                        SizedBox(height: 10.h),
                        _buildReceiptCode(),
                        SizedBox(height: 10.h),
                        _buildActionButtons(),
                        SizedBox(height: 20.h),
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

  void _navigateToGiftCards() {
    Get.until((route) => route.settings.name == AppRoutes.giftCards);
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _navigateToGiftCards(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          Expanded(
            child: Text(
              'Receipt',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => _shareGiftCard(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child:
                  Icon(Icons.share_rounded, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptHeader() {
    final gc = widget.giftCard;
    final hasSenderInfo = gc.senderAmount > 0 && gc.senderCurrency.isNotEmpty && gc.senderCurrency != gc.currency;
    final isActive = gc.status == 'available';

    return Column(
      children: [
        // Status icon
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? const Color(0xFF10B981).withValues(alpha: 0.15)
                : const Color(0xFFFB923C).withValues(alpha: 0.15),
          ),
          child: Icon(
            isActive ? Icons.check_circle : Icons.info_outline,
            color: isActive ? const Color(0xFF10B981) : const Color(0xFFFB923C),
            size: 28.sp,
          ),
        ),
        SizedBox(height: 10.h),
        // Amount in local currency (what user paid)
        if (hasSenderInfo) ...[
          Text(
            '${gc.senderCurrency} ${_formatAmount(gc.senderAmount)}',
            style: GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          SizedBox(height: 2.h),
          Text(
            '${gc.currency} ${gc.originalAmount.toStringAsFixed(2)} gift card',
            style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
          ),
        ] else ...[
          Text(
            '${gc.currency} ${gc.originalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ],
        SizedBox(height: 4.h),
        // Status + date
        Text(
          '${gc.status[0].toUpperCase()}${gc.status.substring(1)} · ${_formatDate(gc.purchaseDate)}',
          style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF8E8E93)),
        ),
      ],
    );
  }

  Widget _buildReceiptDetails() {
    final gc = widget.giftCard;
    final hasSenderInfo = gc.senderAmount > 0 && gc.senderCurrency.isNotEmpty && gc.senderCurrency != gc.currency;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(height: 10.h),
          _buildReceiptRow('Brand', gc.brandName),
          _buildReceiptRow('Card Value', '${gc.currency} ${gc.originalAmount.toStringAsFixed(2)}'),
          if (hasSenderInfo)
            _buildReceiptRow('Amount Paid', '${gc.senderCurrency} ${_formatAmount(gc.senderAmount)}'),
          if (gc.discountPercentage > 0)
            _buildReceiptRow('Discount', '${gc.discountPercentage.toStringAsFixed(0)}%'),
          Divider(color: const Color(0xFF2D2D2D), height: 14.h),
          _buildReceiptRow('Purchase Date', _formatDate(gc.purchaseDate)),
          _buildReceiptRow('Expiry Date', _formatDate(gc.expiryDate)),
          if (gc.providerTransactionId != null && gc.providerTransactionId!.isNotEmpty)
            _buildReceiptRow('Transaction ID', '#${gc.providerTransactionId}'),
          if (gc.countryCode != null && gc.countryCode!.isNotEmpty)
            _buildReceiptRow('Country', gc.countryCode!),
          if (gc.recipientName != null && gc.recipientName!.isNotEmpty)
            _buildReceiptRow('Recipient', gc.recipientName!),
          if (gc.recipientEmail != null && gc.recipientEmail!.isNotEmpty)
            _buildReceiptRow('Email', gc.recipientEmail!),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(label, style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF8E8E93))),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.white),
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _maskText(String text) {
    if (text.length <= 4) return '*' * text.length;
    return '${'*' * (text.length - 4)}${text.substring(text.length - 4)}';
  }

  Widget _buildReceiptCode() {
    final gc = widget.giftCard;
    final code = (gc.redemptionCode != null && gc.redemptionCode!.isNotEmpty)
        ? gc.redemptionCode!
        : '';
    final pin = (gc.redemptionPin != null && gc.redemptionPin!.isNotEmpty)
        ? gc.redemptionPin!
        : null;

    if (code.isEmpty && pin == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          // Code
          if (code.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Redemption Code', style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF8E8E93))),
                      SizedBox(height: 4.h),
                      Text(
                        _showRedemptionCode ? code : _maskText(code),
                        style: GoogleFonts.robotoMono(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _showRedemptionCode = !_showRedemptionCode),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Icon(
                      _showRedemptionCode ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF9CA3AF),
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: () => _copyToClipboard(code),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(Icons.copy_rounded, color: Colors.white, size: 16.sp),
                  ),
                ),
              ],
            ),
          ],
          if (pin != null) ...[
            if (code.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Divider(color: const Color(0xFF2D2D2D), height: 1),
              SizedBox(height: 10.h),
            ],
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Redemption PIN', style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF8E8E93))),
                      SizedBox(height: 4.h),
                      Text(
                        _showRedemptionPin ? pin : '*' * pin.length,
                        style: GoogleFonts.robotoMono(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 2),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _showRedemptionPin = !_showRedemptionPin),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Icon(
                      _showRedemptionPin ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF9CA3AF),
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: () => _copyToClipboard(pin),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(Icons.copy_rounded, color: Colors.white, size: 16.sp),
                  ),
                ),
              ],
            ),
          ],
          if (code.isNotEmpty) ...[
            SizedBox(height: 12.h),
            // Compact QR code
            QrImageView(
              data: code,
              version: QrVersions.auto,
              size: 80.w,
              backgroundColor: Colors.transparent,
              eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.white),
              dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.white),
            ),
          ],
          // Redemption instructions accordion
          if (gc.redemptionInstructions != null && gc.redemptionInstructions!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            SizedBox(height: 6.h),
            GestureDetector(
              onTap: () => setState(() => _redeemInstructionsExpanded = !_redeemInstructionsExpanded),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: const Color(0xFF3B82F6), size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'How to Redeem',
                        style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF3B82F6)),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _redeemInstructionsExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF3B82F6), size: 20.sp),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity, height: 0),
              secondChild: Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                child: Text(
                  gc.redemptionInstructions!,
                  style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF), height: 1.5),
                ),
              ),
              crossFadeState: _redeemInstructionsExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ],
      ),
    );
  }

  // Legacy methods kept for transfer/share functionality
  Widget _buildGiftCardVisual() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 48.h,
                width: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: widget.giftCard.logoUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Icon(
                      Icons.card_giftcard_rounded,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(widget.giftCard.status)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _getStatusText(widget.giftCard.status),
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(widget.giftCard.status),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            widget.giftCard.brandName,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          // Show card value in its native currency
          Text(
            '${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          // Show what user paid in their local currency (if different)
          if (widget.giftCard.senderAmount > 0 &&
              widget.giftCard.senderCurrency.isNotEmpty &&
              widget.giftCard.senderCurrency != widget.giftCard.currency) ...[
            SizedBox(height: 4.h),
            Text(
              'Paid: ${widget.giftCard.senderCurrency} ${_formatAmount(widget.giftCard.senderAmount)}',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ],
          if (widget.giftCard.discountPercentage > 0) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'You saved ${widget.giftCard.currency} ${(widget.giftCard.originalAmount * widget.giftCard.discountPercentage / 100).toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF10B981),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGiftCardInfo() {
    final gc = widget.giftCard;
    final hasSenderInfo = gc.senderAmount > 0 && gc.senderCurrency.isNotEmpty;

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
            'Purchase Receipt',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          // Only show redemption PIN from the provider
          if (gc.redemptionPin != null && gc.redemptionPin!.isNotEmpty)
            _buildInfoRow('Redemption PIN', gc.redemptionPin!),
          Divider(color: const Color(0xFF2D2D2D), height: 20.h),
          // Price paid
          _buildInfoRow('Card Value', '${gc.currency} ${gc.originalAmount.toStringAsFixed(2)}'),
          if (hasSenderInfo && gc.senderCurrency != gc.currency)
            _buildInfoRow('Amount Paid', '${gc.senderCurrency} ${gc.senderAmount.toStringAsFixed(2)}'),
          Divider(color: const Color(0xFF2D2D2D), height: 20.h),
          // Dates
          _buildInfoRow('Purchase Date', _formatDate(gc.purchaseDate)),
          _buildInfoRow('Expiry Date', _formatDate(gc.expiryDate)),
          // Provider info
          if (gc.providerTransactionId != null && gc.providerTransactionId!.isNotEmpty)
            _buildInfoRow('Transaction ID', '#${gc.providerTransactionId}'),
          if (gc.countryCode != null && gc.countryCode!.isNotEmpty)
            _buildInfoRow('Country', gc.countryCode!),
          // Recipient info
          if (gc.recipientName != null && gc.recipientName!.isNotEmpty)
            _buildInfoRow('Recipient', gc.recipientName!),
          if (gc.recipientEmail != null && gc.recipientEmail!.isNotEmpty)
            _buildInfoRow('Email', gc.recipientEmail!),
        ],
      ),
    );
  }

  Widget _buildGiftCardCode() {
    // Show redemption code if available
    final code = (widget.giftCard.redemptionCode != null && widget.giftCard.redemptionCode!.isNotEmpty)
        ? widget.giftCard.redemptionCode!
        : '';
    if (code.isEmpty) return const SizedBox.shrink();

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
            'Gift Card Code',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    code,
                    style: GoogleFonts.robotoMono(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      _copyToClipboard(code),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.copy_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.giftCard.redemptionPin != null && widget.giftCard.redemptionPin!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              'Redemption PIN',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.giftCard.redemptionPin!,
                      style: GoogleFonts.robotoMono(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _copyToClipboard(widget.giftCard.redemptionPin!),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.copy_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQRCode() {
    if (widget.giftCard.redemptionCode == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Text(
            'QR Code',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: QrImageView(
              data: widget.giftCard.redemptionCode!,
              version: QrVersions.auto,
              size: 160.w,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Scan this QR code to redeem',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails() {
    final currency = widget.giftCard.currency;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Details',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.giftCardTransactions),
                child: Text(
                  'View History',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildInfoRow('Gift Card Value',
              '$currency ${widget.giftCard.originalAmount.toStringAsFixed(2)}'),
          if (widget.giftCard.discountPercentage > 0)
            _buildInfoRow(
              'Discount (${widget.giftCard.discountPercentage.toStringAsFixed(0)}%)',
              '-$currency ${(widget.giftCard.originalAmount * widget.giftCard.discountPercentage / 100).toStringAsFixed(2)}',
            ),
          _buildInfoRow(
            'Amount Paid',
            '$currency ${(widget.giftCard.originalAmount * (1 - widget.giftCard.discountPercentage / 100)).toStringAsFixed(2)}',
          ),
          if (widget.giftCard.providerTransactionId != null)
            _buildInfoRow(
                'Transaction ID', widget.giftCard.providerTransactionId!),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final gc = widget.giftCard;
    final isActive = gc.status == 'available';
    final isTransferred = gc.status == 'transferred';
    final isExpired = gc.status == 'expired';
    final hasRedeemCode = gc.redemptionCode != null && gc.redemptionCode!.isNotEmpty;

    return Column(
      children: [
        // Get Redeem Code — only show if code is NOT already loaded on the receipt
        if ((isActive || isTransferred) && !hasRedeemCode) ...[
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: () => _getRedeemCode(),
              icon: Icon(Icons.vpn_key_rounded, size: 18.sp),
              label: Text(
                'Get Redeem Code',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],

        // All actions in a single compact row
        Row(
          children: [
            Expanded(
              child: _buildActionBox(
                icon: _isSharing
                    ? SizedBox(
                        width: 18.sp,
                        height: 18.sp,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF3B82F6),
                        ),
                      )
                    : Icon(Icons.share_rounded,
                        color: const Color(0xFF3B82F6), size: 20.sp),
                label: 'Share',
                onTap: _isSharing ? null : _shareReceipt,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildActionBox(
                icon: _isDownloading
                    ? SizedBox(
                        width: 18.sp,
                        height: 18.sp,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFFB923C),
                        ),
                      )
                    : Icon(Icons.download_rounded,
                        color: const Color(0xFFFB923C), size: 20.sp),
                label: 'Save',
                onTap: _isDownloading ? null : _downloadReceipt,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildActionBox(
                icon: isActive
                    ? (_isTransferring
                        ? SizedBox(
                            width: 18.sp,
                            height: 18.sp,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF10B981),
                            ),
                          )
                        : Icon(Icons.send_rounded,
                            color: const Color(0xFF10B981), size: 20.sp))
                    : Icon(Icons.send_rounded,
                        color: const Color(0xFF9CA3AF), size: 20.sp),
                label: 'Transfer',
                onTap: isActive && !_isTransferring
                    ? _showTransferSheet
                    : null,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildActionBox(
                icon: Icon(Icons.receipt_long_rounded,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
                label: 'History',
                onTap: () => Get.toNamed(AppRoutes.giftCardTransactions),
              ),
            ),
          ],
        ),

        // Status banners for non-active cards
        if (isTransferred) ...[
          SizedBox(height: 12.h),
          _buildStatusBanner(
            'This gift card has been transferred',
            Icons.swap_horiz_rounded,
            const Color(0xFF9CA3AF),
          ),
        ],
        if (isExpired) ...[
          SizedBox(height: 12.h),
          _buildStatusBanner(
            'This gift card has expired',
            Icons.timer_off_rounded,
            const Color(0xFFEF4444),
          ),
        ],
      ],
    );
  }

  Widget _buildActionBox({
    required Widget icon,
    required String label,
    VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDisabled
                ? const Color(0xFF2D2D2D).withValues(alpha: 0.5)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          children: [
            icon,
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isDisabled
                    ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(String message, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      'Copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      borderRadius: 12.r,
      margin: EdgeInsets.all(16.w),
    );
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await GiftCardPdfService.shareReceipt(giftCard: widget.giftCard);
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        borderRadius: 12.r,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path =
          await GiftCardPdfService.downloadReceipt(giftCard: widget.giftCard);
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${path.split('/').last}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
        borderRadius: 12.r,
        margin: EdgeInsets.all(16.w),
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        borderRadius: 12.r,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  void _shareGiftCard() {
    _shareReceipt();
  }

  void _getRedeemCode() {
    // Open bottom sheet immediately with loading state
    Get.bottomSheet(
      BlocProvider.value(
        value: context.read<GiftCardCubit>(),
        child: _RedeemCodeBottomSheet(giftCard: widget.giftCard),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
    // Fire the request
    context.read<GiftCardCubit>().getRedeemCode(
      transactionId: widget.giftCard.providerTransactionId ?? '',
    );
  }

  void _showTransferSheet() {
    _recipientEmailController.clear();
    _recipientNameController.clear();
    _messageController.clear();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              'Transfer Gift Card',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${widget.giftCard.brandName} - ${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 24.h),
            // Platform transfer option
            _buildTransferOption(
              icon: Icons.person_search_rounded,
              label: 'Transfer to LazerVault User',
              description: 'Search and select a user on the platform',
              color: const Color(0xFF3B82F6),
              onTap: () {
                Get.back();
                _startPlatformTransfer();
              },
            ),
            SizedBox(height: 12.h),
            // Email transfer option
            _buildTransferOption(
              icon: Icons.email_rounded,
              label: 'Transfer via Email',
              description: 'Send gift card details to any email',
              color: const Color(0xFF10B981),
              onTap: () {
                Get.back();
                _showEmailTransferSheet();
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildTransferOption({
    required IconData icon,
    required String label,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _startPlatformTransfer() async {
    final result = await Get.to(() => const GiftCardUserSearchScreen());
    if (result == null || result is! Map) return;

    final recipientUserId = result['userId'] as String? ?? '';
    final recipientName = result['fullName'] as String? ?? '';
    final recipientUsername = result['username'] as String? ?? '';

    if (recipientUserId.isEmpty) return;

    // Show confirmation + message sheet
    _recipientNameController.text = recipientName;
    _messageController.clear();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Text(
                'Confirm Transfer',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              // Recipient info card
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Center(
                        child: Text(
                          recipientName.isNotEmpty ? recipientName[0].toUpperCase() : '?',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF3B82F6),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
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
                            recipientName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (recipientUsername.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Text(
                              '@$recipientUsername',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // Gift card info
              Text(
                '${widget.giftCard.brandName} - ${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 16.h),
              _buildSheetTextField(
                controller: _messageController,
                label: 'Message (optional)',
                hint: 'Add a personal message',
                maxLines: 3,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _onPlatformTransferSubmit(
                      recipientUserId: recipientUserId,
                      recipientName: recipientName,
                      recipientEmail: result['email'] as String? ?? '',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Transfer to @$recipientUsername',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _onPlatformTransferSubmit({
    required String recipientUserId,
    required String recipientName,
    required String recipientEmail,
  }) {
    final transactionId =
        'TRANSFER-${DateTime.now().millisecondsSinceEpoch}_${widget.giftCard.id}';

    validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'gift_card_transfer',
      amount: widget.giftCard.originalAmount,
      currency: widget.giftCard.currency.isNotEmpty ? widget.giftCard.currency : 'NGN',
      title: 'Transfer Gift Card',
      message:
          'Transfer ${widget.giftCard.brandName} (${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}) to $recipientName',
      onPinValidated: (verificationToken) async {
        setState(() => _isTransferring = true);
        context.read<GiftCardCubit>().transferGiftCard(
              giftCardId: widget.giftCard.id,
              recipientEmail: recipientEmail,
              recipientName: recipientName,
              message: _messageController.text.trim(),
              transactionId: transactionId,
              verificationToken: verificationToken,
              recipientUserId: recipientUserId,
              transferType: 'platform',
            );
      },
    );
  }

  void _showEmailTransferSheet() {
    _recipientEmailController.clear();
    _recipientNameController.clear();
    _messageController.clear();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Text(
                'Transfer via Email',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${widget.giftCard.brandName} - ${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 20.h),
              _buildSheetTextField(
                controller: _recipientEmailController,
                label: 'Recipient Email',
                hint: 'Enter recipient email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              _buildSheetTextField(
                controller: _recipientNameController,
                label: 'Recipient Name',
                hint: 'Enter recipient name',
              ),
              SizedBox(height: 16.h),
              _buildSheetTextField(
                controller: _messageController,
                label: 'Message (optional)',
                hint: 'Add a personal message',
                maxLines: 3,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _onTransferSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Transfer',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildSheetTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  void _onTransferSubmit() {
    final email = _recipientEmailController.text.trim();
    final name = _recipientNameController.text.trim();

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (name.isEmpty) {
      Get.snackbar(
        'Missing Name',
        'Please enter the recipient name',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    Get.back(); // Close bottom sheet

    final transactionId =
        'TRANSFER-${DateTime.now().millisecondsSinceEpoch}_${widget.giftCard.id}';

    validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'gift_card_transfer',
      amount: widget.giftCard.originalAmount,
      currency: widget.giftCard.currency.isNotEmpty ? widget.giftCard.currency : 'NGN',
      title: 'Transfer Gift Card',
      message:
          'Transfer ${widget.giftCard.brandName} (${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}) to $name',
      onPinValidated: (verificationToken) async {
        _executeTransfer(
          transactionId: transactionId,
          verificationToken: verificationToken,
          email: email,
          name: name,
        );
      },
    );
  }

  void _executeTransfer({
    required String transactionId,
    required String verificationToken,
    required String email,
    required String name,
  }) {
    setState(() => _isTransferring = true);
    context.read<GiftCardCubit>().transferGiftCard(
          giftCardId: widget.giftCard.id,
          recipientEmail: email,
          recipientName: name,
          message: _messageController.text.trim(),
          transactionId: transactionId,
          verificationToken: verificationToken,
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

  String _formatDate(String date) {
    if (date.isEmpty) return 'N/A';
    try {
      final parsed = DateTime.parse(date);
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    } catch (_) {
      return date;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return const Color(0xFF10B981);
      case 'used':
      case 'redeemed':
        return const Color(0xFF9CA3AF);
      case 'expired':
        return const Color(0xFFEF4444);
      case 'pending':
        return const Color(0xFFFB923C);
      case 'transferred':
        return const Color(0xFF3B82F6);
      case 'cancelled':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'available':
        return 'AVAILABLE';
      case 'used':
        return 'USED';
      case 'redeemed':
        return 'USED';
      case 'expired':
        return 'EXPIRED';
      case 'pending':
        return 'PENDING';
      case 'transferred':
        return 'TRANSFERRED';
      case 'cancelled':
        return 'CANCELLED';
      default:
        return status.toUpperCase();
    }
  }
}

class _RedeemCodeBottomSheet extends StatelessWidget {
  final GiftCard giftCard;
  const _RedeemCodeBottomSheet({required this.giftCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: BlocBuilder<GiftCardCubit, GiftCardState>(
        buildWhen: (prev, curr) =>
            curr is GiftCardRedeeming ||
            curr is RedeemCodeLoaded ||
            curr is GiftCardRedeemError,
        builder: (context, state) {
          if (state is RedeemCodeLoaded) {
            return _buildContent(context, state);
          }
          if (state is GiftCardRedeemError) {
            // Close sheet — error snackbar handled by parent listener
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (Get.isBottomSheetOpen == true) Get.back();
            });
            return const SizedBox.shrink();
          }
          // Loading state (GiftCardRedeeming or initial)
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          _buildHeader(),
          SizedBox(height: 40.h),
          const CircularProgressIndicator(
            color: Color(0xFF3B82F6),
            strokeWidth: 2.5,
          ),
          SizedBox(height: 16.h),
          Text(
            'Fetching redeem code...',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, RedeemCodeLoaded state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandle(),
          _buildHeader(),
          SizedBox(height: 20.h),
          if (state.status == 'available') ...[
            if (state.redemptionCode.isNotEmpty) ...[
              Text('Redemption Code', style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 4.h),
              _buildCopyableField(
                context,
                text: state.redemptionCode,
                label: 'Code',
                color: const Color(0xFF10B981),
              ),
              SizedBox(height: 12.h),
            ],
            if (state.redemptionPin.isNotEmpty) ...[
              Text('Redemption PIN', style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 4.h),
              _buildCopyableField(
                context,
                text: state.redemptionPin,
                label: 'PIN',
                color: Colors.white,
              ),
              SizedBox(height: 12.h),
            ],
            if (giftCard.redemptionInstructions != null && giftCard.redemptionInstructions!.isNotEmpty) ...[
              Text('How to Redeem', style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 4.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  giftCard.redemptionInstructions!,
                  style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
                ),
              ),
            ],
          ] else ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                state.message.isNotEmpty ? state.message : 'Redeem code is not yet available. Please try again shortly.',
                style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFFFB923C)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.vpn_key_rounded, color: const Color(0xFF10B981), size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'Redeem Code',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          giftCard.brandName,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildCopyableField(BuildContext context, {required String text, required String label, required Color color}) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
        Get.snackbar('Copied', '$label copied to clipboard',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color == const Color(0xFF10B981) ? color.withValues(alpha: 0.3) : const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.copy, color: const Color(0xFF9CA3AF), size: 18.sp),
          ],
        ),
      ),
    );
  }
}
