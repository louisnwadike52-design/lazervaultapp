import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';

sealed class RecurringTransferState extends Equatable {
  const RecurringTransferState();

  @override
  List<Object?> get props => [];
}

final class RecurringTransferInitial extends RecurringTransferState {
  const RecurringTransferInitial();
}

final class RecurringTransferLoading extends RecurringTransferState {
  const RecurringTransferLoading();
}

final class RecurringTransferListLoaded extends RecurringTransferState {
  final List<RecurringTransferEntity> transfers;
  final int total;

  const RecurringTransferListLoaded({
    required this.transfers,
    required this.total,
  });

  @override
  List<Object?> get props => [transfers, total];
}

final class RecurringTransferDetailLoaded extends RecurringTransferState {
  final RecurringTransferEntity transfer;

  const RecurringTransferDetailLoaded({required this.transfer});

  @override
  List<Object?> get props => [transfer];
}

final class RecurringTransferCreated extends RecurringTransferState {
  final RecurringTransferEntity transfer;
  final String message;

  const RecurringTransferCreated({
    required this.transfer,
    required this.message,
  });

  @override
  List<Object?> get props => [transfer, message];
}

final class RecurringTransferUpdated extends RecurringTransferState {
  final RecurringTransferEntity transfer;
  final String message;

  const RecurringTransferUpdated({
    required this.transfer,
    required this.message,
  });

  @override
  List<Object?> get props => [transfer, message];
}

final class RecurringTransferDeleted extends RecurringTransferState {
  final String message;

  const RecurringTransferDeleted({required this.message});

  @override
  List<Object?> get props => [message];
}

final class RecurringTransferExecutionsLoaded extends RecurringTransferState {
  final List<RecurringTransferExecutionEntity> executions;
  final int total;

  const RecurringTransferExecutionsLoaded({
    required this.executions,
    required this.total,
  });

  @override
  List<Object?> get props => [executions, total];
}

final class RecurringTransferError extends RecurringTransferState {
  final String message;

  const RecurringTransferError({required this.message});

  @override
  List<Object?> get props => [message];
}
