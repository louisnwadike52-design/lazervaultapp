import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:image/image.dart' as img;
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import '../domain/entities/tag_pay_entity.dart';
import '../domain/entities/user_tag_entity.dart';
import 'package:lazervault/src/features/widgets/receipt_metadata_humanizer.dart';

/// Which party a transfer receipt is generated FOR. Drives whether the fee is
/// shown: the SENDER paid amount + fee, so their copy itemises the fee; the
/// RECIPIENT received only the amount (the fee never touches them), so their
/// copy shows just the amount + transaction details — never the sender's fee.
enum ReceiptCopyType {
  sender,
  recipient;

  bool get isRecipient => this == ReceiptCopyType.recipient;

  /// Caption stamped on the PDF so a printed/shared copy is unambiguous.
  String get label => switch (this) {
        ReceiptCopyType.sender => "Sender's Copy",
        ReceiptCopyType.recipient => "Recipient's Copy",
      };
}

/// Output format the user picks for a shareable/downloadable receipt. PNG/JPG
/// are rasterised from the SAME PDF layout so all three formats look identical.
enum ReceiptFileFormat {
  pdf,
  png,
  jpg;

  String get ext => name; // pdf | png | jpg
  String get label => switch (this) {
        ReceiptFileFormat.pdf => 'PDF document',
        ReceiptFileFormat.png => 'PNG image',
        ReceiptFileFormat.jpg => 'JPG image',
      };
  String get mime => switch (this) {
        ReceiptFileFormat.pdf => 'application/pdf',
        ReceiptFileFormat.png => 'image/png',
        ReceiptFileFormat.jpg => 'image/jpeg',
      };
}

class TagPayPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  /// Money is grouped for READING. `toStringAsFixed(2)` alone rendered
  /// "₦1500000.00" — a figure a customer has to count digits on to trust.
  /// Display only: every amount used for arithmetic stays a double.
  static final _amountFormat = NumberFormat('#,##0.00');

  // Cache for loaded fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Currency symbol for the PDF. With Inter embedded we render the REAL
  /// symbol (₦, £, €, ₹…) so the document matches the on-screen receipt, which
  /// has always shown ₦; the blanket ASCII codes here were a leftover from the
  /// CDN-only font era and printed "NGN 1500.00" against an on-screen
  /// "₦1,500.00" for the same transaction. Without an embedded TrueType font
  /// the built-in PDF font cannot draw those glyphs and the pdf package RAISES
  /// rather than substituting, so the ASCII code remains the fallback.
  static String _currencySymbolFor(String code) {
    if (ReceiptFonts.embedded) {
      switch (code.toUpperCase()) {
        case 'NGN':
          return '₦';
        case 'GBP':
          return '£';
        case 'EUR':
          return '€';
        case 'ZAR':
          return 'R';
        case 'CAD':
          return r'CA$';
        case 'AUD':
          return r'A$';
        case 'INR':
          return '₹';
        case 'JPY':
          return '¥';
        case 'USD':
          return r'$';
        default:
          return '$code ';
      }
    }
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
      case 'CAD':
        return 'CAD ';
      case 'AUD':
        return 'AUD ';
      case 'INR':
        return 'INR ';
      case 'JPY':
        return 'JPY ';
      default:
        return '$code ';
    }
  }

  /// Get display currency name
  static String _currencyNameFor(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return 'Nigerian Naira';
      case 'GBP':
        return 'British Pound';
      case 'EUR':
        return 'Euro';
      case 'USD':
        return 'US Dollar';
      case 'ZAR':
        return 'South African Rand';
      default:
        return code;
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

  /// Load fonts that support unicode characters (₦, —, etc). BUNDLED Inter is
  /// the primary source — receipts must render correctly offline and instantly.
  /// The old CDN-only fetch was version-pinned and started 404ing when Google
  /// rotated the URL, silently degrading every receipt to Helvetica (no ₦
  /// glyph) after an unbounded network wait that made Share look frozen.
  /// This file's loader was the one that got it right, so it became the shared
  /// [ReceiptFonts] — bundled asset first, bounded CDN fetch as a last resort.
  static Future<void> _loadFonts() async {
    await ReceiptFonts.load();
    _regularFont = ReceiptFonts.regular;
    _boldFont = ReceiptFonts.bold;
  }

  /// Get text style with proper font
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

  /// Sanitise a string for the PDF font. The masked-account bullet `•`
  /// (U+2022) is above Latin-1 and is missing from the built-in Helvetica the
  /// PDF falls back to when the remote Inter subset can't be fetched — it renders
  /// as a tofu box (▨). Swap it for the Latin-1 middle dot `·` (U+00B7), which is
  /// covered by every font path and keeps the "•••• 1234" masked look.
  static String? _pdfSafe(String? s) => s == null ? null : _pdfSafeText(s);

  /// Non-nullable form of [_pdfSafe]. The tag entities expose plain (never
  /// null) Strings for names/tags/descriptions, and those went into the tag
  /// generators completely unsanitised while the transfer/crypto generators
  /// sanitised everything — same font, same failure mode, only tag receipts
  /// were exposed to it.
  static String _pdfSafeText(String s) => s.replaceAll('•', '·');

  /// First non-empty value in [candidates], trimmed, or null.
  ///
  /// Receipt metadata has three producers with three key spellings: the
  /// realtime send-funds flow writes `Beneficiary Name`/`From`, the
  /// transaction-history mapper writes snake_case (`recipient_name`,
  /// `sender_name`, `bank_name`), and older map-based callers write camelCase.
  /// A lookup that knows only one spelling silently finds nothing.
  static String? _firstNonEmpty(List<Object?> candidates) {
    for (final candidate in candidates) {
      final value = candidate?.toString().trim();
      if (value != null && value.isNotEmpty) return value;
    }
    return null;
  }

  /// True when the value is a TagPay HANDLE rather than an account number.
  ///
  /// [_buildRecipientDetails] takes one "tag" slot that carries a handle for
  /// tag flows and a (possibly masked) BANK ACCOUNT NUMBER for fund transfers.
  /// Prefixing it unconditionally printed "Tag: @0123456789" on every bank
  /// transfer receipt, so the shape of the value decides: masked accounts
  /// arrive as "···· 1234" / "****1234", i.e. digits and masking punctuation
  /// only — anything containing a letter is a real handle.
  static bool _isTagHandle(String value) =>
      !RegExp(r'^[\d\s·•*.\-]+$').hasMatch(value.trim());

  /// Generate a professional invoice PDF for a tag (before payment)
  static Future<File> generateTagInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final createdDate = _dateFormat.format(tag.createdAt);
    final currencySymbol = _currencySymbolFor(tag.currency);
    final amount = _amountFormat.format(tag.amount);

    // For outgoing tags: you are the tagger (sender), recipient is taggedUser
    // For incoming tags: tagger sent it to you (taggedUser)
    // Names/tags/description are USER-SUPPLIED, so they go through _pdfSafe
    // before they reach the document.
    final senderName = _pdfSafeText(tag.taggerName);
    final senderTag = _pdfSafeText(tag.taggerTagPay);
    final recipientName = _pdfSafeText(tag.taggedUserName);
    final recipientTag = _pdfSafeText(tag.taggedUserTagPay);
    final description = _pdfSafeText(tag.description);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildInvoiceHeader(logo, generatedDate, isInvoice: true),
              pw.SizedBox(height: 24),

              // From/To and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(senderName.toUpperCase(),
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (senderTag.isNotEmpty)
                          pw.Text('@$senderTag',
                              style: _getTextStyle(
                                  fontSize: 11, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: createdDate,
                      status: _tagStatusLabel(tag),
                      type: 'Tagpay Invoice',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Invoice Details
              _buildInvoiceDetails(
                tag: tag,
                currencySymbol: currencySymbol,
                amount: amount,
                description: description,
              ),
              pw.SizedBox(height: 32),

              // Recipient Details
              _buildRecipientDetails(
                recipientName: recipientName,
                recipientTag: recipientTag,
                title: 'Bill To',
              ),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'tagpay_invoice_${tag.id.substring(0, 8)}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a professional receipt PDF for a paid tag
  static Future<File> generateTagPayReceipt({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? senderAccountNumber,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final completedDate = transaction.completedAt != null
        ? _dateFormat.format(transaction.completedAt!)
        : transactionDate;
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = _amountFormat.format(transaction.amount);

    // USER-SUPPLIED text (names, tags, narration) is sanitised before it
    // reaches the document — same rule the transfer/crypto generators follow.
    final beneficiaryName = _pdfSafeText(transaction.receiverName.isNotEmpty
        ? transaction.receiverName
        : tag.taggerName);
    final beneficiaryTag = _pdfSafeText(transaction.receiverTagPay.isNotEmpty
        ? transaction.receiverTagPay
        : tag.taggerTagPay);
    final reference = _pdfSafeText(transaction.description ?? tag.description);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildSenderInfo(
                      transaction: transaction,
                      tag: tag,
                      accountNumber: senderAccountNumber,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: completedDate,
                      status: transaction.statusDisplay,
                      type: 'Tagpay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference: reference,
                tagPayReference: transaction.referenceNumber,
                transactionId: transaction.id,
              ),
              pw.SizedBox(height: 32),

              // Both parties — a paid receipt records who paid whom.
              _buildRecipientDetails(
                recipientName: beneficiaryName,
                recipientTag: beneficiaryTag,
                title: 'Transaction Parties',
                senderName: _pdfSafeText(transaction.senderName.isNotEmpty
                    ? transaction.senderName
                    : tag.taggedUserName),
                senderTag: _pdfSafeText(transaction.senderTagPay.isNotEmpty
                    ? transaction.senderTagPay
                    : tag.taggedUserTagPay),
              ),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'tagpay_receipt_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildInvoiceHeader(
      pw.MemoryImage? logo, String generatedDate,
      {required bool isInvoice}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null)
              pw.Image(logo, width: 120)
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
              isInvoice ? 'Tag Invoice' : 'Transfer Confirmation',
              style: _getTextStyle(fontSize: 24, isBold: true)
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

  static pw.Widget _buildSenderInfo({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? accountNumber,
  }) {
    // User-supplied names/handles are sanitised for the PDF font here rather
    // than at the call site, so every caller of this block gets it.
    final senderName = _pdfSafeText(transaction.senderName.isNotEmpty
        ? transaction.senderName
        : tag.taggedUserName);
    final senderTag = _pdfSafeText(transaction.senderTagPay.isNotEmpty
        ? transaction.senderTagPay
        : tag.taggedUserTagPay);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          senderName.toUpperCase(),
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        pw.SizedBox(height: 4),
        if (senderTag.isNotEmpty)
          pw.Text(
            '@$senderTag',
            style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
          ),
        if (accountNumber != null && accountNumber.isNotEmpty) ...[
          pw.SizedBox(height: 16),
          pw.Row(
            children: [
              pw.Text(
                'Account Number',
                style: _getTextStyle(fontSize: 11, isBold: true),
              ),
              pw.SizedBox(width: 12),
              pw.Text(
                accountNumber,
                style: _getTextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String createdDate,
    String? completedDate,
    required String status,
    required String type,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Value Date', completedDate ?? createdDate),
        _buildSummaryRow('Operation Date', createdDate),
        _buildSummaryRow('Date available', completedDate ?? createdDate),
        _buildSummaryRow('Status', status),
        _buildSummaryRow('Type', type),
      ],
    );
  }

  static pw.Widget _buildSummaryRow(String label, String value) {
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
          pw.Text(
            label,
            style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
          pw.Text(
            value,
            style: _getTextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildInvoiceDetails({
    required UserTagEntity tag,
    required String currencySymbol,
    required String amount,
    required String description,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Invoice Details',
          style: _getTextStyle(fontSize: 16, isBold: true),
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
              _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true),
              _buildDetailRow('Currency', _currencyNameFor(tag.currency)),
              _buildDetailRow('Fee', '${currencySymbol}0.00'),
              if (description.isNotEmpty)
                _buildDetailRow('Description', description),
              _buildDetailRow('Tag ID', tag.id),
              _buildDetailRow(
                  'Created', _fullDateTimeFormat.format(tag.createdAt)),
              if (tag.paidAt != null)
                _buildDetailRow(
                    'Paid', _fullDateTimeFormat.format(tag.paidAt!)),
            ],
          ),
        ),
      ],
    );
  }

  /// Fund-transfer details card: amount + fee SEPARATE, ONE "Transfer Reference"
  /// (no Tagpay reference, no duplicate Transaction Id). Distinct from the TagPay
  /// card below so each service owns its own fields.
  static pw.Widget _buildFundTransferDetails({
    required String currencySymbol,
    required String amount,
    required String fee,
    required String description,
    required String transferReference,
    // SENDER copy itemises Fee + Total Paid (amount + fee). RECIPIENT copy hides
    // the fee entirely — the recipient received exactly `amount`; the fee is the
    // sender's cost and must never appear on the beneficiary's copy.
    bool showFee = true,
    String? totalPaid,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transfer details',
          style: _getTextStyle(fontSize: 16, isBold: true),
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
              _buildDetailRow(showFee ? 'Amount' : 'Amount Received',
                  '$currencySymbol$amount',
                  isBold: true),
              if (showFee) ...[
                _buildDetailRow('Fee', '$currencySymbol$fee'),
                if (totalPaid != null && totalPaid.isNotEmpty)
                  _buildDetailRow('Total Paid', '$currencySymbol$totalPaid',
                      isBold: true),
              ],
              if (description.isNotEmpty)
                _buildDetailRow('Description', description),
              _buildDetailRow('Transfer Reference', transferReference),
            ],
          ),
        ),
      ],
    );
  }

  /// Tagpay details card. Keeps its OWN "Tagpay Reference" field (no PascalCase).
  static pw.Widget _buildTransferDetails({
    required String currencySymbol,
    required String amount,
    required String reference,
    required String tagPayReference,
    required String transactionId,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transfer details',
          style: _getTextStyle(fontSize: 16, isBold: true),
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
              _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true),
              _buildDetailRow('Reference', reference),
              _buildDetailRow('Tagpay Reference', tagPayReference),
              _buildDetailRow('Transaction Id', transactionId),
            ],
          ),
        ),
      ],
    );
  }

  /// Clean a transfer reference for display: drop a redundant "_transfer" /
  /// "-transfer" suffix. The id already carries a "TRF" prefix, so leaving the
  /// suffix would say "transfer" twice (e.g. "TRF-abc_transfer").
  static String _cleanTransferRef(String ref) {
    var r = ref.trim();
    for (final suffix in const ['_transfer', '-transfer', ' transfer']) {
      if (r.toLowerCase().endsWith(suffix)) {
        r = r.substring(0, r.length - suffix.length).trim();
        break;
      }
    }
    return r;
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(
              label,
              style: _getTextStyle(fontSize: 11, isBold: true)
                  .copyWith(color: PdfColors.grey700),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: _getTextStyle(fontSize: 11, isBold: isBold),
              textAlign: pw.TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRecipientDetails({
    required String recipientName,
    required String recipientTag,
    required String title,
    // Both parties, when the caller knows them. A receipt that names only one
    // side does not record who paid whom — and for a TagPay, where the TAGGED
    // user pays the TAGGER, a reader holding the document cannot tell which
    // side they were on. Optional so callers that genuinely have one party
    // (a tag not yet paid) still render.
    String senderName = '',
    String senderTag = '',
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: _getTextStyle(fontSize: 16, isBold: true),
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
              if (senderName.isNotEmpty) ...[
                _buildDetailRow('From', senderName),
                if (senderTag.isNotEmpty)
                  _isTagHandle(senderTag)
                      ? _buildDetailRow('From tag', '@$senderTag')
                      : _buildDetailRow('From account', senderTag),
              ],
              _buildDetailRow(
                senderName.isNotEmpty ? 'Recipient' : 'Name',
                recipientName,
              ),
              if (recipientTag.isNotEmpty)
                // Handles get the "@" and the "Tag" label; bank account numbers
                // are printed bare under "Account". See [_isTagHandle].
                _isTagHandle(recipientTag)
                    ? _buildDetailRow(
                        senderName.isNotEmpty ? 'Recipient tag' : 'Tag',
                        '@$recipientTag')
                    : _buildDetailRow(
                        senderName.isNotEmpty ? 'Recipient account' : 'Account',
                        recipientTag),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter({String transactionType = 'Tagpay transfer'}) {
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
                pw.Text(
                  'Need help?',
                  style: _getTextStyle(fontSize: 10, isBold: true),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Get help directly in-app',
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  '(C) ${DateTime.now().year} Lazervault Technologies Ltd',
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Page 1 of 1',
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey500),
                ),
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
            'Lazervault Technologies Ltd is a financial technology company. '
            'This document is a confirmation of a $transactionType processed through the Lazervault platform. '
            'For any queries regarding this transaction, please contact support through the Lazervault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Download the invoice to device storage.
  ///
  /// Goes through [ReceiptDownload], the app's single answer to where a saved
  /// document lands. The previous direct write to /storage/emulated/0/Download
  /// fails on Android 11+: scoped storage reports that path as existing and
  /// then refuses the write, so `exists()` passed, the fallback never ran, and
  /// the copy threw — "Failed to download invoice" on every current device.
  static Future<String> downloadInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'tagpay_invoice_${tag.id.substring(0, 8)}.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download invoice: $e');
    }
  }

  // ── iOS share-sheet anchor ────────────────────────────────────────────
  //
  // share_plus on iOS REQUIRES a non-zero `sharePositionOrigin` (the rect the
  // share popover anchors to). An unset/zero rect throws
  // PlatformException("sharePositionOrigin: argument must be set, {{0,0},{0,0}}
  // must be non-zero …") — the "Failed to share invoice/receipt" the user hit.
  // Callers pass the tapped widget's global rect via [shareOriginFromContext];
  // when unavailable we fall back to a small valid rect so the sheet still opens.
  static Rect _resolveShareOrigin(Rect? origin) {
    if (origin != null && origin.width > 0 && origin.height > 0) {
      return origin;
    }
    return const Rect.fromLTWH(0, 0, 1, 1);
  }

  /// Build a share-sheet anchor rect from a widget's [context] (its global
  /// bounds). Returns null when the render box isn't ready; the share methods
  /// then fall back to a safe default.
  static Rect? shareOriginFromContext(BuildContext context) {
    final obj = context.findRenderObject();
    if (obj is RenderBox && obj.hasSize) {
      return obj.localToGlobal(Offset.zero) & obj.size;
    }
    return null;
  }

  /// Share the invoice via system share sheet
  static Future<void> shareInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
      final currencySymbol = _currencySymbolFor(tag.currency);
      final amount = _amountFormat.format(tag.amount);
      final recipientName = isOutgoing ? tag.taggedUserName : tag.taggerName;
      final recipientTag = isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Tagpay Invoice - $currencySymbol$amount ${isOutgoing ? "to" : "from"} ${recipientName.isNotEmpty ? recipientName : "@$recipientTag"}',
        subject: 'Lazervault Tagpay Invoice',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share invoice: $e');
    }
  }

  /// Share the invoices for a BATCH of tags — one PDF per recipient, all
  /// attached to a single share sheet.
  ///
  /// Batch creation produces N DISTINCT invoices (one per tagged user, each
  /// naming that user). The receipt screen used to share `tags.first` for the
  /// whole batch, so a screen reading "5 users x ₦2,000" handed out recipient
  /// #1's invoice five times and the other four never got theirs.
  static Future<void> shareInvoices({
    required List<UserTagEntity> tags,
    required bool isOutgoing,
    Rect? sharePositionOrigin,
  }) async {
    if (tags.isEmpty) return;
    if (tags.length == 1) {
      return shareInvoice(
        tag: tags.first,
        isOutgoing: isOutgoing,
        sharePositionOrigin: sharePositionOrigin,
      );
    }
    try {
      final files = <XFile>[];
      var total = 0.0;
      for (final tag in tags) {
        final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
        files.add(XFile(file.path));
        total += tag.amount;
      }
      final currencySymbol = _currencySymbolFor(tags.first.currency);

      await SharePlus.instance.share(ShareParams(
        files: files,
        text:
            'Tagpay Invoices - ${tags.length} recipients, $currencySymbol${_amountFormat.format(total)} total',
        subject: 'Lazervault Tagpay Invoices',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share invoices: $e');
    }
  }

  /// Download the receipt to device storage
  static Future<String> downloadReceipt({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? senderAccountNumber,
  }) async {
    try {
      final file = await generateTagPayReceipt(
        transaction: transaction,
        tag: tag,
        senderAccountNumber: senderAccountNumber,
      );
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName:
            'tagpay_receipt_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
    required TagPayTransactionEntity transaction,
    required UserTagEntity tag,
    String? senderAccountNumber,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file = await generateTagPayReceipt(
        transaction: transaction,
        tag: tag,
        senderAccountNumber: senderAccountNumber,
      );

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = _amountFormat.format(transaction.amount);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Tagpay Transfer Receipt - $currencySymbol$amount to @${transaction.receiverTagPay}',
        subject: 'Lazervault Tagpay Transfer Confirmation',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Title-cased form of the entity's single status source.
  ///
  /// Was `tag.isPaid ? 'Paid' : (tag.isCancelled ? 'Cancelled' : 'Pending')`,
  /// which printed "Pending" on the invoice of a tag that had in fact been
  /// declined, expired, or was mid-transfer — a PDF the customer could keep as
  /// evidence of a debt that no longer existed.
  static String _tagStatusLabel(UserTagEntity tag) {
    final label = tag.statusLabel;
    return label[0] + label.substring(1).toLowerCase();
  }

  /// Generate a receipt PDF from tag data only (for paid tags without transaction entity)
  /// This creates a simplified receipt using available tag information
  static Future<File> generatePaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    if (!tag.isPaid) {
      throw Exception('Cannot generate receipt for unpaid tag');
    }

    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final paidDate = tag.paidAt != null
        ? _dateFormat.format(tag.paidAt!)
        : _dateFormat.format(tag.createdAt);
    final currencySymbol = _currencySymbolFor(tag.currency);
    final amount = _amountFormat.format(tag.amount);

    // Direction of money is a property of the TRANSACTION, not of who is
    // looking at it. On a paid tag the tagged user always pays and the tagger
    // is always paid. These four lines used to swap on `isOutgoing` (which
    // means "I created this tag", i.e. I am the PAYEE) — so the person who
    // received the money got a receipt naming themselves as the sender, and
    // the two parties held contradictory documents under one reference.
    // All four are USER-SUPPLIED and are sanitised for the PDF font.
    final senderName = _pdfSafeText(tag.taggedUserName);
    final senderTag = _pdfSafeText(tag.taggedUserTagPay);
    final recipientName = _pdfSafeText(tag.taggerName);
    final recipientTag = _pdfSafeText(tag.taggerTagPay);
    final description = _pdfSafeText(tag.description);

    // Generate reference from tag ID
    final reference =
        'TPTAG-${tag.id.length > 8 ? tag.id.substring(0, 8) : tag.id}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          senderName.toUpperCase(),
                          style: _getTextStyle(fontSize: 14, isBold: true),
                        ),
                        pw.SizedBox(height: 4),
                        if (senderTag.isNotEmpty)
                          pw.Text(
                            '@$senderTag',
                            style: _getTextStyle(
                                fontSize: 12, color: PdfColors.grey700),
                          ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: paidDate,
                      completedDate: paidDate,
                      status: 'Completed',
                      type: 'Tagpay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference:
                    description.isNotEmpty ? description : 'Tagpay payment',
                tagPayReference: reference,
                transactionId: tag.id,
              ),
              pw.SizedBox(height: 32),

              // Beneficiary Details
              _buildRecipientDetails(
                recipientName: recipientName,
                recipientTag: recipientTag,
                title: 'Beneficiary Details',
              ),

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName = 'tagpay_receipt_$reference.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download receipt for a paid tag (without transaction entity)
  static Future<String> downloadPaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file =
          await generatePaidTagReceipt(tag: tag, isOutgoing: isOutgoing);
      final reference =
          'TPTAG-${tag.id.length > 8 ? tag.id.substring(0, 8) : tag.id}';
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'tagpay_receipt_$reference.pdf',
      );
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share receipt for a paid tag (without transaction entity)
  static Future<void> sharePaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final file =
          await generatePaidTagReceipt(tag: tag, isOutgoing: isOutgoing);

      final currencySymbol = _currencySymbolFor(tag.currency);
      final amount = _amountFormat.format(tag.amount);
      // The tagger (isOutgoing) was PAID by the tagged user; the tagged user
      // paid the tagger. Preposition and handle have to move together.
      final counterpartyTag =
          isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;
      final direction = isOutgoing ? 'from' : 'to';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Tagpay Receipt - $currencySymbol$amount $direction @$counterpartyTag',
        subject: 'Lazervault Tagpay Receipt',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  // ─── Fund Transfer Receipt (same visual style as TagPay) ───

  /// Generate a transfer receipt PDF from map-based transfer details
  static Future<File> generateFundTransferReceipt({
    required Map<String, dynamic> transferDetails,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbolFor(currency);
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    // Recipient copy hides the fee (it's the sender's cost); sender copy itemises
    // fee + total paid (amount + fee).
    final showFee = !copyType.isRecipient;

    final recipientName =
        _pdfSafe(transferDetails['recipientName'] as String?) ?? '';
    final recipientAccount =
        _pdfSafe(transferDetails['recipientAccountMasked'] as String?);
    final recipientBank =
        _pdfSafe(transferDetails['recipientBankName'] as String?);
    final sourceAccountName =
        _pdfSafe(transferDetails['sourceAccountName'] as String?);
    final sourceAccountInfo =
        _pdfSafe(transferDetails['sourceAccountInfo'] as String?);
    final reference = transferDetails['reference'] as String? ?? '';
    final narration = _pdfSafe(transferDetails['narration'] as String?);
    final status = transferDetails['status'] as String? ?? 'completed';
    final transferType =
        transferDetails['transferType'] as String? ?? 'Fund Transfer';
    final transferId = transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        '';

    DateTime? timestamp;
    if (transferDetails['timestamp'] != null) {
      timestamp = transferDetails['timestamp'] as DateTime?;
    } else if (transferDetails['createdAt'] != null) {
      timestamp = transferDetails['createdAt'] as DateTime?;
    }
    timestamp ??= DateTime.now();
    final transactionDate = _dateFormat.format(timestamp);

    final formattedStatus = _formatTransferStatus(status);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 8),
              // Which party this copy is for (Sender's / Recipient's Copy).
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text(
                  copyType.label.toUpperCase(),
                  style: _getTextStyle(fontSize: 9, color: PdfColors.grey700),
                ),
              ),
              pw.SizedBox(height: 16),

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text((sourceAccountName ?? '').toUpperCase(),
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (sourceAccountInfo != null &&
                            sourceAccountInfo.isNotEmpty)
                          pw.Text(sourceAccountInfo,
                              style: _getTextStyle(
                                  fontSize: 11, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: transactionDate,
                      status: formattedStatus,
                      type: transferType,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details — SENDER copy: amount + fee + total paid.
              // RECIPIENT copy: amount received only (no fee).
              _buildFundTransferDetails(
                currencySymbol: currencySymbol,
                amount: _amountFormat.format(amount),
                fee: _amountFormat.format(fee),
                showFee: showFee,
                totalPaid: showFee ? _amountFormat.format(amount + fee) : null,
                description: narration ?? '',
                transferReference: _cleanTransferRef(
                    reference.isNotEmpty ? reference : transferId),
              ),
              pw.SizedBox(height: 24),

              // Beneficiary Details
              _buildRecipientDetails(
                recipientName: recipientName,
                recipientTag: recipientAccount ?? '',
                title: 'Beneficiary Details',
              ),
              if (recipientBank != null && recipientBank.isNotEmpty)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 0, top: 4),
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 16),
                    child: _buildDetailRow('Bank', recipientBank),
                  ),
                ),

              // Scannable QR of the transfer reference (same id as the
              // on-screen receipt) so the PDF carries the barcode too.
              pw.SizedBox(height: 24),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: reference.isNotEmpty ? reference : transferId,
                      width: 90,
                      height: 90,
                      drawText: false,
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      reference.isNotEmpty ? reference : transferId,
                      style:
                          _getTextStyle(fontSize: 9, color: PdfColors.grey600),
                    ),
                  ],
                ),
              ),

              pw.Spacer(),
              _buildFooter(transactionType: 'fund transfer'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef = reference.isNotEmpty
        ? reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
        : transferId.isNotEmpty
            ? transferId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
            : 'transfer';
    final fileName = 'transfer_receipt_$safeRef.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a transfer receipt PDF from UnifiedTransaction (for transaction history)
  static Future<File> generateUnifiedTransferReceipt({
    required UnifiedTransaction transaction,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final metadata = transaction.metadata ?? {};

    // A receipt opened from TRANSACTION HISTORY carries none of the keys this
    // used to read: the history mapper writes snake_case (`recipient_name`,
    // `sender_name`, `bank_name`) and puts the direction-resolved counterparty
    // on the ENTITY, while the realtime send-funds flow writes
    // 'Beneficiary Name'/'From'. Every lookup therefore ran off the end of its
    // chain — FROM printed blank and the beneficiary fell through to
    // `transaction.title`, i.e. the SCREEN HEADING ("Tag Payment Received")
    // was printed as the person paid. The entity's counterparty is the last
    // real source; the title is only a placeholder of last resort.
    final recipientName = _firstNonEmpty([
          metadata['Recipient'],
          metadata['Beneficiary Name'],
          metadata['recipientName'],
          metadata['recipient_name'],
          transaction.counterpartyName,
        ]) ??
        transaction.title;
    final sourceAccountName = _firstNonEmpty([
      metadata['Source Account'],
      metadata['From'],
      metadata['sender_name'],
      metadata['senderAccount'],
    ]);
    final sourceAccountInfo = _firstNonEmpty([
      metadata['senderAccount'],
      metadata['sender_account'],
    ]);

    return generateTransferReceiptFile(
      copyType: copyType,
      format: format,
      transferDetails: {
        'amount': transaction.amount,
        'currency': transaction.currency,
        'recipientName': recipientName,
        'recipientAccountMasked': _firstNonEmpty([
          metadata['Recipient Account'],
          metadata['Beneficiary Account'],
          metadata['recipientAccount'],
          metadata['recipient_account'],
          transaction.counterpartyAccount,
        ]),
        'recipientBankName': _firstNonEmpty([
          metadata['recipientBank'],
          metadata['Beneficiary Bank'],
          metadata['bank_name'],
        ]),
        'sourceAccountName': sourceAccountName,
        // Don't print the same string twice when both slots resolved from the
        // one key that was available.
        'sourceAccountInfo':
            sourceAccountInfo == sourceAccountName ? null : sourceAccountInfo,
        'reference': transaction.transactionReference ?? transaction.id,
        'narration': transaction.description,
        'status': transaction.status.displayName,
        'transferType': metadata['Transfer Type']?.toString() ??
            metadata['transferType']?.toString() ??
            'Fund Transfer',
        'transactionId': transaction.id,
        'fee': double.tryParse(
            _firstNonEmpty([metadata['Fee'], metadata['fee']])
                    ?.replaceAll(RegExp(r'[^0-9.]'), '') ??
                '0'),
        'timestamp': transaction.createdAt,
      },
    );
  }

  /// Rasterise page 1 of a generated receipt PDF to a PNG/JPG file. Reuses the
  /// exact PDF layout, so the image is a pixel-faithful copy of the document.
  static Future<File> _rasterizeReceipt({
    required File pdfFile,
    required ReceiptFileFormat format,
    required String baseName,
  }) async {
    final pdfBytes = await pdfFile.readAsBytes();
    // 200 dpi = crisp on-screen + printable without a huge file.
    final raster = await Printing.raster(pdfBytes, pages: [0], dpi: 200).first;

    // Decode the raster ONCE, correctly, for both image formats.
    //
    // Two things were wrong here and both produced visibly broken files:
    //
    // 1. `raster.pixels.buffer` throws away the view's offset. A Uint8List is a
    //    WINDOW onto a ByteBuffer, and .buffer hands back the whole underlying
    //    buffer ignoring offsetInBytes/lengthInBytes. Whenever that window did
    //    not start at byte 0 the image decoded from the wrong origin, which is
    //    why the exported picture came out skewed/garbled.
    //
    // 2. The old comment claimed the background was "already white". It is not:
    //    a rasterised PDF page carries an ALPHA channel, and the receipt card
    //    sits on transparent pixels. JPG has no alpha, so encoding dropped it
    //    and those pixels rendered BLACK; PNG kept them transparent, which
    //    viewers show as black or a checkerboard. Both formats are now
    //    composited onto opaque white first, so what is saved is what is seen.
    // Copy into a fresh list so the ByteBuffer handed to the decoder starts at
    // byte 0. Taking .buffer off a view would re-introduce the very offset this
    // is correcting, since .buffer always returns the whole underlying buffer.
    final rgba = Uint8List.fromList(raster.pixels);
    final decoded = img.Image.fromBytes(
      width: raster.width,
      height: raster.height,
      bytes: rgba.buffer,
      numChannels: 4,
      order: img.ChannelOrder.rgba,
    );
    final flattened = img.Image(width: raster.width, height: raster.height)
      ..clear(img.ColorRgb8(255, 255, 255));
    img.compositeImage(flattened, decoded);

    final Uint8List bytes = format == ReceiptFileFormat.jpg
        ? img.encodeJpg(flattened, quality: 92)
        : img.encodePng(flattened);
    final out = await getTemporaryDirectory();
    final file = File('${out.path}/$baseName.${format.ext}');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Produce a transfer-receipt FILE in the requested [format] for [copyType].
  /// PDF returns the vector document; PNG/JPG rasterise page 1 of that same PDF
  /// so all three formats are visually identical.
  static Future<File> generateTransferReceiptFile({
    required Map<String, dynamic> transferDetails,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final pdfFile = await generateFundTransferReceipt(
        transferDetails: transferDetails, copyType: copyType);
    if (format == ReceiptFileFormat.pdf) return pdfFile;

    final reference = (transferDetails['reference'] as String?) ?? '';
    final transferId = transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        '';
    final rawRef = reference.isNotEmpty
        ? reference
        : (transferId.isNotEmpty ? transferId : 'transfer');
    final safeRef = rawRef.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final suffix = copyType.isRecipient ? 'recipient' : 'sender';
    return _rasterizeReceipt(
      pdfFile: pdfFile,
      format: format,
      baseName: 'transfer_receipt_${safeRef}_$suffix',
    );
  }

  /// Download transfer receipt from map details
  static Future<String> downloadTransferReceipt({
    required Map<String, dynamic> transferDetails,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateTransferReceiptFile(
          transferDetails: transferDetails, copyType: copyType, format: format);

      final reference = transferDetails['reference'] as String? ?? '';
      final transferId = transferDetails['transferId']?.toString() ??
          transferDetails['transactionId']?.toString() ??
          '';
      final safeRef = reference.isNotEmpty
          ? reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          : transferId.isNotEmpty
              ? transferId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
              : 'transfer';
      final copySuffix = copyType.isRecipient ? '_recipient' : '_sender';
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'transfer_receipt_$safeRef$copySuffix.${format.ext}',
      );
    } catch (e) {
      throw Exception('Failed to download transfer receipt: $e');
    }
  }

  /// Share transfer receipt from map details
  static Future<void> shareTransferReceipt({
    required Map<String, dynamic> transferDetails,
    Rect? sharePositionOrigin,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateTransferReceiptFile(
          transferDetails: transferDetails, copyType: copyType, format: format);

      final currency = transferDetails['currency'] as String? ?? 'NGN';
      final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
      final currencySymbol = _currencySymbolFor(currency);
      final recipientName = transferDetails['recipientName'] as String? ?? '';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Lazervault Transfer Receipt (${copyType.label}) - $currencySymbol${_amountFormat.format(amount)} to $recipientName',
        subject: 'Lazervault Transfer Receipt',
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share transfer receipt: $e');
    }
  }

  /// Download transfer receipt from UnifiedTransaction (for transaction history)
  static Future<String> downloadUnifiedTransferReceipt({
    required UnifiedTransaction transaction,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateUnifiedTransferReceipt(
          transaction: transaction, copyType: copyType, format: format);
      final safeRef = (transaction.transactionReference ?? transaction.id)
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      return await ReceiptDownload.saveAndOpen(
        source: file,
        fileName: 'transfer_receipt_$safeRef.${format.ext}',
      );
    } catch (e) {
      throw Exception('Failed to download transfer receipt: $e');
    }
  }

  /// Share transfer receipt from UnifiedTransaction (for transaction history)
  static Future<void> shareUnifiedTransferReceipt({
    required UnifiedTransaction transaction,
    Rect? sharePositionOrigin,
    ReceiptCopyType copyType = ReceiptCopyType.sender,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    try {
      final file = await generateUnifiedTransferReceipt(
          transaction: transaction, copyType: copyType, format: format);

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = _amountFormat.format(transaction.amount);

      // An invoice payment is not a transfer: name it correctly and reference
      // the invoice number instead of "to <title>" (which produced the absurd
      // "to Invoice Payment").
      final String text;
      final String subject;
      if (transaction.serviceType == TransactionServiceType.invoice) {
        final invoiceNo = transaction.metadata?['Invoice No.']?.toString() ??
            transaction.metadata?['Invoice ID']?.toString();
        subject = 'Lazervault Invoice Receipt';
        text = invoiceNo != null && invoiceNo.isNotEmpty
            ? 'Lazervault Invoice Receipt - $currencySymbol$amount for Invoice #$invoiceNo'
            : 'Lazervault Invoice Receipt - $currencySymbol$amount';
      } else {
        // Same metadata-spelling problem as the PDF body: a history-opened
        // receipt has no 'Recipient' key, so this fell back to the screen
        // TITLE and shared "…to Tag Payment Received". Try every spelling and
        // the entity's counterparty; with no counterparty at all, name no one
        // rather than naming the heading.
        final recipient = _firstNonEmpty([
          transaction.metadata?['Recipient'],
          transaction.metadata?['Beneficiary Name'],
          transaction.metadata?['recipientName'],
          transaction.metadata?['recipient_name'],
          transaction.counterpartyName,
        ]);
        subject = 'Lazervault Transfer Receipt';
        text = recipient != null
            ? 'Lazervault Transfer Receipt - $currencySymbol$amount to $recipient'
            : 'Lazervault Transfer Receipt - $currencySymbol$amount';
      }

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: text,
        subject: subject,
        sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
      ));
    } catch (e) {
      throw Exception('Failed to share transfer receipt: $e');
    }
  }

  // ==========================================================================
  // CRYPTO receipt PDF (buy / sell / swap / send / deposit)
  // ==========================================================================
  /// Revolut-style PDF for a crypto transaction. Reuses the shared transfer
  /// builders (header / summary table / detail rows / QR / footer) but renders
  /// the crypto-specific rows by iterating the UnifiedTransaction metadata
  /// (Asset, Rate, Trading fee, Network fee, Total, To address, Network,
  /// Blockchain txid, Note, Custody, From address …). Recipient + sender
  /// addresses ride in that metadata, so one generator covers every crypto flow.
  static Future<File> generateCryptoReceipt({
    required UnifiedTransaction transaction,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    final metadata = transaction.metadata ?? const {};
    final reference = transaction.transactionReference ?? transaction.id;
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final formattedStatus =
        _formatTransferStatus(transaction.status.displayName);

    // Crypto sends carry a display override ("5 USDT"); buy/sell/swap are fiat.
    final heroAmount = (transaction.amountDisplayOverride != null &&
            transaction.amountDisplayOverride!.trim().isNotEmpty)
        ? transaction.amountDisplayOverride!.trim()
        : '${_currencySymbolFor(transaction.currency)}${_amountFormat.format(transaction.amount)}';

    // Sender: an explicit 'From address' (send flow) or the LazerVault identity.
    final fromLabel = _pdfSafe(metadata['From address']?.toString() ??
            metadata['From']?.toString()) ??
        'LazerVault Wallet';

    // Every metadata entry becomes a label/value row, in insertion order.
    // Minor-unit plumbing (kobo / crypto minor scales) is humanized to naira
    // or dropped — a customer receipt never shows raw ledger units.
    final detailRows = <pw.Widget>[];
    metadata.forEach((k, v) {
      final val = _pdfSafe(v?.toString());
      if (val == null || val.isEmpty) return;
      final human = humanizeReceiptMetadataEntry(k, val);
      if (human == null) return;
      detailRows.add(pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 3),
        child: _buildDetailRow(_pdfSafe(human.label) ?? human.label,
            _pdfSafe(human.value) ?? human.value),
      ));
    });

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildInvoiceHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(fromLabel.toUpperCase(),
                            style: _getTextStyle(fontSize: 13, isBold: true)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: transactionDate,
                      status: formattedStatus,
                      type: transaction.title,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 24),
              // Hero amount card
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(transaction.title,
                        style: _getTextStyle(
                            fontSize: 11, color: PdfColors.grey600)),
                    pw.SizedBox(height: 4),
                    pw.Text(heroAmount,
                        style: _getTextStyle(fontSize: 22, isBold: true)),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              // Detail rows from metadata (Asset / Rate / fees / addresses / …)
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 16),
                child: pw.Column(children: detailRows),
              ),
              pw.SizedBox(height: 24),
              // Scannable QR of the reference (same id as the on-screen receipt)
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: reference,
                      width: 90,
                      height: 90,
                      drawText: false,
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(reference,
                        style: _getTextStyle(
                            fontSize: 9, color: PdfColors.grey600)),
                  ],
                ),
              ),
              pw.Spacer(),
              _buildFooter(transactionType: 'crypto transaction'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef = reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${output.path}/crypto_receipt_$safeRef.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download the crypto PDF receipt to the device Downloads/Documents dir.
  static Future<String> downloadCryptoReceipt({
    required UnifiedTransaction transaction,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final file = await generateCryptoReceiptFile(
        transaction: transaction, format: format);
    final safeRef = (transaction.transactionReference ?? transaction.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return ReceiptDownload.saveAndOpen(
      source: file,
      fileName: 'crypto_receipt_$safeRef.pdf',
    );
  }

  /// Share the crypto PDF receipt via the system share sheet.
  /// Produce the crypto receipt in the requested format (PNG/JPG rasterise the
  /// same PDF layout).
  static Future<File> generateCryptoReceiptFile({
    required UnifiedTransaction transaction,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final pdfFile = await generateCryptoReceipt(transaction: transaction);
    if (format == ReceiptFileFormat.pdf) return pdfFile;
    final safeRef = (transaction.transactionReference ?? transaction.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return _rasterizeReceipt(
      pdfFile: pdfFile,
      format: format,
      baseName: 'crypto_receipt_$safeRef',
    );
  }

  static Future<void> shareCryptoReceipt({
    required UnifiedTransaction transaction,
    Rect? sharePositionOrigin,
    ReceiptFileFormat format = ReceiptFileFormat.pdf,
  }) async {
    final file = await generateCryptoReceiptFile(
        transaction: transaction, format: format);
    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text:
          'LazerVault Crypto Receipt - ${transaction.title} (${transaction.transactionReference ?? transaction.id})',
      subject: 'LazerVault Crypto Receipt',
      sharePositionOrigin: _resolveShareOrigin(sharePositionOrigin),
    ));
  }

  static String _formatTransferStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'Completed';
      case 'pending':
      case 'processing':
        return 'Pending';
      case 'failed':
        return 'Failed';
      case 'scheduled':
        return 'Scheduled';
      default:
        return status;
    }
  }
}
