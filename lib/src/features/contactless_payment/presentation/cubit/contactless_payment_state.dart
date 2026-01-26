import 'package:equatable/equatable.dart';
import '../../domain/entities/contactless_payment_entity.dart';

abstract class ContactlessPaymentState extends Equatable {
  const ContactlessPaymentState();

  @override
  List<Object?> get props => [];
}

class ContactlessPaymentInitial extends ContactlessPaymentState {}

class ContactlessPaymentLoading extends ContactlessPaymentState {}

/// State when a payment session is created successfully (receiver mode)
class PaymentSessionCreated extends ContactlessPaymentState {
  final PaymentSessionEntity session;
  final String nfcPayload;
  final String message;

  const PaymentSessionCreated({
    required this.session,
    required this.nfcPayload,
    required this.message,
  });

  @override
  List<Object?> get props => [session, nfcPayload, message];
}

/// State when a payment session is loaded (payer mode - after NFC read)
class PaymentSessionLoaded extends ContactlessPaymentState {
  final PaymentSessionEntity session;

  const PaymentSessionLoaded(this.session);

  @override
  List<Object?> get props => [session];
}

/// State when session read is acknowledged
class SessionReadAcknowledged extends ContactlessPaymentState {
  final PaymentSessionEntity session;
  final String message;

  const SessionReadAcknowledged({
    required this.session,
    required this.message,
  });

  @override
  List<Object?> get props => [session, message];
}

/// State when payment is processed successfully
class PaymentProcessed extends ContactlessPaymentState {
  final ContactlessTransactionEntity transaction;
  final double newBalance;
  final String message;

  const PaymentProcessed({
    required this.transaction,
    required this.newBalance,
    required this.message,
  });

  @override
  List<Object?> get props => [transaction, newBalance, message];
}

/// State when session is cancelled
class SessionCancelled extends ContactlessPaymentState {
  final String message;

  const SessionCancelled(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when sessions list is loaded
class PaymentSessionsLoaded extends ContactlessPaymentState {
  final List<PaymentSessionEntity> sessions;
  final int total;

  const PaymentSessionsLoaded({
    required this.sessions,
    required this.total,
  });

  @override
  List<Object?> get props => [sessions, total];
}

/// State when transactions list is loaded
class ContactlessPaymentsLoaded extends ContactlessPaymentState {
  final List<ContactlessTransactionEntity> transactions;
  final int total;

  const ContactlessPaymentsLoaded({
    required this.transactions,
    required this.total,
  });

  @override
  List<Object?> get props => [transactions, total];
}

/// State when session status is checked (polling)
class SessionStatusChecked extends ContactlessPaymentState {
  final String status;
  final String? payerName;
  final DateTime updatedAt;

  const SessionStatusChecked({
    required this.status,
    this.payerName,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [status, payerName, updatedAt];
}

/// Error state
class ContactlessPaymentError extends ContactlessPaymentState {
  final String message;
  final ContactlessErrorType errorType;
  final bool retryable;

  const ContactlessPaymentError(
    this.message, {
    this.errorType = ContactlessErrorType.unknown,
    this.retryable = false,
  });

  @override
  List<Object?> get props => [message, errorType, retryable];
}

/// Error type enum for better error categorization
enum ContactlessErrorType {
  nfcNotAvailable,
  nfcDisabled,
  networkError,
  timeout,
  serverError,
  insufficientBalance,
  sessionExpired,
  sessionNotFound,
  pinValidationFailed,
  accountLocked,
  unknown,
}

/// State when NFC is not available on the device
class NfcNotAvailable extends ContactlessPaymentState {
  final String message;
  final bool canOpenSettings;

  const NfcNotAvailable({
    required this.message,
    this.canOpenSettings = false,
  });

  @override
  List<Object?> get props => [message, canOpenSettings];
}

/// State when NFC is disabled but available
class NfcDisabled extends ContactlessPaymentState {
  final String message;

  const NfcDisabled({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// State when there's a network error
class NetworkError extends ContactlessPaymentState {
  final String message;
  final bool retryable;
  final int? retryCount;

  const NetworkError({
    required this.message,
    this.retryable = true,
    this.retryCount,
  });

  @override
  List<Object?> get props => [message, retryable, retryCount];
}

/// State when the session has expired
class SessionExpired extends ContactlessPaymentState {
  final String sessionId;
  final String message;

  const SessionExpired({
    required this.sessionId,
    required this.message,
  });

  @override
  List<Object?> get props => [sessionId, message];
}

/// State when there's insufficient balance
class InsufficientBalance extends ContactlessPaymentState {
  final String accountId;
  final double required;
  final double available;
  final String currency;

  const InsufficientBalance({
    required this.accountId,
    required this.required,
    required this.available,
    required this.currency,
  });

  @override
  List<Object?> get props => [accountId, required, available, currency];
}

/// State when PIN validation fails
class PinValidationFailed extends ContactlessPaymentState {
  final String message;
  final int attemptsRemaining;
  final bool accountLocked;

  const PinValidationFailed({
    required this.message,
    this.attemptsRemaining = 3,
    this.accountLocked = false,
  });

  @override
  List<Object?> get props => [message, attemptsRemaining, accountLocked];
}
