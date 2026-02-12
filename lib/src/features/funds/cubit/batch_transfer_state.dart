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
