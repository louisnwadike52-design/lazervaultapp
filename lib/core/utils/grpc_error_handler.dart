import 'package:grpc/grpc.dart';

/// Centralized gRPC error handling with user-friendly messages,
/// PIN failure extraction, and error classification helpers.
///
/// Usage in cubits:
/// ```dart
/// } on GrpcError catch (e) {
///   final pinFailure = GrpcErrorHandler.extractPinFailure(e);
///   if (pinFailure != null) {
///     emit(PinFailureState(info: pinFailure));
///   } else {
///     emit(ErrorState(GrpcErrorHandler.userFriendlyMessage(e)));
///   }
/// }
/// ```
class GrpcErrorHandler {
  /// Converts a [GrpcError] into a human-readable message suitable for display.
  ///
  /// Preserves the server's error message for codes where the backend provides
  /// meaningful context (e.g., failedPrecondition, permissionDenied, notFound,
  /// alreadyExists, invalidArgument). Falls back to generic messages for
  /// infrastructure-level errors.
  static String userFriendlyMessage(GrpcError error) {
    switch (error.code) {
      case StatusCode.failedPrecondition:
        return error.message ??
            'Operation cannot be completed. Please check your account status.';
      case StatusCode.resourceExhausted:
        return 'Too many requests. Please wait a moment and try again.';
      case StatusCode.permissionDenied:
        return error.message ??
            "You don't have permission to perform this action.";
      case StatusCode.notFound:
        return error.message ?? 'The requested resource was not found.';
      case StatusCode.alreadyExists:
        return error.message ?? 'This operation has already been completed.';
      case StatusCode.unavailable:
        return 'Service temporarily unavailable. Please try again shortly.';
      case StatusCode.deadlineExceeded:
        return 'Request timed out. Please check your connection and try again.';
      case StatusCode.unauthenticated:
        return 'Your session has expired. Please log in again.';
      case StatusCode.invalidArgument:
        return error.message ??
            'Invalid input. Please check your details and try again.';
      default:
        // If the server sent a short, meaningful message, prefer it
        final msg = error.message ?? '';
        if (msg.isNotEmpty && !msg.contains('Exception') && msg.length < 120) {
          return msg;
        }
        return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Whether the error is transient and the operation can be retried.
  static bool isRetryable(GrpcError error) {
    return error.code == StatusCode.unavailable ||
        error.code == StatusCode.deadlineExceeded ||
        error.code == StatusCode.resourceExhausted;
  }

  /// Whether the error indicates the user's session/token is invalid.
  static bool isAuthError(GrpcError error) {
    return error.code == StatusCode.unauthenticated;
  }

  /// Attempts to extract PIN failure details from a [GrpcError].
  ///
  /// Returns `null` if the error is not PIN-related. Parses the server's
  /// error message for attempt counts and lock status.
  static PinFailureInfo? extractPinFailure(GrpcError error) {
    if (error.code != StatusCode.permissionDenied) return null;
    final message = error.message ?? '';
    final lowerMessage = message.toLowerCase();

    // Check for explicit lock/block indicators
    final isLocked = lowerMessage.contains('locked') ||
        lowerMessage.contains('blocked') ||
        lowerMessage.contains('too many attempts');

    if (isLocked) {
      return PinFailureInfo(
        isLocked: true,
        attemptsRemaining: 0,
        message: message.isNotEmpty
            ? message
            : 'Your account has been locked due to too many failed attempts. Please contact support.',
      );
    }

    // Try to extract remaining attempts from message patterns like:
    //   "invalid PIN, 2 attempts remaining"
    //   "Wrong PIN. 1 attempt remaining"
    final attemptsMatch = RegExp(
      r'(\d+)\s*attempts?\s*remaining',
      caseSensitive: false,
    ).firstMatch(message);

    if (attemptsMatch != null) {
      return PinFailureInfo(
        isLocked: false,
        attemptsRemaining: int.tryParse(attemptsMatch.group(1)!) ?? 0,
        message: message,
      );
    }

    // Check if it's a PIN-related error without attempt info
    if (lowerMessage.contains('pin') ||
        lowerMessage.contains('invalid transaction') ||
        lowerMessage.contains('incorrect')) {
      return PinFailureInfo(
        isLocked: false,
        attemptsRemaining: null,
        message: message.isNotEmpty ? message : 'Incorrect PIN. Please try again.',
      );
    }

    // Not a PIN error
    return null;
  }
}

/// Details about a failed PIN validation attempt.
class PinFailureInfo {
  /// Whether the account/PIN is locked due to too many failures.
  final bool isLocked;

  /// Number of remaining attempts before lock, or `null` if unknown.
  final int? attemptsRemaining;

  /// The raw or formatted message from the server.
  final String message;

  const PinFailureInfo({
    required this.isLocked,
    this.attemptsRemaining,
    required this.message,
  });
}
