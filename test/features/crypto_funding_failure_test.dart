import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/crypto_pay/domain/crypto_funding_failure.dart';

/// THE SERVER SAID WHY. THE APP THREW IT AWAY.
///
/// Pay with Crypto shipped behind a server-side gate, so every attempt — in
/// airtime, data, electricity, cable TV, internet, water and send funds —
/// came back:
///
///     FailedPrecondition: Paying with crypto is not available on your
///                         account right now.
///
/// Five of those seven cubits caught the error with `catch (_)`, discarded it,
/// and showed "We could not confirm the conversion. Check this payment in your
/// history before trying again." So the customer was sent to look for a record
/// that was never written, about money that never moved, with nothing naming
/// the actual reason — and the one person who could fix it (the operator) had
/// no way to see it from the app either.
void main() {
  GrpcError err(int code, String msg) => GrpcError.custom(code, msg);

  group('a refusal is reported as a refusal', () {
    test('and carries the server\'s own sentence', () {
      const sentence = 'Paying with crypto is not available on your account '
          'right now.';
      final f = CryptoFundingFailure.from(
          err(StatusCode.failedPrecondition, sentence));
      expect(f.refused, isTrue);
      expect(f.message, sentence,
          reason: 'the server writes these for customers; a message invented '
              'here would be a worse copy of it');
      expect(f.mayRetryWithWallet, isTrue,
          reason: 'nothing was converted, so paying from the wallet is safe');
    });

    test('for every code that means the server decided', () {
      for (final code in [
        StatusCode.failedPrecondition, // the gate, a cap, a small holding
        StatusCode.invalidArgument, // an unsupported coin, below the floor
        StatusCode.outOfRange, // outside the configured band
        StatusCode.permissionDenied, // not enabled for this account
        StatusCode.notFound, // the payment to fund is not there
      ]) {
        final f = CryptoFundingFailure.from(err(code, 'That coin is not '
            'supported for payments yet.'));
        expect(f.refused, isTrue, reason: 'code $code must be a refusal');
        expect(f.message, contains('not supported'));
      }
    });

    test('a refusal with no message still says nothing was charged', () {
      final f = CryptoFundingFailure.from(err(StatusCode.failedPrecondition, ''));
      expect(f.refused, isTrue);
      expect(f.message, contains('Nothing has been charged'),
          reason: 'an empty server message must not become an empty dialog');
    });
  });

  group('ambiguity is NOT reported as a refusal', () {
    test('a timeout keeps the check-your-history sentence', () {
      // The conversion may have started and we lost the reply. Telling the
      // customer "you have not been charged" here would be a guess about
      // their money, and the sale is irreversible.
      for (final code in [
        StatusCode.deadlineExceeded,
        StatusCode.unavailable,
        StatusCode.internal,
        StatusCode.unknown,
      ]) {
        final f = CryptoFundingFailure.from(err(code, 'upstream timeout'));
        expect(f.refused, isFalse, reason: 'code $code is ambiguous');
        expect(f.message, contains('history'));
        expect(f.mayRetryWithWallet, isFalse,
            reason: 'a second payment after an ambiguous first is how a '
                'customer pays twice');
      }
    });

    test('a non-gRPC error is ambiguous too', () {
      final f = CryptoFundingFailure.from(Exception('socket closed'));
      expect(f.refused, isFalse);
      expect(f.message, contains('history'));
    });

    test('the raw error text never reaches the customer on an ambiguity', () {
      // A refusal's message is written for customers. An internal error's is
      // not — "rpc error: code = Internal desc = pq: deadlock detected" is
      // not something to put in a dialog.
      final f = CryptoFundingFailure.from(
          err(StatusCode.internal, 'pq: deadlock detected on relation 18273'));
      expect(f.message, isNot(contains('deadlock')));
      expect(f.message, isNot(contains('pq:')));
    });
  });

  test('an already-running conversion is not a failure at all', () {
    // The idempotent retry returning the original conversion. Filing this as
    // "refused" would tell a customer nothing happened while their coin is
    // being sold.
    final f = CryptoFundingFailure.from(
        err(StatusCode.alreadyExists, 'funding already requested'));
    expect(f.refused, isFalse);
    expect(f.mayRetryWithWallet, isFalse);
    expect(f.message, contains('already running'));
  });
}
