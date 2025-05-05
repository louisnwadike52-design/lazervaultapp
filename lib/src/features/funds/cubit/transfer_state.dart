import 'package:equatable/equatable.dart';
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

  const TransferFailure({required this.message});

  @override
  List<Object?> get props => [message];
} 