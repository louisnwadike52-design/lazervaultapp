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

  // -------------------------------------------------------------------------
  // The STRING sink had to learn what the OBJECT sink already knew.
  //
  // Go wraps a business refusal as fmt.Errorf("%w: ...", ErrInvalidRequest)
  // and the handler returns err.Error() as the gRPC message, so
  // "invalid request: " leads the sentence. _unwrappedMessage stripped that;
  // sanitizeUserFacingError did not — and the payout receiver picker
  // sanitises a plain e.message, so the refusal reached the user with a
  // developer's error type on the front. It now shows in a MODAL, which is
  // where that prefix would be least excusable.
  // -------------------------------------------------------------------------
  group('sanitizeUserFacingError strips Go error sentinels', () {
    test('the rotation refusal reads as a sentence, not an error type', () {
      const fromServer = 'invalid request: cycle 2 belongs to Ada Obi in the '
          'rotation, so paying Chidi Eze now would take a turn before theirs. '
          'Assign Ada Obi, or advance the rotation first';

      final shown = sanitizeUserFacingError(fromServer);

      expect(shown.toLowerCase(), isNot(startsWith('invalid request')));
      expect(shown, startsWith('Cycle 2 belongs to Ada Obi'));
      // The actionable half must survive intact — it is the only part that
      // tells the admin what to do next.
      expect(shown, contains('advance the rotation first'));
    });

    test('other sentinels too', () {
      expect(sanitizeUserFacingError('failed precondition: the pot is held'),
          'The pot is held');
      expect(sanitizeUserFacingError('permission denied: only the creator may'),
          'Only the creator may');
    });

    test('a bare sentinel is left whole rather than emptied', () {
      expect(sanitizeUserFacingError('invalid request: '), 'invalid request:');
    });

    test('a genuine sentence containing a colon is untouched', () {
      const msg = 'Note: your payout lands on Friday';
      expect(sanitizeUserFacingError(msg), msg);
    });
  });
}
