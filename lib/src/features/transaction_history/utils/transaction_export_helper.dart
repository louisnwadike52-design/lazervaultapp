import 'dart:io';
import 'dart:ui' show Rect;
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_statement_pdf.dart';
import 'package:path_provider/path_provider.dart';
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
        text: 'Lazervault Transaction History',
        // iOS requires a non-zero popover anchor; omitting it makes share_plus
        // pass CGRectZero and the whole export throws PlatformException
        // ("sharePositionOrigin: argument must be set … must be non-zero") —
        // the "Export failed" the user hit. A 1×1 rect at the origin is always
        // inside the view's coordinate space (same fallback as receipts).
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      ),
    );
  }

  static Future<File> _exportCsv(
    List<UnifiedTransaction> transactions,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final rows = <List<String>>[
      [
        'Date',
        'Time',
        'Type',
        'Description',
        'Amount',
        'Balance before',
        'Balance after',
        'Currency',
        'Status',
        'Reference'
      ],
    ];

    for (final tx in transactions) {
      rows.add([
        DateFormat('yyyy-MM-dd').format(tx.createdAt),
        DateFormat('HH:mm:ss').format(tx.createdAt),
        tx.serviceType.displayName,
        tx.description ?? tx.title,
        '${tx.flow == TransactionFlow.outgoing ? "-" : ""}${tx.amount.toStringAsFixed(2)}',
        // Raw, unformatted and unseparated: a CSV cell is going into a
        // spreadsheet, where "1,234.00" becomes text and stops adding up.
        tx.balanceBefore?.toStringAsFixed(2) ?? '',
        tx.balanceAfter?.toStringAsFixed(2) ?? '',
        tx.currency,
        tx.status.displayName,
        tx.transactionReference ?? '',
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final dateRange =
        '${DateFormat('yyyyMMdd').format(startDate)}_${DateFormat('yyyyMMdd').format(endDate)}';
    final file = File('${dir.path}/Lazervault_Transactions_$dateRange.csv');
    await file.writeAsString(csvString);
    return file;
  }

  static Future<File> _exportPdf(
    List<UnifiedTransaction> transactions,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // The document is built by buildTransactionStatementPdf, which returns
    // BYTES. Keeping the layout out of here is what finally let it be tested:
    // writing the file needs a platform binding, and that is why the statement
    // could print a header over a blank page without any test noticing.
    final bytes = await buildTransactionStatementPdf(
      transactions: transactions,
      startDate: startDate,
      endDate: endDate,
    );

    final dir = await getTemporaryDirectory();
    final fileDate =
        '${DateFormat('yyyyMMdd').format(startDate)}_${DateFormat('yyyyMMdd').format(endDate)}';
    final file = File('${dir.path}/Lazervault_Transactions_$fileDate.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }
}
