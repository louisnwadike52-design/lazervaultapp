import 'package:dartz/dartz.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';

/// Repository contract for the saved-batches surface added in
/// core-payments commit e83680f. Every mutation returns the freshly
/// loaded SavedBatchEntity so the UI can render the new state without
/// a follow-up read.
abstract class ISavedBatchRepository {
  Future<Either<Failure, SavedBatchEntity>> saveBatchDraft({
    required String name,
    required String currency,
    required String sourceAccountId,
    required List<SavedBatchItemInputEntity> items,
  });

  Future<Either<Failure, (List<SavedBatchEntity>, int)>> listSavedBatches({
    int limit = 20,
    int offset = 0,
  });

  Future<Either<Failure, SavedBatchEntity>> getSavedBatch(String id);

  Future<Either<Failure, SavedBatchEntity>> updateSavedBatch({
    required String id,
    required String name,
  });

  Future<Either<Failure, bool>> deleteSavedBatch(String id);

  Future<Either<Failure, SavedBatchEntity>> addItem({
    required String savedBatchId,
    required SavedBatchItemInputEntity item,
  });

  Future<Either<Failure, SavedBatchEntity>> removeItem({
    required String savedBatchId,
    required String itemId,
  });

  Future<Either<Failure, SavedBatchEntity>> updateItemAmount({
    required String savedBatchId,
    required String itemId,
    required double amount,
  });

  /// Pass [multiplier] OR [amountPerItem] (exactly one). The server
  /// enforces oneof; the impl mirrors that.
  Future<Either<Failure, SavedBatchEntity>> applyCollectiveAmount({
    required String savedBatchId,
    double? multiplier,
    double? amountPerItem,
  });

  /// Returns the same `BatchTransferEntity` shape the immediate-flow
  /// produces so the receipt screen can be reused.
  Future<Either<Failure, BatchTransferEntity>> executeFromSavedBatch({
    required String savedBatchId,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    Map<String, double> perItemOverrides = const {},
    String? sourceAccountId,
  });

  Future<Either<Failure, BatchReceiptEntity>> getBatchReceipt(String batchId);

  Future<Either<Failure, BatchItemReceiptEntity>> getBatchItemReceipt(
      String itemId);
}
