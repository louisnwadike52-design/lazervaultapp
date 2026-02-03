import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/tag_pay_entity.dart';
import '../domain/entities/user_tag_entity.dart';

class TagPayPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  // Cache for loaded fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Get currency symbol - using ASCII-safe alternatives for PDF compatibility
  static String _currencySymbolFor(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return 'NGN '; // Use code instead of symbol for PDF compatibility
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

  /// Load fonts that support unicode characters
  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;

    try {
      // Try loading Inter font from Google Fonts CDN
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));

      if (regularResponse.statusCode == 200 && boldResponse.statusCode == 200) {
        _regularFont = pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (e) {
      // Fallback to default fonts if loading fails
      _regularFont = null;
      _boldFont = null;
    }
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
    final amount = tag.amount.toStringAsFixed(2);

    // For outgoing tags: you are the tagger (sender), recipient is taggedUser
    // For incoming tags: tagger sent it to you (taggedUser)
    final senderName = isOutgoing ? tag.taggerName : tag.taggerName;
    final senderTag = isOutgoing ? tag.taggerTagPay : tag.taggerTagPay;
    final recipientName = isOutgoing ? tag.taggedUserName : tag.taggedUserName;
    final recipientTag = isOutgoing ? tag.taggedUserTagPay : tag.taggedUserTagPay;

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
                        pw.Text(
                            senderName.isNotEmpty ? senderName.toUpperCase() : 'LAZERVAULT USER',
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
                      status: tag.isPaid ? 'Paid' : (tag.isCancelled ? 'Cancelled' : 'Pending'),
                      type: 'TagPay Invoice',
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
    final fileName = 'tagpay_invoice_${tag.id.substring(0, 8)}_${DateTime.now().millisecondsSinceEpoch}.pdf';
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
    final amount = transaction.amount.toStringAsFixed(2);

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
                      type: 'TagPay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference: transaction.description ?? tag.description,
                tagPayReference: transaction.referenceNumber,
                transactionId: transaction.id,
              ),
              pw.SizedBox(height: 32),

              // Beneficiary Details
              _buildRecipientDetails(
                recipientName: transaction.receiverName.isNotEmpty
                    ? transaction.receiverName
                    : tag.taggerName,
                recipientTag: transaction.receiverTagPay.isNotEmpty
                    ? transaction.receiverTagPay
                    : tag.taggerTagPay,
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
    final fileName =
        'tagpay_receipt_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildInvoiceHeader(pw.MemoryImage? logo, String generatedDate,
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
                'LazerVault',
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
    final senderName = transaction.senderName.isNotEmpty
        ? transaction.senderName
        : tag.taggedUserName;
    final senderTag = transaction.senderTagPay.isNotEmpty
        ? transaction.senderTagPay
        : tag.taggedUserTagPay;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          senderName.isNotEmpty ? senderName.toUpperCase() : 'LAZERVAULT USER',
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
              if (tag.description.isNotEmpty)
                _buildDetailRow('Description', tag.description),
              _buildDetailRow('Tag ID', tag.id),
              _buildDetailRow('Created', _fullDateTimeFormat.format(tag.createdAt)),
              if (tag.paidAt != null)
                _buildDetailRow('Paid', _fullDateTimeFormat.format(tag.paidAt!)),
            ],
          ),
        ),
      ],
    );
  }

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
              _buildDetailRow('Fee', '${currencySymbol}0.00'),
              _buildDetailRow('Reference', reference),
              _buildDetailRow('TagPay Reference', tagPayReference),
              _buildDetailRow('Transaction Id', transactionId),
            ],
          ),
        ),
      ],
    );
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
              _buildDetailRow(
                'Name',
                recipientName.isNotEmpty ? recipientName : 'LazerVault User',
              ),
              if (recipientTag.isNotEmpty)
                _buildDetailRow('Tag', '@$recipientTag'),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter() {
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
                  '(C) ${DateTime.now().year} LazerVault Technologies Ltd',
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
            'LazerVault Technologies Ltd is a financial technology company. '
            'This document is a confirmation of a TagPay transfer processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Download the invoice to device storage
  static Future<String> downloadInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      final fileName = 'tagpay_invoice_${tag.id.substring(0, 8)}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download invoice: $e');
    }
  }

  /// Share the invoice via system share sheet
  static Future<void> shareInvoice({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file = await generateTagInvoice(tag: tag, isOutgoing: isOutgoing);
      final currencySymbol = _currencySymbolFor(tag.currency);
      final amount = tag.amount.toStringAsFixed(2);
      final recipientName = isOutgoing ? tag.taggedUserName : tag.taggerName;
      final recipientTag = isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'TagPay Invoice - $currencySymbol$amount ${isOutgoing ? "to" : "from"} ${recipientName.isNotEmpty ? recipientName : "@$recipientTag"}',
        subject: 'LazerVault TagPay Invoice',
      ));
    } catch (e) {
      throw Exception('Failed to share invoice: $e');
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

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      final fileName =
          'tagpay_receipt_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
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

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = transaction.amount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'TagPay Transfer Receipt - $currencySymbol$amount to @${transaction.receiverTagPay}',
        subject: 'LazerVault TagPay Transfer Confirmation',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
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
    final paidDate = tag.paidAt != null ? _dateFormat.format(tag.paidAt!) : _dateFormat.format(tag.createdAt);
    final currencySymbol = _currencySymbolFor(tag.currency);
    final amount = tag.amount.toStringAsFixed(2);

    // For a paid tag viewed by the tagged user (incoming), they paid the tagger
    // Sender = tagged user, Receiver = tagger
    final senderName = isOutgoing ? tag.taggerName : tag.taggedUserName;
    final senderTag = isOutgoing ? tag.taggerTagPay : tag.taggedUserTagPay;
    final recipientName = isOutgoing ? tag.taggedUserName : tag.taggerName;
    final recipientTag = isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;

    // Generate reference from tag ID
    final reference = 'TPTAG-${tag.id.length > 8 ? tag.id.substring(0, 8) : tag.id}';

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
                          senderName.isNotEmpty ? senderName.toUpperCase() : 'LAZERVAULT USER',
                          style: _getTextStyle(fontSize: 14, isBold: true),
                        ),
                        pw.SizedBox(height: 4),
                        if (senderTag.isNotEmpty)
                          pw.Text(
                            '@$senderTag',
                            style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
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
                      type: 'TagPay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference: tag.description.isNotEmpty ? tag.description : 'TagPay payment',
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
      final file = await generatePaidTagReceipt(tag: tag, isOutgoing: isOutgoing);

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      final reference = 'TPTAG-${tag.id.length > 8 ? tag.id.substring(0, 8) : tag.id}';
      final fileName = 'tagpay_receipt_$reference.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share receipt for a paid tag (without transaction entity)
  static Future<void> sharePaidTagReceipt({
    required UserTagEntity tag,
    required bool isOutgoing,
  }) async {
    try {
      final file = await generatePaidTagReceipt(tag: tag, isOutgoing: isOutgoing);

      final currencySymbol = _currencySymbolFor(tag.currency);
      final amount = tag.amount.toStringAsFixed(2);
      final recipientTag = isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay;

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'TagPay Receipt - $currencySymbol$amount ${isOutgoing ? "to" : "from"} @$recipientTag',
        subject: 'LazerVault TagPay Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
