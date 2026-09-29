// One transfer must appear ONCE in history, carrying the fee and naming the payee.
//
// Reported live: a single ₦200 transfer showed as TWO pending rows —
// "Transfer Sent / External transfer ₦223" (the ledger hold: principal + ₦23
// fee) and "Transfer to GRACE C. ON… ₦200" (the payment). Same money, two
// services.
//
// The collapse keys a ledger HOLD-CAP row on `metadata.reference`, the only
// field carrying the TRF-… reference the payments side uses. It silently
// failed while the transfer was PENDING because the pending ledger row shipped
// `metadata = {}`. accounts-service now stamps the originating reference at
// placement; this pins the client half.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/external_transfer_merge.dart';

UnifiedTransaction _tx({
  required String id,
  required String reference,
  required double amount,
  Map<String, dynamic>? metadata,
  String? counterpartyName,
  String title = 'Transfer',
}) =>
    UnifiedTransaction(
      id: id,
      serviceType: TransactionServiceType.transfer,
      title: title,
      amount: amount,
      currency: 'NGN',
      createdAt: DateTime(2026, 9, 29, 13, 7),
      status: UnifiedTransactionStatus.pending,
      flow: TransactionFlow.outgoing,
      transactionReference: reference,
      metadata: metadata,
      counterpartyName: counterpartyName,
    );

void main() {
  test('a pending transfer collapses to ONE row once the hold carries the reference', () {
    final ledger = _tx(
      id: 'ledger-1',
      reference: 'HOLD-CAP-8ea6e75d-8566-4346-bb1e-3a19b0e37146',
      amount: 223,
      metadata: const {'reference': 'TRF-transfer_56976d64'},
      title: 'Transfer Sent',
    );
    final payment = _tx(
      id: 'pay-1',
      reference: 'TRF-transfer_56976d64',
      amount: 200,
      counterpartyName: 'GRACE C. ONWUKA',
      title: 'Transfer to GRACE C. ONWUKA',
    );

    final merged = mergeExternalTransfers([ledger], [payment]);

    expect(merged, hasLength(1), reason: 'the same transfer was listed twice');
    expect(merged.single.amount, 223,
        reason: 'the surviving row must be the money that left — principal + fee');
    expect(merged.single.counterpartyName, 'GRACE C. ONWUKA',
        reason: 'only the payment row knows the payee; it must survive the merge');
  });

  test('a hold with no reference cannot collapse — documents the original bug', () {
    final ledger = _tx(
      id: 'ledger-1',
      reference: 'HOLD-CAP-8ea6e75d',
      amount: 223,
      metadata: const {}, // what the pending row used to ship
    );
    final payment =
        _tx(id: 'pay-1', reference: 'TRF-transfer_56976d64', amount: 200);

    expect(mergeExternalTransfers([ledger], [payment]), hasLength(2),
        reason: 'no reference on the hold means no join key, hence the duplicate');
  });

  test('unrelated transfers are never collapsed together', () {
    final a = _tx(id: 'a', reference: 'HOLD-CAP-aaaa', amount: 100, metadata: const {'reference': 'TRF-one'});
    final b = _tx(id: 'b', reference: 'HOLD-CAP-bbbb', amount: 500, metadata: const {'reference': 'TRF-two'});

    final merged = mergeExternalTransfers([a, b], [
      _tx(id: 'p1', reference: 'TRF-one', amount: 100),
      _tx(id: 'p2', reference: 'TRF-two', amount: 500),
    ]);
    expect(merged, hasLength(2), reason: 'two distinct transfers were over-collapsed');
  });

  test('a NON-hold ledger row keeps its own reference even with a metadata ref', () {
    // The narrow HOLD-CAP condition exists so ordinary rows that happen to
    // carry a metadata.reference are not folded into someone else's transfer.
    final ordinary = _tx(
      id: 'led', reference: 'TXN-unrelated', amount: 10,
      metadata: const {'reference': 'TRF-one'},
    );
    final payment = _tx(id: 'pay', reference: 'TRF-one', amount: 999);

    expect(mergeExternalTransfers([ordinary], [payment]), hasLength(2),
        reason: 'an ordinary ledger row must not be collapsed into a payment');
  });

  test('a payment with no ledger counterpart is still listed', () {
    final merged = mergeExternalTransfers(
      const [],
      [_tx(id: 'p', reference: 'TRF-orphan', amount: 50, counterpartyName: 'Ada')],
    );
    expect(merged, hasLength(1));
    expect(merged.single.counterpartyName, 'Ada');
  });
}
