import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/id_pay_entity.dart';
import '../domain/entities/id_pay_transaction_entity.dart';

class IDPayPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
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
      default:
        return '$code ';
    }
  }

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

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;

    try {
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));

      if (regularResponse.statusCode == 200 &&
          boldResponse.statusCode == 200) {
        _regularFont =
            pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
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

  /// Generate a payment receipt PDF for a paid IDPay
  static Future<File> generatePaymentReceipt({
    required IDPayTransactionEntity transaction,
    required IDPayEntity idPay,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final transactionDate = _dateFormat.format(transaction.createdAt);
    final currencySymbol = _currencySymbolFor(transaction.currency);
    final amount = transaction.amount.toStringAsFixed(2);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(logo, generatedDate, isInvoice: false),
              pw.SizedBox(height: 24),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            transaction.payerName.isNotEmpty
                                ? transaction.payerName.toUpperCase()
                                : 'LAZERVAULT USER',
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (transaction.payerUsername.isNotEmpty)
                          pw.Text('@${transaction.payerUsername}',
                              style: _getTextStyle(
                                  fontSize: 11, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: transactionDate,
                      completedDate: transactionDate,
                      status: transaction.isCompleted ? 'Completed' : transaction.status,
                      type: 'IDPay Transfer',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              _buildTransferDetails(
                currencySymbol: currencySymbol,
                amount: amount,
                reference: idPay.description.isNotEmpty
                    ? idPay.description
                    : 'IDPay payment',
                idPayReference: transaction.reference,
                transactionId: transaction.id,
                payId: idPay.displayPayId,
              ),
              pw.SizedBox(height: 32),
              _buildRecipientDetails(
                recipientName: transaction.recipientName.isNotEmpty
                    ? transaction.recipientName
                    : idPay.creatorName,
                recipientUsername: idPay.creatorUsername,
              ),
              pw.Spacer(),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeRef =
        transaction.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName = 'idpay_receipt_$safeRef.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generate an invoice PDF for a created IDPay (before payment)
  static Future<File> generateCreationInvoice({
    required IDPayEntity idPay,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());
    final createdDate = _dateFormat.format(idPay.createdAt);
    final currencySymbol = _currencySymbolFor(idPay.currency);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(logo, generatedDate, isInvoice: true),
              pw.SizedBox(height: 24),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('FROM',
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.grey600)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            idPay.creatorName.isNotEmpty
                                ? idPay.creatorName.toUpperCase()
                                : 'LAZERVAULT USER',
                            style: _getTextStyle(fontSize: 14, isBold: true)),
                        if (idPay.creatorUsername.isNotEmpty)
                          pw.Text('@${idPay.creatorUsername}',
                              style: _getTextStyle(
                                  fontSize: 11, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: _buildSummaryTable(
                      createdDate: createdDate,
                      status: idPay.status.displayName,
                      type: 'IDPay Invoice',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              _buildInvoiceDetails(
                idPay: idPay,
                currencySymbol: currencySymbol,
              ),
              pw.Spacer(),
              _buildFooter(transactionType: 'IDPay payment request'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'idpay_invoice_${idPay.payId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(pw.MemoryImage? logo, String generatedDate,
      {required bool isInvoice}) {
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
              isInvoice ? 'IDPay Invoice' : 'Transfer Confirmation',
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

  static pw.Widget _buildSummaryTable({
    required String createdDate,
    String? completedDate,
    required String status,
    required String type,
  }) {
    return pw.Column(
      children: [
        _buildSummaryRow('Value Date', completedDate ?? createdDate),
        _buildSummaryRow('Operation Date', createdDate),
        _buildSummaryRow('Date available', completedDate ?? createdDate),
        _buildSummaryRow('Status', status),
        _buildSummaryRow('Type', type),
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
          pw.Text(label,
              style: _getTextStyle(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value, style: _getTextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  static pw.Widget _buildTransferDetails({
    required String currencySymbol,
    required String amount,
    required String reference,
    required String idPayReference,
    required String transactionId,
    required String payId,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Transfer details',
            style: _getTextStyle(fontSize: 16, isBold: true)),
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
              _buildDetailRow('Amount', '$currencySymbol$amount', isBold: true),
              _buildDetailRow('Fee', '${currencySymbol}0.00'),
              _buildDetailRow('PayID', payId),
              _buildDetailRow('Reference', idPayReference),
              _buildDetailRow('Description', reference),
              _buildDetailRow('Transaction Id', transactionId),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildInvoiceDetails({
    required IDPayEntity idPay,
    required String currencySymbol,
  }) {
    final amountDisplay = idPay.isFixed
        ? '$currencySymbol${idPay.amount.toStringAsFixed(2)}'
        : 'Flexible';

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Invoice Details',
            style: _getTextStyle(fontSize: 16, isBold: true)),
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
              _buildDetailRow('PayID', idPay.displayPayId, isBold: true),
              _buildDetailRow('Amount', amountDisplay, isBold: true),
              if (idPay.isFlexible && idPay.minAmount > 0)
                _buildDetailRow('Min Amount',
                    '$currencySymbol${idPay.minAmount.toStringAsFixed(2)}'),
              if (idPay.isFlexible && idPay.maxAmount > 0)
                _buildDetailRow('Max Amount',
                    '$currencySymbol${idPay.maxAmount.toStringAsFixed(2)}'),
              _buildDetailRow('Currency', _currencyNameFor(idPay.currency)),
              _buildDetailRow('Type', idPay.type.displayName),
              _buildDetailRow('Amount Mode', idPay.amountMode.displayName),
              _buildDetailRow('Fee', '${currencySymbol}0.00'),
              if (idPay.description.isNotEmpty)
                _buildDetailRow('Description', idPay.description),
              _buildDetailRow(
                  'Created', _fullDateTimeFormat.format(idPay.createdAt)),
              _buildDetailRow(
                  'Expires', _fullDateTimeFormat.format(idPay.expiresAt)),
              _buildDetailRow('Status', idPay.status.displayName),
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
            child: pw.Text(label,
                style: _getTextStyle(fontSize: 11, isBold: true)
                    .copyWith(color: PdfColors.grey700)),
          ),
          pw.Expanded(
            child: pw.Text(value,
                style: _getTextStyle(fontSize: 11, isBold: isBold),
                textAlign: pw.TextAlign.right),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRecipientDetails({
    required String recipientName,
    required String recipientUsername,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Beneficiary Details',
            style: _getTextStyle(fontSize: 16, isBold: true)),
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
              _buildDetailRow('Name',
                  recipientName.isNotEmpty ? recipientName : 'LazerVault User'),
              if (recipientUsername.isNotEmpty)
                _buildDetailRow('Username', '@$recipientUsername'),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter(
      {String transactionType = 'IDPay transfer'}) {
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
                pw.Text('Need help?',
                    style: _getTextStyle(fontSize: 10, isBold: true)),
                pw.SizedBox(height: 4),
                pw.Text('Get help directly in-app',
                    style:
                        _getTextStyle(fontSize: 9, color: PdfColors.grey600)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                    '(C) ${DateTime.now().year} LazerVault Technologies Ltd',
                    style:
                        _getTextStyle(fontSize: 9, color: PdfColors.grey600)),
                pw.SizedBox(height: 2),
                pw.Text('Page 1 of 1',
                    style:
                        _getTextStyle(fontSize: 9, color: PdfColors.grey500)),
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
            'This document is a confirmation of a $transactionType processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  // ─── Public API methods ───

  /// Download payment receipt to device storage
  static Future<String> downloadReceipt({
    required IDPayTransactionEntity transaction,
    required IDPayEntity idPay,
  }) async {
    try {
      final file = await generatePaymentReceipt(
          transaction: transaction, idPay: idPay);

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

      final safeRef =
          transaction.reference.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName = 'idpay_receipt_$safeRef.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download receipt: $e');
    }
  }

  /// Share payment receipt via system share sheet
  static Future<void> shareReceipt({
    required IDPayTransactionEntity transaction,
    required IDPayEntity idPay,
  }) async {
    try {
      final file = await generatePaymentReceipt(
          transaction: transaction, idPay: idPay);

      final currencySymbol = _currencySymbolFor(transaction.currency);
      final amount = transaction.amount.toStringAsFixed(2);

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'IDPay Transfer Receipt - $currencySymbol$amount to ${transaction.recipientName}',
        subject: 'LazerVault IDPay Transfer Confirmation',
      ));
    } catch (e) {
      throw Exception('Failed to share receipt: $e');
    }
  }

  /// Download creation invoice to device storage
  static Future<String> downloadInvoice({
    required IDPayEntity idPay,
  }) async {
    try {
      final file = await generateCreationInvoice(idPay: idPay);

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

      final fileName = 'idpay_invoice_${idPay.payId}.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download invoice: $e');
    }
  }

  /// Share creation invoice via system share sheet
  static Future<void> shareInvoice({
    required IDPayEntity idPay,
  }) async {
    try {
      final file = await generateCreationInvoice(idPay: idPay);

      final currencySymbol = _currencySymbolFor(idPay.currency);
      final amountText = idPay.isFixed
          ? '$currencySymbol${idPay.amount.toStringAsFixed(2)}'
          : 'Flexible amount';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'IDPay Invoice - ${idPay.displayPayId} - $amountText from ${idPay.creatorName}',
        subject: 'LazerVault IDPay Invoice',
      ));
    } catch (e) {
      throw Exception('Failed to share invoice: $e');
    }
  }
}
