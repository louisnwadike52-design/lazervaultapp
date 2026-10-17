import 'dart:io';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import 'package:lazervault/core/utils/bill_receipt_status.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../domain/entities/airtime_transaction.dart';
import '../domain/entities/network_provider.dart';
import 'dart:ui' show Rect;

/// The word on the PDF's status banner.
///
/// Named and exported so the one thing that went wrong here — a refunded
/// top-up exporting a red "PAYMENT FAILED" — is testable. The rendering
/// around it needs golden files; this decision does not.
String airtimeReceiptBannerText({
  required bool isSuccess,
  required bool isRefunded,
}) {
  if (isSuccess) return 'PAYMENT SUCCESSFUL';
  // Refund wins over failure: the purchase did fail, and saying only that
  // hides the fact that the money is already back.
  if (isRefunded) return 'PAYMENT REFUNDED';
  return 'PAYMENT FAILED';
}

class AirtimePdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  static String _currencySymbolFor(String code) => receiptCurrencySymbol(code);

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
    }
  }

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;

    // Load Inter from the BUNDLE, not over HTTP.
    //
    // This used to fetch the font from a CDN on every cold receipt. Offline —
    // or on a slow link — the fetch failed and the PDF silently fell back to
    // the built-in Helvetica, which latin1-encodes text and THROWS on any code
    // unit above 255. The fonts already ship in assets/fonts, so the network
    // was never needed and the fallback is now genuinely last-resort.
    try {
      final regular = await rootBundle.load('assets/fonts/Inter-Regular.ttf');
      final bold = await rootBundle.load('assets/fonts/Inter-Bold.ttf');
      _regularFont = pw.Font.ttf(regular);
      _boldFont = pw.Font.ttf(bold);
    } catch (_) {
      _regularFont = null;
      _boldFont = null;
    }
  }

  static pw.TextStyle _getTextStyle({
    double fontSize = 12,
    bool isBold = false,
    PdfColor? color,
  }) {
    return pw.TextStyle(
      font: isBold ? _boldFont : _regularFont,
      fontBold: _boldFont,
      fontSize: fontSize,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: color,
    );
  }

  static Future<File> generateReceipt({
    required AirtimeTransaction transaction,
  }) async {
    await _loadFonts();
    // Embed Inter BEFORE the symbol is resolved. ReceiptFonts.embedded is
    // PROCESS-WIDE, so once any other receipt has loaded it this service would
    // start emitting the real glyph — and the pdf package RAISES on a glyph
    // the document's font cannot draw rather than substituting one. Loading
    // here keeps the symbol and the font that has to draw it in agreement.
    await ReceiptFonts.load();
    final pdf = pw.Document(
      theme: ReceiptFonts.embedded
          ? pw.ThemeData.withFont(
              base: ReceiptFonts.regular!,
              bold: ReceiptFonts.bold!,
            )
          : null,
    );
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = transaction.amount.toStringAsFixed(2);
    final isSuccess = transaction.status == AirtimeTransactionStatus.completed;
    // A REFUNDED TOP-UP IS NOT A FAILED ONE, AND THIS IS THE COPY PEOPLE KEEP.
    //
    // The banner read SUCCESSFUL or FAILED and nothing else, so a purchase the
    // network could not deliver — money already back in the wallet — exported
    // a red "PAYMENT FAILED" document with no mention of the refund. The
    // screen beside it says "Payment Refunded"; the PDF is the one that gets
    // forwarded. Same rule, from the same shared helper, as every other bill
    // receipt (core/utils/bill_receipt_status.dart).
    final statusLabel = billReceiptStatusLabel(
      transaction.status.name,
      refundSource: transaction.refundSignal,
      isRefunded: transaction.status == AirtimeTransactionStatus.refunded,
    );
    final isRefunded = isRefundLabel(statusLabel);
    final bannerText = airtimeReceiptBannerText(
      isSuccess: isSuccess,
      isRefunded: isRefunded,
    );
    // Amber, not green and not red: the purchase did not happen, and the
    // money is not gone.
    const refundBg = PdfColor.fromInt(0xFFFEF3C7);
    const refundFg = PdfColor.fromInt(0xFF92400E);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(logo, generatedDate),
              pw.SizedBox(height: 24),

              // Status banner
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: isSuccess
                      ? const PdfColor.fromInt(0xFFDCFCE7)
                      : isRefunded
                          ? refundBg
                          : const PdfColor.fromInt(0xFFFEE2E2),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Center(
                  child: pw.Text(
                    bannerText,
                    style: _getTextStyle(
                      fontSize: 14,
                      isBold: true,
                      color: isSuccess
                          ? const PdfColor.fromInt(0xFF166534)
                          : isRefunded
                              ? refundFg
                              : const PdfColor.fromInt(0xFF991B1B),
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 24),

              // Amount summary
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0xFFF8FAFC),
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(
                    color: const PdfColor.fromInt(0xFFE2E8F0),
                  ),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Airtime Amount',
                      style: _getTextStyle(
                        fontSize: 12,
                        color: const PdfColor.fromInt(0xFF64748B),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      '$currencySymbol$amount',
                      style: _getTextStyle(fontSize: 28, isBold: true),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),

              // Transaction details
              pw.Text(
                'Transaction Details',
                style: _getTextStyle(fontSize: 16, isBold: true),
              ),
              pw.SizedBox(height: 12),
              pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
              pw.SizedBox(height: 8),

              _buildDetailRow('Reference', transaction.transactionReference),
              _buildDetailRow(
                  'Network Provider', transaction.networkProvider.displayName),
              _buildDetailRow(
                  'Phone Number', transaction.displayRecipientNumber),
              if (transaction.recipientName != null &&
                  transaction.recipientName!.isNotEmpty)
                _buildDetailRow('Recipient', transaction.recipientName!),
              _buildDetailRow('Status', statusLabel),
              _buildDetailRow(
                  'Date', _fullDateTimeFormat.format(transaction.createdAt)),
              if (transaction.completedAt != null)
                _buildDetailRow('Completed',
                    _fullDateTimeFormat.format(transaction.completedAt!)),

              pw.SizedBox(height: 16),

              // Payment breakdown
              if (transaction.fee != null || transaction.discount != null) ...[
                pw.Text(
                  'Payment Breakdown',
                  style: _getTextStyle(fontSize: 16, isBold: true),
                ),
                pw.SizedBox(height: 12),
                pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
                pw.SizedBox(height: 8),
                _buildDetailRow('Airtime Amount', '$currencySymbol$amount'),
                if (transaction.fee != null)
                  _buildDetailRow('Service Fee',
                      '$currencySymbol${transaction.fee!.toStringAsFixed(2)}'),
                if (transaction.discount != null && transaction.discount! > 0)
                  _buildDetailRow('Discount',
                      '-$currencySymbol${transaction.discount!.toStringAsFixed(2)}'),
                pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
                _buildDetailRow(
                  'Total Paid',
                  '$currencySymbol${transaction.totalAmount.toStringAsFixed(2)}',
                  isBold: true,
                ),
                pw.SizedBox(height: 16),
              ],

              pw.Spacer(),

              // Footer
              pw.Divider(color: const PdfColor.fromInt(0xFFE2E8F0)),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Thank you for using Lazervault',
                      style: _getTextStyle(
                        fontSize: 12,
                        isBold: true,
                        color: const PdfColor.fromInt(0xFF64748B),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Keep this receipt for your records',
                      style: _getTextStyle(
                        fontSize: 10,
                        color: const PdfColor.fromInt(0xFF94A3B8),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Generated on $generatedDate',
                      style: _getTextStyle(
                        fontSize: 10,
                        color: const PdfColor.fromInt(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File(
        '${dir.path}/airtime_receipt_${transaction.transactionReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(pw.MemoryImage? logo, String date) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Row(
          children: [
            if (logo != null) ...[
              pw.Image(logo, width: 40, height: 40),
              pw.SizedBox(width: 12),
            ],
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Lazervault',
                  style: _getTextStyle(fontSize: 20, isBold: true),
                ),
                pw.Text(
                  'Airtime Purchase Receipt',
                  style: _getTextStyle(
                    fontSize: 12,
                    color: const PdfColor.fromInt(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'RECEIPT',
              style: _getTextStyle(
                fontSize: 14,
                isBold: true,
                color: const PdfColor.fromInt(0xFF3B82F6),
              ),
            ),
            pw.Text(
              date,
              style: _getTextStyle(
                fontSize: 10,
                color: const PdfColor.fromInt(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: _getTextStyle(
              fontSize: 12,
              color: const PdfColor.fromInt(0xFF64748B),
              isBold: isBold,
            ),
          ),
          pw.Text(
            value,
            style: _getTextStyle(fontSize: 12, isBold: isBold),
          ),
        ],
      ),
    );
  }

  /// Download the receipt to device storage
  static Future<String> downloadReceipt({
    required AirtimeTransaction transaction,
  }) async {
    try {
      final file = await generateReceipt(transaction: transaction);

      // Save, then OPEN — the Android save location is not browsable, so
      // handing the user the receipt beats naming a folder they cannot reach.
      final fileName =
          'airtime_receipt_${transaction.transactionReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      return ReceiptDownload.saveAndOpen(source: file, fileName: fileName);
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
    required AirtimeTransaction transaction,
  }) async {
    try {
      final file = await generateReceipt(transaction: transaction);

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = transaction.amount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
        files: [XFile(file.path)],
        text:
            'Airtime Purchase Receipt - $currencySymbol$amount to ${transaction.displayRecipientNumber}',
        subject: 'Lazervault Airtime Purchase Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
