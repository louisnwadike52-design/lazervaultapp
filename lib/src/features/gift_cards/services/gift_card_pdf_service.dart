import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../domain/entities/gift_card_entity.dart';
import 'receipt_text.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';

class GiftCardPdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  static String _currencySymbolFor(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return 'NGN ';
      case 'GBP':
        return 'GBP ';
      case 'EUR':
        return 'EUR ';
      case 'USD':
        return 'USD ';
      case 'ZAR':
        return 'ZAR ';
      default:
        return '$code ';
    }
  }

  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
    }
  }

  /// True once a real TrueType face is embedded. When false the receipt is
  /// drawn with the PDF's built-in Helvetica, which cannot draw anything
  /// outside Latin-1 — so text has to be routed through [pdfSafe] first.
  static bool get _hasEmbeddedFont => ReceiptFonts.embedded;

  /// Loads Inter for the receipt. See [ReceiptFonts] for why the bundled asset
  /// is tried before the network.
  static Future<void> _loadFonts() async {
    await ReceiptFonts.load();
    _regularFont = ReceiptFonts.regular;
    _boldFont = ReceiptFonts.bold;
  }

  /// _text is the ONLY way customer- or provider-supplied text should reach the
  /// PDF: entities decoded, markup removed, and — when no font could be
  /// embedded — reduced to characters the built-in font can actually draw.
  static String _text(String raw, {bool multiline = false}) {
    final normalised = multiline ? receiptProse(raw) : receiptLine(raw);
    return _hasEmbeddedFont ? normalised : pdfSafe(normalised);
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
    required GiftCard giftCard,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final currencySymbol = _currencySymbolFor(giftCard.currency);
    final amount = giftCard.originalAmount.toStringAsFixed(2);
    final hasCrossCurrency = giftCard.isMultiCurrency;

    // MultiPage, NOT Page.
    //
    // pw.Page does not paginate — a Column taller than the sheet is silently
    // clipped, and a Spacer inside it makes that worse by claiming the space
    // the overflowing children needed. On a real receipt (cross-currency, a
    // recipient, provider instructions) the document ran past A4 and the part
    // that fell off the bottom was the Redemption Details section: the code
    // and PIN. The receipt printed everything about the purchase except the
    // one thing the customer bought.
    //
    // Each section is a top-level entry so the page break can fall BETWEEN
    // them, and the redemption block is split into its own pieces so a long
    // set of provider instructions flows onto a second page rather than
    // overflowing one.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        footer: (pw.Context context) => _buildFooter(),
        build: (pw.Context context) => [
          _buildHeader(logo, generatedDate),
          pw.SizedBox(height: 16),
          _buildAmountSection(
            giftCard: giftCard,
            currencySymbol: currencySymbol,
            amount: amount,
            hasCrossCurrency: hasCrossCurrency,
          ),
          pw.SizedBox(height: 16),
          // Redemption BEFORE the purchase details: the code is what the
          // customer opened the receipt for, and putting it first also keeps
          // the code/PIN panel high on page one instead of straddling the page
          // break, which split it from its own heading.
          ..._buildRedemptionSection(giftCard: giftCard),
          _buildPurchaseDetails(
            giftCard: giftCard,
            currencySymbol: currencySymbol,
            amount: amount,
            hasCrossCurrency: hasCrossCurrency,
          ),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final ref = (giftCard.providerTransactionId ?? giftCard.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName =
        'giftcard_receipt_${ref}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(
      pw.MemoryImage? logo, String generatedDate) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null)
              pw.Image(logo, width: 90)
            else
              pw.Text(
                'Lazervault',
                style: _getTextStyle(fontSize: 28, isBold: true)
                    .copyWith(color: PdfColors.blue800),
              ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Gift Card Receipt',
              style: _getTextStyle(fontSize: 18, isBold: true)
                  .copyWith(color: PdfColors.grey800),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Generated on $generatedDate',
              style: _getTextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildAmountSection({
    required GiftCard giftCard,
    required String currencySymbol,
    required String amount,
    required bool hasCrossCurrency,
  }) {
    return pw.Container(
      width: double.infinity,
      // Sized so a receipt carrying a code, a PIN, instructions and the full
      // details table still lands on ONE page. MultiPage remains the safety
      // net for a provider that sends unusually long instructions.
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: PdfColors.blue200),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            _text(giftCard.brandName),
            style: _getTextStyle(fontSize: 14, isBold: true),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            '$currencySymbol$amount',
            style: _getTextStyle(fontSize: 22, isBold: true)
                .copyWith(color: PdfColors.blue800),
          ),
          if (hasCrossCurrency) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              'Paid: ${_currencySymbolFor(giftCard.senderCurrency)}${giftCard.senderAmount.toStringAsFixed(2)}',
              style: _getTextStyle(fontSize: 14, color: PdfColors.grey700),
            ),
          ],
          pw.SizedBox(height: 8),
          pw.Container(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: pw.BoxDecoration(
              color: giftCard.status == 'available'
                  ? PdfColors.green50
                  : PdfColors.orange50,
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Text(
              giftCard.status[0].toUpperCase() + giftCard.status.substring(1),
              style: _getTextStyle(
                fontSize: 11,
                isBold: true,
                color: giftCard.status == 'available'
                    ? PdfColors.green800
                    : PdfColors.orange800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPurchaseDetails({
    required GiftCard giftCard,
    required String currencySymbol,
    required String amount,
    required bool hasCrossCurrency,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Purchase Details',
          style: _getTextStyle(fontSize: 13, isBold: true),
        ),
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
              _buildDetailRow('Brand', _text(giftCard.brandName)),
              _buildDetailRow('Card Value', '$currencySymbol$amount',
                  isBold: true),
              if (hasCrossCurrency)
                _buildDetailRow('Amount Paid',
                    '${_currencySymbolFor(giftCard.senderCurrency)}${giftCard.senderAmount.toStringAsFixed(2)}'),
              if (giftCard.discountPercentage > 0)
                _buildDetailRow('Discount',
                    '${giftCard.discountPercentage.toStringAsFixed(0)}%'),
              // The internal reference, which is what support asks for — the
              // on-screen receipt has always shown it and the PDF did not, so
              // the downloadable copy was the one without the useful number.
              if (giftCard.reference.isNotEmpty)
                _buildDetailRow('Reference', giftCard.reference),
              _buildDetailRow('Purchase Date',
                  _formatDate(giftCard.purchaseDate)),
              _buildDetailRow(
                  'Expiry Date', _formatDate(giftCard.expiryDate)),
              if (giftCard.countryCode != null &&
                  giftCard.countryCode!.isNotEmpty)
                _buildDetailRow('Country', giftCard.countryCode!),
              if (giftCard.providerTransactionId != null &&
                  giftCard.providerTransactionId!.isNotEmpty)
                _buildDetailRow(
                    'Transaction ID', giftCard.providerTransactionId!),
              if (giftCard.recipientName != null &&
                  giftCard.recipientName!.isNotEmpty)
                _buildDetailRow('Recipient', _text(giftCard.recipientName!)),
              if (giftCard.recipientEmail != null &&
                  giftCard.recipientEmail!.isNotEmpty)
                _buildDetailRow('Email', _text(giftCard.recipientEmail!)),
            ],
          ),
        ),
      ],
    );
  }

  /// The redemption block, as separate top-level pieces.
  ///
  /// A list rather than one widget so MultiPage can break between the code and
  /// a long set of instructions. Returns empty when there is nothing to
  /// redeem yet — a card still being delivered has no code, and an empty green
  /// panel reads as though something went missing.
  /// Link-redeemed brands (Google Play and friends) deliver a URL where other
  /// products deliver a code/PIN — label it for what it is.
  static bool _looksLikeLink(String v) {
    final s = v.trim().toLowerCase();
    return s.startsWith('http://') || s.startsWith('https://');
  }

  static List<pw.Widget> _buildRedemptionSection({
    required GiftCard giftCard,
  }) {
    final code = giftCard.redemptionCode ?? '';
    final pin = giftCard.redemptionPin ?? '';
    final instructions = giftCard.redemptionInstructions ?? '';
    if (code.isEmpty && pin.isEmpty && instructions.isEmpty) return const [];

    return [
      pw.Text(
        'Redemption Details',
        style: _getTextStyle(fontSize: 13, isBold: true),
      ),
      pw.SizedBox(height: 12),
      if (code.isNotEmpty || pin.isNotEmpty)
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.green50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.green200),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (code.isNotEmpty) ...[
                pw.Text(
                    _looksLikeLink(code)
                        ? 'Redemption Link'
                        : 'Redemption Code',
                    style:
                        _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(
                  _text(code),
                  // A URL needs to wrap at a readable size; a code stays big.
                  style: _getTextStyle(
                      fontSize: _looksLikeLink(code) ? 10 : 14, isBold: true),
                ),
              ],
              if (pin.isNotEmpty) ...[
                pw.SizedBox(height: 12),
                pw.Text(
                    _looksLikeLink(pin) ? 'Redemption Link' : 'Redemption PIN',
                    style:
                        _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
                pw.SizedBox(height: 4),
                pw.Text(
                  _text(pin),
                  style: _getTextStyle(
                      fontSize: _looksLikeLink(pin) ? 10 : 14, isBold: true),
                ),
              ],
            ],
          ),
        ),
      if (instructions.isNotEmpty) ...[
        pw.SizedBox(height: 12),
        pw.Text('How to Redeem',
            style: _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.SizedBox(height: 4),
        pw.Paragraph(
          text: _text(instructions, multiline: true),
          style: _getTextStyle(fontSize: 11, color: PdfColors.grey800),
        ),
      ],
      pw.SizedBox(height: 16),
    ];
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
          pw.SizedBox(width: 20),
          pw.Expanded(
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.right,
              style: _getTextStyle(fontSize: 11, isBold: isBold),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Lazervault Financial Services',
              style: _getTextStyle(fontSize: 10, color: PdfColors.grey500),
            ),
            pw.Text(
              'This is a computer-generated document',
              style: _getTextStyle(fontSize: 9, color: PdfColors.grey400),
            ),
          ],
        ),
      ],
    );
  }

  static String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return _displayDateFormat.format(date);
    } catch (e) {
      return dateStr;
    }
  }

  /// Saves the receipt to the device and opens it.
  ///
  /// Goes through [ReceiptDownload], which is the app's one answer to where a
  /// receipt lands. This used to write straight to /storage/emulated/0/Download
  /// — a path Android scoped storage (API 30+) reports as existing and then
  /// refuses to write to, so Download failed on every current Android device
  /// while looking like a code path that had been thought about.
  ///
  /// The saved file is named after the reference printed ON the receipt, so the
  /// file a customer finds and the number support asks for are the same string.
  static Future<String> downloadReceipt({
    required GiftCard giftCard,
  }) async {
    try {
      final file = await generateReceipt(giftCard: giftCard);
      final ref = (giftCard.reference.isNotEmpty
              ? giftCard.reference
              : (giftCard.providerTransactionId ?? giftCard.id))
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      return ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'giftcard_receipt_$ref.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share receipt via system share sheet
  static Future<void> shareReceipt({
    required GiftCard giftCard,
  }) async {
    try {
      final file = await generateReceipt(giftCard: giftCard);

      final currencySymbol = _currencySymbolFor(giftCard.currency);
      final amount = giftCard.originalAmount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
        files: [XFile(file.path)],
        // The brand goes through the same normaliser as the PDF: a brand
        // carrying an entity ("Barnes &amp; Noble") would otherwise be shared
        // with the markup showing, in the one line the recipient reads first.
        text: 'Gift Card Receipt - ${receiptLine(giftCard.brandName)} '
            '$currencySymbol$amount',
        subject: 'Lazervault Gift Card Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
