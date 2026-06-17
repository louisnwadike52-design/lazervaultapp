import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/airtime_transaction.dart';
import '../domain/entities/network_provider.dart';

class AirtimePdfService {
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

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
      case 'KES':
        return 'KES ';
      case 'GHS':
        return 'GHS ';
      case 'INR':
        return 'INR ';
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

  static Future<File> generateReceipt({
    required AirtimeTransaction transaction,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = transaction.amount.toStringAsFixed(2);
    final isSuccess = transaction.status == AirtimeTransactionStatus.completed;

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
                      : const PdfColor.fromInt(0xFFFEE2E2),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Center(
                  child: pw.Text(
                    isSuccess ? 'PAYMENT SUCCESSFUL' : 'PAYMENT FAILED',
                    style: _getTextStyle(
                      fontSize: 14,
                      isBold: true,
                      color: isSuccess
                          ? const PdfColor.fromInt(0xFF166534)
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
              _buildDetailRow('Network Provider', transaction.networkProvider.displayName),
              _buildDetailRow('Phone Number', transaction.displayRecipientNumber),
              if (transaction.recipientName != null && transaction.recipientName!.isNotEmpty)
                _buildDetailRow('Recipient', transaction.recipientName!),
              _buildDetailRow('Status', transaction.status.displayName),
              _buildDetailRow('Date', _fullDateTimeFormat.format(transaction.createdAt)),
              if (transaction.completedAt != null)
                _buildDetailRow('Completed', _fullDateTimeFormat.format(transaction.completedAt!)),

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
                  _buildDetailRow('Service Fee', '$currencySymbol${transaction.fee!.toStringAsFixed(2)}'),
                if (transaction.discount != null && transaction.discount! > 0)
                  _buildDetailRow('Discount', '-$currencySymbol${transaction.discount!.toStringAsFixed(2)}'),
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
                      'Thank you for using LazerVault',
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
    final file = File('${dir.path}/airtime_receipt_${transaction.transactionReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf');
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
                  'LazerVault',
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

  static pw.Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
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
          'airtime_receipt_${transaction.transactionReference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
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
        files: [XFile(file.path)],
        text:
            'Airtime Purchase Receipt - $currencySymbol$amount to ${transaction.displayRecipientNumber}',
        subject: 'LazerVault Airtime Purchase Receipt',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }
}
