import 'dart:async';
import 'dart:math';
import 'package:grpc/grpc.dart';

/// PRODUCTION-GRADE RETRY POLICY FOR NETWORK REQUESTS
///
/// Implements exponential backoff with jitter for failed network requests
/// Handles both gRPC and HTTP failures with intelligent retry logic
class RetryPolicy {
  final int maxRetries;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;
  final bool addJitter;

  const RetryPolicy({
    this.maxRetries = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.addJitter = true,
  });

  /// Default retry policy for critical operations (transfers, payments)
  static const RetryPolicy critical = RetryPolicy(
    maxRetries: 5,
    initialDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 30),
    backoffMultiplier: 2.0,
    addJitter: true,
  );

  /// Default retry policy for non-critical operations
  static const RetryPolicy standard = RetryPolicy(
    maxRetries: 3,
    initialDelay: Duration(seconds: 1),
    maxDelay: Duration(seconds: 15),
    backoffMultiplier: 2.0,
    addJitter: true,
  );

  /// No retry policy
  static const RetryPolicy none = RetryPolicy(
    maxRetries: 0,
  );

  /// Execute a function with retry logic
  Future<T> execute<T>(Future<T> Function() operation, {
    bool Function(dynamic error)? shouldRetry,
    void Function(int attempt, dynamic error)? onRetry,
  }) async {
    int attempt = 0;
    dynamic lastError;

    while (attempt <= maxRetries) {
      try {
        return await operation();
      } catch (error) {
        lastError = error;
        attempt++;

        // Check if we should retry this error
        if (attempt > maxRetries || !_shouldRetryError(error, shouldRetry)) {
          rethrow;
        }

        // Calculate delay with exponential backoff and jitter
        final delay = _calculateDelay(attempt);

        // Notify about retry
        if (onRetry != null) {
          onRetry(attempt, error);
        }

        print('Retry attempt $attempt/$maxRetries after ${delay.inMilliseconds}ms due to: $error');

        // Wait before retrying
        await Future.delayed(delay);
      }
    }

    // This should never be reached, but just in case
    throw lastError ?? Exception('Retry failed after $maxRetries attempts');
  }

  /// Determine if an error should be retried
  bool _shouldRetryError(dynamic error, bool Function(dynamic)? customCheck) {
    // Use custom check if provided
    if (customCheck != null) {
      return customCheck(error);
    }

    // Default retry logic for common error types
    if (error is GrpcError) {
      return _shouldRetryGrpcError(error);
    }

    // Network-related exceptions (connection errors, timeouts)
    if (error is TimeoutException ||
        error.toString().toLowerCase().contains('timeout') ||
        error.toString().toLowerCase().contains('connection') ||
        error.toString().toLowerCase().contains('network')) {
      return true;
    }

    // Don't retry by default
    return false;
  }

  /// Determine if a gRPC error should be retried
  bool _shouldRetryGrpcError(GrpcError error) {
    // Retry on transient errors
    switch (error.code) {
      case StatusCode.unavailable:      // Service unavailable
      case StatusCode.deadlineExceeded: // Timeout
      case StatusCode.aborted:          // Conflict, may succeed on retry
      case StatusCode.internal:         // Internal server error (may be transient)
      case StatusCode.unknown:          // Unknown error (may be transient)
      case StatusCode.resourceExhausted: // Rate limited (with backoff)
        return true;

      // Don't retry on permanent errors
      case StatusCode.invalidArgument:   // Bad request
      case StatusCode.notFound:          // Resource not found
      case StatusCode.alreadyExists:     // Already exists
      case StatusCode.permissionDenied:  // Permission denied
      case StatusCode.unauthenticated:   // Not authenticated
      case StatusCode.failedPrecondition: // Precondition failed (e.g., insufficient funds)
      case StatusCode.unimplemented:     // Not implemented
        return false;

      default:
        return false;
    }
  }

  /// Calculate delay for the given attempt number
  Duration _calculateDelay(int attempt) {
    // Calculate exponential backoff: initialDelay * (backoffMultiplier ^ (attempt - 1))
    final baseDelay = initialDelay.inMilliseconds *
        pow(backoffMultiplier, attempt - 1).toDouble();

    // Cap at maxDelay
    final cappedDelay = min(baseDelay, maxDelay.inMilliseconds.toDouble());

    // Add jitter to prevent thundering herd
    final jitter = addJitter
        ? Random().nextDouble() * cappedDelay * 0.3 // Up to 30% jitter
        : 0.0;

    return Duration(milliseconds: (cappedDelay + jitter).round());
  }
}

/// Extension to add retry capability to any Future
extension RetryExtension<T> on Future<T> {
  /// Retry this future with the given policy
  Future<T> retry({
    RetryPolicy policy = RetryPolicy.standard,
    bool Function(dynamic error)? shouldRetry,
    void Function(int attempt, dynamic error)? onRetry,
  }) {
    return policy.execute(
      () => this,
      shouldRetry: shouldRetry,
      onRetry: onRetry,
    );
  }
}
