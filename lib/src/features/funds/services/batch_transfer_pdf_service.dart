import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

class BatchTransferPdfService {
  static Future<File> generateBatchTransferReceipt(BatchTransferEntity batchTransfer) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Column(
                children: [
                  pw.Text(
                    'LazerVault',
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Batch Transfer Receipt',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Transaction ID: ${batchTransfer.batchId}',
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 32),

            // Transaction Summary
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Transaction Summary',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 12),
                  _buildSummaryRow('Status:', _getStatusText(batchTransfer.status)),
                  _buildSummaryRow('Date:', dateFormat.format(batchTransfer.createdAt)),
                  if (batchTransfer.completedAt != null)
                    _buildSummaryRow('Completed:', dateFormat.format(batchTransfer.completedAt!)),
                  _buildSummaryRow('Total Recipients:', '${batchTransfer.totalTransfers}'),
                  _buildSummaryRow('Successful:', '${batchTransfer.successfulTransfers}'),
                  if (batchTransfer.failedTransfers > 0)
                    _buildSummaryRow('Failed:', '${batchTransfer.failedTransfers}'),
                  pw.Divider(),
                  _buildSummaryRow('Total Amount:', currencyFormat.format(batchTransfer.totalAmount.toInt() / 100)),
                  _buildSummaryRow('Total Fees:', currencyFormat.format(batchTransfer.totalFee.toInt() / 100)),
                  _buildSummaryRow('Grand Total:', currencyFormat.format(batchTransfer.totalAmountWithFee.toInt() / 100), isTotal: true),
                ],
              ),
            ),
            pw.SizedBox(height: 24),

            // Recipients Details
            pw.Text(
              'Recipients Details',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 12),

            // Recipients Table
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              columnWidths: {
                0: const pw.FlexColumnWidth(3),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
                3: const pw.FlexColumnWidth(1.5),
              },
              children: [
                // Header
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _buildTableCell('Recipient', isHeader: true),
                    _buildTableCell('Account', isHeader: true),
                    _buildTableCell('Amount', isHeader: true),
                    _buildTableCell('Status', isHeader: true),
                  ],
                ),
                // Data rows
                ...batchTransfer.results.map((result) => pw.TableRow(
                  children: [
                    _buildTableCell(result.recipientName ?? 'Unknown'),
                    _buildTableCell(result.recipientAccount ?? 'N/A'),
                    _buildTableCell(currencyFormat.format(result.amount.toInt() / 100)),
                    _buildTableCell(_getStatusText(result.status)),
                  ],
                )),
              ],
            ),

            // Failed transactions details (if any)
            if (batchTransfer.results.any((r) => r.status == 'failed')) ...[
              pw.SizedBox(height: 24),
              pw.Text(
                'Failed Transactions',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.red800,
                ),
              ),
              pw.SizedBox(height: 12),
              ...batchTransfer.results
                  .where((r) => r.status == 'failed')
                  .map((result) => pw.Container(
                        margin: const pw.EdgeInsets.only(bottom: 8),
                        padding: const pw.EdgeInsets.all(12),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.red50,
                          border: pw.Border.all(color: PdfColors.red200),
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              '${result.recipientName} - ${currencyFormat.format(result.amount.toInt() / 100)}',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            if (result.failureReason != null)
                              pw.Text(
                                'Reason: ${result.failureReason}',
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                          ],
                        ),
                      )),
            ],

            pw.SizedBox(height: 32),

            // Footer
            pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Column(
                children: [
                  pw.Text(
                    'Thank you for using LazerVault',
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Generated on ${dateFormat.format(DateTime.now())}',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    // Save PDF to temporary directory
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/batch_transfer_${batchTransfer.batchId}_receipt.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontSize: isTotal ? 14 : 12,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontSize: isTotal ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTableCell(String text, {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'partial_success':
        return 'Partial Success';
      default:
        return status.toUpperCase();
    }
  }

  static Future<void> shareReceipt(BatchTransferEntity batchTransfer) async {
    try {
      final file = await generateBatchTransferReceipt(batchTransfer);
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Batch Transfer Receipt - Transaction ID: ${batchTransfer.batchId}',
        subject: 'LazerVault Batch Transfer Receipt',
      );
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  static Future<String> downloadReceipt(BatchTransferEntity batchTransfer) async {
    try {
      final file = await generateBatchTransferReceipt(batchTransfer);
      
      // Move to downloads directory if available
      try {
        final downloadsDirectory = await getDownloadsDirectory();
        if (downloadsDirectory != null) {
          final downloadFile = File('${downloadsDirectory.path}/batch_transfer_${batchTransfer.batchId}_receipt.pdf');
          await file.copy(downloadFile.path);
          return downloadFile.path;
        }
      } catch (e) {
        // Fallback to documents directory
        final documentsDirectory = await getApplicationDocumentsDirectory();
        final downloadFile = File('${documentsDirectory.path}/batch_transfer_${batchTransfer.batchId}_receipt.pdf');
        await file.copy(downloadFile.path);
        return downloadFile.path;
      }
      
      return file.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }
} 