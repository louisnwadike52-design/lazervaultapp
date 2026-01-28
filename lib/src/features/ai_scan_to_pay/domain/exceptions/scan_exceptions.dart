// Custom exceptions for AI Scan to Pay feature
// Provides specific error types for better error handling and user messaging

/// Base exception for scan operations
abstract class ScanException implements Exception {
  final String message;
  final String? details;
  final bool canRetry;
  final String? userMessage;

  const ScanException({
    required this.message,
    this.details,
    this.canRetry = true,
    this.userMessage,
  });

  String getUserMessage() => userMessage ?? message;

  @override
  String toString() => 'ScanException: $message${details != null ? ' - $details' : ''}';
}

/// OCR-related exceptions
class OCRException extends ScanException {
  final OCRErrorType errorType;

  const OCRException({
    required this.errorType,
    required String message,
    String? details,
    bool canRetry = true,
    String? userMessage,
  }) : super(
          message: message,
          details: details,
          canRetry: canRetry,
          userMessage: userMessage,
        );

  factory OCRException.lowConfidence({double? confidence}) {
    return OCRException(
      errorType: OCRErrorType.lowConfidence,
      message: 'OCR confidence too low: ${confidence?.toStringAsFixed(2) ?? 'unknown'}',
      userMessage: 'Image quality is too low. Please retake with better lighting and focus.',
      canRetry: true,
    );
  }

  factory OCRException.noTextDetected() {
    return const OCRException(
      errorType: OCRErrorType.noTextDetected,
      message: 'No text detected in image',
      userMessage: 'No bank details found. Please ensure the document is clearly visible.',
      canRetry: true,
    );
  }

  factory OCRException.invalidImageFormat() {
    return const OCRException(
      errorType: OCRErrorType.invalidImageFormat,
      message: 'Invalid image format',
      userMessage: 'Image format not supported. Please take a new photo.',
      canRetry: true,
    );
  }

  factory OCRException.imageTooSmall() {
    return const OCRException(
      errorType: OCRErrorType.imageTooSmall,
      message: 'Image resolution too low',
      userMessage: 'Image is too small. Please move closer and retake.',
      canRetry: true,
    );
  }

  factory OCRException.processingTimeout() {
    return const OCRException(
      errorType: OCRErrorType.processingTimeout,
      message: 'OCR processing timed out',
      userMessage: 'Processing took too long. Please try again.',
      canRetry: true,
    );
  }
}

enum OCRErrorType {
  lowConfidence,
  noTextDetected,
  invalidImageFormat,
  imageTooSmall,
  processingTimeout,
}

/// Network-related exceptions
class NetworkException extends ScanException {
  final NetworkErrorType errorType;

  const NetworkException({
    required this.errorType,
    required String message,
    String? details,
    bool canRetry = true,
    String? userMessage,
  }) : super(
          message: message,
          details: details,
          canRetry: canRetry,
          userMessage: userMessage,
        );

  factory NetworkException.noConnection() {
    return const NetworkException(
      errorType: NetworkErrorType.noConnection,
      message: 'No internet connection',
      userMessage: 'No internet connection. Please check your network and try again.',
      canRetry: true,
    );
  }

  factory NetworkException.timeout() {
    return const NetworkException(
      errorType: NetworkErrorType.timeout,
      message: 'Request timed out',
      userMessage: 'Request took too long. Please check your connection and try again.',
      canRetry: true,
    );
  }

  factory NetworkException.serverError({int? statusCode}) {
    return NetworkException(
      errorType: NetworkErrorType.serverError,
      message: 'Server error${statusCode != null ? ': $statusCode' : ''}',
      userMessage: 'Server error. Please try again in a few moments.',
      canRetry: true,
    );
  }

  factory NetworkException.badRequest({String? reason}) {
    return NetworkException(
      errorType: NetworkErrorType.badRequest,
      message: 'Bad request${reason != null ? ': $reason' : ''}',
      userMessage: reason ?? 'Invalid request. Please try again.',
      canRetry: false,
    );
  }
}

enum NetworkErrorType {
  noConnection,
  timeout,
  serverError,
  badRequest,
}

/// Payment-related exceptions
class PaymentException extends ScanException {
  final PaymentErrorType errorType;

  const PaymentException({
    required this.errorType,
    required String message,
    String? details,
    bool canRetry = true,
    String? userMessage,
  }) : super(
          message: message,
          details: details,
          canRetry: canRetry,
          userMessage: userMessage,
        );

  factory PaymentException.insufficientFunds({
    required double availableBalance,
    required double requestedAmount,
  }) {
    return PaymentException(
      errorType: PaymentErrorType.insufficientFunds,
      message: 'Insufficient funds: Available \$$availableBalance, Requested \$$requestedAmount',
      userMessage: 'Insufficient balance. Available: \$${availableBalance.toStringAsFixed(2)}',
      canRetry: false,
    );
  }

  factory PaymentException.invalidAccount() {
    return const PaymentException(
      errorType: PaymentErrorType.invalidAccount,
      message: 'Invalid account details',
      userMessage: 'Account not found. Please verify the account details.',
      canRetry: false,
    );
  }

  factory PaymentException.transactionFailed({String? reason}) {
    return PaymentException(
      errorType: PaymentErrorType.transactionFailed,
      message: 'Transaction failed${reason != null ? ': $reason' : ''}',
      userMessage: reason ?? 'Transaction failed. Please try again.',
      canRetry: true,
    );
  }

  factory PaymentException.pinLocked({required String unlocksAt}) {
    return PaymentException(
      errorType: PaymentErrorType.pinLocked,
      message: 'Account locked due to too many PIN attempts',
      userMessage: 'Account locked. Try again at $unlocksAt',
      canRetry: false,
      details: unlocksAt,
    );
  }

  factory PaymentException.invalidPin() {
    return const PaymentException(
      errorType: PaymentErrorType.invalidPin,
      message: 'Invalid PIN',
      userMessage: 'Incorrect PIN. Please try again.',
      canRetry: true,
    );
  }

  factory PaymentException.amountTooLarge({required double maxAmount}) {
    return PaymentException(
      errorType: PaymentErrorType.amountTooLarge,
      message: 'Amount exceeds maximum limit',
      userMessage: 'Amount too large. Maximum: \$${maxAmount.toStringAsFixed(2)}',
      canRetry: false,
    );
  }

  factory PaymentException.amountTooSmall({required double minAmount}) {
    return PaymentException(
      errorType: PaymentErrorType.amountTooSmall,
      message: 'Amount below minimum limit',
      userMessage: 'Amount too small. Minimum: \$${minAmount.toStringAsFixed(2)}',
      canRetry: false,
    );
  }
}

enum PaymentErrorType {
  insufficientFunds,
  invalidAccount,
  transactionFailed,
  pinLocked,
  invalidPin,
  amountTooLarge,
  amountTooSmall,
}

/// Validation-related exceptions
class ValidationException extends ScanException {
  final ValidationType validationType;

  const ValidationException({
    required this.validationType,
    required String message,
    String? details,
    String? userMessage,
  }) : super(
          message: message,
          details: details,
          canRetry: false,
          userMessage: userMessage,
        );

  factory ValidationException.invalidAccountNumber() {
    return const ValidationException(
      validationType: ValidationType.accountNumber,
      message: 'Invalid account number format',
      userMessage: 'Account number format is invalid. Please verify.',
    );
  }

  factory ValidationException.invalidAmount() {
    return const ValidationException(
      validationType: ValidationType.amount,
      message: 'Invalid amount',
      userMessage: 'Please enter a valid amount.',
    );
  }

  factory ValidationException.missingBankName() {
    return const ValidationException(
      validationType: ValidationType.bankName,
      message: 'Bank name is required',
      userMessage: 'Bank name is required.',
    );
  }

  factory ValidationException.missingAccountName() {
    return const ValidationException(
      validationType: ValidationType.accountName,
      message: 'Account name is required',
      userMessage: 'Account name is required.',
    );
  }
}

enum ValidationType {
  accountNumber,
  amount,
  bankName,
  accountName,
  routingNumber,
}

/// Authentication-related exceptions
class AuthenticationException extends ScanException {
  const AuthenticationException({
    required String message,
    String? details,
    String? userMessage,
  }) : super(
          message: message,
          details: details,
          canRetry: false,
          userMessage: userMessage,
        );

  factory AuthenticationException.notAuthenticated() {
    return const AuthenticationException(
      message: 'User not authenticated',
      userMessage: 'Please log in to continue.',
    );
  }

  factory AuthenticationException.sessionExpired() {
    return const AuthenticationException(
      message: 'Session expired',
      userMessage: 'Your session has expired. Please log in again.',
    );
  }

  factory AuthenticationException.unauthorized() {
    return const AuthenticationException(
      message: 'Unauthorized access',
      userMessage: 'You do not have permission to perform this action.',
    );
  }
}

/// Rate limiting exception
class RateLimitException extends ScanException {
  final int? retryAfterSeconds;

  const RateLimitException({
    required String message,
    this.retryAfterSeconds,
    String? userMessage,
  }) : super(
          message: message,
          canRetry: true,
          userMessage: userMessage,
        );

  factory RateLimitException.tooManyRequests({int? retryAfter}) {
    return RateLimitException(
      message: 'Too many requests',
      retryAfterSeconds: retryAfter,
      userMessage: retryAfter != null
          ? 'Too many attempts. Please try again in $retryAfter seconds.'
          : 'Too many attempts. Please try again later.',
    );
  }

  factory RateLimitException.dailyLimitReached() {
    return const RateLimitException(
      message: 'Daily scan limit reached',
      userMessage: 'Daily scan limit reached. Try again tomorrow.',
    );
  }
}

/// Bank validation exception
class BankValidationException extends ScanException {
  const BankValidationException({
    required String message,
    String? details,
    bool canRetry = false,
    String? userMessage,
  }) : super(
          message: message,
          details: details,
          canRetry: canRetry,
          userMessage: userMessage,
        );

  factory BankValidationException.accountNotFound() {
    return const BankValidationException(
      message: 'Account not found',
      userMessage: 'Could not verify account. Please check the details.',
      canRetry: false,
    );
  }

  factory BankValidationException.bankNotSupported({required String bankName}) {
    return BankValidationException(
      message: 'Bank not supported: $bankName',
      userMessage: 'This bank is not currently supported.',
      canRetry: false,
    );
  }

  factory BankValidationException.validationFailed({String? reason}) {
    return BankValidationException(
      message: 'Bank validation failed${reason != null ? ': $reason' : ''}',
      userMessage: 'Could not validate account. Please verify the details.',
      canRetry: true,
    );
  }
}
