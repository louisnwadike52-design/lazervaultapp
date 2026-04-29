// GiftCardDetailsScreen — payment receipt for a purchased gift card.
//
// Visual model: matches the electricity bill PaymentReceiptScreen
// (lib/src/features/electricity_bill/presentation/view/payment_receipt_screen.dart)
// 1:1 — circular check icon, "Payment Successful!" hero, single
// Transaction Details card (Amount/Service Fee/Total → divider →
// brand/recipient → divider → Reference/Date/Time/Status), then the
// shared BillReceiptQrBlock and the Share + Download Outlined-button
// pair.
//
// The gift-card specifics (redemption code, redemption PIN, redemption
// instructions) sit between the hero and the transaction-details
// card, styled like the electricity TokenCard so they're prominent
// without breaking the receipt rhythm.
//
// Why this layout: the user wants every receipt across the app to
// look the same so a user reading any LazerVault receipt has the
// same scanning pattern. We keep gift-card-only payload (token, QR
// for redemption code) but render it with the same primitives.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/widgets/bill_receipt_qr_block.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../services/gift_card_pdf_service.dart';

class GiftCardDetailsScreen extends StatefulWidget {
  final GiftCard giftCard;
  const GiftCardDetailsScreen({super.key, required this.giftCard});

  @override
  State<GiftCardDetailsScreen> createState() => _GiftCardDetailsScreenState();
}

class _GiftCardDetailsScreenState extends State<GiftCardDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkScale;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );
    _checkController.forward();
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  GiftCard get giftCard => widget.giftCard;

  String get _currencySymbol {
    switch (giftCard.currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      default:
        return '${giftCard.currency} ';
    }
  }

  String get _senderSymbol {
    switch (giftCard.senderCurrency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      default:
        return '${giftCard.senderCurrency} ';
    }
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
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 18),
        ),
        title: Text(
          'Payment Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSuccessIcon(),
            SizedBox(height: 12.h),
            Text(
              _heroTitle(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _statusMessage(),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            // Redemption code + PIN — equivalent of the electricity
            // token card, styled the same way (purple gradient instead
            // of orange so it doesn't impersonate an electricity token).
            if ((giftCard.redemptionCode ?? '').isNotEmpty)
              _buildCodeCard(),
            if ((giftCard.redemptionCode ?? '').isNotEmpty)
              SizedBox(height: 14.h),
            _buildTransactionDetails(),
            SizedBox(height: 20.h),
            BillReceiptQrBlock(
              type: 'gift_card',
              reference: giftCard.providerTransactionId ?? giftCard.id,
              amount: giftCard.originalAmount,
              currency: giftCard.currency,
              status: giftCard.status,
              timestamp: _resolveTimestamp(),
              showDivider: false,
              extraPayload: {
                if (giftCard.brandName.isNotEmpty) 'brand': giftCard.brandName,
                if ((giftCard.redemptionCode ?? '').isNotEmpty)
                  'code': giftCard.redemptionCode!,
              },
            ),
            SizedBox(height: 20.h),
            _buildActions(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  // ── Hero ────────────────────────────────────────────────────────────
  String _heroTitle() {
    final s = giftCard.status.toLowerCase();
    if (s == 'redeemed') return 'Gift Card Redeemed';
    if (s == 'expired') return 'Gift Card Expired';
    if (s == 'transferred') return 'Gift Card Transferred';
    if (s == 'failed' || s == 'refunded') return 'Payment Refunded';
    if (s == 'pending' || s == 'processing') return 'Payment Submitted';
    return 'Payment Successful!';
  }

  String _statusMessage() {
    final s = giftCard.status.toLowerCase();
    if (s == 'pending' || s == 'processing') {
      return 'Waiting for confirmation from the provider.';
    }
    if (s == 'failed' || s == 'refunded') {
      return 'Your payment was refunded. Your balance has been restored.';
    }
    if (s == 'expired') return 'This gift card has expired.';
    if (s == 'redeemed') return 'This gift card has been redeemed.';
    if (s == 'transferred') return 'This gift card was transferred.';
    return 'Your payment has been processed';
  }

  Widget _buildSuccessIcon() {
    final s = giftCard.status.toLowerCase();
    IconData icon;
    Color color;
    if (s == 'failed' || s == 'refunded') {
      icon = Icons.undo;
      color = const Color(0xFF6B7280);
    } else if (s == 'expired') {
      icon = Icons.history;
      color = const Color(0xFFFB923C);
    } else if (s == 'pending' || s == 'processing') {
      icon = Icons.hourglass_top;
      color = const Color(0xFFFB923C);
    } else {
      icon = Icons.check_circle;
      color = const Color(0xFF10B981);
    }
    return AnimatedBuilder(
      animation: _checkScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _checkScale.value,
          child: Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 40.sp),
          ),
        );
      },
    );
  }

  // ── Redemption code card (gift card analogue of electricity token) ──
  Widget _buildCodeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C1D95), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.card_giftcard,
                  color: const Color(0xFFE9D5FF), size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'REDEMPTION CODE',
                style: GoogleFonts.inter(
                  color: const Color(0xFFE9D5FF),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              final code = giftCard.redemptionCode;
              if (code == null || code.isEmpty) return;
              Clipboard.setData(ClipboardData(text: code));
              HapticFeedback.mediumImpact();
              Get.snackbar(
                'Copied',
                'Redemption code copied to clipboard',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16.w),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: const Color(0xFFE9D5FF).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  SelectableText(
                    giftCard.redemptionCode ?? '',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFF5F3FF),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.copy_rounded,
                          color: const Color(0xFFE9D5FF).withValues(alpha: 0.8),
                          size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'Tap to copy code',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFE9D5FF).withValues(alpha: 0.8),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if ((giftCard.redemptionPin ?? '').isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline,
                      color: const Color(0xFFE9D5FF), size: 12.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'PIN: ${giftCard.redemptionPin}',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFF5F3FF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
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

  // ── Transaction Details card ────────────────────────────────────────
  Widget _buildTransactionDetails() {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final displayDate = _resolveTimestamp();
    final cardAmount =
        '$_currencySymbol${giftCard.originalAmount.toStringAsFixed(2)}';
    final paid = giftCard.isMultiCurrency && giftCard.senderAmount > 0
        ? '$_senderSymbol${giftCard.senderAmount.toStringAsFixed(2)}'
        : cardAmount;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _row('Card Value', cardAmount),
          if (giftCard.isMultiCurrency && giftCard.senderAmount > 0) ...[
            SizedBox(height: 10.h),
            _row('You Paid', paid),
          ],
          SizedBox(height: 10.h),
          _row('Total', paid, isBold: true),

          _divider(),

          _row('Brand', giftCard.brandName),
          if ((giftCard.recipientName ?? '').isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Recipient', giftCard.recipientName!),
          ],
          if ((giftCard.recipientEmail ?? '').isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Recipient Email', giftCard.recipientEmail!),
          ],
          if ((giftCard.countryCode ?? '').isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Country', giftCard.countryCode!),
          ],

          _divider(),

          _row('Reference',
              giftCard.providerTransactionId ?? giftCard.id),
          SizedBox(height: 10.h),
          _row('Provider', _resolveProvider()),
          if (giftCard.purchaseDate.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Date', _safeFormat(displayDate, dateFormat)),
            SizedBox(height: 10.h),
            _row('Time', _safeFormat(displayDate, timeFormat)),
          ],
          if (giftCard.expiryDate.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Expires', giftCard.expiryDate),
          ],
          SizedBox(height: 10.h),
          _row('Status', giftCard.status.toUpperCase(),
              valueColor: _statusColor()),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: const Divider(color: Color(0xFF2D2D2D), height: 1),
      );

  Color _statusColor() {
    switch (giftCard.status.toLowerCase()) {
      case 'available':
      case 'active':
      case 'completed':
        return const Color(0xFF10B981);
      case 'pending':
      case 'processing':
        return const Color(0xFFFB923C);
      case 'failed':
      case 'refunded':
      case 'expired':
        return const Color(0xFFEF4444);
      default:
        return Colors.white;
    }
  }

  String _resolveProvider() {
    // The Reloadly product → giftcard row stores no provider name;
    // every buy goes through Reloadly today, so we default to that.
    return 'Reloadly';
  }

  DateTime _resolveTimestamp() {
    // Prefer purchaseDate (display string), fall back to createdAt.
    final raw = giftCard.purchaseDate.isNotEmpty
        ? giftCard.purchaseDate
        : giftCard.createdAt;
    return DateTime.tryParse(raw) ?? DateTime.now();
  }

  String _safeFormat(DateTime ts, DateFormat fmt) {
    try {
      return fmt.format(ts);
    } catch (_) {
      return '—';
    }
  }

  // ── Actions: Share + Download ───────────────────────────────────────
  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _isSharing ? null : _shareReceipt,
            icon: _isSharing
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(Icons.share, size: 16.sp),
            label: Text(
              _isSharing ? 'Sharing...' : 'Share',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF4E03D0)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _isDownloading ? null : _downloadReceipt,
            icon: _isDownloading
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(Icons.download, size: 16.sp),
            label: Text(
              _isDownloading ? 'Saving...' : 'Download',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF4E03D0)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _shareReceipt() async {
    setState(() => _isSharing = true);
    try {
      await GiftCardPdfService.shareReceipt(giftCard: giftCard);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Share failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadReceipt() async {
    setState(() => _isDownloading = true);
    try {
      await GiftCardPdfService.shareReceipt(giftCard: giftCard);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }
}
