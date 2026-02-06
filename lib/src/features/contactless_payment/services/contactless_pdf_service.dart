import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/contactless_payment_entity.dart';

class ContactlessPdfService {
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

  /// Load fonts that support unicode characters
  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;

    try {
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));

      if (regularResponse.statusCode == 200 && boldResponse.statusCode == 200) {
        _regularFont = pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (e) {
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

  /// Generate a professional receipt PDF for a completed contactless payment
  /// For the payer (sender)
  static Future<File> generatePayerReceipt({
    required ContactlessTransactionEntity transaction,
    String? payerAccountNumber,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
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
              _buildHeader(logo, generatedDate, isPayer: true),
              pw.SizedBox(height: 24),

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildSenderInfo(
                      transaction: transaction,
                      accountNumber: payerAccountNumber,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      transactionDate: transactionDate,
                      status: 'Completed',
                      type: 'Contactless Payment',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Payment Details
              _buildPaymentDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                transaction: transaction,
              ),
              pw.SizedBox(height: 32),

              // Beneficiary Details
              _buildRecipientDetails(
                recipientName: transaction.receiverName.isNotEmpty
                    ? transaction.receiverName
                    : transaction.receiverUsername,
                recipientTag: transaction.receiverUsername,
                title: 'Payment Sent To',
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
        'contactless_payer_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate a professional receipt PDF for a completed contactless payment
  /// For the receiver (recipient)
  static Future<File> generateReceiverReceipt({
    required ContactlessTransactionEntity transaction,
    String? receiverAccountNumber,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
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
              _buildHeader(logo, generatedDate, isPayer: false),
              pw.SizedBox(height: 24),

              // Payer and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildPayerInfo(
                      transaction: transaction,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      transactionDate: transactionDate,
                      status: 'Completed',
                      type: 'Contactless Payment',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Payment Details
              _buildPaymentDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                transaction: transaction,
              ),
              pw.SizedBox(height: 32),

              // Your Account Details
              if (receiverAccountNumber != null && receiverAccountNumber.isNotEmpty)
                _buildAccountDetails(
                  accountNumber: receiverAccountNumber,
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
        'contactless_receiver_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(pw.MemoryImage? logo, String generatedDate,
      {required bool isPayer}) {
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
            pw.SizedBox(height: 8),
            pw.Text(
              'NFC Contactless Payment',
              style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              isPayer ? 'Payment Receipt' : 'Payment Received',
              style: _getTextStyle(fontSize: 20, isBold: true)
                  .copyWith(color: PdfColors.grey800),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Generated on $generatedDate',
              style: _getTextStyle(fontSize: 11, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSenderInfo({
    required ContactlessTransactionEntity transaction,
    String? accountNumber,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PAYMENT FROM',
          style: _getTextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          transaction.payerName.isNotEmpty
              ? transaction.payerName.toUpperCase()
              : 'LAZERVAULT USER',
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          '@${transaction.payerUsername}',
          style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        if (accountNumber != null && accountNumber.isNotEmpty) ...[
          pw.SizedBox(height: 16),
          pw.Text(
            'Account Number',
            style: _getTextStyle(fontSize: 11, isBold: true),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            accountNumber,
            style: _getTextStyle(fontSize: 11),
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildPayerInfo({
    required ContactlessTransactionEntity transaction,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RECEIVED FROM',
          style: _getTextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          transaction.payerName.isNotEmpty
              ? transaction.payerName.toUpperCase()
              : 'LAZERVAULT USER',
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          '@${transaction.payerUsername}',
          style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String transactionDate,
    required String status,
    required String type,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Value Date', transactionDate),
        _buildSummaryRow('Operation Date', transactionDate),
        _buildSummaryRow('Date available', transactionDate),
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

  static pw.Widget _buildPaymentDetails({
    required String currencySymbol,
    required String amount,
    required ContactlessTransactionEntity transaction,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Payment Details',
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
              _buildDetailRow('Currency', _currencyNameFor(transaction.currency)),
              _buildDetailRow('Fee', '${currencySymbol}0.00'),
              if (transaction.description != null &&
                  transaction.description!.isNotEmpty)
                _buildDetailRow('Description', transaction.description!),
              if (transaction.category != null &&
                  transaction.category!.isNotEmpty)
                _buildDetailRow('Category', transaction.category!),
              _buildDetailRow('Reference', transaction.referenceNumber),
              _buildDetailRow(
                  'Transaction ID', transaction.id.substring(0, 8).toUpperCase()),
              _buildDetailRow(
                  'Date/Time', _fullDateTimeFormat.format(transaction.createdAt)),
              _buildDetailRow('Method', 'NFC Contactless'),
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
              _buildDetailRow('Username', '@$recipientTag'),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildAccountDetails({
    required String accountNumber,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Credited To',
          style: _getTextStyle(fontSize: 16, isBold: true),
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: PdfColors.green50,
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.green200),
          ),
          child: pw.Column(
            children: [
              _buildDetailRow('Account Number', accountNumber),
              _buildDetailRow('Status', 'Credited'),
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
            'This document is a confirmation of a Contactless NFC payment processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Download the payer's receipt to device storage
  static Future<String> downloadPayerReceipt({
    required ContactlessTransactionEntity transaction,
    String? accountNumber,
  }) async {
    try {
      final file = await generatePayerReceipt(
        transaction: transaction,
        payerAccountNumber: accountNumber,
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
          'contactless_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Download the receiver's receipt to device storage
  static Future<String> downloadReceiverReceipt({
    required ContactlessTransactionEntity transaction,
    String? accountNumber,
  }) async {
    try {
      final file = await generateReceiverReceipt(
        transaction: transaction,
        receiverAccountNumber: accountNumber,
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
          'contactless_received_${transaction.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the payer's receipt via system share sheet
  static Future<void> sharePayerReceipt({
    required ContactlessTransactionEntity transaction,
    String? accountNumber,
  }) async {
    try {
      final file = await generatePayerReceipt(
        transaction: transaction,
        payerAccountNumber: accountNumber,
      );

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = transaction.amount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Contactless Payment Receipt - $currencySymbol$amount to @${transaction.receiverUsername}',
        subject: 'LazerVault Contactless Payment Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Share the receiver's receipt via system share sheet
  static Future<void> shareReceiverReceipt({
    required ContactlessTransactionEntity transaction,
    String? accountNumber,
  }) async {
    try {
      final file = await generateReceiverReceipt(
        transaction: transaction,
        receiverAccountNumber: accountNumber,
      );

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = transaction.amount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Contactless Payment Received - $currencySymbol$amount from @${transaction.payerUsername}',
        subject: 'LazerVault Contactless Payment Received',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
