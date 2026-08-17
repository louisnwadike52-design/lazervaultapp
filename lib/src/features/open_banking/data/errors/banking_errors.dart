/// Banking error types and utilities for handling provider switch edge cases
library;

import 'dart:convert';
import 'dart:io';
part 'banking_errors_widgets.dart';


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

    // grpc-gateway returns camelCase JSON; also handle snake_case from custom REST
    final errorCode = data?['error_code'] as String? ??
        data?['errorCode'] as String? ??
        data?['code'] as String? ??
        BankingErrorCode.unknown;
    final errorMessage = data?['error_message'] as String? ??
        data?['errorMessage'] as String? ??
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
      case BankingErrorCode.monthlyLimitExceeded:
      case BankingErrorCode.singleTransactionLimitExceeded:
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
