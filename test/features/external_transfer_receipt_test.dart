import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/external_transfer_merge.dart';

/// An external transfer is reported by TWO sources and only one knows the
/// principal.
///
/// accounts-service writes the LEDGER row — principal PLUS fee, the money that
/// actually left the account. core-payments writes the PAYMENT row and is the
/// only side that knows what the payee was sent. The merge collapses them, and
/// it used to keep the ledger amount and drop the payment amount entirely.
///
/// Measured on prod 2026-11-02: every external transfer stored as principal +
/// a 23 fee — 223, 523, 973, 1123, 5023 — rendered as one figure with no
/// breakdown. A sender sharing that receipt tells the payee 223 arrived when
/// 200 did.
UnifiedTransaction _tx({
  required String id,
  required String ref,
  required double amount,
  TransactionFlow flow = TransactionFlow.outgoing,
  String? counterpartyName,
  Map<String, dynamic>? metadata,
}) =>
    UnifiedTransaction(
      id: id,
      serviceType: TransactionServiceType.transfer,
      title: 'Transfer',
      amount: amount,
      currency: 'NGN',
      createdAt: DateTime(2026, 11, 2),
      status: UnifiedTransactionStatus.completed,
      flow: flow,
      transactionReference: ref,
      counterpartyName: counterpartyName,
      metadata: metadata,
    );

void main() {
  group('the principal survives the merge', () {
    test('a 200 transfer with a 23 fee keeps BOTH figures', () {
      final ledger = _tx(
        id: 'L', ref: 'HOLD-CAP-abc', amount: 223,
        metadata: {'reference': 'TRF-xyz'},
      );
      final payment = _tx(
        id: 'P', ref: 'TRF-xyz', amount: 200,
        counterpartyName: 'GRACE C. ONWUANAKU',
      );

      final merged = mergeExternalTransfers([ledger], [payment]);
      expect(merged, hasLength(1), reason: 'the two rows must collapse to one');

      final m = merged.single;
      expect(m.amount, 223,
          reason: 'the headline stays the money that left the account');
      expect(m.metadata?['external_principal'], 200,
          reason: 'what the payee actually received must survive');
      expect(m.metadata?['external_fee'], 23,
          reason: 'the fee is derived as ledger minus payment');
      expect(m.counterpartyName, 'GRACE C. ONWUANAKU',
          reason: 'the payee still comes from the payment row');
    });

    test('the existing metadata is preserved, not replaced', () {
      final ledger = _tx(
        id: 'L', ref: 'HOLD-CAP-abc', amount: 223,
        metadata: {'reference': 'TRF-xyz', 'note': 'rent'},
      );
      final payment = _tx(id: 'P', ref: 'TRF-xyz', amount: 200);
      final m = mergeExternalTransfers([ledger], [payment]).single;
      expect(m.metadata?['note'], 'rent');
      expect(m.metadata?['reference'], 'TRF-xyz',
          reason: 'the join key must not be lost — it is how the rows paired');
    });

    test('NO fee rows when there is no fee', () {
      // A zero-fee transfer must not gain a "Fee ₦0.00" line on every receipt.
      final ledger = _tx(id: 'L', ref: 'HOLD-CAP-abc', amount: 200,
          metadata: {'reference': 'TRF-xyz'});
      final payment = _tx(id: 'P', ref: 'TRF-xyz', amount: 200);
      final m = mergeExternalTransfers([ledger], [payment]).single;
      expect(m.metadata?.containsKey('external_fee'), isFalse);
      expect(m.metadata?.containsKey('external_principal'), isFalse);
    });

    test('a ledger row SMALLER than the payment row is not treated as a fee', () {
      // Would imply a negative fee. Refuse rather than print nonsense on a
      // receipt — some other explanation is needed, not arithmetic.
      final ledger = _tx(id: 'L', ref: 'HOLD-CAP-abc', amount: 180,
          metadata: {'reference': 'TRF-xyz'});
      final payment = _tx(id: 'P', ref: 'TRF-xyz', amount: 200);
      final m = mergeExternalTransfers([ledger], [payment]).single;
      expect(m.metadata?.containsKey('external_fee'), isFalse);
    });

    test('fees with kobo are not mangled by floating point', () {
      // 1123.45 - 1100.20 is 23.249999... in binary floating point. A receipt
      // must not print "₦23.25" in one place and "23.249999999999996" in
      // another.
      final ledger = _tx(id: 'L', ref: 'HOLD-CAP-abc', amount: 1123.45,
          metadata: {'reference': 'TRF-xyz'});
      final payment = _tx(id: 'P', ref: 'TRF-xyz', amount: 1100.20);
      final m = mergeExternalTransfers([ledger], [payment]).single;
      expect(m.metadata?['external_fee'], 23.25);
    });

    test('an unmatched ledger row is untouched', () {
      final ledger = _tx(id: 'L', ref: 'HOLD-CAP-abc', amount: 223,
          metadata: {'reference': 'TRF-xyz'});
      final m = mergeExternalTransfers([ledger], []).single;
      expect(m.amount, 223);
      expect(m.metadata?.containsKey('external_fee'), isFalse,
          reason: 'with no payment row there is no principal to report');
    });

    test('incoming and outgoing legs never collapse into each other', () {
      // keyFor includes the flow; without it a credit and a debit sharing a
      // reference would merge and one side would vanish.
      final out = _tx(id: 'L', ref: 'HOLD-CAP-abc', amount: 223,
          metadata: {'reference': 'TRF-xyz'});
      final inc = _tx(id: 'P', ref: 'TRF-xyz', amount: 200,
          flow: TransactionFlow.incoming);
      expect(mergeExternalTransfers([out], [inc]), hasLength(2));
    });
  });
}
