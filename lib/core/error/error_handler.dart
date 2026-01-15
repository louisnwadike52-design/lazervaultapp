import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// ErrorCode represents standardized error codes from backend
enum ErrorCode {
  // Client Errors (4xx) - Do NOT retry
  badRequest('BAD_REQUEST'),
  unauthorized('UNAUTHORIZED'),
  forbidden('FORBIDDEN'),
  notFound('NOT_FOUND'),
  conflict('CONFLICT'),
  validationFailed('VALIDATION_FAILED'),
  invalidCredentials('INVALID_CREDENTIALS'),
  insufficientFunds('INSUFFICIENT_FUNDS'),
  duplicateEntry('DUPLICATE_ENTRY'),
  rateLimitExceeded('RATE_LIMIT_EXCEEDED'),
  invalidPIN('INVALID_PIN'),
  accountLocked('ACCOUNT_LOCKED'),
  expiredToken('EXPIRED_TOKEN'),

  // Transient Errors (5xx) - Retryable
  internalError('INTERNAL_ERROR'),
  serviceUnavailable('SERVICE_UNAVAILABLE'),
  databaseError('DATABASE_ERROR'),
  upstreamTimeout('UPSTREAM_TIMEOUT'),
  upstreamUnavailable('UPSTREAM_UNAVAILABLE'),
  circuitBreakerOpen('CIRCUIT_BREAKER_OPEN'),
  rateLimited('RATE_LIMITED'),

  // Network errors
  networkError('NETWORK_ERROR'),
  timeout('TIMEOUT'),

  // Unknown
  unknown('UNKNOWN');

  final String value;
  const ErrorCode(this.value);

  static ErrorCode fromString(String value) {
    return ErrorCode.values.firstWhere(
      (code) => code.value == value,
      orElse: () => ErrorCode.unknown,
    );
  }
}

/// AppError represents a structured application error
class AppError implements Exception {
  final ErrorCode code;
  final String message;
  final bool retryable;
  final String? traceId;
  final dynamic details;
  final int? httpStatus;
  final DateTime timestamp;

  AppError({
    required this.code,
    required this.message,
    this.retryable = false,
    this.traceId,
    this.details,
    this.httpStatus,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory AppError.fromJson(Map<String, dynamic> json) {
    final error = json['error'] as Map<String, dynamic>?;
    if (error == null) {
      return AppError(
        code: ErrorCode.unknown,
        message: json['message']?.toString() ?? 'Unknown error',
        retryable: json['retryable'] == true,
        traceId: json['trace_id']?.toString(),
        details: json['details'],
      );
    }

    return AppError(
      code: ErrorCode.fromString(error['code']?.toString() ?? ''),
      message: error['message']?.toString() ?? 'Unknown error',
      retryable: error['retryable'] == true,
      traceId: error['trace_id']?.toString(),
      details: error['details'],
      httpStatus: json['status'] as int?,
    );
  }

  factory AppError.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          code: ErrorCode.timeout,
          message: 'Request timed out. Please check your connection.',
          retryable: true,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          return AppError.fromJson(data);
        }

        return AppError(
          code: _codeFromStatus(statusCode),
          message: data?['error']?['message'] ??
              data?['message'] ??
              'Request failed with status $statusCode',
          httpStatus: statusCode,
          retryable: _isRetryableStatus(statusCode),
        );

      case DioExceptionType.cancel:
        return AppError(
          code: ErrorCode.unknown,
          message: 'Request was cancelled',
          retryable: false,
        );

      case DioExceptionType.connectionError:
        return AppError(
          code: ErrorCode.networkError,
          message: 'No internet connection. Please check your network.',
          retryable: true,
        );

      default:
        return AppError(
          code: ErrorCode.unknown,
          message: error.message ?? 'An unexpected error occurred',
          retryable: false,
        );
    }
  }

  static ErrorCode _codeFromStatus(int? status) {
    switch (status) {
      case 400:
        return ErrorCode.badRequest;
      case 401:
        return ErrorCode.unauthorized;
      case 403:
        return ErrorCode.forbidden;
      case 404:
        return ErrorCode.notFound;
      case 409:
        return ErrorCode.conflict;
      case 429:
        return ErrorCode.rateLimitExceeded;
      case 500:
      case 502:
      case 503:
      case 504:
        return ErrorCode.serviceUnavailable;
      default:
        return ErrorCode.unknown;
    }
  }

  static bool _isRetryableStatus(int? status) {
    return status != null && status >= 500;
  }

  @override
  String toString() {
    return 'AppError: $code - $message${retryable ? " (retryable)" : ""}';
  }

  String get userMessage {
    switch (code) {
      case ErrorCode.unauthorized:
        return 'Please log in to continue';
      case ErrorCode.forbidden:
        return 'You don\'t have permission to perform this action';
      case ErrorCode.notFound:
        return 'The requested resource was not found';
      case ErrorCode.insufficientFunds:
        return 'Insufficient funds for this transaction';
      case ErrorCode.invalidPIN:
        return 'Invalid PIN. Please try again';
      case ErrorCode.accountLocked:
        return 'Your account has been locked. Please contact support';
      case ErrorCode.expiredToken:
        return 'Your session has expired. Please log in again';
      case ErrorCode.rateLimitExceeded:
        return 'Too many requests. Please wait a moment';
      case ErrorCode.networkError:
        return 'No internet connection';
      case ErrorCode.timeout:
        return 'Request timed out. Please try again';
      case ErrorCode.serviceUnavailable:
        return 'Service temporarily unavailable. Please try again later';
      default:
        return message;
    }
  }

  bool get isAuthError =>
      code == ErrorCode.unauthorized ||
      code == ErrorCode.expiredToken ||
      code == ErrorCode.invalidCredentials;

  bool get isNetworkError =>
      code == ErrorCode.networkError ||
      code == ErrorCode.timeout ||
      httpStatus != null && httpStatus! >= 500;
}

/// RetryConfig defines retry behavior
class RetryConfig {
  final int maxRetries;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffFactor;
  final Duration timeout;

  const RetryConfig({
    this.maxRetries = 3,
    this.initialDelay = const Duration(milliseconds: 100),
    this.maxDelay = const Duration(seconds: 10),
    this.backoffFactor = 2.0,
    this.timeout = const Duration(seconds: 30),
  });

  static const fast = RetryConfig(
    maxRetries: 2,
    initialDelay: Duration(milliseconds: 50),
    maxDelay: Duration(milliseconds: 200),
  );

  static const standard = RetryConfig();

  static const slow = RetryConfig(
    maxRetries: 5,
    initialDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 30),
  );
}

/// ErrorHandler handles errors consistently across the app
class ErrorHandler {
  final List<void Function(AppError)> _errorListeners = [];

  /// Add error listener for logging/analytics
  void addErrorListener(void Function(AppError) listener) {
    _errorListeners.add(listener);
  }

  /// Remove error listener
  void removeErrorListener(void Function(AppError) listener) {
    _errorListeners.remove(listener);
  }

  /// Handle error and notify listeners
  void handleError(AppError error) {
    // Notify all listeners
    for (final listener in _errorListeners) {
      try {
        listener(error);
      } catch (e) {
        debugPrint('Error in error listener: $e');
      }
    }
  }

  /// Execute function with retry logic
  Future<T> executeWithRetry<T>(
    Future<T> Function() fn, {
    RetryConfig config = RetryConfig.standard,
  }) async {
    int attempts = 0;
    Duration delay = config.initialDelay;

    while (true) {
      try {
        // Add timeout
        final result = await fn().timeout(
          config.timeout,
          onTimeout: () {
            throw TimeoutException('Operation timed out after ${config.timeout}');
          },
        );
        return result;
      } catch (e) {
        attempts++;

        // Convert to AppError
        final appError = e is AppError
            ? e
            : (e is DioException
                ? AppError.fromDioError(e)
                : AppError(
                    code: ErrorCode.unknown,
                    message: e.toString(),
                    retryable: false,
                  ));

        // Don't retry if not retryable
        if (!appError.retryable || attempts >= config.maxRetries) {
          handleError(appError);
          rethrow;
        }

        // Log retry
        debugPrint('Retry $attempts/$config.maxRetries after ${delay.inMilliseconds}ms: ${appError.code}');

        // Wait before retry
        await Future.delayed(delay);

        // Exponential backoff
        delay = Duration(
          milliseconds: (delay.inMilliseconds * config.backoffFactor)
              .clamp(config.initialDelay.inMilliseconds, config.maxDelay.inMilliseconds)
              .toInt(),
        );
      }
    }
  }

  /// Execute with idempotency (safe retry)
  Future<T> executeIdempotent<T>(
    String idempotencyKey,
    Future<T> Function() fn, {
    RetryConfig config = RetryConfig.standard,
  }) async {
    // In a real implementation, this would:
    // 1. Check local cache for previous result with this key
    // 2. If found, return cached result
    // 3. If not, execute with retry
    // 4. Cache result

    return executeWithRetry(fn, config: config);
  }
}

/// Global error handler instance
final errorHandler = ErrorHandler();

/// Extension to add retry to Dio
extension DioRetry on Dio {
  Future<Response<T>> fetchWithRetry<T>(
    RequestOptions requestOptions, {
    RetryConfig config = RetryConfig.standard,
  }) async {
    return errorHandler.executeWithRetry(
      () => fetch<T>(requestOptions),
      config: config,
    );
  }
}

/// Usage example:
///
/// ```dart
/// try {
///   final response = await dio.get('/api/payments')
///     .timeout(Duration(seconds: 10));
///   // Handle success
/// } on AppError catch (e) {
///   // Handle structured error
///   showErrorSnackBar(e.userMessage);
///
///   if (e.isAuthError) {
///     // Navigate to login
///     Navigator.pushReplacementNamed(context, '/login');
///   } else if (e.retryable) {
///     // Show retry option
///     showRetryDialog(
///       message: e.userMessage,
///       onRetry: () => retryRequest(),
///     );
///   }
/// } catch (e) {
///   // Handle unexpected errors
///   final appError = e is DioException
///       ? AppError.fromDioError(e)
///       : AppError(code: ErrorCode.unknown, message: e.toString());
///   showErrorSnackBar(appError.userMessage);
/// }
/// ```
