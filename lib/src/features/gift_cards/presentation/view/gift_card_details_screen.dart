// GiftCardDetailsScreen — receipt-style detail screen for a purchased
// gift card. Mirrors the visual pattern of SendFundReceipt
// (lib/src/features/widgets/send_fund_receipt.dart): brand avatar on
// top, list of label→value tiles for every payload field, then a
// Download Receipt action that generates a PDF via the existing
// GiftCardPdfService.
//
// Why a dedicated screen instead of reusing SendFundReceipt's widget:
// SendFundReceipt is hard-coded to the Transaction shape. Gift cards
// have additional fields (redemption code, redemption PIN, scannable
// QR, redemption instructions) that don't fit there. We keep the
// receipt LOOK (avatar + tile list + download) but render gift-card
// specific payloads.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/screen.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../services/gift_card_pdf_service.dart';

class GiftCardDetailsScreen extends StatelessWidget {
  final GiftCard giftCard;

  const GiftCardDetailsScreen({super.key, required this.giftCard});

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
          ScreenName.sendFundReceipt.displayName, // "Receipt"
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar header — brand logo or gift-icon fallback. Mirrors
            // the CircleAvatar in SendFundReceipt but sized for a square
            // brand mark (Reloadly returns square logos, not portraits).
            Center(child: _buildAvatar()),
            SizedBox(height: 24.h),

            // Brand + amount + status — the headline of the receipt.
            Text(
              giftCard.brandName,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${giftCard.currency} ${giftCard.originalAmount.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.primaryPurple,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Center(child: _buildStatusChip(giftCard.status)),
            SizedBox(height: 28.h),

            // Tile list — one row per field. Same style as
            // SendFundReceipt's FlatTile rows: muted label on the
            // left, white value on the right.
            ..._buildTiles(),

            // Redemption code + PIN with copy-to-clipboard, separate
            // from the basic tiles because they're sensitive payload
            // and need a copy affordance.
            if ((giftCard.redemptionCode ?? '').isNotEmpty)
              _buildCopyableRow(
                  context, 'Redemption Code', giftCard.redemptionCode!),
            if ((giftCard.redemptionPin ?? '').isNotEmpty)
              _buildCopyableRow(
                  context, 'Redemption PIN', giftCard.redemptionPin!),

            // QR — same scan target as the redemption code, lets the
            // user redeem at a kiosk or partner app without typing.
            if (_qrPayload() != null) ...[
              SizedBox(height: 8.h),
              Center(child: _buildQr()),
              SizedBox(height: 16.h),
            ],

            // Redemption instructions accordion — usually multi-paragraph
            // copy from Reloadly, kept collapsed by default.
            if ((giftCard.redemptionInstructions ?? '').trim().isNotEmpty)
              _buildRedemptionAccordion(giftCard.redemptionInstructions!),

            SizedBox(height: 24.h),
            _buildDownloadButton(context),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  // ── Header avatar ───────────────────────────────────────────────────
  Widget _buildAvatar() {
    return Container(
      width: 96.w,
      height: 96.w,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: giftCard.logoUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                giftCard.logoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.card_giftcard,
                  size: 44.sp,
                  color: InvoiceThemeColors.primaryPurple,
                ),
              ),
            )
          : Icon(
              Icons.card_giftcard,
              size: 44.sp,
              color: InvoiceThemeColors.primaryPurple,
            ),
    );
  }

  // ── Status chip ─────────────────────────────────────────────────────
  Widget _buildStatusChip(String status) {
    final tone = _statusTone(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: tone.bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.inter(
          color: tone.fg,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  _StatusTone _statusTone(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'available':
      case 'completed':
        return const _StatusTone(
          bg: Color(0x2010B981),
          fg: Color(0xFF10B981),
        );
      case 'pending':
      case 'processing':
        return const _StatusTone(
          bg: Color(0x20F59E0B),
          fg: Color(0xFFF59E0B),
        );
      case 'expired':
      case 'failed':
      case 'refunded':
        return const _StatusTone(
          bg: Color(0x20EF4444),
          fg: Color(0xFFEF4444),
        );
      default:
        return const _StatusTone(
          bg: Color(0x206B7280),
          fg: Color(0xFF9CA3AF),
        );
    }
  }

  // ── Tile rows ───────────────────────────────────────────────────────
  // Build the receipt's payload tiles. Skips empty/optional fields so
  // the receipt only shows data we actually have. Matches the
  // FlatTile-style row layout used in SendFundReceipt.
  List<Widget> _buildTiles() {
    final tiles = <Widget>[];

    if (giftCard.isMultiCurrency && giftCard.senderAmount > 0) {
      tiles.add(_tile('You paid',
          '${giftCard.senderCurrency} ${giftCard.senderAmount.toStringAsFixed(2)}'));
    }
    if (giftCard.purchaseDate.isNotEmpty) {
      tiles.add(_tile('Purchase Date', giftCard.purchaseDate));
    }
    if (giftCard.expiryDate.isNotEmpty) {
      tiles.add(_tile('Expiry Date', giftCard.expiryDate));
    }
    if ((giftCard.recipientEmail ?? '').isNotEmpty) {
      tiles.add(_tile('Recipient Email', giftCard.recipientEmail!));
    }
    if ((giftCard.recipientName ?? '').isNotEmpty) {
      tiles.add(_tile('Recipient Name', giftCard.recipientName!));
    }
    if ((giftCard.message ?? '').trim().isNotEmpty) {
      tiles.add(_tile('Message', giftCard.message!));
    }
    if ((giftCard.providerTransactionId ?? '').isNotEmpty) {
      tiles.add(_tile('Transaction ID', giftCard.providerTransactionId!));
    }
    if ((giftCard.countryCode ?? '').isNotEmpty) {
      tiles.add(_tile('Country', giftCard.countryCode!));
    }

    return tiles;
  }

  Widget _tile(String name, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: HybridHexColor.fromHex('#9CA3AF'),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Copyable redemption fields ──────────────────────────────────────
  Widget _buildCopyableRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: HybridHexColor.fromHex('#9CA3AF'),
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SelectableText(
                    value,
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
                  icon: Icon(
                    Icons.copy_rounded,
                    color: InvoiceThemeColors.primaryPurple,
                    size: 18.sp,
                  ),
                  tooltip: 'Copy $label',
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: value));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$label copied'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── QR ─────────────────────────────────────────────────────────────
  String? _qrPayload() {
    final code = giftCard.redemptionCode?.trim();
    final pin = giftCard.redemptionPin?.trim();
    final hasCode = code != null && code.isNotEmpty;
    final hasPin = pin != null && pin.isNotEmpty;
    if (!hasCode && !hasPin) return null;
    if (hasCode && hasPin) return 'CODE:$code\nPIN:$pin';
    return hasCode ? code : pin;
  }

  Widget _buildQr() {
    final payload = _qrPayload();
    if (payload == null) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          QrImageView(
            data: payload,
            version: QrVersions.auto,
            size: 160.w,
            backgroundColor: Colors.transparent,
            dataModuleStyle: const QrDataModuleStyle(color: Colors.white),
            eyeStyle: const QrEyeStyle(color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Text(
            'Scan to redeem',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionAccordion(String instructions) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: InvoiceThemeColors.primaryPurple,
          ),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          iconColor: InvoiceThemeColors.primaryPurple,
          collapsedIconColor: const Color(0xFF9CA3AF),
          leading: Icon(
            Icons.menu_book_outlined,
            color: InvoiceThemeColors.primaryPurple,
            size: 20.sp,
          ),
          title: Text(
            'How to redeem',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Tap to view instructions',
            style: GoogleFonts.inter(
              color: const Color(0xFF8E8E93),
              fontSize: 11.sp,
            ),
          ),
          children: [
            Text(
              instructions,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Download receipt — same affordance as SendFundReceipt ───────────
  Widget _buildDownloadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: InvoiceThemeColors.primaryPurple,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        icon: const Icon(Icons.download_rounded, size: 20),
        label: Text(
          'Download Receipt',
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () async {
          try {
            await GiftCardPdfService.shareReceipt(giftCard: giftCard);
          } catch (e) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Receipt download failed: $e')),
            );
          }
        },
      ),
    );
  }
}

class _StatusTone {
  final Color bg;
  final Color fg;
  const _StatusTone({required this.bg, required this.fg});
}
