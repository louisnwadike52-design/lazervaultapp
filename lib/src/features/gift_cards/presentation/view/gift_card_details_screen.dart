import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../../../core/types/app_routes.dart';

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
            state.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
          );
        }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildGiftCardVisual(),
                      SizedBox(height: 24.h),
                      _buildGiftCardInfo(),
                      SizedBox(height: 20.h),
                      _buildGiftCardCode(),
                      SizedBox(height: 20.h),
                      _buildQRCode(),
                      SizedBox(height: 20.h),
                      _buildTransactionDetails(),
                      SizedBox(height: 28.h),
                      _buildActionButtons(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          Expanded(
            child: Text(
              'Gift Card Details',
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
          Text(
            '${widget.giftCard.currency} ${widget.giftCard.originalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          if (widget.giftCard.currentBalance != widget.giftCard.originalAmount &&
              widget.giftCard.currentBalance > 0) ...[
            SizedBox(height: 4.h),
            Text(
              'Balance: ${widget.giftCard.currency} ${widget.giftCard.currentBalance.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFB923C),
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
            'Gift Card Information',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
              'Purchase Date', _formatDate(widget.giftCard.purchaseDate)),
          _buildInfoRow('Expiry Date', _formatDate(widget.giftCard.expiryDate)),
          _buildInfoRow('Currency', widget.giftCard.currency),
          if (widget.giftCard.recipientEmail != null)
            _buildInfoRow('Recipient', widget.giftCard.recipientEmail!),
          if (widget.giftCard.recipientName != null)
            _buildInfoRow('Recipient Name', widget.giftCard.recipientName!),
          if (widget.giftCard.message != null)
            _buildInfoRow('Message', widget.giftCard.message!),
        ],
      ),
    );
  }

  Widget _buildGiftCardCode() {
    if (widget.giftCard.redemptionCode == null) return const SizedBox.shrink();

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
                    widget.giftCard.redemptionCode!,
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
                      _copyToClipboard(widget.giftCard.redemptionCode!),
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
          if (widget.giftCard.pin != null) ...[
            SizedBox(height: 16.h),
            Text(
              'PIN',
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
                      widget.giftCard.pin!,
                      style: GoogleFonts.robotoMono(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _copyToClipboard(widget.giftCard.pin!),
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
    final isActive = widget.giftCard.status == 'active';
    final isTransferred = widget.giftCard.status == 'transferred';
    final isExpired = widget.giftCard.status == 'expired';

    return Column(
      children: [
        // Primary actions for active cards
        if (isActive) ...[
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: _isTransferring ? null : _showTransferSheet,
              icon: _isTransferring
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.send_rounded, size: 18.sp),
              label: Text(
                _isTransferring ? 'Transferring...' : 'Transfer Gift Card',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],

        // Status banners for non-active cards
        if (isTransferred)
          _buildStatusBanner(
            'This gift card has been transferred',
            Icons.swap_horiz_rounded,
            const Color(0xFF9CA3AF),
          ),
        if (isExpired)
          _buildStatusBanner(
            'This gift card has expired',
            Icons.timer_off_rounded,
            const Color(0xFFEF4444),
          ),

        // Secondary actions (always visible)
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _shareGiftCard(),
                icon: Icon(Icons.share_rounded, size: 18.sp),
                label: Text(
                  'Share',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F1F1F),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () =>
                    Get.toNamed(AppRoutes.giftCardTransactions),
                icon: Icon(Icons.receipt_long_rounded, size: 18.sp),
                label: Text(
                  'History',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F1F1F),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ],
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

  void _shareGiftCard() {
    final card = widget.giftCard;
    final buffer = StringBuffer();
    buffer.writeln('${card.brandName} Gift Card');
    buffer.writeln('Amount: ${card.currency} ${card.originalAmount.toStringAsFixed(2)}');
    if (card.redemptionCode != null) {
      buffer.writeln('Code: ${card.redemptionCode}');
    }
    if (card.pin != null) {
      buffer.writeln('PIN: ${card.pin}');
    }
    buffer.writeln('Expires: ${_formatDate(card.expiryDate)}');

    SharePlus.instance.share(ShareParams(text: buffer.toString(), subject: '${card.brandName} Gift Card'));
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

    if (email.isEmpty || !email.contains('@')) {
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
      case 'active':
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
      case 'active':
        return 'ACTIVE';
      case 'used':
        return 'USED';
      case 'redeemed':
        return 'REDEEMED';
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
