import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../domain/entities/transaction_entity.dart';

class ExchangePdfService {
  static Future<pw.Document> _generateReceiptPdf({
    required CurrencyTransaction transaction,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMMM d, yyyy HH:mm:ss');
    final isConversion = transaction.type == TransactionType.exchange;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'LazerVault',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        isConversion ? 'Currency Conversion Receipt' : 'International Transfer Receipt',
                        style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        dateFormat.format(transaction.createdAt),
                        style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                      ),
                      pw.SizedBox(height: 2),
                      if (transaction.referenceNumber != null)
                        pw.Text(
                          'Ref: ${transaction.referenceNumber}',
                          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                        ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 20),

              // Status
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: pw.BoxDecoration(
                  color: transaction.isCompleted ? PdfColors.green50 : PdfColors.orange50,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text(
                  transaction.statusString,
                  style: pw.TextStyle(
                    color: transaction.isCompleted ? PdfColors.green800 : PdfColors.orange800,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              // Amounts
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text('You Sent', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          transaction.formattedFromAmount,
                          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    pw.Text('→', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
                    pw.Column(
                      children: [
                        pw.Text(
                          isConversion ? 'You Received' : 'They Receive',
                          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          transaction.formattedToAmount,
                          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.green800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Details
              _buildPdfRow('Exchange Rate', '1 ${transaction.fromCurrency} = ${transaction.exchangeRate.toStringAsFixed(4)} ${transaction.toCurrency}'),
              if (transaction.fees > 0)
                _buildPdfRow('Service Fee', transaction.formattedFees),
              _buildPdfRow('Total Cost', transaction.formattedTotalCost),
              _buildPdfRow('Type', isConversion ? 'Wallet Conversion' : 'International Transfer'),
              _buildPdfRow('Transaction ID', transaction.id),
              if (transaction.completedAt != null)
                _buildPdfRow('Completed At', dateFormat.format(transaction.completedAt!)),

              // Recipient (international)
              if (!isConversion && transaction.recipientName.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Recipient Details',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 12),
                _buildPdfRow('Name', transaction.recipient.name),
                if (transaction.recipient.accountNumber.isNotEmpty)
                  _buildPdfRow('Account', transaction.recipient.accountNumber),
                if (transaction.recipient.bankName.isNotEmpty)
                  _buildPdfRow('Bank', transaction.recipient.bankName),
                if (transaction.recipient.swiftCode != null && transaction.recipient.swiftCode!.isNotEmpty)
                  _buildPdfRow('SWIFT/BIC', transaction.recipient.swiftCode!),
              ],

              // Footer
              pw.Spacer(),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 8),
              pw.Text(
                'This receipt was generated by LazerVault. For questions, contact support@lazervault.com',
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _buildPdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static Future<String> downloadReceipt({
    required CurrencyTransaction transaction,
  }) async {
    final pdf = await _generateReceiptPdf(transaction: transaction);
    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'exchange_receipt_${transaction.id.substring(0, 8)}_${DateFormat('yyyyMMdd').format(transaction.createdAt)}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static Future<void> shareReceipt({
    required CurrencyTransaction transaction,
  }) async {
    final pdf = await _generateReceiptPdf(transaction: transaction);
    final dir = await getTemporaryDirectory();
    final fileName = 'exchange_receipt_${transaction.id.substring(0, 8)}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Exchange receipt - ${transaction.formattedFromAmount} → ${transaction.formattedToAmount}',
      ),
    );
  }
}
