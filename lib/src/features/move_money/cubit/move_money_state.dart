import 'package:equatable/equatable.dart';
import '../domain/entities/move_transfer.dart';
import '../domain/entities/move_fee_calculation.dart';

/// Base state for move money feature
abstract class MoveMoneyState extends Equatable {
  const MoveMoneyState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class MoveMoneyInitial extends MoveMoneyState {}

/// Loading state
class MoveMoneyLoading extends MoveMoneyState {}

/// Fee calculation result
class MoveMoneyFeeCalculated extends MoveMoneyState {
  final MoveFeeCalculation feeCalculation;

  const MoveMoneyFeeCalculated({required this.feeCalculation});

  @override
  List<Object?> get props => [feeCalculation];
}

/// Transfer initiated successfully
class MoveTransferInitiated extends MoveMoneyState {
  final MoveTransfer transfer;
  final String message;
  final bool requiresAuthorization;
  final String? paymentUrl;

  const MoveTransferInitiated({
    required this.transfer,
    required this.message,
    this.requiresAuthorization = false,
    this.paymentUrl,
  });

  @override
  List<Object?> get props => [transfer, message, requiresAuthorization];
}

/// Transfer status loaded
class MoveTransferStatusLoaded extends MoveMoneyState {
  final MoveTransfer transfer;

  const MoveTransferStatusLoaded({required this.transfer});

  @override
  List<Object?> get props => [transfer];
}

/// Transfer history loaded
class MoveTransfersLoaded extends MoveMoneyState {
  final List<MoveTransfer> transfers;
  final int total;

  const MoveTransfersLoaded({
    required this.transfers,
    required this.total,
  });

  @override
  List<Object?> get props => [transfers, total];
}

/// Generic error state
class MoveMoneyError extends MoveMoneyState {
  final String message;
  final String? errorCode;

  const MoveMoneyError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

/// Insufficient funds in source account
class MoveMoneyInsufficientFunds extends MoveMoneyState {
  final String message;
  final double availableBalance;
  final double requiredAmount;

  const MoveMoneyInsufficientFunds({
    required this.message,
    required this.availableBalance,
    required this.requiredAmount,
  });

  @override
  List<Object?> get props => [message, availableBalance, requiredAmount];
}

/// Source account needs reauthorization (re-link)
class MoveMoneyNeedsReauth extends MoveMoneyState {
  final String accountId;
  final String message;

  const MoveMoneyNeedsReauth({
    required this.accountId,
    this.message = 'Source account requires re-authorization. Please re-link the account.',
  });

  @override
  List<Object?> get props => [accountId, message];
}

/// Mandate required or expired for source account
class MoveMoneyMandateRequired extends MoveMoneyState {
  final String accountId;
  final String message;

  const MoveMoneyMandateRequired({
    required this.accountId,
    this.message = 'Auto-debit authorization is required for this account.',
  });

  @override
  List<Object?> get props => [accountId, message];
}

/// Rate limited — retry after delay
class MoveMoneyRateLimited extends MoveMoneyState {
  final Duration retryAfter;
  final String message;

  const MoveMoneyRateLimited({
    required this.retryAfter,
    this.message = 'Too many requests. Please wait before trying again.',
  });

  @override
  List<Object?> get props => [retryAfter, message];
}

/// Transfer polling timed out — transfer may still be processing
class MoveMoneyTransferTimeout extends MoveMoneyState {
  final String transferId;
  final String reference;
  final String message;

  const MoveMoneyTransferTimeout({
    required this.transferId,
    required this.reference,
    this.message = 'Transfer is still processing. Check your transfer history for updates.',
  });

  @override
  List<Object?> get props => [transferId, reference, message];
}

/// Fee calculation failed with retry option
class MoveMoneyFeeError extends MoveMoneyState {
  final String message;
  final int lastAmount;
  final int retryCount;

  const MoveMoneyFeeError({
    required this.message,
    required this.lastAmount,
    this.retryCount = 0,
  });

  @override
  List<Object?> get props => [message, lastAmount, retryCount];
}
