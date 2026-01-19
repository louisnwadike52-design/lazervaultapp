/// Account verification states for recipient addition flow.
///
/// Handles the states during bank account name verification via Paystack API.
abstract class AccountVerificationState {
  const AccountVerificationState();
}

/// Initial state before any verification attempt.
class AccountVerificationInitial extends AccountVerificationState {
  const AccountVerificationInitial();
}

/// Loading state during account verification.
class AccountVerificationLoading extends AccountVerificationState {
  final String accountNumber;
  final String bankName;
  final String bankCode;

  const AccountVerificationLoading({
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
  });
}

/// Success state after successful account verification.
class AccountVerificationSuccess extends AccountVerificationState {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final String verificationStatus;

  const AccountVerificationSuccess({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
    this.verificationStatus = 'verified',
  });
}

/// Failure state when account verification fails.
class AccountVerificationFailure extends AccountVerificationState {
  final String errorCode;
  final String message;
  final String userMessage;
  final bool allowManualEntry;
  final String? accountNumber;
  final String? bankCode;

  const AccountVerificationFailure({
    required this.errorCode,
    required this.message,
    required this.userMessage,
    this.allowManualEntry = false,
    this.accountNumber,
    this.bankCode,
  });

  /// Check if this error allows retry.
  bool get canRetry {
    return errorCode != 'INVALID_FORMAT' && errorCode != 'INVALID_BANK_CODE';
  }

  /// Check if this is a network/timeout error.
  bool get isNetworkError {
    return errorCode == 'NETWORK_ERROR' ||
        errorCode == 'TIMEOUT' ||
        errorCode == 'CONNECTION_ERROR';
  }

  /// Check if this is a rate limit error.
  bool get isRateLimitError {
    return errorCode == 'RATE_LIMIT_EXCEEDED';
  }

  /// Check if account was not found.
  bool get isAccountNotFound {
    return errorCode == 'ACCOUNT_NOT_FOUND';
  }
}
