import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_lookup.dart';

/// What makes a notification deep link able to open the ACTUAL receipt.
///
/// The server sends whichever identifier the publishing service had, and the
/// services do not agree: a reference can arrive raw (`IDEM-CR-SPRAY-WD-x`),
/// stripped (`SPRAY-WD-x`), as a credit leg (`…-CR`), under a reservation
/// prefix (`HOLD-AIR-1`), or only inside `metadata.reference` when the row
/// itself is a `HOLD-CAP` settlement. Every one of those has to find the same
/// row, or the tap lands on a list instead of the receipt.
UnifiedTransaction _tx({
  required String id,
  String? reference,
  Map<String, dynamic>? metadata,
  TransactionFlow flow = TransactionFlow.outgoing,
}) =>
    UnifiedTransaction(
      id: id,
      serviceType: TransactionServiceType.transfer,
      title: 'T $id',
      amount: 200,
      currency: 'NGN',
      createdAt: DateTime(2026, 11, 3),
      status: UnifiedTransactionStatus.completed,
      flow: flow,
      transactionReference: reference,
      metadata: metadata,
    );

void main() {
  group('normalizeTransactionRef', () {
    test('drops the credit-leg suffix so both legs compare equal', () {
      expect(normalizeTransactionRef('TRF-1-CR'), 'TRF-1');
      expect(normalizeTransactionRef('TRF-1'), 'TRF-1');
    });

    test('strips the reservation and idempotency prefixes', () {
      expect(normalizeTransactionRef('HOLD-AIR-1791750032'), 'AIR-1791750032');
      expect(
        normalizeTransactionRef('IDEM-CR-SPRAY-WD-53a25fe4'),
        'SPRAY-WD-53A25FE4',
      );
    });

    test('keeps HOLD-CAP whole', () {
      // HOLD-CAP is a settlement row in its own right and is what
      // external_transfer_merge keys on. Collapsing it to its reserve id would
      // make two different rows compare equal.
      expect(
        normalizeTransactionRef('HOLD-CAP-abc'),
        'HOLD-CAP-ABC',
      );
    });

    test('is case-insensitive in both directions', () {
      expect(
        normalizeTransactionRef('trf-1'),
        normalizeTransactionRef('TRF-1'),
      );
    });

    test('an empty or blank identifier normalises to empty', () {
      expect(normalizeTransactionRef('   '), '');
    });
  });

  group('findTransaction', () {
    final rows = [
      _tx(id: 'row-1', reference: 'IDEM-DR-TRF-1'),
      _tx(
        id: 'row-2',
        reference: 'HOLD-CAP-reserve-9',
        metadata: const {'reference': 'TRF-2'},
      ),
      _tx(id: 'row-3', reference: 'HOLD-AIR-77'),
    ];

    test('finds a row by its own id', () {
      expect(findTransaction(rows, 'row-1')!.id, 'row-1');
    });

    test('finds a row by its raw reference', () {
      expect(findTransaction(rows, 'IDEM-DR-TRF-1')!.id, 'row-1');
    });

    test('finds a row by the business reference the receipt shows', () {
      // This is the one that matters: the server quotes `TRF-1` in the push
      // body and in `data.reference`, while the ledger stored the idempotency
      // marker. An exact string compare finds nothing here.
      expect(findTransaction(rows, 'TRF-1')!.id, 'row-1');
    });

    test('finds a row by the credit leg of its reference', () {
      expect(findTransaction(rows, 'TRF-1-CR')!.id, 'row-1');
    });

    test('finds a settlement row through metadata.reference', () {
      // A HOLD-CAP row's own reference is the reserve id; the reference the
      // notification quoted survives only in metadata.
      expect(findTransaction(rows, 'TRF-2')!.id, 'row-2');
    });

    test('finds a reserved bill payment by its business reference', () {
      expect(findTransaction(rows, 'AIR-77')!.id, 'row-3');
    });

    test('returns null rather than guessing', () {
      expect(findTransaction(rows, 'TRF-999'), isNull);
      expect(findTransaction(rows, ''), isNull);
      expect(findTransaction(const [], 'TRF-1'), isNull);
    });

    test('a blank identifier never matches a row with a blank reference', () {
      // The empty-string trap: a row with no reference must not become the
      // answer to every unresolvable link.
      final blank = [_tx(id: 'row-x', reference: '')];
      expect(findTransaction(blank, '  '), isNull);
      expect(transactionMatches(blank.first, ''), isFalse);
    });

    test('returns the first match, which is the freshest row', () {
      // Rows arrive newest-first; an internal transfer has two legs under
      // derived references and either is a correct answer.
      final twoLegs = [
        _tx(id: 'new', reference: 'TRF-5', flow: TransactionFlow.outgoing),
        _tx(id: 'old', reference: 'TRF-5-CR', flow: TransactionFlow.incoming),
      ];
      expect(findTransaction(twoLegs, 'TRF-5')!.id, 'new');
    });
  });
}
