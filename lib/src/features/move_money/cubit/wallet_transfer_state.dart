import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';

sealed class WalletTransferState extends Equatable {
  const WalletTransferState();

  @override
  List<Object?> get props => [];
}

class WalletTransferInitial extends WalletTransferState {}

class WalletTransferLoading extends WalletTransferState {}

class WalletTransferSuccess extends WalletTransferState {
  final String? transferId;
  final String? reference;
  final String sourceAccountName;
  final String destinationAccountName;
  final double amount;
  final String currency;
  final double? newBalance;

  const WalletTransferSuccess({
    this.transferId,
    this.reference,
    required this.sourceAccountName,
    required this.destinationAccountName,
    required this.amount,
    required this.currency,
    this.newBalance,
  });

  @override
  List<Object?> get props => [
        transferId,
        reference,
        sourceAccountName,
        destinationAccountName,
        amount,
        currency,
        newBalance,
      ];
}

class WalletTransferError extends WalletTransferState {
  final String message;

  const WalletTransferError(this.message);

  @override
  List<Object?> get props => [message];
}

class WalletTransferHistoryLoading extends WalletTransferState {}

class WalletTransferHistoryLoaded extends WalletTransferState {
  final List<PaymentsTransferResult> transfers;
  final int total;

  const WalletTransferHistoryLoaded({
    required this.transfers,
    required this.total,
  });

  @override
  List<Object?> get props => [transfers, total];
}

class WalletTransferHistoryError extends WalletTransferState {
  final String message;

  const WalletTransferHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
