import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

// Reported as "airtime purchase on savings account fails". It was neither a
// savings account nor a client problem.
//
// Measured from the server log at the exact moment of the report
// (02 Oct 21:29:00, utility-payments BuyAirtime):
//
//   code = FailedPrecondition desc = The family pool has ₦80.00 left, which
//   doesn't cover this payment. Anyone in the family can add money to the pool.
//
// A ₦100 airtime purchase against a family pool holding ₦80. The server said
// so precisely and actionably. The app showed "Transaction Failed / Something
// went wrong" and "We couldn't complete your transfer right now. Please try
// again." — a fixable refusal reported as an unexplained fault, with advice
// (retry) that could only fail identically.
//
// Two independent defects, both measured:
//   1. friendlyError only unwrapped a LIVE GrpcError. Once a repository
//      rethrows it as Exception(e.toString()) the envelope survives, the
//      sanitizer correctly rejects "rpc error: code = ..." as technical, and
//      the sentence is replaced by the generic line.
//   2. The PIN modal's refusal vocabulary had no plain-English insufficiency,
//      so even the real message was framed as a malfunction.

const _prod = "The family pool has NGN80.00 left, which doesn't cover "
    "this payment. Anyone in the family can add money to the pool.";

void main() {
  group('a wrapped refusal keeps the server sentence', () {
    test('the exact production failure survives being rethrown', () {
      final msg = friendlyError(
        Exception('rpc error: code = FailedPrecondition desc = $_prod'),
        context: 'complete your transfer',
      );
      expect(msg, _prod);
    });

    test('a live GrpcError still works (the path that always did)', () {
      expect(
        friendlyError(GrpcError.failedPrecondition(_prod),
            context: 'complete your transfer'),
        _prod,
      );
    });

    test('InvalidArgument carries user text too', () {
      expect(
        friendlyError(
            Exception('rpc error: code = InvalidArgument desc = Amount must '
                'be at least NGN100.'),
            context: 'complete your transfer'),
        'Amount must be at least NGN100.',
      );
    });

    test('the INNERMOST sentence wins when nested through two services', () {
      final msg = friendlyError(
        Exception('rpc error: code = FailedPrecondition desc = '
            'rpc error: code = FailedPrecondition desc = $_prod'),
        context: 'complete your transfer',
      );
      expect(msg, _prod);
    });
  });

  group('internal errors must still NOT leak', () {
    // This gate is load-bearing: unwrapping without it freed internal text
    // that the envelope had been accidentally hiding. Caught in testing.
    test('Internal stays generic', () {
      final msg = friendlyError(
        Exception('rpc error: code = Internal desc = pq: duplicate key value '
            'violates unique constraint "bill_payments_pkey"'),
        context: 'complete your transfer',
      );
      expect(msg.contains('pq:'), isFalse);
      expect(msg.contains('unique constraint'), isFalse);
      expect(msg, contains('try again'));
    });

    test('Unknown stays generic', () {
      final msg = friendlyError(
        Exception('rpc error: code = Unknown desc = panic: runtime error: '
            'invalid memory address'),
        context: 'complete your transfer',
      );
      expect(msg.contains('panic'), isFalse);
    });

    test('a bare rpc envelope with no desc stays generic', () {
      final msg = friendlyError(Exception('rpc error: code = Internal'),
          context: 'complete your transfer');
      expect(msg, contains('try again'));
    });
  });

  group('the modal calls it a refusal, not a malfunction', () {
    test('plain-English insufficiency is a refusal', () {
      expect(TransactionPinModalState.isRefusalMessage(_prod), isTrue);
      expect(TransactionPinModalState.refusalSubtitleFor(_prod),
          'Not enough balance');
    });

    test('the word "insufficient" still works', () {
      expect(
          TransactionPinModalState.isRefusalMessage('Insufficient balance'),
          isTrue);
      expect(TransactionPinModalState.refusalSubtitleFor('Insufficient balance'),
          'Not enough balance');
    });

    test('an unrecognised message stays a FAILURE', () {
      // The safe direction: mislabelling a genuine fault "Not sent" would stop
      // someone retrying something that would have worked.
      expect(
          TransactionPinModalState.isRefusalMessage(
              'The provider did not respond'),
          isFalse);
    });
  });
}
