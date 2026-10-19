library;

import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Builds the exported transaction statement.
///
/// THE STATEMENT PRINTED ITS HEADER AND THEN NOTHING. Reported from the
/// dashboard: the PDF read "19 Sep 2026 - 19 Oct 2026 / 23 transactions" over a
/// blank page. The count is taken from the very list the table is built from,
/// so the data was never missing — the table rendered empty.
///
/// The cause was the page model. It used a FIXED `pw.Page` per 25 rows, with
/// the rows and a `pw.Spacer()` in one `pw.Column`. `cellHeight: 22` is a
/// MINIMUM, not a height: descriptions like "Data purchase - MTN-DATA
/// 07033609489" wrap to two or three lines, so 23 real rows are far taller than
/// the 506pt the chunk size assumes. Once the non-flex children exceed the
/// page, the `Spacer`'s flex space goes negative and the column cannot lay out
/// — and a fixed page has nowhere to put the overflow, so the body came out
/// blank while the header, measured before the table, still drew.
///
/// `pw.MultiPage` is the widget for this: it flows a table across as many pages
/// as the CONTENT needs, measuring real row heights instead of trusting a row
/// count. The chunking, the per-page `if (p == 0)` header and the `Spacer` all
/// go away with it, and with them three ways to get the same bug back.
///
/// Returning bytes rather than a File is deliberate — writing to disk needs a
/// platform binding, and that is what stopped this from being covered by a
/// test before.
Future<Uint8List> buildTransactionStatementPdf({
  required List<UnifiedTransaction> transactions,
  required DateTime startDate,
  required DateTime endDate,
  String title = 'Transaction History',
}) async {
  await ReceiptFonts.load();

  final doc = pw.Document(
    theme: ReceiptFonts.embedded
        ? pw.ThemeData.withFont(
            base: ReceiptFonts.regular!,
            bold: ReceiptFonts.bold!,
          )
        : null,
  );

  final dateRange = '${DateFormat('d MMM yyyy').format(startDate)} - '
      '${DateFormat('d MMM yyyy').format(endDate)}';
  final generated =
      'Generated ${DateFormat('d MMM yyyy, h:mm a').format(DateTime.now())}';

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      header: (context) => context.pageNumber == 1
          ? _statementHeader(title, dateRange, transactions.length)
          : pw.SizedBox(height: 0),
      footer: (context) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 8),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(generated,
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500)),
            pw.Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500)),
          ],
        ),
      ),
      build: (context) => [
        if (transactions.isEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 40),
            child: pw.Center(
              child: pw.Text(
                'No transactions found for the selected period.',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ),
          )
        else
          _statementTable(transactions),
      ],
    ),
  );

  return doc.save();
}

pw.Widget _statementHeader(String title, String dateRange, int count) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text('Lazervault',
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 4),
      pw.Text(title, style: const pw.TextStyle(fontSize: 14)),
      pw.SizedBox(height: 2),
      pw.Text(dateRange,
          style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600)),
      pw.SizedBox(height: 4),
      pw.Text('$count transaction${count == 1 ? "" : "s"}',
          style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600)),
      pw.SizedBox(height: 12),
    ],
  );
}

/// A balance cell for the statement.
///
/// Prints an em dash for a row that has no wallet balance — a crypto leg, or
/// a service-local record. "0.00" there would read as an emptied account,
/// which is the one thing a statement must never imply by accident.
String _balanceCell(double? value) =>
    value == null ? '—' : NumberFormat('#,##0.00').format(value);

pw.Widget _statementTable(List<UnifiedTransaction> transactions) {
  return pw.TableHelper.fromTextArray(
    headerStyle: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
    cellStyle: const pw.TextStyle(fontSize: 8),
    headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
    // No cellHeight: it is a MINIMUM, and pinning it was part of how the old
    // fixed-page maths under-counted how tall 23 wrapped rows really are.
    cellPadding: const pw.EdgeInsets.symmetric(horizontal: 3, vertical: 5),
    // Repeat the column headings on every page the table flows onto.
    headerCount: 1,
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
    headers: const [
      'Date',
      'Type',
      'Description',
      'Amount',
      'Balance before',
      'Balance after',
      'Currency',
      'Status',
    ],
    data: transactions.map((tx) {
      final sign = tx.flow == TransactionFlow.outgoing ? '-' : '+';
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
  );
}
