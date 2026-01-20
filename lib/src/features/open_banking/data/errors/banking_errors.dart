/// Banking error types and utilities for handling provider switch edge cases
library;

import 'dart:convert';
import 'dart:io';

/// Error codes returned by the backend
class BankingErrorCode {
  static const String insufficientFunds = 'INSUFFICIENT_FUNDS';
  static const String accountNotFound = 'ACCOUNT_NOT_FOUND';
  static const String accountFrozen = 'ACCOUNT_FROZEN';
  static const String limitExceeded = 'LIMIT_EXCEEDED';
  static const String dailyLimitExceeded = 'DAILY_LIMIT_EXCEEDED';
  static const String duplicateTransaction = 'DUPLICATE_TRANSACTION';
  static const String serviceUnavailable = 'SERVICE_UNAVAILABLE';
  static const String providerMismatch = 'PROVIDER_MISMATCH';
  static const String providerError = 'PROVIDER_ERROR';
  static const String transferFailed = 'TRANSFER_FAILED';
  static const String accountVerificationFailed = 'ACCOUNT_VERIFICATION_FAILED';
  static const String identityVerificationFailed = 'IDENTITY_VERIFICATION_FAILED';
  static const String rateLimitExceeded = 'RATE_LIMIT_EXCEEDED';
  static const String invalidAmount = 'INVALID_AMOUNT';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String networkError = 'NETWORK_ERROR';
  static const String timeout = 'TIMEOUT';
  static const String unknown = 'UNKNOWN_ERROR';
}

/// Base class for all banking-related exceptions
sealed class BankingException implements Exception {
  final String message;
  final String code;
  final bool isRetryable;
  final Map<String, dynamic>? details;

  const BankingException({
    required this.message,
    required this.code,
    this.isRetryable = false,
    this.details,
  });

  /// Get user-friendly error message
  String get userMessage;

  @override
  String toString() => 'BankingException($code): $message';
}

/// Network-related errors (timeout, no connection)
class NetworkException extends BankingException {
  final bool isTimeout;

  const NetworkException({
    required super.message,
    this.isTimeout = false,
    super.details,
  }) : super(
          code: isTimeout ? BankingErrorCode.timeout : BankingErrorCode.networkError,
          isRetryable: true,
        );

  @override
  String get userMessage => isTimeout
      ? 'The request timed out. Please check your internet connection and try again.'
      : 'Unable to connect to our servers. Please check your internet connection.';
}

/// Service unavailable (provider down, circuit breaker open)
class ServiceUnavailableException extends BankingException {
  final Duration? retryAfter;

  const ServiceUnavailableException({
    required super.message,
    this.retryAfter,
    super.details,
  }) : super(
          code: BankingErrorCode.serviceUnavailable,
          isRetryable: true,
        );

  @override
  String get userMessage =>
      'Our payment service is temporarily unavailable. Please try again in a few moments.';
}

/// Insufficient funds error
class InsufficientFundsException extends BankingException {
  final int? availableBalance;
  final int? requiredAmount;
  final String? currency;

  const InsufficientFundsException({
    required super.message,
    this.availableBalance,
    this.requiredAmount,
    this.currency,
    super.details,
  }) : super(
          code: BankingErrorCode.insufficientFunds,
          isRetryable: false,
        );

  @override
  String get userMessage {
    if (availableBalance != null && currency != null) {
      final available = (availableBalance! / 100).toStringAsFixed(2);
      return 'Insufficient funds. Your available balance is $currency$available.';
    }
    return 'You don\'t have enough funds to complete this transaction.';
  }
}

/// Limit exceeded error (daily, per-transaction, tier)
class LimitExceededException extends BankingException {
  final String limitType;
  final int? limit;
  final int? attempted;
  final String? currency;

  const LimitExceededException({
    required super.message,
    required this.limitType,
    this.limit,
    this.attempted,
    this.currency,
    super.details,
  }) : super(
          code: BankingErrorCode.limitExceeded,
          isRetryable: false,
        );

  @override
  String get userMessage {
    if (limit != null && currency != null) {
      final limitAmount = (limit! / 100).toStringAsFixed(2);
      return 'This transaction exceeds your $limitType limit of $currency$limitAmount.';
    }
    return 'This transaction exceeds your $limitType limit.';
  }
}

/// Account not found error
class AccountNotFoundException extends BankingException {
  final String? accountId;

  const AccountNotFoundException({
    required super.message,
    this.accountId,
    super.details,
  }) : super(
          code: BankingErrorCode.accountNotFound,
          isRetryable: false,
        );

  @override
  String get userMessage => 'The account could not be found.';
}

/// Account frozen error
class AccountFrozenException extends BankingException {
  final String? reason;

  const AccountFrozenException({
    required super.message,
    this.reason,
    super.details,
  }) : super(
          code: BankingErrorCode.accountFrozen,
          isRetryable: false,
        );

  @override
  String get userMessage =>
      'This account is currently frozen. Please contact support for assistance.';
}

/// Duplicate transaction error
class DuplicateTransactionException extends BankingException {
  final String? existingTransactionId;

  const DuplicateTransactionException({
    required super.message,
    this.existingTransactionId,
    super.details,
  }) : super(
          code: BankingErrorCode.duplicateTransaction,
          isRetryable: false,
        );

  @override
  String get userMessage => 'This transaction has already been processed.';
}

/// Transfer failed error
class TransferFailedException extends BankingException {
  final String? providerCode;
  final String? providerMessage;

  TransferFailedException({
    required super.message,
    this.providerCode,
    this.providerMessage,
    bool isRetryable = true,
    super.details,
  }) : super(
          code: BankingErrorCode.transferFailed,
          isRetryable: isRetryable,
        );

  @override
  String get userMessage {
    if (!isRetryable) {
      return providerMessage ?? 'The transfer could not be completed.';
    }
    return 'The transfer couldn\'t be completed. Please try again.';
  }
}

/// Account verification failed
class AccountVerificationException extends BankingException {
  const AccountVerificationException({
    required super.message,
    super.details,
  }) : super(
          code: BankingErrorCode.accountVerificationFailed,
          isRetryable: true,
        );

  @override
  String get userMessage =>
      'We couldn\'t verify the account details. Please check and try again.';
}

/// Rate limit exceeded
class RateLimitException extends BankingException {
  final Duration? retryAfter;

  const RateLimitException({
    required super.message,
    this.retryAfter,
    super.details,
  }) : super(
          code: BankingErrorCode.rateLimitExceeded,
          isRetryable: true,
        );

  @override
  String get userMessage =>
      'You\'ve made too many requests. Please wait a moment before trying again.';
}

/// Unauthorized error
class UnauthorizedException extends BankingException {
  const UnauthorizedException({
    required super.message,
    super.details,
  }) : super(
          code: BankingErrorCode.unauthorized,
          isRetryable: false,
        );

  @override
  String get userMessage =>
      'Your session has expired. Please log in again.';
}

/// Provider mismatch error (account created with different provider)
class ProviderMismatchException extends BankingException {
  final String? originalProvider;
  final String? currentProvider;

  const ProviderMismatchException({
    required super.message,
    this.originalProvider,
    this.currentProvider,
    super.details,
  }) : super(
          code: BankingErrorCode.providerMismatch,
          isRetryable: false,
        );

  @override
  String get userMessage =>
      'This operation cannot be completed at this time. Please contact support.';
}

/// Generic banking error
class GenericBankingException extends BankingException {
  const GenericBankingException({
    required super.message,
    super.code = BankingErrorCode.unknown,
    super.isRetryable = false,
    super.details,
  });

  @override
  String get userMessage => 'An unexpected error occurred. Please try again later.';
}

/// Error parser utility
class BankingErrorParser {
  /// Parse HTTP response into appropriate exception
  static BankingException parseResponse(int statusCode, String body) {
    Map<String, dynamic>? data;
    try {
      data = jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      // Body is not valid JSON
    }

    final errorCode = data?['error_code'] as String? ??
        data?['code'] as String? ??
        BankingErrorCode.unknown;
    final errorMessage = data?['error_message'] as String? ??
        data?['message'] as String? ??
        'An error occurred';

    // Check for specific error codes first
    switch (errorCode) {
      case BankingErrorCode.insufficientFunds:
        return InsufficientFundsException(
          message: errorMessage,
          availableBalance: data?['available_balance'] as int?,
          requiredAmount: data?['required_amount'] as int?,
          currency: data?['currency'] as String? ?? 'NGN',
          details: data,
        );

      case BankingErrorCode.limitExceeded:
      case BankingErrorCode.dailyLimitExceeded:
        return LimitExceededException(
          message: errorMessage,
          limitType: data?['limit_type'] as String? ?? 'transaction',
          limit: data?['limit'] as int?,
          attempted: data?['attempted'] as int?,
          currency: data?['currency'] as String? ?? 'NGN',
          details: data,
        );

      case BankingErrorCode.accountNotFound:
        return AccountNotFoundException(
          message: errorMessage,
          accountId: data?['account_id'] as String?,
          details: data,
        );

      case BankingErrorCode.accountFrozen:
        return AccountFrozenException(
          message: errorMessage,
          reason: data?['reason'] as String?,
          details: data,
        );

      case BankingErrorCode.duplicateTransaction:
        return DuplicateTransactionException(
          message: errorMessage,
          existingTransactionId: data?['existing_transaction_id'] as String?,
          details: data,
        );

      case BankingErrorCode.serviceUnavailable:
        return ServiceUnavailableException(
          message: errorMessage,
          retryAfter: data?['retry_after'] != null
              ? Duration(seconds: data!['retry_after'] as int)
              : null,
          details: data,
        );

      case BankingErrorCode.rateLimitExceeded:
        return RateLimitException(
          message: errorMessage,
          retryAfter: data?['retry_after'] != null
              ? Duration(seconds: data!['retry_after'] as int)
              : null,
          details: data,
        );

      case BankingErrorCode.transferFailed:
        return TransferFailedException(
          message: errorMessage,
          providerCode: data?['provider_code'] as String?,
          providerMessage: data?['provider_message'] as String?,
          isRetryable: data?['retryable'] as bool? ?? false,
          details: data,
        );

      case BankingErrorCode.accountVerificationFailed:
        return AccountVerificationException(
          message: errorMessage,
          details: data,
        );

      case BankingErrorCode.unauthorized:
        return UnauthorizedException(
          message: errorMessage,
          details: data,
        );

      case BankingErrorCode.providerMismatch:
        return ProviderMismatchException(
          message: errorMessage,
          originalProvider: data?['original_provider'] as String?,
          currentProvider: data?['current_provider'] as String?,
          details: data,
        );
    }

    // Check status code for generic errors
    switch (statusCode) {
      case 401:
        return UnauthorizedException(
          message: errorMessage,
          details: data,
        );

      case 403:
        return UnauthorizedException(
          message: errorMessage,
          details: data,
        );

      case 404:
        return AccountNotFoundException(
          message: errorMessage,
          details: data,
        );

      case 429:
        return RateLimitException(
          message: errorMessage,
          details: data,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServiceUnavailableException(
          message: errorMessage,
          details: data,
        );

      default:
        return GenericBankingException(
          message: errorMessage,
          code: errorCode,
          isRetryable: statusCode >= 500,
          details: data,
        );
    }
  }

  /// Parse platform exception (e.g., from HTTP client)
  static BankingException parsePlatformException(Object error) {
    if (error is SocketException) {
      return const NetworkException(
        message: 'Network connection failed',
        isTimeout: false,
      );
    }

    if (error is HttpException) {
      return const NetworkException(
        message: 'HTTP error occurred',
        isTimeout: false,
      );
    }

    // Check for timeout patterns
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('timeout') ||
        errorString.contains('timed out') ||
        errorString.contains('deadline')) {
      return const NetworkException(
        message: 'Request timed out',
        isTimeout: true,
      );
    }

    if (errorString.contains('connection') ||
        errorString.contains('network') ||
        errorString.contains('socket')) {
      return const NetworkException(
        message: 'Network connection failed',
        isTimeout: false,
      );
    }

    return GenericBankingException(
      message: error.toString(),
      isRetryable: false,
    );
  }
}
