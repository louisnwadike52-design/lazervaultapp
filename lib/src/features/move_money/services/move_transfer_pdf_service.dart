import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../domain/entities/move_transfer.dart';

/// PDF service for Move Money transfer receipts
/// Generates professional PDF receipts for external bank transfers
class MoveTransferPdfService {
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

  /// Get status color for PDF
  static PdfColor _getStatusColor(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return PdfColors.green600;
      case MoveTransferStatus.failed:
      case MoveTransferStatus.refunded:
        return PdfColors.red600;
      default:
        return PdfColors.blue600;
    }
  }

  /// Get status display text
  static String _getStatusText(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.pending:
        return 'Pending';
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitProcessing:
        return 'Processing - Debiting';
      case MoveTransferStatus.debitCompleted:
        return 'Debit Complete';
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 'Processing - Sending';
      case MoveTransferStatus.completed:
        return 'Completed';
      case MoveTransferStatus.failed:
        return 'Failed';
      case MoveTransferStatus.refunding:
        return 'Refunding';
      case MoveTransferStatus.refunded:
        return 'Refunded';
    }
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

  /// Format amount in Naira
  static String _formatNaira(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return 'NGN $formatter.format(amount)';
  }

  /// Generate PDF receipt for a MoveTransfer
  static Future<Uint8List> generateReceipt({
    required MoveTransfer transfer,
    required String userName,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _dateFormat.format(DateTime.now());
    final statusColor = _getStatusColor(transfer.status);
    final statusText = _getStatusText(transfer.status);

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
                          'Transfer Receipt',
                          style: _getTextStyle(fontSize: 24, isBold: true)
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
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          _formatNaira(transfer.amountNaira),
                          style: _getTextStyle(fontSize: 28, isBold: true),
                        ),
                        if (transfer.totalFee > 0) ...[
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'Total Debit: ${_formatNaira(transfer.totalDebitNaira)}',
                            style: _getTextStyle(
                              fontSize: 12,
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

              // From Account
              _buildAccountSection(
                'From',
                transfer.sourceBankName,
                transfer.sourceAccountName,
                transfer.sourceAccountNumber,
              ),
              pw.SizedBox(height: 16),

              // To Account
              _buildAccountSection(
                'To',
                transfer.destinationBankName,
                transfer.destinationAccountName,
                transfer.destinationAccountNumber,
              ),
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
                    _buildDetailRow('Reference', transfer.reference),
                    _buildDetailRow('Date', _fullDateTimeFormat.format(transfer.createdAt)),
                    if (transfer.completedAt != null)
                      _buildDetailRow('Completed', _fullDateTimeFormat.format(transfer.completedAt!)),
                    if (transfer.debitReference != null)
                      _buildDetailRow('Debit Reference', transfer.debitReference!),
                    if (transfer.payoutReference != null)
                      _buildDetailRow('Payout Reference', transfer.payoutReference!),
                  ],
                ),
              ),

              // Fee breakdown
              if (transfer.totalFee > 0) ...[
                pw.SizedBox(height: 16),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey50,
                    borderRadius: pw.BorderRadius.circular(8),
                    border: pw.Border.all(color: PdfColors.grey200),
                  ),
                  child: pw.Column(
                    children: [
                      _buildDetailRow('Debit Fee', _formatNaira(transfer.debitFee / 100.0)),
                      _buildDetailRow('Transfer Fee', _formatNaira(transfer.transferFee / 100.0)),
                      if (transfer.stampDuty > 0)
                        _buildDetailRow('Stamp Duty', _formatNaira(transfer.stampDuty / 100.0)),
                      if (transfer.serviceFee > 0)
                        _buildDetailRow('Service Fee', _formatNaira(transfer.serviceFee / 100.0)),
                      pw.Divider(color: PdfColors.grey300),
                      pw.SizedBox(height: 8),
                      _buildDetailRow('Total Fees', _formatNaira(transfer.totalFeeNaira),
                          isBold: true),
                      _buildDetailRow('Total Debit', _formatNaira(transfer.totalDebitNaira),
                          isBold: true, color: PdfColors.blue600),
                    ],
                  ),
                ),
              ],

              // Narration
              if (transfer.narration != null && transfer.narration!.isNotEmpty) ...[
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
                      pw.Text('Narration',
                          style: _getTextStyle(fontSize: 11, color: PdfColors.grey600)),
                      pw.SizedBox(height: 4),
                      pw.Text(transfer.narration!,
                          style: _getTextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],

              // Failure info
              if (transfer.status == MoveTransferStatus.failed &&
                  (transfer.failureReason != null || transfer.failureStage != null)) ...[
                pw.SizedBox(height: 16),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.red50,
                    borderRadius: pw.BorderRadius.circular(8),
                    border: pw.Border.all(color: PdfColors.red200),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Failure Information',
                          style: _getTextStyle(fontSize: 11, isBold: true, color: PdfColors.red700)),
                      pw.SizedBox(height: 4),
                      if (transfer.failureReason != null)
                        pw.Text(transfer.failureReason!,
                            style: _getTextStyle(fontSize: 12, color: PdfColors.red700)),
                      if (transfer.failureStage != null) ...[
                        pw.SizedBox(height: 4),
                        pw.Text('Stage: ${transfer.failureStage}',
                            style: _getTextStyle(fontSize: 11, color: PdfColors.red600)),
                      ],
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

  static pw.Widget _buildAccountSection(
    String label,
    String bankName,
    String accountName,
    String accountNumber,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label.toUpperCase(),
            style: _getTextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            bankName,
            style: _getTextStyle(fontSize: 14, isBold: true),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            accountName,
            style: _getTextStyle(fontSize: 12),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            accountNumber,
            style: _getTextStyle(fontSize: 13, isBold: true),
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
    required MoveTransfer transfer,
    required String userName,
  }) async {
    final pdfBytes = await generateReceipt(transfer: transfer, userName: userName);
    final directory = await getDownloadsDirectory();
    final fileName =
        'transfer_${transfer.reference}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${directory!.path}/$fileName');
    await file.writeAsBytes(pdfBytes);
    return file.path;
  }

  /// Share receipt via native share sheet
  static Future<void> shareReceipt({
    required MoveTransfer transfer,
    required String userName,
  }) async {
    final pdfBytes = await generateReceipt(transfer: transfer, userName: userName);
    final fileName = 'transfer_${transfer.reference}.pdf';
    // ignore: deprecated_member_use
    await Share.shareXFiles(
      [XFile.fromData(pdfBytes, name: fileName, mimeType: 'application/pdf')],
      subject: 'LazerVault Transfer Receipt',
    );
  }
}
