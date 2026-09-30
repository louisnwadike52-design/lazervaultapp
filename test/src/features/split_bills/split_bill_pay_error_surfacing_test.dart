import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/utils/friendly_error.dart';

/// A split-bill share that CANNOT be paid must say so.
///
/// Production: a 25.00 share on a bill paying out to an external bank. The
/// payout floor is 100.00, so the payment can never succeed. core-payments
/// computed the exact sentence the payer needed; four layers then threw it
/// away, and the payer saw "Something went wrong. Please try again." three
/// times before giving up:
///
///   core-payments handler   masked InvalidArgument → Internal
///   split-bill mapServiceError  matched "transfer failed" → Aborted
///   split-bill repository   invalidArgument fell to `default` → generic
///   pay screen              showed the generic line twice (banner + sheet)
///
/// These tests pin the last two links; the Go tests pin the first two.
void main() {
  const floorMessage =
      'the minimum for a bank transfer is 100.00 NGN (you entered 25.00) — '
      'payout providers reject smaller amounts';

  group('friendlyError on a deliberate refusal', () {
    test('invalidArgument reaches the payer verbatim', () {
      final shown = friendlyError(
        GrpcError.invalidArgument(floorMessage),
        context: 'complete this payment',
      );
      expect(shown, contains('you entered 25.00'));
      expect(shown, isNot(contains('Something went wrong')));
    });

    test('failedPrecondition reaches the payer verbatim', () {
      const payPathMessage =
          'this share (25.00 NGN) is below the 100.00 NGN minimum for a payout '
          'to a bank account, so it cannot be paid however many times you try. '
          'Ask @nnaemeka to cancel this bill and recreate it with a larger share, '
          'or to receive into their LazerVault account, which has no minimum';
      final shown = friendlyError(GrpcError.failedPrecondition(payPathMessage));
      expect(shown, contains('cancel this bill'));
      expect(shown, isNot(contains('Something went wrong')));
    });

    test('an internal error still gets the calm generic line', () {
      // The other half of the rule: a masked class must stay masked. Nothing
      // here is the payer's business and nothing they do changes it.
      final shown = friendlyError(
        GrpcError.internal('dial tcp 10.0.0.4:9090: connect: connection refused'),
        context: 'complete this payment',
      );
      expect(shown, isNot(contains('dial tcp')));
    });
  });

  group('sanitizeUserFacingError keeps an actionable sentence', () {
    test('the floor message survives the sanitizer', () {
      // The sanitizer collapses anything that looks technical. A sentence
      // about an amount is not technical, and collapsing it is what left the
      // payer with no idea what to do.
      expect(sanitizeUserFacingError(floorMessage), contains('100.00 NGN'));
    });

    test('a wrapped rpc string is still collapsed', () {
      // The reason the SERVER must send the inner message rather than the
      // wrapped one: this text is correctly unshowable.
      expect(
        sanitizeUserFacingError(
            'external transfer failed: rpc error: code = InvalidArgument desc = $floorMessage'),
        'Something went wrong. Please try again.',
      );
    });
  });
}
