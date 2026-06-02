import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';

sealed class SavedBatchesState extends Equatable {
  const SavedBatchesState();

  @override
  List<Object?> get props => [];
}

final class SavedBatchesInitial extends SavedBatchesState {
  const SavedBatchesInitial();
}

final class SavedBatchesLoading extends SavedBatchesState {
  const SavedBatchesLoading();
}

final class SavedBatchesLoaded extends SavedBatchesState {
  final List<SavedBatchEntity> batches;
  final int total;
  const SavedBatchesLoaded({required this.batches, required this.total});

  @override
  List<Object?> get props => [batches, total];
}

final class SavedBatchesError extends SavedBatchesState {
  final String message;
  const SavedBatchesError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class SavedBatchDeleted extends SavedBatchesState {
  final String id;
  const SavedBatchDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}
