import 'package:grpc/grpc.dart';

import 'package:lazervault/core/utils/kyc_error_handler.dart';
import 'package:lazervault/src/core/errors/failures.dart';

/// Stable code carried on a [ServerFailure] when a card action was refused
/// because the holder has not verified their identity.
///
/// accounts-service answers FailedPrecondition with a "KYC_REQUIRED:" prefix.
/// The screen routes on THIS, never on the message text, so the copy can change
/// without silently breaking the routing.
const String kCardKycRequiredCode = 'KYC_REQUIRED';

/// Turn whatever the card RPCs throw into something safe to show.
///
/// # WHAT IT REPLACED, AND WHY THAT MATTERED
///
/// Every card repository method ended `ServerFailure(message: e.toString())`,
/// and the datasource had already wrapped the gRPC error in
/// `Exception('Failed to create virtual card: ...')`. So the string that
/// reached the user was the whole envelope:
///
///   Exception: Failed to create virtual card: gRPC Error (code: 9,
///   codeName: FAILED_PRECONDITION, message: KYC_REQUIRED: Verify your…)
///
/// That is an internal error shown verbatim to a customer — the house rule is
/// that people see something plain while the detail goes to the logs. It was
/// true for every card failure, not just this one; the identity gate simply
/// made it the common path instead of a rare one.
///
/// # WHY THE CODE IS CARRIED SEPARATELY
///
/// The refusal needs to ROUTE, not just read: a holder who has not verified
/// should be offered verification, not a dead-end message. Returning a friendly
/// sentence alone would have meant the screen matching on text to decide, which
/// breaks the moment the copy is reworded. The code travels in `statusCode`;
/// the message is for humans only and contains no code, prefix or envelope.
ServerFailure cardFailureFrom(Object error) {
  final grpc = _asGrpcError(error);

  if (grpc != null) {
    if (isKYCRequiredError(grpc.message)) {
      return ServerFailure(
        message: 'Verify your identity to request a card. It takes a couple '
            'of minutes and also unlocks higher limits and account details '
            'for receiving money.',
        statusCode: kCardKycRequiredCode,
      );
    }
    return ServerFailure(
      message: friendlyGrpcError(
        grpc,
        'We could not complete that card request. Please try again.',
      ),
      statusCode: grpc.code,
    );
  }

  // Not a gRPC failure at all — a parse error, a null, something unforeseen.
  // Deliberately NOT e.toString(): an unknown error is exactly the one most
  // likely to carry something internal.
  return ServerFailure(
    message: 'We could not complete that card request. Please try again.',
    statusCode: 500,
  );
}

/// Dig a [GrpcError] out, including one the datasource wrapped in an
/// `Exception(...)`.
///
/// The datasource rethrows as `Exception('Failed to …: ${e.toString()}')`, so
/// by the time it reaches the repository the type is gone and only the text
/// remains. Rather than change every datasource method and risk missing one,
/// this recovers the signal from either shape.
GrpcError? _asGrpcError(Object error) {
  if (error is GrpcError) return error;
  final text = error.toString();
  if (!text.contains('gRPC Error')) return null;
  // Rebuild just enough for classification: the code drives the wording and
  // the message drives the KYC check.
  final codeMatch = RegExp(r'code:\s*(\d+)').firstMatch(text);
  final msgMatch = RegExp(r'message:\s*(.*?)\)?$').firstMatch(text);
  return GrpcError.custom(
    int.tryParse(codeMatch?.group(1) ?? '') ?? 2, // 2 = UNKNOWN
    msgMatch?.group(1) ?? '',
  );
}
