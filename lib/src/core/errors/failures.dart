import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// Maps raw gRPC errors to user-friendly messages.
/// Use this in all repository catch blocks instead of exposing [GrpcError.message].
///
/// NEVER returns the raw [GrpcError.message] for a transport-level failure — a
/// non-200 gateway response surfaces as a gRPC error whose message contains raw
/// text like "expected 200, got 503", which must never reach the user. Such
/// failures are collapsed to the single [networkErrorMessage]. The server's own
/// message is only passed through for business-meaningful codes, and only when
/// it does not look technical.
String friendlyGrpcError(GrpcError e,
    [String fallback = 'Something went wrong. Please try again.']) {
  // Connectivity / transport failures (incl. non-200 gateway responses) first.
  if (isNetworkError(e)) {
    return networkErrorMessage;
  }
  // Frozen/suspended source account — clean message instead of the raw
  // "account <uuid> is frozen" the server sends.
  if (isFrozenAccountError(e)) {
    return frozenAccountMessage;
  }
  if (e.code == StatusCode.unimplemented ||
      (e.message != null && e.message!.contains('unknown service'))) {
    return networkErrorMessage;
  }
  if (e.code == StatusCode.unauthenticated) {
    return 'Session expired. Please log in again.';
  }
  if (e.code == StatusCode.resourceExhausted) {
    return 'Too many attempts. Please wait a moment and try again.';
  }
  // Business-meaningful codes: prefer the server's message, but only if it reads
  // like a human sentence rather than raw transport/exception text.
  if (e.code == StatusCode.permissionDenied ||
      e.code == StatusCode.failedPrecondition ||
      e.code == StatusCode.invalidArgument ||
      e.code == StatusCode.alreadyExists ||
      e.code == StatusCode.notFound) {
    final msg = e.message;
    if (msg != null && msg.isNotEmpty && !looksTechnical(msg)) {
      return msg;
    }
    return fallback;
  }
  // Default: never leak the raw message.
  return fallback;
}

abstract class Failure {
  // Sanitize on construction so raw transport/exception text can never be
  // stored on `message` and later surfaced via state.message / failure.message.
  // Business messages pass through unchanged (see sanitizeUserFacingError).
  Failure({required String message, required this.statusCode})
      : message = sanitizeUserFacingError(message);

  final String message;
  final dynamic statusCode; // Can be String or int

  @override
  String toString() => '$statusCode Error: $message';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.message == message &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}

// Define specific failure types if needed, e.g., ServerFailure, CacheFailure
class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message})
      : super(statusCode: 'Network Error'); // Example default status code

  factory NetworkFailure.fromException(dynamic exception) {
    return NetworkFailure(message: exception.toString());
  }
} 