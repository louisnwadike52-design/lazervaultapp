import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_history_repository_grpc.dart';

/// A receipt must show a reference the user can quote to support.
///
/// Reported from a device: a completed withdrawal's receipt showed
/// `HOLD-WD-WD-8fd5920e-556000`. The ledger row was correct — accounts-service
/// strips the hold prefix and stored `WD-8fd5920e-556000` — but the row's
/// metadata carried the raw hold reference, and the mapper preferred metadata
/// unconditionally. So an internal id won over a perfectly good reference
/// sitting one field away.
///
/// Holds are namespaced per flow (HOLD-CAP-, HOLD-REL-, HOLD-WD-, HOLD-BUY-…),
/// so the test is on the `HOLD-` family rather than on the three prefixes that
/// happened to be listed when this was written.
void main() {
  String? q(String? s) =>
      TransactionHistoryRepositoryGrpc.quotableReference(s);

  group('internal references never reach the UI', () {
    test('every hold namespace is rejected, not just the ones once listed', () {
      for (final ref in <String>[
        'HOLD-WD-WD-8fd5920e-556000', // the reported withdrawal
        'HOLD-CAP-2f1c9a0e-1111-2222-3333-444455556666',
        'HOLD-REL-2f1c9a0e',
        'HOLD-BUY-abc123', // a namespace nobody listed
      ]) {
        expect(q(ref), isNull, reason: '$ref is a fund hold id, not a receipt');
      }
    });

    test('derived idempotency keys are rejected, including doubled ones', () {
      expect(q('IDEM-DR-9ab3'), isNull);
      expect(q('IDEM-DR-IDEM-DR-9ab3'), isNull,
          reason: 'this doubled form is what read as corruption on receipts');
    });

    test('blank and whitespace are nothing to show', () {
      expect(q(null), isNull);
      expect(q(''), isNull);
      expect(q('   '), isNull);
    });
  });

  group('real references survive', () {
    test('a withdrawal reference is quotable', () {
      expect(q('WD-8fd5920e-556000'), 'WD-8fd5920e-556000');
    });

    test('other issued references are untouched', () {
      expect(q('BTF-2-1791486359-84cfeb19'), 'BTF-2-1791486359-84cfeb19');
      expect(q('CRYPTO-SEND-64bc941a'), 'CRYPTO-SEND-64bc941a');
      expect(q('  EDU-1791428276-1b21bfb2  '), 'EDU-1791428276-1b21bfb2',
          reason: 'trimmed, not rejected');
    });

    test('a reference merely CONTAINING "HOLD" is not an internal one', () {
      expect(q('WD-HOLDINGS-001'), 'WD-HOLDINGS-001',
          reason: 'the test is a prefix, so it must not match mid-string');
    });
  });
}
