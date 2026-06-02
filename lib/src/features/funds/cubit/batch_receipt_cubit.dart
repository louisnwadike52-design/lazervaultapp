import 'package:bloc/bloc.dart';

import 'package:lazervault/src/features/funds/cubit/batch_receipt_state.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_saved_batch_repository.dart';

class BatchReceiptCubit extends Cubit<BatchReceiptState> {
  final ISavedBatchRepository repository;

  BatchReceiptCubit({required this.repository})
      : super(const BatchReceiptInitial());

  Future<void> loadCollectiveReceipt(String batchId) async {
    if (isClosed) return;
    emit(const BatchReceiptLoading());
    final res = await repository.getBatchReceipt(batchId);
    if (isClosed) return;
    res.fold(
      (f) => emit(BatchReceiptError(message: f.message)),
      (r) => emit(BatchReceiptLoaded(receipt: r)),
    );
  }

  Future<void> loadItemReceipt(String itemId) async {
    if (isClosed) return;
    emit(const BatchReceiptLoading());
    final res = await repository.getBatchItemReceipt(itemId);
    if (isClosed) return;
    res.fold(
      (f) => emit(BatchReceiptError(message: f.message)),
      (r) => emit(BatchItemReceiptLoaded(receipt: r)),
    );
  }
}
