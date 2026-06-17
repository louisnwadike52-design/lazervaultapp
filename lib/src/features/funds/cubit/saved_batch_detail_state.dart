import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';

sealed class SavedBatchDetailState extends Equatable {
  const SavedBatchDetailState();

  @override
  List<Object?> get props => [];
}

final class SavedBatchDetailInitial extends SavedBatchDetailState {
  const SavedBatchDetailInitial();
}

final class SavedBatchDetailLoading extends SavedBatchDetailState {
  const SavedBatchDetailLoading();
}

final class SavedBatchDetailLoaded extends SavedBatchDetailState {
  final SavedBatchEntity batch;

  /// When a mutation is in flight we keep the loaded state but flip this
  /// flag so the UI can disable buttons and show a spinner.
  final bool mutating;

  /// Set after a successful execution so the caller can route into the
  /// receipt flow. Null on regular load.
  final BatchTransferEntity? executedBatch;

  /// One-shot mutation error message — the view should surface this via
  /// a snackbar then call [SavedBatchDetailCubit.clearMutationError] so
  /// the cubit clears the field. Keeping the message on the loaded state
  /// avoids flashing a full-screen error widget for a transient blip.
  final String? mutationError;

  const SavedBatchDetailLoaded({
    required this.batch,
    this.mutating = false,
    this.executedBatch,
    this.mutationError,
  });

  SavedBatchDetailLoaded copyWith({
    SavedBatchEntity? batch,
    bool? mutating,
    BatchTransferEntity? executedBatch,
    bool clearExecuted = false,
    String? mutationError,
    bool clearMutationError = false,
  }) {
    return SavedBatchDetailLoaded(
      batch: batch ?? this.batch,
      mutating: mutating ?? this.mutating,
      executedBatch: clearExecuted ? null : (executedBatch ?? this.executedBatch),
      mutationError:
          clearMutationError ? null : (mutationError ?? this.mutationError),
    );
  }

  @override
  List<Object?> get props => [batch, mutating, executedBatch, mutationError];
}

final class SavedBatchDetailError extends SavedBatchDetailState {
  final String message;
  const SavedBatchDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Emitted when the saved batch is deleted from the detail screen so the
/// view can pop back to the list with a success snackbar.
final class SavedBatchDeletedFromDetail extends SavedBatchDetailState {
  final String id;
  const SavedBatchDeletedFromDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
