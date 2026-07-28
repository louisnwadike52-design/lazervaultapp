import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// Maps a raw error (gRPC status, socket/HTTP failure, 502, etc.) to a clean,
/// human message for the RMB UI. Delegates to the canonical
/// `core/utils/friendly_error.dart` so RMB's wording matches the rest of the
/// app and raw rpc/transport text never reaches the UI.
///
/// Order: network/transport → frozen/suspended account → gRPC code (session,
/// permission, rate-limit) → business codes pass their clean backend message
/// through `sanitizeUserFacingError` → generic fallback.
String rmbFriendlyError(Object e) {
  if (isNetworkError(e)) return networkErrorMessage;
  if (isFrozenAccountError(e)) return frozenAccountMessage;
  if (e is GrpcError) {
    switch (e.code) {
      case StatusCode.unauthenticated:
        return 'Your session has expired. Please sign in again.';
      case StatusCode.permissionDenied:
        return "You don't have permission to do that.";
      case StatusCode.resourceExhausted:
        return 'Too many attempts. Please wait a moment and try again.';
      case StatusCode.failedPrecondition:
      case StatusCode.invalidArgument:
        // The service returns clean, user-facing text for known cases
        // (quote expired, insufficient balance, unsupported amount, …).
        return sanitizeUserFacingError(e.message);
      default:
        return 'Something went wrong. Please try again.';
    }
  }
  return sanitizeUserFacingError(e.toString());
}
