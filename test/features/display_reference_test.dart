import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

UnifiedTransaction _tx(String? ref) => UnifiedTransaction(
      id: 'id-1',
      serviceType: TransactionServiceType.airtime,
      title: 'Airtime',
      amount: 1000,
      currency: 'NGN',
      createdAt: DateTime(2026, 10, 11),
      status: UnifiedTransactionStatus.pending,
      flow: TransactionFlow.outgoing,
      transactionReference: ref,
    );

/// A reservation is booked under "HOLD-<business reference>". That is the hold's
/// own key, not something a customer has any use for — and a pending airtime
/// purchase displayed, copied, shared and QR-encoded
/// "HOLD-AIR-1791750032-332db828".
void main() {
  test('the reservation prefix is not shown to the customer', () {
    expect(
      _tx('HOLD-AIR-1791750032-332db828').displayReference,
      'AIR-1791750032-332db828',
    );
  });

  test('what is left is the reference support can actually find', () {
    // bill_payments.reference is the un-prefixed form.
    expect(_tx('HOLD-EDU-1791650334-1ec8913b').displayReference,
        'EDU-1791650334-1ec8913b');
  });

  test('HOLD-CAP is left alone — it is a settlement row in its own right', () {
    // external_transfer_merge keys on exactly this shape.
    const capture = 'HOLD-CAP-9f4c-f1f3b0acefad';
    expect(_tx(capture).displayReference, capture);
  });

  test('an ordinary reference is untouched', () {
    expect(_tx('AIR-123').displayReference, 'AIR-123');
    expect(_tx('C2C-CHAT-transfer-9').displayReference, 'C2C-CHAT-transfer-9');
  });

  test('null and empty stay as they were, never the bare prefix', () {
    expect(_tx(null).displayReference, isNull);
    expect(_tx('   ').displayReference, '   ');
    // "HOLD-" with nothing after it would otherwise render an empty reference.
    expect(_tx('HOLD-').displayReference, 'HOLD-');
  });
}
