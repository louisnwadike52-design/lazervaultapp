import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/utils/receipt_download.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import '../domain/entities/gift_card_entity.dart';
import 'receipt_text.dart';

/// PDF receipt for a gift card SALE.
///
/// Kept separate from GiftCardPdfService (which documents a PURCHASE) because
/// the two receipts answer different questions and share almost no rows. A
/// purchase receipt is about a code the customer now owns; a sale receipt is
/// about money owed to them, so it leads with the payout, the rate it was
/// struck at, and — when the sale did not go through — the reason, which is
/// the single line a rejected customer actually wants.
///
/// A rejected sale is deliberately still a receipt. Producing one only on
/// success would leave the customer with nothing to point at in the case where
/// they are most likely to need it.
class GiftCardSalePdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy • HH:mm');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  static Future<void> _loadFonts() async {
    // Shared loader: one fetch for every PDF service in the app. Falls back to
    // the built-in face if it cannot load — a receipt that renders in
    // Helvetica beats one that fails to generate.
    await ReceiptFonts.load();
    _regularFont = ReceiptFonts.regular;
    _boldFont = ReceiptFonts.bold;
  }

  static pw.TextStyle _style({
    double size = 10,
    bool bold = false,
    PdfColor color = PdfColors.black,
  }) {
    return pw.TextStyle(
      font: bold ? _boldFont : _regularFont,
      fontSize: size,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: color,
    );
  }

  static pw.MemoryImage? _logo;
  static Future<pw.MemoryImage?> _loadLogo() async {
    if (_logo != null) return _logo;
    try {
      final data = await rootBundle.load('assets/images/logos/lazervault-full-logo.png');
      _logo = pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {
      _logo = null;
    }
    return _logo;
  }

  /// Money as the customer reads it, never a bare double.
  static String _money(double v) => NumberFormat('#,##0.00').format(v);

  static String _statusLabel(String raw) {
    switch (raw.toLowerCase()) {
      case 'paid':
      case 'settled':
        return 'PAID';
      case 'approved':
        return 'APPROVED';
      case 'rejected':
        return 'REJECTED';
      case 'failed':
        return 'FAILED';
      case 'refunded':
        return 'REFUNDED';
      case 'pending_review':
      case 'reviewing':
        return 'UNDER REVIEW';
      default:
        return raw.toUpperCase().replaceAll('_', ' ');
    }
  }

  static PdfColor _statusColor(String raw) {
    switch (raw.toLowerCase()) {
      case 'paid':
      case 'settled':
      case 'approved':
        return const PdfColor.fromInt(0xFF10B981);
      case 'rejected':
      case 'failed':
        return const PdfColor.fromInt(0xFFEF4444);
      case 'refunded':
        return const PdfColor.fromInt(0xFF6B7280);
      default:
        return const PdfColor.fromInt(0xFFF59E0B);
    }
  }

  static Future<File> generateSaleReceipt({required GiftCardSale sale}) async {
    await _loadFonts();
    final logo = await _loadLogo();
    final pdf = pw.Document();

    // The figure that matters depends on outcome: what we actually paid once
    // the sale settled, otherwise what was quoted.
    final settled = sale.actualPayout > 0;
    final payout = settled ? sale.actualPayout : sale.expectedPayout;
    final payoutLabel = settled ? 'Amount paid' : 'Expected payout';

    // MultiPage, not Page: a rejection reason can run long, and a fixed Page
    // silently clips whatever overflows.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Gift Card Sale Receipt', style: _style(size: 18, bold: true)),
                  pw.SizedBox(height: 4),
                  pw.Text(_displayDateFormat.format(DateTime.now()),
                      style: _style(size: 9, color: PdfColors.grey700)),
                ],
              ),
              if (logo != null) pw.Image(logo, height: 28),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: const PdfColor.fromInt(0xFFF9FAFB),
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: const PdfColor.fromInt(0xFFE5E7EB)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(payoutLabel.toUpperCase(),
                    style: _style(size: 8, color: PdfColors.grey600)),
                pw.SizedBox(height: 6),
                pw.Text('NGN ${_money(payout)}', style: _style(size: 24, bold: true)),
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    color: _statusColor(sale.status),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(_statusLabel(sale.status),
                      style: _style(size: 8, bold: true, color: PdfColors.white)),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text('SALE DETAILS', style: _style(size: 9, bold: true, color: PdfColors.grey700)),
          pw.SizedBox(height: 8),
          ..._rows([
            ['Card', receiptLine(sale.cardType)],
            ['Face value', '${sale.currency} ${_money(sale.denomination)}'],
            if (sale.ratePercentage > 0)
              ['Rate', 'NGN ${_money(sale.ratePercentage)} per ${sale.currency}'],
            ['Reference', sale.reference],
            if (sale.providerSaleId.isNotEmpty) ['Provider ref', sale.providerSaleId],
            if (sale.providerName.isNotEmpty) ['Processed by', sale.providerName],
            if (sale.submittedAt.isNotEmpty) ['Submitted', sale.submittedAt],
            if (sale.reviewedAt.isNotEmpty) ['Reviewed', sale.reviewedAt],
            if (sale.paidAt.isNotEmpty) ['Paid', sale.paidAt],
          ]),
          if (sale.rejectionReason.trim().isNotEmpty) ...[
            pw.SizedBox(height: 18),
            pw.Text('WHY THIS SALE DID NOT GO THROUGH',
                style: _style(size: 9, bold: true, color: PdfColors.grey700)),
            pw.SizedBox(height: 6),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: const PdfColor.fromInt(0xFFFEF2F2),
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: const PdfColor.fromInt(0xFFFECACA)),
              ),
              child: pw.Text(receiptLine(sale.rejectionReason),
                  style: _style(size: 10)),
            ),
          ],
          pw.SizedBox(height: 28),
          pw.Divider(color: const PdfColor.fromInt(0xFFE5E7EB)),
          pw.SizedBox(height: 8),
          pw.Text(
            'This receipt was generated by Lazervault. Keep it for your records.',
            style: _style(size: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final safeRef = sale.reference.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
    final file = File('${dir.path}/lazervault_sale_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static List<pw.Widget> _rows(List<List<String>> pairs) {
    return pairs
        .map((p) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    width: 130,
                    child: pw.Text(p[0], style: _style(size: 10, color: PdfColors.grey700)),
                  ),
                  pw.Expanded(
                    child: pw.Text(p[1], style: _style(size: 10, bold: true)),
                  ),
                ],
              ),
            ))
        .toList();
  }

  /// Saves to the device and opens it, matching the purchase receipt's
  /// behaviour so "Download" never silently means "share".
  static Future<void> downloadSaleReceipt({required GiftCardSale sale}) async {
    final file = await generateSaleReceipt(sale: sale);
    final safeRef = sale.reference.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
    await ReceiptDownload.saveAndOpen(
      source: file,
      fileName: 'lazervault_sale_$safeRef.pdf',
    );
  }

  static Future<void> shareSaleReceipt({required GiftCardSale sale}) async {
    final file = await generateSaleReceipt(sale: sale);
    final settled = sale.actualPayout > 0;
    final payout = settled ? sale.actualPayout : sale.expectedPayout;
    await SharePlus.instance.share(ShareParams(
      // iOS needs a non-zero anchor or the share throws and fails silently.
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      files: [XFile(file.path)],
      text: 'Gift Card Sale Receipt - ${receiptLine(sale.cardType)} '
          'NGN ${_money(payout)}',
      subject: 'Lazervault Gift Card Sale Receipt',
    ));
  }
}
