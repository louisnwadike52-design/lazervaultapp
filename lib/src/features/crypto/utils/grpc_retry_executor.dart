import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer' as developer;

import 'package:grpc/grpc.dart';

/// Retry configuration for gRPC calls
class RetryConfig {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;

  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 5),
    this.backoffMultiplier = 2.0,
  });

  /// Retry config for network-related operations (more retries)
  static const network = RetryConfig(
    maxAttempts: 5,
    initialDelay: Duration(milliseconds: 300),
    maxDelay: Duration(seconds: 10),
    backoffMultiplier: 1.5,
  );

  /// Retry config for quick operations (fewer retries)
  static const quick = RetryConfig(
    maxAttempts: 2,
    initialDelay: Duration(milliseconds: 200),
    maxDelay: Duration(seconds: 1),
    backoffMultiplier: 2.0,
  );

  /// No retry (single attempt)
  static const none = RetryConfig(maxAttempts: 1);
}

/// Executes gRPC calls with automatic retry logic
class GrpcRetryExecutor {
  final RetryConfig _config;

  const GrpcRetryExecutor({
    RetryConfig config = RetryConfig.network,
  }) : _config = config;

  /// Execute a gRPC operation with retry logic
  ///
  /// [operation] - The gRPC operation to execute
  /// [operationName] - Name of the operation for logging
  /// [config] - Optional retry config (overrides default)
  /// [shouldRetry] - Optional function to determine if an error should trigger retry
  Future<T> execute<T>(
    Future<T> Function() operation, {
    required String operationName,
    RetryConfig? config,
    bool Function(Exception)? shouldRetry,
  }) async {
    final effectiveConfig = config ?? _config;
    Exception? lastException;

    for (int attempt = 1; attempt <= effectiveConfig.maxAttempts; attempt++) {
      try {
        final result = await operation();
        return result;
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());

        // Check if we should retry this error
        if (!_shouldRetryError(lastException, shouldRetry)) {
          developer.log(
            'gRPC_NON_RETRYABLE_ERROR',
            name: operationName,
            error: lastException,
          );
          rethrow;
        }

        // Don't retry on the last attempt
        if (attempt >= effectiveConfig.maxAttempts) {
          break;
        }

        // Calculate delay with exponential backoff
        final delay = _calculateDelay(attempt, effectiveConfig);

        developer.log(
          'Retry attempt $attempt/${effectiveConfig.maxAttempts} after ${delay.inMilliseconds}ms: $lastException',
          name: 'gRPC_RETRY.$operationName',
        );

        await Future.delayed(delay);
      }
    }

    developer.log(
      'All ${effectiveConfig.maxAttempts} retry attempts exhausted: $lastException',
      name: 'gRPC_RETRY.$operationName',
    );

    throw lastException!;
  }

  bool _shouldRetryError(Exception error, bool Function(Exception)? customShouldRetry) {
    // Use custom retry logic if provided
    if (customShouldRetry != null) {
      return customShouldRetry(error);
    }

    // Default retry logic: retry on network/timeout errors
    if (error is GrpcError) {
      final code = error.code;

      // Retry on:
      // - Unavailable (service temporarily down)
      // - DeadlineExceeded (timeout)
      // - Aborted (connection reset)
      // - Internal (server error, may be transient)
      return code == StatusCode.unavailable ||
             code == StatusCode.deadlineExceeded ||
             code == StatusCode.aborted ||
             code == StatusCode.internal;
    }

    // Retry on socket exceptions
    if (error is SocketException || error is HttpException) {
      return true;
    }

    return false;
  }

  Duration _calculateDelay(int attempt, RetryConfig config) {
    final multiplier = math.pow(config.backoffMultiplier, attempt - 1);
    final delayMs = (config.initialDelay.inMilliseconds * multiplier).round();
    return Duration(
      milliseconds: delayMs.clamp(
        config.initialDelay.inMilliseconds,
        config.maxDelay.inMilliseconds,
      ),
    );
  }
}

/// User-friendly error messages for common crypto errors
class CryptoErrorMessages {
  static String translate(Exception error, {String? operation}) {
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.unavailable:
          return 'Service temporarily unavailable. Please check your connection and try again.';
        case StatusCode.deadlineExceeded:
          return 'Request timed out. The server is taking too long to respond. Please try again.';
        case StatusCode.unauthenticated:
          return 'You need to log in to perform this action.';
        case StatusCode.permissionDenied:
          return 'You don\'t have permission to perform this action.';
        case StatusCode.notFound:
          return 'The requested resource was not found.';
        case StatusCode.alreadyExists:
          return 'This item already exists.';
        case StatusCode.resourceExhausted:
          return 'Server is overloaded. Please try again later.';
        case StatusCode.failedPrecondition:
          return 'Cannot complete this operation. Please check your account details.';
        case StatusCode.outOfRange:
          return 'Invalid value provided. Please check your input.';
        case StatusCode.unimplemented:
          return 'This feature is not yet available.';
        case StatusCode.internal:
          return 'A server error occurred. Our team has been notified. Please try again.';
        default:
          return 'An error occurred: ${error.message}';
      }
    }

    if (error is SocketException) {
      return 'Network connection failed. Please check your internet connection.';
    }

    if (error is HttpException) {
      return 'Network error: ${error.message}';
    }

    return 'An unexpected error occurred: ${error.toString()}';
  }

  /// Check if error is a network-related error (user's fault)
  static bool isNetworkError(Exception error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
             error.code == StatusCode.deadlineExceeded;
    }
    return error is SocketException || error is HttpException;
  }

  /// Check if error is an auth-related error (user needs to log in)
  static bool isAuthError(Exception error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unauthenticated ||
             error.code == StatusCode.permissionDenied;
    }
    return false;
  }

  /// Check if error is a not-found error
  static bool isNotFoundError(Exception error) {
    if (error is GrpcError) {
      return error.code == StatusCode.notFound;
    }
    return false;
  }
}
