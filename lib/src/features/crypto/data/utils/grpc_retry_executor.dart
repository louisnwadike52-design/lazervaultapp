import 'dart:developer' as developer;

import 'package:lazervault/core/services/locale_manager.dart';

/// Retry configuration for gRPC calls
class RetryConfig {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;

  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 100),
    this.maxDelay = const Duration(seconds: 5),
    this.backoffMultiplier = 2.0,
  });

  static const quick = RetryConfig(
    maxAttempts: 2,
    initialDelay: Duration(milliseconds: 50),
    maxDelay: Duration(milliseconds: 500),
  );

  static const network = RetryConfig(
    maxAttempts: 3,
    initialDelay: Duration(milliseconds: 200),
    maxDelay: Duration(seconds: 3),
  );
}

/// Error messages for crypto operations
class CryptoErrorMessages {
  static String translate(Exception exception, {required String operation}) {
    final message = exception.toString().toLowerCase();
    if (message.contains('network') || message.contains('connection')) {
      return 'Network error during $operation. Please check your connection.';
    }
    if (message.contains('timeout')) {
      return 'Request timed out during $operation. Please try again.';
    }
    if (message.contains('unauthorized') || message.contains('authentication')) {
      return 'Authentication failed. Please log in again.';
    }
    if (message.contains('not found')) {
      return 'Resource not found during $operation.';
    }
    return 'An error occurred during $operation: ${exception.toString()}';
  }
}

/// Executor for gRPC calls with retry logic
class GrpcRetryExecutor {
  final RetryConfig config;

  const GrpcRetryExecutor([this.config = const RetryConfig()]);

  Future<T> execute<T>(
    Future<T> Function() operation, {
    required String operationName,
    RetryConfig? config,
  }) async {
    final effectiveConfig = config ?? this.config;
    Exception? lastException;
    Duration delay = effectiveConfig.initialDelay;

    for (int attempt = 1; attempt <= effectiveConfig.maxAttempts; attempt++) {
      try {
        return await operation();
      } catch (e) {
        lastException = e as Exception;
        developer.log(
          'gRPC attempt $attempt failed for $operationName: $e',
          name: 'crypto-grpc',
        );

        if (attempt < effectiveConfig.maxAttempts) {
          await Future.delayed(delay);
          delay = Duration(
            milliseconds: (delay.inMilliseconds * effectiveConfig.backoffMultiplier)
                .clamp(0, effectiveConfig.maxDelay.inMilliseconds)
                .toInt(),
          );
        }
      }
    }

    throw lastException ??
        Exception('$operationName failed after ${effectiveConfig.maxAttempts} attempts');
  }
}
