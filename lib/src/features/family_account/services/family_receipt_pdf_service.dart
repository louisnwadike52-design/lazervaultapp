import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/core/config/receipt_footer.dart';

/// Family & Friends transaction receipt, drawn to the same standard as every
/// other receipt in the app.
///
/// Replaces an inline A5 builder that had drifted badly from the rest of the
/// product in two ways, both visible on a shared receipt:
///
///  1. **It never loaded a font.** Without [ReceiptFonts] the pdf package
///     draws with built-in Helvetica, a Type 1 face with no glyph for the
///     characters this very receipt used — the em dash the reference fell back
///     to rendered as a tofu box, and the naira sign had to be worked around
///     by printing "NGN " instead. Loading Inter fixes the box AND lets the
///     real currency symbol print, so the PDF finally matches the screen.
///
///  2. **It was a bare list on A5** while send-funds, PayID, gift cards and
///     the rest share one A4 layout: branded header, from/summary split,
///     boxed detail sections, legal footer. A family receipt looked like a
///     different company had produced it.
class FamilyReceiptPdfService {
  const FamilyReceiptPdfService._();

  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateFormat = DateFormat('MMM dd, yyyy · HH:mm');

  static pw.Font? _regular;
  static pw.Font? _bold;

  static Future<void> _loadFonts() async {
    await ReceiptFonts.load();
    _regular = ReceiptFonts.regular;
    _bold = ReceiptFonts.bold;
  }

  static pw.TextStyle _style({
    double fontSize = 12,
    bool isBold = false,
    PdfColor? color,
  }) =>
      pw.TextStyle(
        font: isBold ? _bold : _regular,
        fontBold: _bold,
        fontSize: fontSize,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: color,
      );

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  /// Human label for a missing value.
  ///
  /// The old code used a bare em dash, which is exactly the character the
  /// built-in font could not draw. Even with Inter embedded, "Not recorded"
  /// tells the reader something a dash does not: the transaction is fine, the
  /// field simply was not captured.
  static const _missing = 'Not recorded';

  static String _orMissing(String? v) {
    final t = (v ?? '').trim();
    return t.isEmpty ? _missing : t;
  }

  /// Builds and shares the receipt. Returns nothing; throws on failure so the
  /// caller can surface its own dialog.
  static Future<void> share(
    FamilyTransaction transaction, {
    required String familyName,
    required String memberName,
    required String reference,
    required String currencyCode,
  }) async {
    await _loadFonts();
    final logo = await _loadLogo();

    final symbol = receiptCurrencySymbol(currencyCode);
    final isCredit = transaction.type == FamilyTransactionType.allocation ||
        transaction.type == FamilyTransactionType.refund ||
        transaction.type == FamilyTransactionType.contribution;
    final amountStr = '${isCredit ? '+' : '-'}$symbol'
        '${NumberFormat('#,##0.00').format(transaction.amount.abs())}';

    final createdAt = transaction.createdAt;
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final txDate = _fullDateFormat.format(createdAt);

    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _header(logo, generatedDate),
            pw.SizedBox(height: 24),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('FAMILY ACCOUNT',
                          style:
                              _style(fontSize: 10, color: PdfColors.grey600)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        familyName.trim().isEmpty
                            ? 'FAMILY & FRIENDS'
                            : familyName.trim().toUpperCase(),
                        style: _style(fontSize: 14, isBold: true),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text('MEMBER',
                          style:
                              _style(fontSize: 10, color: PdfColors.grey600)),
                      pw.SizedBox(height: 4),
                      pw.Text(_orMissing(memberName),
                          style: _style(fontSize: 12)),
                    ],
                  ),
                ),
                pw.SizedBox(width: 40),
                pw.Expanded(
                  child: pw.Column(
                    children: [
                      _summaryRow('Date', txDate),
                      _summaryRow('Type', transaction.type.displayName),
                      _summaryRow(
                          'Direction', isCredit ? 'Money in' : 'Money out'),
                      _summaryRow('Status', 'Completed'),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 32),
            _amountBlock(amountStr, isCredit),
            pw.SizedBox(height: 32),
            _detailsBlock(transaction, reference, currencyCode),
            pw.Spacer(),
            _footer(),
          ],
        ),
      ),
    );

    final bytes = await doc.save();
    final safeRef = reference.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'family-receipt-'
          '${safeRef.isEmpty ? DateFormat('yyyyMMddHHmm').format(createdAt) : safeRef}'
          '.pdf',
    );
  }

  static pw.Widget _header(pw.MemoryImage? logo, String generatedDate) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (logo != null)
          pw.Image(logo, width: 120)
        else
          pw.Text('Lazervault',
              style: _style(fontSize: 28, isBold: true)
                  .copyWith(color: PdfColors.blue800)),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text('Family & Friends Receipt',
                style: _style(fontSize: 22, isBold: true)
                    .copyWith(color: PdfColors.grey800)),
            pw.SizedBox(height: 4),
            pw.Text('Generated on $generatedDate',
                style: _style(fontSize: 12, color: PdfColors.grey600)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _summaryRow(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: _style(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value, style: _style(fontSize: 11)),
        ],
      ),
    );
  }

  static pw.Widget _amountBlock(String amountStr, bool isCredit) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Column(
        children: [
          pw.Text(isCredit ? 'AMOUNT RECEIVED' : 'AMOUNT SPENT',
              style: _style(fontSize: 10, color: PdfColors.grey600)),
          pw.SizedBox(height: 8),
          pw.Text(amountStr,
              style: _style(fontSize: 30, isBold: true).copyWith(
                  color: isCredit ? PdfColors.green800 : PdfColors.grey900)),
        ],
      ),
    );
  }

  static pw.Widget _detailsBlock(
    FamilyTransaction transaction,
    String reference,
    String currencyCode,
  ) {
    final isSpending = transaction.type == FamilyTransactionType.spending;
    final merchant = transaction.merchantName?.trim() ?? '';
    final category = transaction.merchantCategory?.trim() ?? '';
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Transaction Details',
            style: _style(fontSize: 16, isBold: true)),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.grey200),
          ),
          child: pw.Column(
            children: [
              _detailRow('Reference', _orMissing(reference), isBold: true),
              _detailRow('Currency', currencyCode.toUpperCase()),
              if (isSpending && merchant.isNotEmpty)
                _detailRow('Recipient', merchant),
              if (isSpending &&
                  category.isNotEmpty &&
                  category.toLowerCase() != 'general')
                _detailRow('Category', category),
              if ((transaction.description ?? '').trim().isNotEmpty)
                _detailRow('Note', transaction.description!.trim()),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _detailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(label,
                style: _style(fontSize: 11, isBold: true)
                    .copyWith(color: PdfColors.grey700)),
          ),
          pw.Expanded(
            child: pw.Text(value,
                style: _style(fontSize: 11, isBold: isBold),
                textAlign: pw.TextAlign.right),
          ),
        ],
      ),
    );
  }

  static pw.Widget _footer() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 12),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Need help?',
                    style: _style(fontSize: 10, isBold: true)),
                pw.SizedBox(height: 4),
                pw.Text(ReceiptFooter.support,
                    style: _style(fontSize: 9, color: PdfColors.grey600)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                    ReceiptFooter.copyright(),
                    style: _style(fontSize: 9, color: PdfColors.grey600)),
                pw.SizedBox(height: 2),
                pw.Text('Page 1 of 1',
                    style: _style(fontSize: 9, color: PdfColors.grey500)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Text(
            ReceiptFooter.disclaimer('a Family & Friends account transaction'),
            style: _style(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
