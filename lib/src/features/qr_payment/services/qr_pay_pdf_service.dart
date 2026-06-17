import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_transaction_entity.dart';

class QRPayPdfService {
  static Future<String> downloadReceipt({
    required QRTransactionEntity transaction,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              pw.SizedBox(height: 30),
              _buildAmountSection(transaction),
              pw.SizedBox(height: 20),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 20),
              _buildDetailsSection(transaction),
              pw.SizedBox(height: 30),
              _buildFooter(transaction),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'qr_pay_receipt_${transaction.referenceNumber}.pdf';
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  static Future<void> shareReceipt({
    required QRTransactionEntity transaction,
  }) async {
    final filePath = await downloadReceipt(transaction: transaction);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath)],
        subject: 'QR Pay Receipt - ${transaction.referenceNumber}',
      ),
    );
  }

  static Future<String> downloadQRCodeSummary({
    required QRPaymentEntity qrCode,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildQRSummaryHeader(),
              pw.SizedBox(height: 30),
              _buildQRSummaryAmountSection(qrCode),
              pw.SizedBox(height: 20),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 20),
              _buildQRSummaryDetailsSection(qrCode),
              pw.SizedBox(height: 30),
              _buildQRSummaryFooter(qrCode),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'qr_code_summary_${qrCode.id}.pdf';
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  static Future<void> shareQRCodeSummary({
    required QRPaymentEntity qrCode,
  }) async {
    final filePath = await downloadQRCodeSummary(qrCode: qrCode);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath)],
        subject: 'QR Code Summary - ${qrCode.id}',
      ),
    );
  }

  static pw.Widget _buildQRSummaryHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Center(
          child: pw.Text(
            'LazerVault',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Center(
          child: pw.Text(
            'QR Code Summary',
            style: pw.TextStyle(
              fontSize: 16,
              color: PdfColors.grey600,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildQRSummaryAmountSection(QRPaymentEntity qr) {
    final isPaid = qr.status == QRPaymentStatus.paid;
    final bgColor = isPaid ? PdfColors.green50 : PdfColors.orange50;
    final labelColor = isPaid ? PdfColors.green800 : PdfColors.orange800;
    final statusLabel = qr.status.displayName.toUpperCase();

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: bgColor,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            statusLabel,
            style: pw.TextStyle(
              fontSize: 14,
              color: labelColor,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            qr.amount > 0
                ? '${qr.currency} ${qr.amount.toStringAsFixed(2)}'
                : 'Any Amount',
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey900,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildQRSummaryDetailsSection(QRPaymentEntity qr) {
    return pw.Column(
      children: [
        _buildDetailRow('Type', qr.qrType.displayName),
        _buildDetailRow('Owner', '${qr.fullName} (@${qr.username})'),
        _buildDetailRow('Status', qr.status.displayName),
        if (qr.description.isNotEmpty)
          _buildDetailRow('Description', qr.description),
        _buildDetailRow('Created', _formatDate(qr.createdAt)),
        _buildDetailRow('Expires', _formatDate(qr.expiresAt)),
        if (qr.paidAt != null)
          _buildDetailRow('Paid At', _formatDate(qr.paidAt!)),
      ],
    );
  }

  static pw.Widget _buildQRSummaryFooter(QRPaymentEntity qr) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            'QR Code ID: ${qr.id}',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey400,
            ),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Center(
          child: pw.Text(
            'Generated by LazerVault QR Pay',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey400,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Center(
          child: pw.Text(
            'LazerVault',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Center(
          child: pw.Text(
            'QR Payment Receipt',
            style: pw.TextStyle(
              fontSize: 16,
              color: PdfColors.grey600,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildAmountSection(QRTransactionEntity txn) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.green50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'Payment Successful',
            style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.green800,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            '${txn.currency} ${txn.amount.toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey900,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildDetailsSection(QRTransactionEntity txn) {
    return pw.Column(
      children: [
        _buildDetailRow('Payer', '${txn.payerName} (@${txn.payerUsername})'),
        _buildDetailRow(
            'Recipient', '${txn.recipientName} (@${txn.recipientUsername})'),
        _buildDetailRow('Reference', txn.referenceNumber),
        _buildDetailRow('Status', txn.status.displayName),
        if (txn.description.isNotEmpty)
          _buildDetailRow('Description', txn.description),
        _buildDetailRow('Date', _formatDate(txn.createdAt)),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.grey600,
            ),
          ),
          pw.Flexible(
            child: pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey900,
              ),
              textAlign: pw.TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(QRTransactionEntity txn) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            'Transaction ID: ${txn.id}',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey400,
            ),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Center(
          child: pw.Text(
            'Generated by LazerVault QR Pay',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey400,
            ),
          ),
        ),
      ],
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
