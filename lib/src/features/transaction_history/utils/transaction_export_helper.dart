import 'dart:io';
import 'dart:ui' show Rect;
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
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

  /// A balance cell for the statement.
  ///
  /// Prints an em dash for a row that has no wallet balance — a crypto leg, or
  /// a service-local record. "0.00" there would read as an emptied account,
  /// which is the one thing a statement must never imply by accident.
  static String _balanceCell(double? value) {
    if (value == null) return '—';
    return NumberFormat('#,##0.00').format(value);
  }

  static Future<File> _exportPdf(
    List<UnifiedTransaction> transactions,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // EMBED A REAL TYPEFACE.
    //
    // pw.Document() with no theme draws with the PDF built-in Helvetica, which
    // has no glyph for most of what this statement actually contains — so
    // "Voice assistant usage — session …" printed the em dash as a hollow box,
    // and the same would happen to ₦, curly quotes and accented names. Inter is
    // already bundled and already shared by every receipt in the app
    // (ReceiptFonts); this export simply never asked for it.
    await ReceiptFonts.load();
    final pdf = pw.Document(
      theme: ReceiptFonts.embedded
          ? pw.ThemeData.withFont(
              base: ReceiptFonts.regular!,
              bold: ReceiptFonts.bold!,
            )
          : null,
    );
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
                    'Lazervault',
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
                    0: const pw.FlexColumnWidth(1.7),
                    1: const pw.FlexColumnWidth(1.9),
                    2: const pw.FlexColumnWidth(3.1),
                    3: const pw.FlexColumnWidth(1.6),
                    4: const pw.FlexColumnWidth(1.7),
                    5: const pw.FlexColumnWidth(1.7),
                    6: const pw.FlexColumnWidth(1.0),
                    7: const pw.FlexColumnWidth(1.3),
                  },
                  headers: [
                    'Date',
                    'Type',
                    'Description',
                    'Amount',
                    'Balance before',
                    'Balance after',
                    'Currency',
                    'Status'
                  ],
                  data: pageItems.map((tx) {
                    final sign =
                        tx.flow == TransactionFlow.outgoing ? '-' : '+';
                    return [
                      DateFormat('dd/MM/yy').format(tx.createdAt),
                      tx.serviceType.displayName,
                      tx.description ?? tx.title,
                      '$sign${tx.amount.toStringAsFixed(2)}',
                      _balanceCell(tx.balanceBefore),
                      _balanceCell(tx.balanceAfter),
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
    final file = File('${dir.path}/Lazervault_Transactions_$fileDate.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
