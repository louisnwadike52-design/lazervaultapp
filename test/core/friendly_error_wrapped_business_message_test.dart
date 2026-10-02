import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// A wrapped business refusal must still reach the user.
///
/// friendlyError unwrapped only GrpcError and DioException, so once a
/// repository had turned a gRPC status into a Failure or Exception the precise
/// reason was invisible and everything collapsed to the contextual line.
///
/// Measured 2026-10-02 on send-funds: core-payments returned InvalidArgument
/// "the minimum for a bank transfer is 100.00 NGN (you entered 10.00) — payout
/// providers reject smaller amounts", retryable=false, and the user saw
/// "Something went wrong … Please try again" AFTER entering their PIN.
///
/// Telling someone to retry a NON-RETRYABLE refusal is worse than silence:
/// every retry fails identically and it reads as the app being broken rather
/// than the amount being too small.

class _Failure implements Exception {
  final String message;
  _Failure(this.message);
  @override
  String toString() => 'Failure: $message';
}

void main() {
  const belowMin =
      'the minimum for a bank transfer is 100.00 NGN (you entered 10.00) '
      '— payout providers reject smaller amounts';

  group('a wrapped business refusal survives to the user', () {
    test('the exact reported case is shown, not the generic retry line', () {
      final shown = friendlyError(_Failure(belowMin), context: 'complete your transfer');
      expect(shown, contains('minimum for a bank transfer'));
      expect(
        shown,
        isNot(contains('Please try again')),
        reason: 'the refusal is non-retryable; "try again" guarantees a loop',
      );
    });

    test('a plain Exception carrying the same sentence also survives', () {
      final shown = friendlyError(Exception(belowMin), context: 'complete your transfer');
      expect(shown, contains('minimum for a bank transfer'));
    });

    test('other real business refusals survive too', () {
      for (final m in [
        'Insufficient balance',
        'cannot transfer to the same account',
        'Daily transfer limit exceeded',
      ]) {
        expect(friendlyError(_Failure(m), context: 'complete your transfer'), m,
            reason: '$m is written for the user and should be shown as-is');
      }
    });
  });

  group('and nothing unsafe leaks', () {
    test('technical wrapper text still generalises', () {
      for (final m in [
        'Exception: SocketException: Failed host lookup',
        'type \'Null\' is not a subtype of type \'String\'',
        'HTTP connection completed with 502 instead of 200',
      ]) {
        final shown = friendlyError(_Failure(m), context: 'complete your transfer');
        expect(shown, isNot(contains('SocketException')));
        expect(shown, isNot(contains('502')));
        expect(shown, isNot(contains('subtype')));
      }
    });

    test('an error with no usable message falls back to the contextual line', () {
      final shown = friendlyError(_Failure(''), context: 'complete your transfer');
      expect(shown.toLowerCase(), contains('complete your transfer'));
    });

    test('null stays generic', () {
      expect(friendlyError(null), isNotEmpty);
    });
  });
}
