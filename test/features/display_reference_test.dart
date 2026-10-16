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
  _idemGroup();
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

/// IDEM-CR-/IDEM-DR- are accounts-service's DEDUP markers, and they reach the
/// receipt for the same structural reason HOLD- did: accounts-service stores
/// the transaction reference AS its idempotency key (idem_reference.go) so a
/// retried credit can be located by reference. The business reference the
/// originating service generated is then buried behind that prefix.
///
/// Measured on prod 2026-10-15, a Lazerspray withdrawal:
///
///   reference   = IDEM-CR-SPRAY-WD-53a25fe4-be7c-4236-b8a8-fe75cde0b4c6
///   description = "SprayMe wallet withdrawal. Ref SPRAY-WD-53a25fe4-…"
///
/// The service had duplicated the reference INTO the description precisely
/// because the reference column was unusable, so the receipt carried the same
/// id twice — once mangled by a prefix, once inside a sentence. The prefix is
/// stripped here and the duplication removed from the description, so the
/// Reference row carries it once and the description reads as a description.
void _idemGroup() {
  group('IDEM- dedup prefixes never reach the user', () {
    test('a credit dedup key shows the business reference', () {
      expect(
        _tx('IDEM-CR-SPRAY-WD-53a25fe4-be7c-4236-b8a8-fe75cde0b4c6')
            .displayReference,
        'SPRAY-WD-53a25fe4-be7c-4236-b8a8-fe75cde0b4c6',
      );
    });

    test('a debit dedup key shows the business reference', () {
      expect(
        _tx('IDEM-DR-SPRAY-FUND-516d770a-4f08-4f73-908c-f87c291d48d4')
            .displayReference,
        'SPRAY-FUND-516d770a-4f08-4f73-908c-f87c291d48d4',
      );
    });

    test('a prefix with nothing behind it falls back, never blanks the row',
        () {
      // An empty reference hides the Reference row entirely, which reads as
      // "this transaction has no reference".
      expect(_tx('IDEM-CR-').displayReference, 'IDEM-CR-');
    });

    test('an ordinary reference is untouched', () {
      expect(_tx('SPRAY-WD-abc').displayReference, 'SPRAY-WD-abc');
      expect(_tx('TRF-2026-0001').displayReference, 'TRF-2026-0001');
    });
  });
}
