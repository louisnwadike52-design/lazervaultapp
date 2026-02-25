import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';

/// PDF service for Wallet Transfer receipts
/// Generates professional PDF receipts for internal LazerVault wallet transfers
class WalletTransferPdfService {
  static final _dateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  // Cache for loaded fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

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

  /// Load logo from assets
  static Future<pw.MemoryImage?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
    }
  }

  /// Format amount in Naira (or other currency)
  static String _formatCurrency(double amount, String currency) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return '$currency ${formatter.format(amount)}';
  }

  /// Get status color for PDF
  static PdfColor _getStatusColor(String? status) {
    if (status == null) return PdfColors.blue600;

    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'completed' || lowerStatus == 'success') {
      return PdfColors.green600;
    } else if (lowerStatus == 'failed' || lowerStatus == 'error') {
      return PdfColors.red600;
    }
    return PdfColors.blue600;
  }

  /// Get status display text
  static String _getStatusText(String? status) {
    if (status == null) return 'Processing';

    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'completed' || lowerStatus == 'success') {
      return 'Completed';
    } else if (lowerStatus == 'failed' || lowerStatus == 'error') {
      return 'Failed';
    } else if (lowerStatus == 'pending') {
      return 'Pending';
    } else if (lowerStatus == 'scheduled') {
      return 'Scheduled';
    }
    return 'Processing';
  }

  /// Generate PDF receipt for a Wallet Transfer
  static Future<Uint8List> generateReceipt({
    required PaymentsTransferResult transfer,
    required String userName,
    required String sourceAccountName,
    required String destinationAccountName,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _dateFormat.format(DateTime.now());
    final statusColor = _getStatusColor(transfer.status);
    final statusText = _getStatusText(transfer.status);
    final amount = transfer.amount != null
        ? transfer.amount! / 100.0
        : 0.0;
    final currency = 'NGN'; // Default, could be passed as parameter if needed

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

              // Status and Amount
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Wallet Transfer Receipt',
                          style: _getTextStyle(fontSize: 22, isBold: true)
                              .copyWith(color: PdfColors.grey800),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          statusText,
                          style: _getTextStyle(
                            fontSize: 14,
                            isBold: true,
                            color: statusColor,
                          ),
                        ),
                        // Free transfer badge
                        pw.SizedBox(height: 8),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.green50,
                            borderRadius: pw.BorderRadius.circular(12),
                            border: pw.Border.all(color: PdfColors.green200),
                          ),
                          child: pw.Text(
                            'FREE TRANSFER',
                            style: _getTextStyle(
                              fontSize: 10,
                              isBold: true,
                              color: PdfColors.green700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          _formatCurrency(amount, currency),
                          style: _getTextStyle(fontSize: 28, isBold: true),
                        ),
                        if (transfer.newBalance != null) ...[
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'New Balance: ${_formatCurrency(transfer.newBalance!, currency)}',
                            style: _getTextStyle(
                              fontSize: 11,
                              color: PdfColors.grey600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Account Details
              pw.Text(
                'Accounts',
                style: _getTextStyle(fontSize: 14, isBold: true),
              ),
              pw.SizedBox(height: 12),
              _buildAccountRow('From', sourceAccountName),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    shape: pw.BoxShape.circle,
                  ),
                  child: pw.Icon(
                    const pw.IconData(0xE156), // arrow_downward
                    color: PdfColors.blue600,
                    size: 16,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              _buildAccountRow('To', destinationAccountName),
              pw.SizedBox(height: 24),

              // Transaction Details
              pw.Text(
                'Transaction Details',
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
                    _buildDetailRow('Amount', _formatCurrency(amount, currency)),
                    _buildDetailRow('Fee', '${currency} 0.00'),
                    pw.Divider(color: PdfColors.grey300),
                    pw.SizedBox(height: 4),
                    _buildDetailRow('Total', _formatCurrency(amount, currency),
                        isBold: true),
                    pw.SizedBox(height: 8),
                    if (transfer.reference != null && transfer.reference!.isNotEmpty)
                      _buildDetailRow('Reference', transfer.reference!),
                    if (transfer.transferId != null && transfer.transferId!.isNotEmpty)
                      _buildDetailRow('Transfer ID', transfer.transferId!),
                    _buildDetailRow(
                      'Date',
                      transfer.createdAt != null
                          ? _fullDateTimeFormat.format(transfer.createdAt!)
                          : _fullDateTimeFormat.format(DateTime.now()),
                    ),
                    if (transfer.scheduledAt != null)
                      _buildDetailRow(
                        'Scheduled For',
                        _fullDateTimeFormat.format(transfer.scheduledAt!),
                      ),
                  ],
                ),
              ),

              // Recipient info
              if (transfer.recipientName != null && transfer.recipientName!.isNotEmpty) ...[
                pw.SizedBox(height: 16),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey50,
                    borderRadius: pw.BorderRadius.circular(8),
                    border: pw.Border.all(color: PdfColors.grey200),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Recipient',
                          style: _getTextStyle(fontSize: 11, color: PdfColors.grey600)),
                      pw.SizedBox(height: 4),
                      pw.Text(transfer.recipientName!,
                          style: _getTextStyle(fontSize: 13, isBold: true)),
                    ],
                  ),
                ),
              ],

              pw.Spacer(),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );

    return pdf.save();
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
              'Transfer Confirmation',
              style: _getTextStyle(fontSize: 18, isBold: true)
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

  static pw.Widget _buildAccountRow(String label, String accountName) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Row(
        children: [
          pw.Text(
            label.toUpperCase(),
            style: _getTextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
          pw.SizedBox(width: 16),
          pw.Expanded(
            child: pw.Text(
              accountName,
              style: _getTextStyle(fontSize: 13, isBold: true),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    PdfColor? color,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: _getTextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
          pw.Text(
            value,
            style: _getTextStyle(fontSize: 11, isBold: isBold, color: color),
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
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              'Generated by LazerVault',
              style: _getTextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              'This is an automatically generated receipt.',
              style: _getTextStyle(fontSize: 9, color: PdfColors.grey500),
            ),
          ],
        ),
      ],
    );
  }

  /// Download receipt to device
  static Future<String> downloadReceipt({
    required PaymentsTransferResult transfer,
    required String userName,
    required String sourceAccountName,
    required String destinationAccountName,
  }) async {
    final pdfBytes = await generateReceipt(
      transfer: transfer,
      userName: userName,
      sourceAccountName: sourceAccountName,
      destinationAccountName: destinationAccountName,
    );
    final directory = await getDownloadsDirectory();
    final fileName = 'wallet_transfer_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${directory!.path}/$fileName');
    await file.writeAsBytes(pdfBytes);
    return file.path;
  }

  /// Share receipt via native share sheet
  static Future<void> shareReceipt({
    required PaymentsTransferResult transfer,
    required String userName,
    required String sourceAccountName,
    required String destinationAccountName,
  }) async {
    final pdfBytes = await generateReceipt(
      transfer: transfer,
      userName: userName,
      sourceAccountName: sourceAccountName,
      destinationAccountName: destinationAccountName,
    );
    final fileName = 'wallet_transfer_receipt.pdf';
    // ignore: deprecated_member_use
    await Share.shareXFiles(
      [XFile.fromData(pdfBytes, name: fileName, mimeType: 'application/pdf')],
      subject: 'LazerVault Wallet Transfer Receipt',
    );
  }
}
