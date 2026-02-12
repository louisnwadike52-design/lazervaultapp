import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/education_purchase_entity.dart';
import '../domain/entities/education_provider_entity.dart';

class EducationPdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final _currencyFormat = NumberFormat('#,##0.00');

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

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

  /// Generate a professional receipt PDF for an education PIN purchase
  static Future<File> generateReceipt({
    required EducationPurchaseEntity purchase,
    EducationProviderEntity? provider,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final receiptNumber =
        'EDU-${purchase.reference.length > 12 ? purchase.reference.substring(0, 12) : purchase.reference}';

    String paymentDate;
    try {
      paymentDate = _fullDateTimeFormat.format(DateTime.parse(purchase.createdAt));
    } catch (_) {
      paymentDate = purchase.createdAt;
    }

    final providerName = provider?.name ?? purchase.billType;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(logo, generatedDate),
              pw.SizedBox(height: 24),

              // Customer Info and Summary
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildCustomerInfo(
                      providerName: providerName,
                      phone: purchase.customerNumber,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      paymentDate: paymentDate,
                      status: purchase.isCompleted ? 'Completed' : 'Pending',
                      receiptNumber: receiptNumber,
                      quantity: purchase.pins.length,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // PINs Section
              if (purchase.pins.isNotEmpty)
                _buildPinsSection(purchase: purchase),
              if (purchase.pins.isNotEmpty)
                pw.SizedBox(height: 32),

              // Payment Details
              _buildPaymentDetails(
                purchase: purchase,
                provider: provider,
              ),

              pw.Spacer(),

              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'education_receipt_${purchase.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
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
              'Education PIN Purchase Receipt',
              style: _getTextStyle(fontSize: 22, isBold: true)
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
    required String providerName,
    required String phone,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          providerName.toUpperCase(),
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        if (phone.isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            'Phone: $phone',
            style: _getTextStyle(fontSize: 12, color: PdfColors.grey700),
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String paymentDate,
    required String status,
    required String receiptNumber,
    required int quantity,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Receipt No.', receiptNumber),
        _buildSummaryRow('Payment Date', paymentDate),
        _buildSummaryRow('Quantity', '$quantity ${quantity == 1 ? 'PIN' : 'PINs'}'),
        _buildSummaryRow('Status', status),
        _buildSummaryRow('Type', 'Education PIN Purchase'),
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

  /// Build the PINs section with each PIN prominently displayed
  static pw.Widget _buildPinsSection({
    required EducationPurchaseEntity purchase,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Generated PINs',
          style: _getTextStyle(fontSize: 16, isBold: true),
        ),
        pw.SizedBox(height: 12),
        ...purchase.pins.asMap().entries.map((entry) {
          final index = entry.key;
          final pin = entry.value;
          return pw.Container(
            width: double.infinity,
            margin: const pw.EdgeInsets.only(bottom: 10),
            padding: const pw.EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: pw.BoxDecoration(
              color: const PdfColor.fromInt(0xFF1F1F1F),
              borderRadius: pw.BorderRadius.circular(10),
              border: pw.Border.all(
                color: const PdfColor.fromInt(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            child: pw.Column(
              children: [
                pw.Text(
                  'PIN ${index + 1}',
                  style: _getTextStyle(
                    fontSize: 10,
                    isBold: true,
                    color: const PdfColor.fromInt(0xFF3B82F6),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  pin.pin,
                  style: _getTextStyle(fontSize: 20, isBold: true)
                      .copyWith(color: PdfColors.white, letterSpacing: 2),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 6),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Serial: ${pin.serial}',
                      style: _getTextStyle(
                        fontSize: 9,
                        color: const PdfColor.fromInt(0xFF9CA3AF),
                      ),
                    ),
                    pw.Text(
                      'Expires: ${pin.expiresAt}',
                      style: _getTextStyle(
                        fontSize: 9,
                        color: const PdfColor.fromInt(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  static pw.Widget _buildPaymentDetails({
    required EducationPurchaseEntity purchase,
    EducationProviderEntity? provider,
  }) {
    final unitPrice = provider != null
        ? 'NGN ${_currencyFormat.format(provider.amount)}'
        : null;

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
              if (unitPrice != null)
                _buildDetailRow('Unit Price', unitPrice),
              _buildDetailRow(
                'Quantity',
                '${purchase.pins.length} ${purchase.pins.length == 1 ? 'PIN' : 'PINs'}',
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Divider(color: PdfColors.grey300, thickness: 0.5),
              ),
              _buildDetailRow(
                'Total Amount',
                'NGN ${_currencyFormat.format(purchase.amount)}',
                isBold: true,
              ),
              _buildDetailRow(
                'Reference',
                purchase.reference,
              ),
              _buildDetailRow(
                'Provider',
                provider?.name ?? purchase.billType,
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
            'This document is a confirmation of an education PIN purchase processed through the LazerVault platform. '
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
    required EducationPurchaseEntity purchase,
    EducationProviderEntity? provider,
  }) async {
    try {
      final file = await generateReceipt(purchase: purchase, provider: provider);

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
          'education_receipt_${purchase.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share the receipt via system share sheet
  static Future<void> shareReceipt({
    required EducationPurchaseEntity purchase,
    EducationProviderEntity? provider,
  }) async {
    try {
      final file = await generateReceipt(purchase: purchase, provider: provider);

      final amount = _currencyFormat.format(purchase.amount);
      final providerName = provider?.name ?? purchase.billType;

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'Education PIN Purchase Receipt - NGN $amount for $providerName (${purchase.pins.length} PINs)',
        subject: 'LazerVault Education PIN Purchase Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
