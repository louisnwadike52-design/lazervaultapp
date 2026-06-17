import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/bill_payment_entity.dart';

class ElectricityBillPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final _currencyFormat = NumberFormat('#,##0.00');

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

  /// Generate a professional receipt PDF for an electricity bill payment
  static Future<File> generateReceipt({
    required BillPaymentEntity payment,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final paymentDate = _dateFormat.format(payment.createdAt);
    final completedDate = payment.completedAt != null
        ? _dateFormat.format(payment.completedAt!)
        : paymentDate;
    final currencySymbol = _currencySymbolFor(payment.currency);
    final receiptNumber = 'ELEC-${payment.referenceNumber.length > 12 ? payment.referenceNumber.substring(0, 12) : payment.referenceNumber}';

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

              // Customer Info and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildCustomerInfo(payment: payment),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      paymentDate: paymentDate,
                      completedDate: completedDate,
                      status: payment.status.displayName,
                      receiptNumber: receiptNumber,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Electricity Token (prominently displayed for prepaid)
              if (payment.hasToken)
                _buildTokenSection(token: payment.token!),
              if (payment.hasToken)
                pw.SizedBox(height: 32),

              // Payment Details
              _buildPaymentDetails(
                payment: payment,
                currencySymbol: currencySymbol,
              ),
              pw.SizedBox(height: 32),

              // Provider Details
              _buildProviderDetails(payment: payment),

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
        'electricity_receipt_${payment.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
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
              'Electricity Payment Receipt',
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

  static pw.Widget _buildCustomerInfo({
    required BillPaymentEntity payment,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          payment.customerName.isNotEmpty
              ? payment.customerName.toUpperCase()
              : 'CUSTOMER',
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Meter: ${payment.meterNumber}',
          style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          'Type: ${payment.meterType.displayName}',
          style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
        if (payment.customerAddress != null &&
            payment.customerAddress!.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          pw.Text(
            payment.customerAddress!,
            style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String paymentDate,
    required String completedDate,
    required String status,
    required String receiptNumber,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Receipt No.', receiptNumber),
        _buildSummaryRow('Payment Date', paymentDate),
        _buildSummaryRow('Completed', completedDate),
        _buildSummaryRow('Status', status),
        _buildSummaryRow('Type', 'Electricity Bill Payment'),
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

  /// Build the prominent electricity token section
  static pw.Widget _buildTokenSection({required String token}) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFF1F1F1F),
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(
          color: const PdfColor.fromInt(0xFF3B82F6),
          width: 2,
        ),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'ELECTRICITY TOKEN',
            style: _getTextStyle(
              fontSize: 12,
              isBold: true,
              color: const PdfColor.fromInt(0xFF3B82F6),
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            token,
            style: _getTextStyle(fontSize: 24, isBold: true)
                .copyWith(color: PdfColors.white, letterSpacing: 2),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Enter this token on your meter to load your units',
            style: _getTextStyle(
              fontSize: 10,
              color: const PdfColor.fromInt(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentDetails({
    required BillPaymentEntity payment,
    required String currencySymbol,
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
              _buildDetailRow(
                'Amount',
                '$currencySymbol${_currencyFormat.format(payment.amount)}',
                isBold: true,
              ),
              _buildDetailRow(
                'Service Fee',
                '$currencySymbol${_currencyFormat.format(payment.serviceFee)}',
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Divider(color: PdfColors.grey300, thickness: 0.5),
              ),
              _buildDetailRow(
                'Total Amount',
                '$currencySymbol${_currencyFormat.format(payment.totalAmount)}',
                isBold: true,
              ),
              _buildDetailRow(
                'Currency',
                _currencyNameFor(payment.currency),
              ),
              if (payment.units != null)
                _buildDetailRow(
                  'Units',
                  '${payment.units!.toStringAsFixed(2)} kWh',
                ),
              _buildDetailRow(
                'Reference',
                payment.referenceNumber,
              ),
              if (payment.gatewayReference != null &&
                  payment.gatewayReference!.isNotEmpty)
                _buildDetailRow(
                  'Gateway Reference',
                  payment.gatewayReference!,
                ),
              _buildDetailRow(
                'Payment Date',
                _fullDateTimeFormat.format(payment.createdAt),
              ),
              if (payment.completedAt != null)
                _buildDetailRow(
                  'Completed',
                  _fullDateTimeFormat.format(payment.completedAt!),
                ),
              _buildDetailRow(
                'Status',
                payment.status.displayName,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildProviderDetails({
    required BillPaymentEntity payment,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Provider Details',
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
                'Provider',
                payment.providerName,
              ),
              _buildDetailRow(
                'Provider Code',
                payment.providerCode,
              ),
              _buildDetailRow(
                'Meter Number',
                payment.meterNumber,
              ),
              _buildDetailRow(
                'Meter Type',
                payment.meterType.displayName,
              ),
              _buildDetailRow(
                'Customer Name',
                payment.customerName,
              ),
              if (payment.customerAddress != null &&
                  payment.customerAddress!.isNotEmpty)
                _buildDetailRow(
                  'Address',
                  payment.customerAddress!,
                ),
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
            'This document is a confirmation of an electricity bill payment processed through the LazerVault platform. '
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
    required BillPaymentEntity payment,
  }) async {
    try {
      final file = await generateReceipt(payment: payment);

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
          'electricity_receipt_${payment.referenceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
    required BillPaymentEntity payment,
  }) async {
    try {
      final file = await generateReceipt(payment: payment);

      final currencySymbol = _currencySymbolFor(payment.currency);
      final amount = _currencyFormat.format(payment.totalAmount);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Electricity Payment Receipt - $currencySymbol$amount to ${payment.providerName} (Meter: ${payment.meterNumber})',
        subject: 'LazerVault Electricity Payment Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
