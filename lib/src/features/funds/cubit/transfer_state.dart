import 'package:equatable/equatable.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

sealed class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object?> get props => [];
}

final class TransferInitial extends TransferState {
  const TransferInitial();
}

final class TransferLoading extends TransferState {
  const TransferLoading();
}

final class TransferSuccess extends TransferState {
  final TransferEntity response;

  const TransferSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class TransferFailure extends TransferState {
  final String message;
  final bool isRetryable;
  final bool isKYCError;

  const TransferFailure({required this.message, this.isRetryable = false, this.isKYCError = false});

  @override
  List<Object?> get props => [message, isRetryable, isKYCError];
}

/// Emitted when a transfer fails specifically due to an incorrect PIN.
final class TransferPinFailure extends TransferState {
  final PinFailureInfo pinInfo;

  const TransferPinFailure({required this.pinInfo});

  @override
  List<Object?> get props => [pinInfo.isLocked, pinInfo.attemptsRemaining, pinInfo.message];
}

// Fee lookup states
final class TransferFeeLoading extends TransferState {
  const TransferFeeLoading();
}

final class TransferFeeLoaded extends TransferState {
  final int fee; // Minor units (kobo)
  final String currency;
  final String feeType; // "flat" or "percentage"
  final int totalAmount; // Minor units
  final List<FeeBreakdownItem> breakdown;

  const TransferFeeLoaded({
    required this.fee,
    required this.currency,
    required this.feeType,
    required this.totalAmount,
    required this.breakdown,
  });

  @override
  List<Object?> get props => [fee, currency, feeType, totalAmount, breakdown];
}

final class TransferFeeError extends TransferState {
  final String message;

  const TransferFeeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FeeBreakdownItem extends Equatable {
  final String label;
  final int amount; // Minor units

  const FeeBreakdownItem({required this.label, required this.amount});

  @override
  List<Object?> get props => [label, amount];
}