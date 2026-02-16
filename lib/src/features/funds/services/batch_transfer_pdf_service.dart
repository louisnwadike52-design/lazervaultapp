import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

/// Production-grade batch transfer receipt PDF service
/// Generates professional, Revolut-style downloadable and shareable PDF receipts
class BatchTransferPdfService {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _displayDateFormat = DateFormat('MMM dd, yyyy');
  static final _fullDateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  // Cache for loaded fonts
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  /// Get currency symbol - ASCII-safe for PDF compatibility
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
      case 'CAD':
        return 'Canadian Dollar';
      case 'AUD':
        return 'Australian Dollar';
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

  /// Generate a production-quality batch transfer receipt PDF
  static Future<File> generateReceipt({
    required Map<String, dynamic> receiptData,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    // Extract data
    final batchId = receiptData['batchId']?.toString() ??
        'BTX${DateTime.now().millisecondsSinceEpoch}';
    final totalAmount =
        (receiptData['totalAmount'] as num?)?.toDouble() ?? 0.0;
    final totalFee = (receiptData['totalFee'] as num?)?.toDouble() ?? 0.0;
    final currency = receiptData['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbolFor(currency);
    final status = receiptData['status'] as String? ?? 'Completed';
    final recipientCount = receiptData['recipientCount'] as int? ?? 0;
    final successfulTransfers =
        receiptData['successfulTransfers'] as int? ?? recipientCount;
    final failedTransfers = receiptData['failedTransfers'] as int? ?? 0;
    final isScheduled = receiptData['isScheduled'] as bool? ?? false;
    final scheduledAt = receiptData['scheduledAt'] as String?;
    final senderName =
        receiptData['senderAccountName'] as String? ?? 'LazerVault User';
    final senderAccountInfo =
        receiptData['senderAccountInfo'] as String?;
    final transfers =
        receiptData['transfers'] as List<dynamic>? ?? [];

    DateTime? timestamp;
    if (receiptData['timestamp'] != null) {
      timestamp = receiptData['timestamp'] as DateTime?;
    }
    timestamp ??= DateTime.now();
    final transactionDate = _dateFormat.format(timestamp);

    DateTime? scheduledDateTime;
    if (scheduledAt != null) {
      try {
        scheduledDateTime = DateTime.parse(scheduledAt).toLocal();
      } catch (_) {}
    }

    // Separate successful and failed transfers
    final successfulList = transfers
        .where((t) =>
            (t as Map<String, dynamic>)['status']?.toString().toLowerCase() !=
            'failed')
        .toList();
    final failedList = transfers
        .where((t) =>
            (t as Map<String, dynamic>)['status']?.toString().toLowerCase() ==
            'failed')
        .toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            // Header with Logo
            _buildHeader(logo, generatedDate, isScheduled),
            pw.SizedBox(height: 24),

            // Sender and Transaction Summary side by side
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: _buildSenderInfo(
                    senderName: senderName,
                    accountInfo: senderAccountInfo,
                  ),
                ),
                pw.SizedBox(width: 40),
                pw.Expanded(
                  flex: 1,
                  child: _buildSummaryTable(
                    transactionDate: transactionDate,
                    status: _formatStatus(status),
                    batchId: batchId,
                    recipientCount: recipientCount,
                    successfulTransfers: successfulTransfers,
                    failedTransfers: failedTransfers,
                    isScheduled: isScheduled,
                    scheduledDateTime: scheduledDateTime,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 32),

            // Transfer Details
            _buildTransferDetails(
              currencySymbol: currencySymbol,
              totalAmount: totalAmount,
              totalFee: totalFee,
              batchId: batchId,
              currency: currency,
              recipientCount: recipientCount,
            ),
            pw.SizedBox(height: 32),

            // Successful Recipients Table
            if (successfulList.isNotEmpty) ...[
              pw.Text(
                'Successful Transfers (${successfulList.length})',
                style: _getTextStyle(fontSize: 16, isBold: true),
              ),
              pw.SizedBox(height: 12),
              _buildRecipientsTable(
                  successfulList, currencySymbol, PdfColors.green700),
              pw.SizedBox(height: 24),
            ],

            // Failed Recipients Table
            if (failedList.isNotEmpty) ...[
              pw.Text(
                'Failed Transfers (${failedList.length})',
                style: _getTextStyle(fontSize: 16, isBold: true)
                    .copyWith(color: PdfColors.red800),
              ),
              pw.SizedBox(height: 12),
              _buildRecipientsTable(
                  failedList, currencySymbol, PdfColors.red700),
              pw.SizedBox(height: 12),
              // Failed transfer reasons
              ...failedList.map((t) {
                final transfer = t as Map<String, dynamic>;
                final name = _resolveTransferName(transfer);
                final reason = transfer['failureReason'] as String?;
                if (reason == null || reason.isEmpty) {
                  return pw.SizedBox.shrink();
                }
                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 6),
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.red50,
                    border: pw.Border.all(color: PdfColors.red200),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('$name: ',
                          style: _getTextStyle(fontSize: 10, isBold: true)),
                      pw.Expanded(
                        child: pw.Text(reason,
                            style: _getTextStyle(
                                fontSize: 10, color: PdfColors.red800)),
                      ),
                    ],
                  ),
                );
              }),
              pw.SizedBox(height: 24),
            ],

            // If no individual transfers listed, show placeholder
            if (transfers.isEmpty) ...[
              pw.Text(
                'Recipients',
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
                child: pw.Text(
                  '$recipientCount transfer${recipientCount == 1 ? '' : 's'} processed',
                  style: _getTextStyle(fontSize: 12, color: PdfColors.grey600),
                ),
              ),
              pw.SizedBox(height: 24),
            ],
          ];
        },
        footer: (pw.Context context) => _buildFooter(context),
      ),
    );

    final output = await getTemporaryDirectory();
    final safeId =
        batchId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName = 'batch_transfer_receipt_$safeId.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(
      pw.MemoryImage? logo, String generatedDate, bool isScheduled) {
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
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'LazerVault',
                    style: _getTextStyle(fontSize: 28, isBold: true)
                        .copyWith(color: PdfColors.blue800),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue50,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      'FINANCIAL SERVICES',
                      style: _getTextStyle(fontSize: 8, isBold: true)
                          .copyWith(
                              color: PdfColors.blue800, letterSpacing: 1),
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
              isScheduled
                  ? 'Scheduled Transfer Receipt'
                  : 'Batch Transfer Receipt',
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

  static pw.Widget _buildSenderInfo({
    required String senderName,
    String? accountInfo,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('FROM',
            style: _getTextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.SizedBox(height: 4),
        pw.Text(
          senderName.toUpperCase(),
          style: _getTextStyle(fontSize: 14, isBold: true),
        ),
        if (accountInfo != null && accountInfo.isNotEmpty) ...[
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              pw.Text('Account',
                  style: _getTextStyle(fontSize: 11, isBold: true)),
              pw.SizedBox(width: 12),
              pw.Text(accountInfo, style: _getTextStyle(fontSize: 11)),
            ],
          ),
        ],
        pw.SizedBox(height: 4),
        pw.Row(
          children: [
            pw.Text('Bank',
                style: _getTextStyle(fontSize: 11, isBold: true)),
            pw.SizedBox(width: 12),
            pw.Text('LazerVault', style: _getTextStyle(fontSize: 11)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryTable({
    required String transactionDate,
    required String status,
    required String batchId,
    required int recipientCount,
    required int successfulTransfers,
    required int failedTransfers,
    required bool isScheduled,
    DateTime? scheduledDateTime,
  }) {
    final statusColor = status.toLowerCase() == 'completed'
        ? PdfColors.green700
        : status.toLowerCase() == 'scheduled'
            ? PdfColors.orange700
            : status.toLowerCase() == 'failed'
                ? PdfColors.red700
                : PdfColors.orange700;

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Column(
        children: [
          _buildSummaryRow('Batch ID', batchId),
          _buildSummaryRow('Date', transactionDate),
          // Status with colored badge
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom:
                    pw.BorderSide(color: PdfColors.grey200, width: 0.5),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Status',
                    style: _getTextStyle(
                        fontSize: 11, color: PdfColors.grey700)),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: pw.BoxDecoration(
                    color: statusColor.shade(50),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    status,
                    style: _getTextStyle(fontSize: 10, isBold: true)
                        .copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
          ),
          _buildSummaryRow('Recipients', '$recipientCount'),
          if (failedTransfers > 0) ...[
            _buildSummaryRow('Successful', '$successfulTransfers'),
            _buildSummaryRow('Failed', '$failedTransfers'),
          ],
          if (isScheduled && scheduledDateTime != null)
            _buildSummaryRow('Scheduled For',
                DateFormat('MMM dd, yyyy HH:mm').format(scheduledDateTime)),
        ],
      ),
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
          pw.Expanded(
            child: pw.Text(
              value,
              style: _getTextStyle(fontSize: 11),
              textAlign: pw.TextAlign.right,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTransferDetails({
    required String currencySymbol,
    required double totalAmount,
    required double totalFee,
    required String batchId,
    required String currency,
    required int recipientCount,
  }) {
    final total = totalAmount + totalFee;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Transfer Details',
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
              _buildDetailRow(
                  'Amount',
                  '$currencySymbol${totalAmount.toStringAsFixed(2)}',
                  isBold: true,
                  isHighlight: true),
              _buildDetailRow(
                  'Fee',
                  totalFee == 0
                      ? 'Free'
                      : '$currencySymbol${totalFee.toStringAsFixed(2)}'),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 8),
                child: pw.Divider(color: PdfColors.grey300, height: 1),
              ),
              _buildDetailRow(
                  'Total', '$currencySymbol${total.toStringAsFixed(2)}',
                  isBold: true),
              pw.SizedBox(height: 8),
              _buildDetailRow('Currency', _currencyNameFor(currency)),
              _buildDetailRow(
                  'Recipients',
                  '$recipientCount transfer${recipientCount == 1 ? '' : 's'}'),
              _buildDetailRow('Batch ID', batchId, isSmall: true),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isBold = false, bool isSmall = false, bool isHighlight = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(
              label,
              style: _getTextStyle(fontSize: isSmall ? 10 : 11, isBold: true)
                  .copyWith(color: PdfColors.grey700),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: _getTextStyle(
                fontSize: isHighlight ? 14 : (isSmall ? 10 : 11),
                isBold: isBold,
              ).copyWith(color: isHighlight ? PdfColors.blue800 : null),
              textAlign: pw.TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRecipientsTable(
      List<dynamic> transfers, String currencySymbol, PdfColor statusColor) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(2.5),
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
        ...transfers.map((t) {
          final transfer = t as Map<String, dynamic>;
          final name = _resolveTransferName(transfer);
          final account =
              transfer['recipientAccount'] as String? ?? 'N/A';
          final amount =
              (transfer['amount'] as num?)?.toDouble() ?? 0.0;
          final status = transfer['status'] as String? ?? 'Pending';

          return pw.TableRow(
            children: [
              _buildTableCell(name),
              _buildTableCell(account),
              _buildTableCell(
                  '$currencySymbol${amount.toStringAsFixed(2)}'),
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: pw.BoxDecoration(
                    color: statusColor.shade(50),
                    borderRadius: pw.BorderRadius.circular(3),
                  ),
                  child: pw.Text(
                    _formatStatus(status),
                    style: _getTextStyle(fontSize: 9, isBold: true)
                        .copyWith(color: statusColor),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildTableCell(String text, {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 11 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
        maxLines: 2,
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
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
                pw.Text(
                  'Get help directly in-app or email support@lazervault.com',
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
                  'Page ${context.pageNumber} of ${context.pagesCount}',
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
            'LazerVault Technologies Ltd is a licensed financial technology company. '
            'This document is a confirmation of a batch transfer processed through the LazerVault platform. '
            'For any queries regarding this transaction, please contact support through the LazerVault app or visit www.lazervault.com.',
            style: _getTextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.justify,
          ),
        ),
      ],
    );
  }

  /// Resolve the best name from a transfer map, avoiding generic names
  static String _resolveTransferName(Map<String, dynamic> transfer) {
    final recipientName = transfer['recipientName'] as String?;
    final beneficiaryName = transfer['beneficiaryName'] as String?;
    final name = transfer['name'] as String?;

    if (beneficiaryName != null && beneficiaryName.isNotEmpty &&
        beneficiaryName.toLowerCase() != 'unknown' &&
        beneficiaryName.toLowerCase() != 'external account') {
      return beneficiaryName;
    }
    if (recipientName != null && recipientName.isNotEmpty &&
        recipientName.toLowerCase() != 'unknown' &&
        recipientName.toLowerCase() != 'business') {
      return recipientName;
    }
    return name ?? recipientName ?? beneficiaryName ?? 'Unknown';
  }

  static String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'Completed';
      case 'pending':
      case 'processing':
        return 'Pending';
      case 'failed':
        return 'Failed';
      case 'scheduled':
        return 'Scheduled';
      case 'partial':
      case 'partially_failed':
        return 'Partial';
      default:
        return status;
    }
  }

  /// Convert a BatchTransferEntity to the receiptData map format
  static Map<String, dynamic> entityToReceiptData(
    BatchTransferEntity entity, {
    String currency = 'NGN',
    String? senderAccountName,
    String? senderAccountInfo,
  }) {
    return {
      'batchId': entity.batchId,
      'totalAmount': entity.totalAmount.toDouble() / 100,
      'totalFee': entity.totalFee.toDouble() / 100,
      'currency': currency,
      'timestamp': entity.completedAt ?? entity.createdAt,
      'status': entity.status,
      'recipientCount': entity.totalTransfers,
      'successfulTransfers': entity.successfulTransfers,
      'failedTransfers': entity.failedTransfers,
      'newBalance': entity.newBalance,
      'message': entity.message,
      'senderAccountName': senderAccountName,
      'senderAccountInfo': senderAccountInfo,
      'transfers': entity.results
          .map((r) => {
                'recipientName': r.recipientName ?? r.beneficiaryName ?? 'Unknown',
                'beneficiaryName': r.beneficiaryName,
                'recipientAccount': r.recipientAccount ?? '',
                'amount': r.amount.toDouble() / 100,
                'fee': r.fee.toDouble() / 100,
                'status': r.status,
                'failureReason': r.failureReason,
                'reference': r.reference,
              })
          .toList(),
    };
  }

  /// Download receipt to device storage
  static Future<String> downloadReceipt({
    required Map<String, dynamic> receiptData,
  }) async {
    try {
      final file = await generateReceipt(receiptData: receiptData);

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

      final batchId = receiptData['batchId']?.toString() ?? 'batch';
      final safeId =
          batchId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName = 'batch_transfer_receipt_$safeId.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to download batch transfer receipt: $e');
    }
  }

  /// Share receipt via system share sheet
  static Future<void> shareReceipt({
    required Map<String, dynamic> receiptData,
  }) async {
    try {
      final file = await generateReceipt(receiptData: receiptData);

      final currency = receiptData['currency'] as String? ?? 'NGN';
      final totalAmount =
          (receiptData['totalAmount'] as num?)?.toDouble() ?? 0.0;
      final currencySymbol = _currencySymbolFor(currency);
      final recipientCount = receiptData['recipientCount'] as int? ?? 0;
      final batchId = receiptData['batchId']?.toString() ?? '';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'LazerVault Batch Transfer Receipt - $currencySymbol${totalAmount.toStringAsFixed(2)} to $recipientCount recipients',
        subject: 'LazerVault Batch Transfer Receipt - $batchId',
      ));
    } catch (e) {
      throw Exception('Failed to share batch transfer receipt: $e');
    }
  }

  /// Generate a single-recipient receipt PDF from batch transfer data
  static Future<File> generateIndividualReceipt({
    required Map<String, dynamic> receiptData,
    required Map<String, dynamic> transfer,
  }) async {
    await _loadFonts();
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final generatedDate = _displayDateFormat.format(DateTime.now());

    // Extract batch-level data
    final batchId = receiptData['batchId']?.toString() ??
        'BTX${DateTime.now().millisecondsSinceEpoch}';
    final currency = receiptData['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbolFor(currency);
    final isScheduled = receiptData['isScheduled'] as bool? ?? false;
    final scheduledAt = receiptData['scheduledAt'] as String?;
    final senderName =
        receiptData['senderAccountName'] as String? ?? 'LazerVault User';
    final senderAccountInfo = receiptData['senderAccountInfo'] as String?;

    DateTime? timestamp;
    if (receiptData['timestamp'] != null) {
      timestamp = receiptData['timestamp'] as DateTime?;
    }
    timestamp ??= DateTime.now();
    final transactionDate = _dateFormat.format(timestamp);

    DateTime? scheduledDateTime;
    if (scheduledAt != null) {
      try {
        scheduledDateTime = DateTime.parse(scheduledAt).toLocal();
      } catch (_) {}
    }

    // Extract individual transfer data
    final recipientName = _resolveTransferName(transfer);
    final recipientAccount =
        transfer['recipientAccount'] as String? ?? 'N/A';
    final amount = (transfer['amount'] as num?)?.toDouble() ?? 0.0;
    final fee = (transfer['fee'] as num?)?.toDouble() ?? 0.0;
    final status = transfer['status'] as String? ?? 'Completed';
    final reference = transfer['reference'] as String? ?? batchId;
    final failureReason = transfer['failureReason'] as String?;

    final statusColor = status.toLowerCase() == 'failed'
        ? PdfColors.red700
        : status.toLowerCase() == 'completed' ||
                status.toLowerCase() == 'success'
            ? PdfColors.green700
            : PdfColors.orange700;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(logo, generatedDate, isScheduled),
              pw.SizedBox(height: 24),

              // Sender info and summary side by side
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: _buildSenderInfo(
                      senderName: senderName,
                      accountInfo: senderAccountInfo,
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey100,
                        borderRadius: pw.BorderRadius.circular(8),
                        border: pw.Border.all(color: PdfColors.grey200),
                      ),
                      child: pw.Column(
                        children: [
                          _buildSummaryRow('Batch ID', batchId),
                          _buildSummaryRow('Date', transactionDate),
                          pw.Container(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 4),
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                bottom: pw.BorderSide(
                                    color: PdfColors.grey200, width: 0.5),
                              ),
                            ),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('Status',
                                    style: _getTextStyle(
                                        fontSize: 11,
                                        color: PdfColors.grey700)),
                                pw.Container(
                                  padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: pw.BoxDecoration(
                                    color: statusColor.shade(50),
                                    borderRadius:
                                        pw.BorderRadius.circular(4),
                                  ),
                                  child: pw.Text(
                                    _formatStatus(status),
                                    style: _getTextStyle(
                                            fontSize: 10, isBold: true)
                                        .copyWith(color: statusColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildSummaryRow('Reference', reference),
                          if (isScheduled && scheduledDateTime != null)
                            _buildSummaryRow(
                                'Scheduled For',
                                DateFormat('MMM dd, yyyy HH:mm')
                                    .format(scheduledDateTime)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Transfer amount details
              pw.Text('Transfer Details',
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
                    _buildDetailRow(
                        'Amount',
                        '$currencySymbol${amount.toStringAsFixed(2)}',
                        isBold: true,
                        isHighlight: true),
                    _buildDetailRow(
                        'Fee',
                        fee == 0
                            ? 'Free'
                            : '$currencySymbol${fee.toStringAsFixed(2)}'),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(vertical: 8),
                      child: pw.Divider(
                          color: PdfColors.grey300, height: 1),
                    ),
                    _buildDetailRow(
                        'Total',
                        '$currencySymbol${(amount + fee).toStringAsFixed(2)}',
                        isBold: true),
                    pw.SizedBox(height: 8),
                    _buildDetailRow(
                        'Currency', _currencyNameFor(currency)),
                    _buildDetailRow('Reference', reference,
                        isSmall: true),
                  ],
                ),
              ),
              pw.SizedBox(height: 32),

              // Beneficiary details
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
                    _buildDetailRow('Name', recipientName, isBold: true),
                    _buildDetailRow('Account', recipientAccount),
                    _buildDetailRow('Bank', 'LazerVault'),
                  ],
                ),
              ),

              // Failure reason if applicable
              if (status.toLowerCase() == 'failed' &&
                  failureReason != null &&
                  failureReason.isNotEmpty) ...[
                pw.SizedBox(height: 16),
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.red50,
                    border: pw.Border.all(color: PdfColors.red200),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Failure Reason: ',
                          style:
                              _getTextStyle(fontSize: 11, isBold: true)
                                  .copyWith(color: PdfColors.red800)),
                      pw.Expanded(
                        child: pw.Text(failureReason,
                            style: _getTextStyle(
                                fontSize: 11,
                                color: PdfColors.red800)),
                      ),
                    ],
                  ),
                ),
              ],

              pw.Spacer(),

              // Footer
              _buildFooter(context),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final safeName =
        recipientName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final safeId =
        batchId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileName =
        'transfer_receipt_${safeName}_$safeId.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download individual recipient receipt to device storage
  static Future<String> downloadIndividualReceipt({
    required Map<String, dynamic> receiptData,
    required Map<String, dynamic> transfer,
  }) async {
    try {
      final file = await generateIndividualReceipt(
        receiptData: receiptData,
        transfer: transfer,
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

      final recipientName =
          transfer['recipientName'] as String? ?? 'recipient';
      final batchId = receiptData['batchId']?.toString() ?? 'batch';
      final safeName =
          recipientName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final safeId =
          batchId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName =
          'transfer_receipt_${safeName}_$safeId.pdf';
      final savedFile = File('${directory.path}/$fileName');
      await file.copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw Exception(
          'Failed to download individual transfer receipt: $e');
    }
  }

  /// Share individual recipient receipt via system share sheet
  static Future<void> shareIndividualReceipt({
    required Map<String, dynamic> receiptData,
    required Map<String, dynamic> transfer,
  }) async {
    try {
      final file = await generateIndividualReceipt(
        receiptData: receiptData,
        transfer: transfer,
      );

      final currency = receiptData['currency'] as String? ?? 'NGN';
      final currencySymbol = _currencySymbolFor(currency);
      final amount = (transfer['amount'] as num?)?.toDouble() ?? 0.0;
      final recipientName =
          transfer['recipientName'] as String? ?? 'Recipient';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            'LazerVault Transfer Receipt - $currencySymbol${amount.toStringAsFixed(2)} to $recipientName',
        subject: 'LazerVault Transfer Receipt - $recipientName',
      ));
    } catch (e) {
      throw Exception(
          'Failed to share individual transfer receipt: $e');
    }
  }
}
