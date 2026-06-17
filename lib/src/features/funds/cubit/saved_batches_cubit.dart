import 'package:bloc/bloc.dart';

import 'package:lazervault/src/features/funds/cubit/saved_batches_state.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_saved_batch_repository.dart';

/// Cubit for the saved-batches LIST surface (mirrors the
/// recipients/beneficiaries list pattern). The detail / mutation surface
/// lives on [SavedBatchDetailCubit] so a list refresh does not collide
/// with an in-progress mutation.
class SavedBatchesCubit extends Cubit<SavedBatchesState> {
  final ISavedBatchRepository repository;

  SavedBatchesCubit({required this.repository})
      : super(const SavedBatchesInitial());

  Future<void> load({int limit = 50, int offset = 0}) async {
    if (isClosed) return;
    emit(const SavedBatchesLoading());
    final result =
        await repository.listSavedBatches(limit: limit, offset: offset);
    if (isClosed) return;
    result.fold(
      (failure) => emit(SavedBatchesError(message: failure.message)),
      (data) => emit(SavedBatchesLoaded(batches: data.$1, total: data.$2)),
    );
  }

  /// Pull-to-refresh wrapper that DOES NOT flash the loading state, so the
  /// list stays visible while we refresh in the background. Best-effort:
  /// on error we keep the previous loaded list and only surface the error
  /// via the snackbar layer.
  Future<void> refresh() async {
    if (isClosed) return;
    final previous = state;
    final result =
        await repository.listSavedBatches(limit: 50, offset: 0);
    if (isClosed) return;
    result.fold(
      (failure) {
        if (previous is SavedBatchesLoaded) {
          // Keep showing the previous list; downstream listeners can
          // observe the transient error via the returned future.
          return;
        }
        emit(SavedBatchesError(message: failure.message));
      },
      (data) => emit(SavedBatchesLoaded(batches: data.$1, total: data.$2)),
    );
  }

  Future<bool> delete(String id) async {
    if (isClosed) return false;
    final result = await repository.deleteSavedBatch(id);
    if (isClosed) return false;
    return result.fold(
      (failure) {
        emit(SavedBatchesError(message: failure.message));
        return false;
      },
      (success) {
        // Optimistically remove from the cached list.
        final current = state;
        if (current is SavedBatchesLoaded) {
          final next = current.batches.where((b) => b.id != id).toList();
          emit(SavedBatchesLoaded(batches: next, total: current.total - 1));
        }
        return success;
      },
    );
  }
}
