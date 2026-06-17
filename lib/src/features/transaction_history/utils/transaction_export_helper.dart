import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

enum ExportFormat { csv, pdf }

class TransactionExportHelper {
  TransactionExportHelper._();

  static Future<File> exportTransactions({
    required List<UnifiedTransaction> transactions,
    required ExportFormat format,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    switch (format) {
      case ExportFormat.csv:
        return _exportCsv(transactions, startDate, endDate);
      case ExportFormat.pdf:
        return _exportPdf(transactions, startDate, endDate);
    }
  }

  static Future<void> exportAndShare({
    required List<UnifiedTransaction> transactions,
    required ExportFormat format,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final file = await exportTransactions(
      transactions: transactions,
      format: format,
      startDate: startDate,
      endDate: endDate,
    );

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'LazerVault Transaction History',
      ),
    );
  }

  static Future<File> _exportCsv(
    List<UnifiedTransaction> transactions,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final rows = <List<String>>[
      ['Date', 'Time', 'Type', 'Description', 'Amount', 'Currency', 'Status', 'Reference'],
    ];

    for (final tx in transactions) {
      rows.add([
        DateFormat('yyyy-MM-dd').format(tx.createdAt),
        DateFormat('HH:mm:ss').format(tx.createdAt),
        tx.serviceType.displayName,
        tx.description ?? tx.title,
        '${tx.flow == TransactionFlow.outgoing ? "-" : ""}${tx.amount.toStringAsFixed(2)}',
        tx.currency,
        tx.status.displayName,
        tx.transactionReference ?? '',
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final dateRange =
        '${DateFormat('yyyyMMdd').format(startDate)}_${DateFormat('yyyyMMdd').format(endDate)}';
    final file = File('${dir.path}/LazerVault_Transactions_$dateRange.csv');
    await file.writeAsString(csvString);
    return file;
  }

  static Future<File> _exportPdf(
    List<UnifiedTransaction> transactions,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final pdf = pw.Document();
    final dateRange =
        '${DateFormat('d MMM yyyy').format(startDate)} - ${DateFormat('d MMM yyyy').format(endDate)}';

    // Split into pages of 25 transactions
    const perPage = 25;
    final pages = (transactions.length / perPage).ceil();

    for (int p = 0; p < pages; p++) {
      final pageItems = transactions.skip(p * perPage).take(perPage).toList();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (p == 0) ...[
                  pw.Text(
                    'LazerVault',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Transaction History',
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    dateRange,
                    style: pw.TextStyle(
                      fontSize: 11,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    '${transactions.length} transaction${transactions.length == 1 ? "" : "s"}',
                    style: pw.TextStyle(
                      fontSize: 11,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.SizedBox(height: 12),
                ],
                pw.TableHelper.fromTextArray(
                  headerStyle: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellStyle: const pw.TextStyle(fontSize: 8),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey200,
                  ),
                  cellHeight: 22,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(2.5),
                    2: const pw.FlexColumnWidth(3),
                    3: const pw.FlexColumnWidth(1.8),
                    4: const pw.FlexColumnWidth(1.2),
                    5: const pw.FlexColumnWidth(1.5),
                  },
                  headers: ['Date', 'Type', 'Description', 'Amount', 'Currency', 'Status'],
                  data: pageItems.map((tx) {
                    final sign = tx.flow == TransactionFlow.outgoing ? '-' : '+';
                    return [
                      DateFormat('dd/MM/yy').format(tx.createdAt),
                      tx.serviceType.displayName,
                      tx.description ?? tx.title,
                      '$sign${tx.amount.toStringAsFixed(2)}',
                      tx.currency,
                      tx.status.displayName,
                    ];
                  }).toList(),
                ),
                pw.Spacer(),
                pw.Text(
                  'Generated ${DateFormat('d MMM yyyy, h:mm a').format(DateTime.now())}',
                  style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
                ),
              ],
            );
          },
        ),
      );
    }

    if (transactions.isEmpty) {
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Center(
            child: pw.Text('No transactions found for the selected period.'),
          ),
        ),
      );
    }

    final dir = await getTemporaryDirectory();
    final fileDate =
        '${DateFormat('yyyyMMdd').format(startDate)}_${DateFormat('yyyyMMdd').format(endDate)}';
    final file = File('${dir.path}/LazerVault_Transactions_$fileDate.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
