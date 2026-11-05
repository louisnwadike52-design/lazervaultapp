import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';
import 'package:lazervault/core/utils/user_friendly_error.dart';

/// The app has THREE gRPC-error mappers, and which one a user meets depends on
/// which cubit caught the error. They must therefore agree about the codes
/// that carry a real sentence from the server.
///
/// They did not. `user_friendly_error.dart` collapsed failedPrecondition to
/// "This action can't be completed right now. Please try again later.", while
/// the other two passed the server's text through. failedPrecondition is the
/// code every deliberate business refusal uses — the onboarding-grant rule,
/// the retained-balance floor, a family pool refusal — so a tester whose
/// transfer was refused with
///
///   "Your NGN2,000.00 bonus is for spending on Lazervault, so you can
///    transfer up to NGN90.00 of your own money right now."
///
/// was shown a generic line plus an invitation to retry something that could
/// never succeed, and reported that he "can't do anything".
void main() {
  // A real policy refusal, worded the way the services word them.
  const refusal = 'Your NGN2,000.00 bonus is for spending on Lazervault, so '
      'you can transfer up to NGN90.00 of your own money right now.';

  group('every mapper preserves an actionable server refusal', () {
    final err = GrpcError.failedPrecondition(refusal);

    test('getUserFriendlyErrorMessage', () {
      expect(getUserFriendlyErrorMessage(err), contains('NGN90.00'));
    });

    test('GrpcErrorHandler.userFriendlyMessage', () {
      expect(GrpcErrorHandler.userFriendlyMessage(err), contains('NGN90.00'));
    });

    test('friendlyGrpcMessage path via sanitizeUserFacingError', () {
      expect(sanitizeUserFacingError(refusal), contains('NGN90.00'));
    });

    test('none of them tells the user to try again later', () {
      for (final m in <String>[
        getUserFriendlyErrorMessage(err),
        GrpcErrorHandler.userFriendlyMessage(err),
      ]) {
        expect(m.toLowerCase(), isNot(contains('try again later')),
            reason: 'a policy refusal never resolves by retrying, so the copy '
                'must not invite a retry');
      }
    });
  });

  group('the generic mask still applies where it should', () {
    test('an empty message falls back rather than showing a blank', () {
      final blank = GrpcError.failedPrecondition('');
      expect(getUserFriendlyErrorMessage(blank).trim(), isNotEmpty);
    });

    test('a technical blob is not echoed verbatim', () {
      final technical = GrpcError.failedPrecondition(
          'rpc error: code = Internal desc = pq: duplicate key value violates '
          'unique constraint "accounts_pkey"');
      final shown = getUserFriendlyErrorMessage(technical);
      expect(shown, isNot(contains('pq:')));
      expect(shown, isNot(contains('accounts_pkey')));
    });
  });
}
