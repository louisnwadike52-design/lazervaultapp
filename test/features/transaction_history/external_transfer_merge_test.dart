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
  UnifiedTransactionStatus status = UnifiedTransactionStatus.pending,
}) =>
    UnifiedTransaction(
      id: id,
      serviceType: TransactionServiceType.transfer,
      title: title,
      amount: amount,
      currency: 'NGN',
      createdAt: DateTime(2026, 9, 29, 13, 7),
      status: status,
      flow: TransactionFlow.outgoing,
      transactionReference: reference,
      metadata: metadata,
      counterpartyName: counterpartyName,
    );

void main() {
  _refundedStatusTests();

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

// ── the ledger row owns the STATUS, which is what makes the backend fix visible
//
// accounts-service used to mark a released hold's display row `failed`. It now
// marks it `refunded`, because releasing the reservation IS the refund and the
// user is whole. Reported from Send Funds history: three external transfers
// (₦223, ₦513, ₦1013) all read Failed after their holds came back — the ₦223
// having failed on OUR Nomba payout float, not the sender's balance.
//
// That fix only reaches the user if the merge lets the LEDGER row's status win.
// The payments side keeps its own view of the same transfer and will still say
// `failed` — it describes the PAYMENT, which genuinely did not happen. Both
// sentences are true; only one is about the user's money, and that is the one
// the history row must show.
void _refundedStatusTests() {
  test('a refunded ledger row wins over the payment row still marked failed', () {
    final ledger = _tx(
      id: 'ledger-223',
      reference: 'HOLD-CAP-f6417e2b-97e7-45cc-ac89-08e80687e0e2',
      amount: 223,
      metadata: const {'reference': 'TRF-transfer_chris_grace'},
      title: 'External transfer',
      status: UnifiedTransactionStatus.refunded,
    );
    final payment = _tx(
      id: 'payment-223',
      reference: 'TRF-transfer_chris_grace',
      amount: 223,
      counterpartyName: 'GRACE C. ONYEKACHI',
      title: 'Transfer to GRACE C. ONYEKACHI',
      status: UnifiedTransactionStatus.failed,
    );

    final merged = mergeExternalTransfers([ledger], [payment]);

    expect(merged, hasLength(1), reason: 'one transfer, one row');
    expect(merged.single.status, UnifiedTransactionStatus.refunded,
        reason: 'the ledger row is the money that moved, so its status is the '
            'one the user sees — otherwise the accounts-service fix is invisible');
    // And the payee still comes across, which is the whole reason for the merge.
    expect(merged.single.counterpartyName, 'GRACE C. ONYEKACHI');
    // The ledger amount (principal + fee) is kept, not the payment's.
    expect(merged.single.amount, 223);
  });

  test('Refunded renders distinctly from Failed, so the two never read alike', () {
    // If these collided the fix would be invisible even with the right status.
    expect(UnifiedTransactionStatus.refunded.displayName, 'Refunded');
    expect(UnifiedTransactionStatus.failed.displayName, 'Failed');
    expect(UnifiedTransactionStatus.refunded.color,
        isNot(UnifiedTransactionStatus.failed.color));
    // And not confusable with Pending either — refunded is a resolved state.
    expect(UnifiedTransactionStatus.refunded.color,
        isNot(UnifiedTransactionStatus.pending.color));
  });

  test('the backend status string parses to refunded, not to the pending fallback', () {
    // fromString falls back to `pending` for anything unknown, so a typo in the
    // Go write (or a rename of the enum value) would silently show Pending on a
    // finished transfer rather than failing anywhere.
    expect(UnifiedTransactionStatus.fromString('refunded'),
        UnifiedTransactionStatus.refunded);
    expect(UnifiedTransactionStatus.fromString('REFUNDED'),
        UnifiedTransactionStatus.refunded);
  });
}
