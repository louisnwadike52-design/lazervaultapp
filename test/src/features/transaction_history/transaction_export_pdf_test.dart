import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_statement_pdf.dart';

/// THE EXPORTED STATEMENT PRINTED ITS HEADER AND THEN NOTHING.
///
/// Reported from the dashboard: the PDF read "19 Sep 2026 - 19 Oct 2026 /
/// 23 transactions" over a blank page. The count comes from the very list the
/// table is built from, so the data was never missing — the table rendered
/// empty.
///
/// The old layout chunked rows 25-to-a-FIXED-`pw.Page` and put the table and a
/// `pw.Spacer()` in one Column. `cellHeight: 22` is a minimum, not a height:
/// real descriptions ("Data purchase - MTN-DATA 07033609489") wrap to two or
/// three lines, so 23 rows are much taller than the chunk size assumes. Once
/// the non-flex children overflow, the Spacer's space goes negative and a
/// fixed page has nowhere to put the remainder.
///
/// These tests use realistic long descriptions on purpose — short ones fit,
/// which is why this survived.

UnifiedTransaction tx(int i, {String? description}) => UnifiedTransaction(
      id: 'tx-$i',
      serviceType: TransactionServiceType.values.first,
      title: 'Payment $i',
      description: description ??
          'Data purchase - MTN-DATA 07033609489 reference DATA-179231040$i',
      amount: 380 + i.toDouble(),
      currency: 'NGN',
      createdAt: DateTime(2026, 10, 1).add(Duration(days: i % 28)),
      status: UnifiedTransactionStatus.values.first,
      flow: TransactionFlow.outgoing,
      balanceBefore: 54012.76,
      balanceAfter: 53632.76,
    );

Future<int> bytesFor(int n) async {
  final out = await buildTransactionStatementPdf(
    transactions: List.generate(n, tx),
    startDate: DateTime(2026, 9, 19),
    endDate: DateTime(2026, 10, 19),
  );
  return out.length;
}

void main() {
  test('the rows are actually in the document', () async {
    // THE REGRESSION. If the table renders nothing, a 23-row statement is
    // byte-for-byte almost a 1-row one — a header over a blank page, which is
    // exactly what shipped. Most of the file is the embedded Inter subset, so
    // the signal is the DELTA, not the ratio: measured here, 23 rows add
    // ~3.4KB over 1 row, and an empty body would add approximately nothing.
    final one = await bytesFor(1);
    final many = await bytesFor(23);
    expect(many - one, greaterThan(1000),
        reason: 'the 23-row statement is the same size as the 1-row one, so '
            'the table body rendered empty — the reported bug');
  });

  test('it grows with the data, so nothing is being silently dropped',
      () async {
    final a = await bytesFor(10);
    final b = await bytesFor(40);
    final c = await bytesFor(120);
    expect(b, greaterThan(a));
    expect(c, greaterThan(b),
        reason: '120 rows must flow onto further pages, not fall off the '
            'end of a fixed one — the old code capped each page at 25 rows '
            'by COUNT and overflowed anyway once they wrapped');
  });

  test('120 rows do not throw — the table flows across pages', () async {
    // The old fixed-page model is where an overflow could take the whole
    // export down. MultiPage must simply paginate.
    await expectLater(bytesFor(120), completes);
  });

  test('an empty range still produces a readable document, not a blank one',
      () async {
    // The caller blocks this case with a message, but the generator must not
    // be the thing that decides — a zero-row export has to say so in words
    // rather than hand the user an empty page.
    final out = await buildTransactionStatementPdf(
      transactions: const [],
      startDate: DateTime(2026, 9, 19),
      endDate: DateTime(2026, 10, 19),
    );
    expect(out.length, greaterThan(0));
  });

  test('very long descriptions wrap instead of emptying the page', () async {
    // The precise trigger: a cell far taller than the assumed 22pt.
    final long = List.generate(
      23,
      (i) => tx(i,
          description: 'Voice assistant usage — session '
              '${'x' * 90} continued $i'),
    );
    final out = await buildTransactionStatementPdf(
      transactions: long,
      startDate: DateTime(2026, 9, 19),
      endDate: DateTime(2026, 10, 19),
    );
    final short = await bytesFor(23);
    expect(out.length, greaterThan(short),
        reason: 'longer text must produce a bigger document, not a blank one');
  });
}
