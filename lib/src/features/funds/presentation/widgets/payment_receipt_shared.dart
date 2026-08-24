import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';

/// Brand mark for receipt headers — logo + "Lazervault" wordmark, matching the
/// send-funds receipt's top-right identity (CLAUDE.md §0: never PascalCase).
class ReceiptBrandMark extends StatelessWidget {
  const ReceiptBrandMark({super.key, this.compact = true});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: compact ? 20.w : 26.w,
          height: compact ? 20.w : 26.w,
          errorBuilder: (_, __, ___) => Icon(Icons.shield_outlined,
              color: Colors.white, size: compact ? 18.sp : 22.sp),
        ),
        SizedBox(width: 6.w),
        Text(
          'Lazervault',
          style: GoogleFonts.inter(
            fontSize: compact ? 13.sp : 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

/// USER-facing money-error copy. Raw provider/internal errors stay in the
/// admin dashboard (audit rows + failure_reason columns) — the app shows a
/// short, calm line instead. Known failure codes get specific, actionable
/// copy; everything else collapses to a generic "something went wrong".
String friendlyMoneyError(String? failureCode, String? rawReason) {
  final code = (failureCode ?? '').toUpperCase();
  switch (code) {
    case 'INSUFFICIENT_FUNDS':
      return 'Insufficient funds in the bank account.';
    case 'REAUTHORIZATION_REQUIRED':
    case 'AUTH_EXPIRED':
      return 'This bank needs to be reconnected before it can be used.';
    case 'DIRECTPAY_CANCELLED':
    case 'DIRECTPAY_ABANDONED':
    case 'CHECKOUT_ABANDONED':
      return 'The bank authorization wasn\'t completed — no money left your account. You can try again anytime.';
    case 'KYC_REQUIRED':
      return 'Identity verification is needed for this transaction.';
  }
  // Anything else — including raw provider plumbing in rawReason — is for the
  // admin dashboard only.
  return 'Something went wrong. Your money is safe — please try again or contact support.';
}

/// Capture the receipt widget tree as a PNG and open the system share sheet —
/// the same share affordance the send-funds receipt offers. Fail-quietly with
/// a snackbar; sharing must never crash a receipt.
Future<void> shareReceiptCapture(
  ScreenshotController controller, {
  required String fileTag,
  required String shareText,
}) async {
  try {
    final Uint8List? bytes =
        await controller.capture(pixelRatio: 2.5, delay: const Duration(milliseconds: 60));
    if (bytes == null) throw Exception('capture returned null');
    final dir = await getTemporaryDirectory();
    final file = File(
        '${dir.path}/lazervault-$fileTag-${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], text: shareText);
  } catch (_) {
    Get.snackbar('', 'Couldn\'t share the receipt. Please try again.',
        titleText: const SizedBox.shrink(),
        messageText: const Text('Couldn\'t share the receipt. Please try again.',
            style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.92),
        margin: EdgeInsets.all(12.w));
  }
}


/// Bottom sheet: pick the file format for a shareable banking receipt
/// (PDF / JPG / PNG). Returns null when dismissed.
Future<ReceiptFileFormat?> pickReceiptFormat(BuildContext context,
    {String action = 'Share'}) {
  Widget tile(BuildContext ctx, ReceiptFileFormat fmt, IconData icon,
      Color color, String desc) {
    return InkWell(
      onTap: () => Navigator.of(ctx).pop(fmt),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF3A3A3A)),
        ),
        child: Row(children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$action as ${fmt.ext.toUpperCase()}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        color: Color(0xFF9CA3AF), fontSize: 11.5)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: Color(0xFF9CA3AF), size: 20),
        ]),
      ),
    );
  }

  return showModalBottomSheet<ReceiptFileFormat>(
    context: context,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Choose format',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            tile(ctx, ReceiptFileFormat.pdf, Icons.picture_as_pdf_outlined,
                const Color(0xFFEF4444), 'Vector document — best for printing.'),
            const SizedBox(height: 10),
            tile(ctx, ReceiptFileFormat.jpg, Icons.image_outlined,
                const Color(0xFF3B82F6), 'Compact image — easy to share in chats.'),
            const SizedBox(height: 10),
            tile(ctx, ReceiptFileFormat.png, Icons.photo_outlined,
                const Color(0xFF8B5CF6), 'Lossless image with full quality.'),
          ],
        ),
      ),
    ),
  );
}

/// Currency SYMBOL → ISO code (the receipt screens carry only the symbol).
String currencyCodeForSymbol(String symbol) {
  switch (symbol) {
    case '\u20a6':
      return 'NGN';
    case '\u00a3':
      return 'GBP';
    case '\u20ac':
      return 'EUR';
    case '\$':
      return 'USD';
    case 'R':
      return 'ZAR';
    case 'GH\u20b5':
      return 'GHS';
    case 'KSh':
      return 'KES';
  }
  return 'NGN';
}

/// Share a deposit/withdrawal receipt in the Revolut-style transfer PDF layout
/// (or a pixel-faithful JPG/PNG raster of it). Details use the transfer-receipt
/// payload keys; [shareText] is the message attached to the share sheet.
Future<void> shareBankingReceiptAs({
  required Map<String, dynamic> details,
  required ReceiptFileFormat format,
  required String shareText,
}) async {
  // Visible progress while the PDF/raster is produced — without it the format
  // sheet closes and nothing happens for a few seconds, which reads as broken.
  Get.dialog(
    const PopScope(
      canPop: false,
      child: Center(
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black54,
  );
  final File file;
  try {
    file = await TagPayPdfService.generateTransferReceiptFile(
      transferDetails: details,
      format: format,
    );
  } finally {
    if (Get.isDialogOpen ?? false) Get.back();
  }
  await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
    files: [XFile(file.path)],
    text: shareText,
    subject: 'Lazervault receipt',
  ));
}
