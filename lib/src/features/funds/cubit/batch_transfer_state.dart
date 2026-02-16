import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

sealed class BatchTransferState extends Equatable {
  const BatchTransferState();

  @override
  List<Object?> get props => [];
}

final class BatchTransferInitial extends BatchTransferState {
  const BatchTransferInitial();
}

final class BatchTransferLoading extends BatchTransferState {
  const BatchTransferLoading();
}

final class BatchTransferSuccess extends BatchTransferState {
  final BatchTransferEntity response;

  const BatchTransferSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class BatchTransferPartialSuccess extends BatchTransferState {
  final BatchTransferEntity response;

  const BatchTransferPartialSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class BatchTransferFailure extends BatchTransferState {
  final String message;

  const BatchTransferFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

final class BatchTransferNetworkError extends BatchTransferState {
  final String message;

  const BatchTransferNetworkError({required this.message});

  @override
  List<Object?> get props => [message];
}

// History states
final class BatchTransferHistoryLoading extends BatchTransferState {
  const BatchTransferHistoryLoading();
}

final class BatchTransferHistoryLoaded extends BatchTransferState {
  final List<BatchTransferHistoryEntity> batches;
  final int total;
  final int page;

  const BatchTransferHistoryLoaded({
    required this.batches,
    required this.total,
    required this.page,
  });

  @override
  List<Object?> get props => [batches, total, page];
}

final class BatchTransferHistoryError extends BatchTransferState {
  final String message;

  const BatchTransferHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Detail states
final class BatchTransferDetailLoading extends BatchTransferState {
  const BatchTransferDetailLoading();
}

final class BatchTransferDetailLoaded extends BatchTransferState {
  final BatchTransferDetailEntity detail;

  const BatchTransferDetailLoaded({required this.detail});

  @override
  List<Object?> get props => [detail];
}

final class BatchTransferDetailError extends BatchTransferState {
  final String message;

  const BatchTransferDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
