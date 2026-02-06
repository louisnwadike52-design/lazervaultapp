import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/types/unified_transaction.dart';

/// Professional transfer receipt PDF service with bank-grade styling
/// Generates downloadable and shareable PDF receipts for fund transfers
class TransferPdfService {
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
      case 'CAD':
        return 'Canadian Dollar';
      case 'AUD':
        return 'Australian Dollar';
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

  /// Generate a professional transfer receipt PDF
  static Future<File> generateTransferReceipt({
    required UnifiedTransaction transaction,
    String? senderName,
    String? senderAccountNumber,
    String? senderBankName,
    String? recipientName,
    String? recipientAccountNumber,
    String? recipientBankName,
    double? fee,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = transaction.amount.toStringAsFixed(2);

    // Extract metadata
    final metadata = transaction.metadata ?? {};
    final actualRecipientName = recipientName ??
        metadata['Recipient']?.toString() ??
        metadata['recipientName']?.toString() ??
        'Recipient';
    final actualRecipientAccount = recipientAccountNumber ??
        metadata['Recipient Account']?.toString() ??
        metadata['recipientAccount']?.toString();
    final actualRecipientBank = recipientBankName ??
        metadata['recipientBank']?.toString();
    final actualSenderName = senderName ?? 'LazerVault User';
    final actualSenderAccount = senderAccountNumber ??
        metadata['Source Account']?.toString();
    final actualSenderBank = senderBankName ??
        metadata['senderBank']?.toString();
    final transferType = metadata['Transfer Type']?.toString() ??
        metadata['transferType']?.toString() ??
        'Fund Transfer';
    final network = metadata['Network']?.toString() ??
        metadata['network']?.toString() ??
        'LazerVault';
    final narration = transaction.description ??
        metadata['Narration']?.toString() ??
        'Transfer';
    final actualFee = fee ??
        double.tryParse(metadata['Fee']?.toString().replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ??
        0.0;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with Logo
              _buildHeader(logo, generatedDate),
              pw.SizedBox(height: 24),

              // Sender and Transaction Summary side by side
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildSenderInfo(
                      senderName: actualSenderName,
                      accountNumber: actualSenderAccount,
                      bankName: actualSenderBank,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      transactionDate: transactionDate,
                      status: transaction.status.displayName,
                      type: transferType,
                      network: network,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                fee: actualFee,
                narration: narration,
                reference: transaction.transactionReference ?? transaction.id,
                transactionId: transaction.id,
                currency: transaction.currency,
              ),
              pw.SizedBox(height: 32),

              // Beneficiary Details
              _buildBeneficiaryDetails(
                recipientName: actualRecipientName,
                accountNumber: actualRecipientAccount,
                bankName: actualRecipientBank,
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
    final safeRef = (transaction.transactionReference ?? transaction.id)
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName = 'transfer_receipt_$safeRef.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(pw.MemoryImage? logo, String generatedDate) {
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
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'LazerVault',
                    style: _getTextStyle(fontSize: 28, isBold: true)
                        .copyWith(color: PdfColors.blue800),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue50,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      'FINANCIAL SERVICES',
                      style: _getTextStyle(fontSize: 8, isBold: true)
                          .copyWith(color: PdfColors.blue800, letterSpacing: 1),
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
              'Transfer Receipt',
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
    required String senderName,
    String? accountNumber,
    String? bankName,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('FROM',
            style: _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.SizedBox(height: 4),
        pw.Text(
          senderName.toUpperCase(),
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        if (accountNumber != null && accountNumber.isNotEmpty) ...[
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              pw.Text(
                'Account',
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
        if (bankName != null && bankName.isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Row(
            children: [
              pw.Text(
                'Bank',
                style: _getTextStyle(fontSize: 11, isBold: true),
              ),
              pw.SizedBox(width: 12),
              pw.Text(
                bankName,
                style: _getTextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String transactionDate,
    required String status,
    required String type,
    required String network,
  }) {
    final statusColor = status.toLowerCase() == 'completed'
        ? PdfColors.green700
        : status.toLowerCase() == 'pending'
            ? PdfColors.orange700
            : PdfColors.grey700;

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Column(
        children: [
          _buildSummaryRow('Value Date', transactionDate),
          _buildSummaryRow('Operation Date', transactionDate),
          pw.Container(
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
                  'Status',
                  style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: pw.BoxDecoration(
                    color: statusColor.shade(50),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    status,
                    style: _getTextStyle(fontSize: 10, isBold: true)
                        .copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
          ),
          _buildSummaryRow('Type', type),
          _buildSummaryRow('Network', network),
        ],
      ),
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

  static pw.Widget _buildTransferDetails({
    required String currencySymbol,
    required String amount,
    required double fee,
    required String narration,
    required String reference,
    required String transactionId,
    required String currency,
  }) {
    final total = double.parse(amount) + fee;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transfer Details',
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
              _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true, isHighlight: true),
              _buildDetailRow('Fee', '$currencySymbol${fee.toStringAsFixed(2)}'),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 8),
                child: pw.Divider(color: PdfColors.grey300, height: 1),
              ),
              _buildDetailRow('Total', '$currencySymbol${total.toStringAsFixed(2)}', isBold: true),
              pw.SizedBox(height: 8),
              _buildDetailRow('Currency', _currencyNameFor(currency)),
              _buildDetailRow('Narration', narration),
              _buildDetailRow('Reference', reference, isSmall: true),
              _buildDetailRow('Transaction ID', transactionId, isSmall: true),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value, {bool isBold = false, bool isSmall = false, bool isHighlight = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(
              label,
              style: _getTextStyle(fontSize: isSmall ? 10 : 11, isBold: true)
                  .copyWith(color: PdfColors.grey700),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: _getTextStyle(
                fontSize: isHighlight ? 14 : (isSmall ? 10 : 11),
                isBold: isBold,
              ).copyWith(color: isHighlight ? PdfColors.blue800 : null),
              textAlign: pw.TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildBeneficiaryDetails({
    required String recipientName,
    String? accountNumber,
    String? bankName,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Beneficiary Details',
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
              _buildDetailRow('Name', recipientName, isBold: true),
              if (accountNumber != null && accountNumber.isNotEmpty)
                _buildDetailRow('Account Number', accountNumber),
              if (bankName != null && bankName.isNotEmpty)
                _buildDetailRow('Bank', bankName),
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
                  'Get help directly in-app or email support@lazervault.com',
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
            'LazerVault Technologies Ltd is a licensed financial technology company. '
            'This document is a confirmation of a transfer processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app or visit www.lazervault.com.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Download the transfer receipt to device storage
  static Future<String> downloadReceipt({
    required UnifiedTransaction transaction,
    String? senderName,
    String? senderAccountNumber,
    String? senderBankName,
    String? recipientName,
    String? recipientAccountNumber,
    String? recipientBankName,
    double? fee,
  }) async {
    try {
      final file = await generateTransferReceipt(
        transaction: transaction,
        senderName: senderName,
        senderAccountNumber: senderAccountNumber,
        senderBankName: senderBankName,
        recipientName: recipientName,
        recipientAccountNumber: recipientAccountNumber,
        recipientBankName: recipientBankName,
        fee: fee,
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

      final safeRef = (transaction.transactionReference ?? transaction.id)
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName = 'transfer_receipt_$safeRef.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download transfer receipt: $e');
    }
  }

  /// Share the transfer receipt via system share sheet
  static Future<void> shareReceipt({
    required UnifiedTransaction transaction,
    String? senderName,
    String? senderAccountNumber,
    String? senderBankName,
    String? recipientName,
    String? recipientAccountNumber,
    String? recipientBankName,
    double? fee,
  }) async {
    try {
      final file = await generateTransferReceipt(
        transaction: transaction,
        senderName: senderName,
        senderAccountNumber: senderAccountNumber,
        senderBankName: senderBankName,
        recipientName: recipientName,
        recipientAccountNumber: recipientAccountNumber,
        recipientBankName: recipientBankName,
        fee: fee,
      );

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = transaction.amount.toStringAsFixed(2);
      final recipient = recipientName ??
          transaction.metadata?['Recipient']?.toString() ??
          'Recipient';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'LazerVault Transfer Receipt - $currencySymbol$amount to $recipient',
        subject: 'LazerVault Transfer Receipt - ${transaction.transactionReference ?? transaction.id}',
      ));
    } catch (e) {
      throw Exception('Failed to share transfer receipt: $e');
    }
  }

  /// Generate PDF from map-based transfer details (for TransferReceiptScreen)
  static Future<File> _generateFromMap({
    required Map<String, dynamic> transferDetails,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbolFor(currency);
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;

    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final recipientAccount = transferDetails['recipientAccountMasked'] as String?;
    final recipientBank = transferDetails['recipientBankName'] as String?;
    final sourceAccountName = transferDetails['sourceAccountName'] as String?;
    final sourceAccountInfo = transferDetails['sourceAccountInfo'] as String?;
    final reference = transferDetails['reference'] as String? ?? '';
    final narration = transferDetails['narration'] as String?;
    final status = transferDetails['status'] as String? ?? 'completed';
    final transferType = transferDetails['transferType'] as String? ?? 'Fund Transfer';
    final network = transferDetails['network'] as String?;
    final transferId = transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ?? '';

    DateTime? timestamp;
    if (transferDetails['timestamp'] != null) {
      timestamp = transferDetails['timestamp'] as DateTime?;
    } else if (transferDetails['createdAt'] != null) {
      timestamp = transferDetails['createdAt'] as DateTime?;
    }
    timestamp ??= DateTime.now();
    final transactionDate = _dateFormat.format(timestamp);

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

              // Sender and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildSenderInfo(
                      senderName: sourceAccountName ?? 'LazerVault User',
                      accountNumber: sourceAccountInfo,
                      bankName: null,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      transactionDate: transactionDate,
                      status: _formatStatusForPdf(status),
                      type: transferType,
                      network: network ?? 'LazerVault',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer Details
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount.toStringAsFixed(2),
                fee: fee,
                narration: narration ?? 'Fund Transfer',
                reference: reference.isNotEmpty ? reference : transferId,
                transactionId: transferId,
                currency: currency,
              ),
              pw.SizedBox(height: 32),

              // Beneficiary Details
              _buildBeneficiaryDetails(
                recipientName: recipientName,
                accountNumber: recipientAccount,
                bankName: recipientBank,
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

  static String _formatStatusForPdf(String status) {
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

  /// Download receipt from map-based transfer details
  static Future<String> downloadReceiptFromMap({
    required Map<String, dynamic> transferDetails,
  }) async {
    try {
      final file = await _generateFromMap(transferDetails: transferDetails);

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

      final reference = transferDetails['reference'] as String? ?? '';
      final transferId = transferDetails['transferId']?.toString() ??
          transferDetails['transactionId']?.toString() ?? '';
      final safeRef = reference.isNotEmpty
          ? reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          : transferId.isNotEmpty
              ? transferId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
              : 'transfer';
      final fileName = 'transfer_receipt_$safeRef.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download transfer receipt: $e');
    }
  }

  /// Share receipt from map-based transfer details
  static Future<void> shareReceiptFromMap({
    required Map<String, dynamic> transferDetails,
  }) async {
    try {
      final file = await _generateFromMap(transferDetails: transferDetails);

      final currency = transferDetails['currency'] as String? ?? 'NGN';
      final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
      final currencySymbol = _currencySymbolFor(currency);
      final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'LazerVault Transfer Receipt - $currencySymbol${amount.toStringAsFixed(2)} to $recipientName',
        subject: 'LazerVault Transfer Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share transfer receipt: $e');
    }
  }
}
