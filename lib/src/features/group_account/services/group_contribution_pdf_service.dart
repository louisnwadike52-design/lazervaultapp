import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/group_entities.dart';

class GroupContributionPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');

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
      case 'GHS':
        return 'GHS ';
      case 'KES':
        return 'KES ';
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
      case 'GHS':
        return 'Ghanaian Cedi';
      case 'KES':
        return 'Kenyan Shilling';
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

  /// Generate a professional receipt PDF for a contribution payment
  static Future<File> generateContributionReceipt({
    required Contribution contribution,
    required ContributionPayment payment,
    required String paymentMethod,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final paymentDate = _dateFormat.format(payment.paymentDate);
    final currencySymbol = _currencySymbolFor(payment.currency);
    final amount = payment.amount.toStringAsFixed(2);

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

              // Payer and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildPayerInfo(payment: payment),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      paymentDate: paymentDate,
                      status: 'Completed',
                      type: 'Group Contribution',
                      paymentMethod: _formatPaymentMethod(paymentMethod),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Payment Details
              _buildPaymentDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                transactionId: payment.transactionId ?? 'N/A',
                notes: payment.notes,
                currency: payment.currency,
              ),
              pw.SizedBox(height: 32),

              // Contribution Details
              _buildContributionDetails(
                contribution: contribution,
                payment: payment,
                currencySymbol: currencySymbol,
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
    final sanitizedId = (payment.transactionId ?? payment.id).replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName = 'contribution_receipt_$sanitizedId.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static String _formatPaymentMethod(String method) {
    switch (method.toLowerCase()) {
      case 'bank_transfer':
        return 'Bank Transfer';
      case 'card':
        return 'Debit/Credit Card';
      case 'mobile_money':
        return 'Mobile Money';
      case 'crypto':
        return 'Cryptocurrency';
      default:
        return method;
    }
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
              pw.Text(
                'LazerVault',
                style: _getTextStyle(fontSize: 28, isBold: true)
                    .copyWith(color: PdfColors.indigo800),
              ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Payment Receipt',
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

  static pw.Widget _buildPayerInfo({required ContributionPayment payment}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'FROM',
          style: _getTextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          payment.userName.isNotEmpty ? payment.userName.toUpperCase() : 'LAZERVAULT USER',
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'User ID: ${_truncateId(payment.userId)}',
          style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
      ],
    );
  }

  static String _truncateId(String id) {
    if (id.length > 12) {
      return '${id.substring(0, 8)}...${id.substring(id.length - 4)}';
    }
    return id;
  }

  static pw.Widget _buildSummaryTable({
    required String paymentDate,
    required String status,
    required String type,
    required String paymentMethod,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Payment Date', paymentDate),
        _buildSummaryRow('Status', status),
        _buildSummaryRow('Type', type),
        _buildSummaryRow('Method', paymentMethod),
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
    required String transactionId,
    String? notes,
    required String currency,
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
              _buildDetailRow('Amount Paid', '$currencySymbol$amount', isBold: true),
              _buildDetailRow('Currency', _currencyNameFor(currency)),
              _buildDetailRow('Transaction ID', transactionId),
              if (notes != null && notes.isNotEmpty)
                _buildDetailRow('Notes', notes),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildContributionDetails({
    required Contribution contribution,
    required ContributionPayment payment,
    required String currencySymbol,
  }) {
    final newTotal = contribution.currentAmount + payment.amount;
    final remaining = contribution.targetAmount - newTotal;
    final progress = ((newTotal / contribution.targetAmount) * 100).clamp(0.0, 100.0);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Contribution Details',
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
              _buildDetailRow('Contribution Name', contribution.title),
              if (contribution.description.isNotEmpty)
                _buildDetailRow('Description', contribution.description),
              _buildDetailRow('Target Amount', '$currencySymbol${contribution.targetAmount.toStringAsFixed(2)}'),
              _buildDetailRow('New Total', '$currencySymbol${newTotal.toStringAsFixed(2)}'),
              _buildDetailRow('Remaining', '$currencySymbol${remaining.toStringAsFixed(2)}'),
              _buildDetailRow('Progress', '${progress.toStringAsFixed(0)}%'),
              _buildDetailRow('Deadline', _displayDateFormat.format(contribution.deadline)),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
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
            'This document is a confirmation of a group contribution payment processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Download the receipt to device storage
  static Future<String> downloadReceipt({
    required Contribution contribution,
    required ContributionPayment payment,
    required String paymentMethod,
  }) async {
    try {
      final file = await generateContributionReceipt(
        contribution: contribution,
        payment: payment,
        paymentMethod: paymentMethod,
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

      final sanitizedId = (payment.transactionId ?? payment.id).replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName = 'contribution_receipt_$sanitizedId.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
    required Contribution contribution,
    required ContributionPayment payment,
    required String paymentMethod,
  }) async {
    try {
      final file = await generateContributionReceipt(
        contribution: contribution,
        payment: payment,
        paymentMethod: paymentMethod,
      );

      final currencySymbol = _currencySymbolFor(payment.currency);
      final amount = payment.amount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: 'Contribution Payment Receipt - $currencySymbol$amount to ${contribution.title}',
        subject: 'LazerVault Group Contribution Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
