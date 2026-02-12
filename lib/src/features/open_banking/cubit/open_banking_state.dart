import 'package:equatable/equatable.dart';
import '../domain/entities/linked_bank_account.dart';
import '../domain/entities/deposit.dart';
import '../domain/entities/withdrawal.dart';
import '../domain/entities/credit_score.dart';
import '../domain/entities/credit_score_ai_insights.dart';
import '../data/errors/banking_errors.dart';

/// Error type classification for UI handling
enum BankingErrorType {
  /// Network connectivity issues - show retry option
  network,

  /// Service temporarily unavailable - show retry later message
  serviceUnavailable,

  /// Insufficient funds - show balance info
  insufficientFunds,

  /// Limit exceeded - show limit info
  limitExceeded,

  /// Account issues (frozen, not found) - show contact support
  accountIssue,

  /// Session expired - redirect to login
  unauthorized,

  /// Needs mandate - user must set up direct debit mandate
  needsMandate,

  /// General error - show generic message
  general,
}

/// Base state for open banking
abstract class OpenBankingState extends Equatable {
  const OpenBankingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class OpenBankingInitial extends OpenBankingState {}

/// Loading state
class OpenBankingLoading extends OpenBankingState {}

/// Linked accounts loaded state
class LinkedAccountsLoaded extends OpenBankingState {
  final List<LinkedBankAccount> accounts;
  final LinkedBankAccount? defaultAccount;

  const LinkedAccountsLoaded({
    required this.accounts,
    this.defaultAccount,
  });

  @override
  List<Object?> get props => [accounts, defaultAccount];
}

/// Account linking in progress
class AccountLinkingInProgress extends OpenBankingState {}

/// Account successfully linked
class AccountLinked extends OpenBankingState {
  final LinkedBankAccount account;
  final bool isNewAccount;

  const AccountLinked({
    required this.account,
    required this.isNewAccount,
  });

  @override
  List<Object?> get props => [account, isNewAccount];
}

/// Account unlinked
class AccountUnlinked extends OpenBankingState {
  final String accountId;

  const AccountUnlinked({required this.accountId});

  @override
  List<Object?> get props => [accountId];
}

/// Balance refreshed
class BalanceRefreshed extends OpenBankingState {
  final String accountId;
  final double newBalance;

  const BalanceRefreshed({
    required this.accountId,
    required this.newBalance,
  });

  @override
  List<Object?> get props => [accountId, newBalance];
}

/// Deposit initiated
class DepositInitiated extends OpenBankingState {
  final Deposit deposit;

  const DepositInitiated({required this.deposit});

  @override
  List<Object?> get props => [deposit];
}

/// Deposit status updated
class DepositStatusUpdated extends OpenBankingState {
  final Deposit deposit;

  const DepositStatusUpdated({required this.deposit});

  @override
  List<Object?> get props => [deposit];
}

/// Deposits loaded
class DepositsLoaded extends OpenBankingState {
  final List<Deposit> deposits;
  final int total;

  const DepositsLoaded({
    required this.deposits,
    required this.total,
  });

  @override
  List<Object?> get props => [deposits, total];
}

/// Fee calculated
class DepositFeeCalculated extends OpenBankingState {
  final DepositFeeCalculation calculation;

  const DepositFeeCalculated({required this.calculation});

  @override
  List<Object?> get props => [calculation];
}

/// Mono Connect config loaded
class ConnectConfigLoaded extends OpenBankingState {
  final String publicKey;
  final String appId;

  const ConnectConfigLoaded({
    required this.publicKey,
    required this.appId,
  });

  @override
  List<Object?> get props => [publicKey, appId];
}

/// Reauthorization token received
class ReauthorizationTokenReceived extends OpenBankingState {
  final String accountId;
  final String token;

  const ReauthorizationTokenReceived({
    required this.accountId,
    required this.token,
  });

  @override
  List<Object?> get props => [accountId, token];
}

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

  /// Create from a BankingException
  factory OpenBankingError.fromException(
    BankingException exception, {
    String? operation,
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
      details: exception.details,
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

/// Service unavailable state - special state for provider outages
class ServiceUnavailable extends OpenBankingState {
  final String message;
  final Duration? retryAfter;
  final bool circuitBreakerOpen;

  const ServiceUnavailable({
    required this.message,
    this.retryAfter,
    this.circuitBreakerOpen = false,
  });

  @override
  List<Object?> get props => [message, retryAfter, circuitBreakerOpen];
}

/// Offline state - no network connectivity
class OpenBankingOffline extends OpenBankingState {
  final String? lastOperation;

  const OpenBankingOffline({this.lastOperation});

  @override
  List<Object?> get props => [lastOperation];
}

/// Retrying state - operation is being retried
class OpenBankingRetrying extends OpenBankingState {
  final String operation;
  final int attempt;
  final int maxAttempts;
  final Duration? delayRemaining;

  const OpenBankingRetrying({
    required this.operation,
    required this.attempt,
    required this.maxAttempts,
    this.delayRemaining,
  });

  @override
  List<Object?> get props => [operation, attempt, maxAttempts, delayRemaining];
}

// =====================================================
// WITHDRAWAL STATES
// =====================================================

/// Banks list loaded
class BanksLoaded extends OpenBankingState {
  final List<Bank> banks;

  const BanksLoaded({required this.banks});

  @override
  List<Object?> get props => [banks];
}

/// Account name inquiry result
class AccountNameResolved extends OpenBankingState {
  final AccountNameInquiry inquiry;

  const AccountNameResolved({required this.inquiry});

  @override
  List<Object?> get props => [inquiry];
}

/// Withdrawal initiated
class WithdrawalInitiated extends OpenBankingState {
  final Withdrawal withdrawal;

  const WithdrawalInitiated({required this.withdrawal});

  @override
  List<Object?> get props => [withdrawal];
}

/// Withdrawal status updated
class WithdrawalStatusUpdated extends OpenBankingState {
  final Withdrawal withdrawal;

  const WithdrawalStatusUpdated({required this.withdrawal});

  @override
  List<Object?> get props => [withdrawal];
}

/// Withdrawals loaded
class WithdrawalsLoaded extends OpenBankingState {
  final List<Withdrawal> withdrawals;
  final int total;

  const WithdrawalsLoaded({
    required this.withdrawals,
    required this.total,
  });

  @override
  List<Object?> get props => [withdrawals, total];
}

/// Withdrawal fee calculated
class WithdrawalFeeCalculated extends OpenBankingState {
  final WithdrawalFeeCalculation calculation;

  const WithdrawalFeeCalculated({required this.calculation});

  @override
  List<Object?> get props => [calculation];
}

// ===== Credit Score States =====

/// Credit score loaded successfully
class CreditScoreLoaded extends OpenBankingState {
  final CreditScoreEntity creditScore;

  const CreditScoreLoaded({required this.creditScore});

  @override
  List<Object?> get props => [creditScore];
}

/// Credit score history loaded
class CreditScoreHistoryLoaded extends OpenBankingState {
  final CreditScoreHistoryEntity history;

  const CreditScoreHistoryLoaded({required this.history});

  @override
  List<Object?> get props => [history];
}

/// Credit score is being refreshed
class CreditScoreRefreshing extends OpenBankingState {}

// ===== Credit Score AI Insights States =====

/// AI insights are being generated
class CreditScoreAIInsightsLoading extends OpenBankingState {}

/// AI insights loaded successfully
class CreditScoreAIInsightsLoaded extends OpenBankingState {
  final CreditScoreAIInsights insights;

  const CreditScoreAIInsightsLoaded({required this.insights});

  @override
  List<Object?> get props => [insights];
}

/// AI insights generation failed
class CreditScoreAIInsightsError extends OpenBankingState {
  final String message;

  const CreditScoreAIInsightsError({required this.message});

  @override
  List<Object?> get props => [message];
}
