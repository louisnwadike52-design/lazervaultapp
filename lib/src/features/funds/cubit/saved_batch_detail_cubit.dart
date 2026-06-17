import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batch_detail_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_saved_batch_repository.dart';

/// Cubit that owns a single saved batch — loads it once, then mutates in
/// place. Every backend mutation returns the freshly loaded
/// [SavedBatchEntity] so we re-emit `SavedBatchDetailLoaded` with the
/// new value. Execution lands as [SavedBatchDetailLoaded.executedBatch]
/// so the view can route to the receipt screen.
class SavedBatchDetailCubit extends Cubit<SavedBatchDetailState> {
  final ISavedBatchRepository repository;

  SavedBatchDetailCubit({required this.repository})
      : super(const SavedBatchDetailInitial());

  Future<void> load(String id) async {
    if (isClosed) return;
    emit(const SavedBatchDetailLoading());
    final res = await repository.getSavedBatch(id);
    if (isClosed) return;
    res.fold(
      (f) => emit(SavedBatchDetailError(message: f.message)),
      (b) => emit(SavedBatchDetailLoaded(batch: b)),
    );
  }

  Future<void> refresh() async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    final res = await repository.getSavedBatch(current.batch.id);
    if (isClosed) return;
    res.fold(
      (_) {/* keep current loaded state */},
      (b) => emit(current.copyWith(batch: b, mutating: false)),
    );
  }

  /// Helper that wraps a SavedBatchEntity-returning mutation: marks
  /// mutating=true, awaits the call, commits the new batch on success
  /// or surfaces a one-shot mutationError on the still-loaded state.
  Future<void> _runBatchMutation(
    Future<Either<Failure, SavedBatchEntity>> Function() body,
  ) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    emit(current.copyWith(mutating: true, clearMutationError: true));
    final res = await body();
    if (isClosed) return;
    res.fold(
      (f) => emit(current.copyWith(
          mutating: false, mutationError: f.message)),
      (newBatch) =>
          emit(current.copyWith(batch: newBatch, mutating: false)),
    );
  }

  Future<void> rename(String name) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    await _runBatchMutation(() => repository.updateSavedBatch(
          id: current.batch.id,
          name: name,
        ));
  }

  Future<void> deleteBatch() async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    emit(current.copyWith(mutating: true, clearMutationError: true));
    final res = await repository.deleteSavedBatch(current.batch.id);
    if (isClosed) return;
    res.fold(
      (f) => emit(current.copyWith(
          mutating: false, mutationError: f.message)),
      (_) => emit(SavedBatchDeletedFromDetail(id: current.batch.id)),
    );
  }

  Future<void> addItem(SavedBatchItemInputEntity item) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    await _runBatchMutation(() => repository.addItem(
          savedBatchId: current.batch.id,
          item: item,
        ));
  }

  Future<void> removeItem(String itemId) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    await _runBatchMutation(() => repository.removeItem(
          savedBatchId: current.batch.id,
          itemId: itemId,
        ));
  }

  Future<void> updateItemAmount(String itemId, double amount) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    await _runBatchMutation(() => repository.updateItemAmount(
          savedBatchId: current.batch.id,
          itemId: itemId,
          amount: amount,
        ));
  }

  Future<void> applyCollective({double? multiplier, double? amountPerItem}) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    await _runBatchMutation(() => repository.applyCollectiveAmount(
          savedBatchId: current.batch.id,
          multiplier: multiplier,
          amountPerItem: amountPerItem,
        ));
  }

  Future<void> execute({
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    Map<String, double> perItemOverrides = const {},
    String? sourceAccountId,
  }) async {
    final current = state;
    if (current is! SavedBatchDetailLoaded) return;
    emit(current.copyWith(mutating: true, clearMutationError: true));
    final res = await repository.executeFromSavedBatch(
      savedBatchId: current.batch.id,
      idempotencyKey: idempotencyKey,
      transactionId: transactionId,
      verificationToken: verificationToken,
      perItemOverrides: perItemOverrides,
      sourceAccountId: sourceAccountId,
    );
    if (isClosed) return;
    res.fold(
      (f) => emit(current.copyWith(
          mutating: false, mutationError: f.message)),
      (batchTransfer) => emit(current.copyWith(
          mutating: false, executedBatch: batchTransfer)),
    );
  }

  /// After the view has consumed the executed-batch payload it should
  /// call this so we don't re-route on a subsequent rebuild.
  void clearExecuted() {
    final current = state;
    if (current is SavedBatchDetailLoaded && current.executedBatch != null) {
      emit(current.copyWith(clearExecuted: true));
    }
  }

  /// After the view has shown the snackbar for a mutation error it should
  /// call this so the next BlocConsumer.listener tick doesn't re-fire.
  void clearMutationError() {
    final current = state;
    if (current is SavedBatchDetailLoaded && current.mutationError != null) {
      emit(current.copyWith(clearMutationError: true));
    }
  }
}
