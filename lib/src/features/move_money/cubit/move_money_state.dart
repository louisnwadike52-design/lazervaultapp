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

/// Error state
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
