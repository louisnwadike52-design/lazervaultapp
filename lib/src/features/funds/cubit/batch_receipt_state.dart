import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';

sealed class BatchReceiptState extends Equatable {
  const BatchReceiptState();

  @override
  List<Object?> get props => [];
}

final class BatchReceiptInitial extends BatchReceiptState {
  const BatchReceiptInitial();
}

final class BatchReceiptLoading extends BatchReceiptState {
  const BatchReceiptLoading();
}

final class BatchReceiptLoaded extends BatchReceiptState {
  final BatchReceiptEntity receipt;
  const BatchReceiptLoaded({required this.receipt});

  @override
  List<Object?> get props => [receipt];
}

final class BatchItemReceiptLoaded extends BatchReceiptState {
  final BatchItemReceiptEntity receipt;
  const BatchItemReceiptLoaded({required this.receipt});

  @override
  List<Object?> get props => [receipt];
}

final class BatchReceiptError extends BatchReceiptState {
  final String message;
  const BatchReceiptError({required this.message});

  @override
  List<Object?> get props => [message];
}
