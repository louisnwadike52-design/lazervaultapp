import 'package:equatable/equatable.dart';
import '../domain/entities/linked_bank_account.dart';
import '../domain/entities/deposit.dart';
import '../domain/entities/withdrawal.dart';
import '../domain/entities/credit_score.dart';
import '../domain/entities/credit_score_ai_insights.dart';
import '../data/errors/banking_errors.dart';
import '../../move_money/domain/entities/mandate_entity.dart';
part 'open_banking_state_widgets.dart';


/// Error state with detailed error information
class OpenBankingError extends OpenBankingState {
  final String message;
  final String? errorCode;
  final BankingErrorType errorType;
  final bool isRetryable;
  final Duration? retryAfter;
  final Map<String, dynamic>? details;
  final String? operation; // What operation failed

  const OpenBankingError({
    required this.message,
    this.errorCode,
    this.errorType = BankingErrorType.general,
    this.isRetryable = false,
    this.retryAfter,
    this.details,
    this.operation,
  });

  /// Create from a BankingException. [accountId], when supplied (e.g. a per-account
  /// balance refresh), is merged into `details` so listeners can scope the failure
  /// to exactly that account instead of every in-flight one.
  factory OpenBankingError.fromException(
    BankingException exception, {
    String? operation,
    String? accountId,
  }) {
    return OpenBankingError(
      message: exception.userMessage,
      errorCode: exception.code,
      errorType: _mapExceptionToType(exception),
      isRetryable: exception.isRetryable,
      retryAfter: exception is ServiceUnavailableException
          ? exception.retryAfter
          : exception is RateLimitException
              ? exception.retryAfter
              : null,
      details: {
        ...?exception.details,
        if (accountId != null) 'account_id': accountId,
      },
      operation: operation,
    );
  }

  static BankingErrorType _mapExceptionToType(BankingException exception) {
    return switch (exception) {
      NetworkException() => BankingErrorType.network,
      ServiceUnavailableException() => BankingErrorType.serviceUnavailable,
      InsufficientFundsException() => BankingErrorType.insufficientFunds,
      LimitExceededException() => BankingErrorType.limitExceeded,
      AccountNotFoundException() => BankingErrorType.accountIssue,
      AccountFrozenException() => BankingErrorType.accountIssue,
      UnauthorizedException() => BankingErrorType.unauthorized,
      NeedsMandateException() => BankingErrorType.needsMandate,
      ReauthorizationRequiredException() => BankingErrorType.reauthorizationRequired,
      _ => BankingErrorType.general,
    };
  }

  @override
  List<Object?> get props => [
        message,
        errorCode,
        errorType,
        isRetryable,
        retryAfter,
        details,
        operation,
      ];
}
