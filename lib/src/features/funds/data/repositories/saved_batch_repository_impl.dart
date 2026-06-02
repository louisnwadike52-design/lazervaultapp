import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/src/features/funds/data/datasources/saved_batch_remote_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_saved_batch_repository.dart';

class SavedBatchRepositoryImpl implements ISavedBatchRepository {
  final ISavedBatchRemoteDataSource remoteDataSource;

  SavedBatchRepositoryImpl({required this.remoteDataSource});

  Failure _toFailure(Object e) {
    if (e is ServerException) {
      return ServerFailure(
          message: e.message ?? 'Server error', statusCode: 500);
    }
    if (e is GrpcError) {
      return ServerFailure(
          message: 'gRPC error: ${e.message ?? e.codeName}',
          statusCode: e.code);
    }
    return ServerFailure(
        message: 'Unexpected error: ${e.toString()}', statusCode: 500);
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> saveBatchDraft({
    required String name,
    required String currency,
    required String sourceAccountId,
    required List<SavedBatchItemInputEntity> items,
  }) async {
    try {
      final res = await remoteDataSource.saveBatchDraft(
        name: name,
        currency: currency,
        sourceAccountId: sourceAccountId,
        items: items,
      );
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, (List<SavedBatchEntity>, int)>> listSavedBatches({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final res =
          await remoteDataSource.listSavedBatches(limit: limit, offset: offset);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> getSavedBatch(String id) async {
    try {
      final res = await remoteDataSource.getSavedBatch(id);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> updateSavedBatch(
      {required String id, required String name}) async {
    try {
      final res =
          await remoteDataSource.updateSavedBatch(id: id, name: name);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSavedBatch(String id) async {
    try {
      final res = await remoteDataSource.deleteSavedBatch(id);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> addItem({
    required String savedBatchId,
    required SavedBatchItemInputEntity item,
  }) async {
    try {
      final res = await remoteDataSource.addItem(
          savedBatchId: savedBatchId, item: item);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> removeItem({
    required String savedBatchId,
    required String itemId,
  }) async {
    try {
      final res = await remoteDataSource.removeItem(
          savedBatchId: savedBatchId, itemId: itemId);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> updateItemAmount({
    required String savedBatchId,
    required String itemId,
    required double amount,
  }) async {
    try {
      final res = await remoteDataSource.updateItemAmount(
        savedBatchId: savedBatchId,
        itemId: itemId,
        amount: amount,
      );
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, SavedBatchEntity>> applyCollectiveAmount({
    required String savedBatchId,
    double? multiplier,
    double? amountPerItem,
  }) async {
    try {
      final res = await remoteDataSource.applyCollectiveAmount(
        savedBatchId: savedBatchId,
        multiplier: multiplier,
        amountPerItem: amountPerItem,
      );
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, BatchTransferEntity>> executeFromSavedBatch({
    required String savedBatchId,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    Map<String, double> perItemOverrides = const {},
    String? sourceAccountId,
  }) async {
    try {
      final res = await remoteDataSource.executeFromSavedBatch(
        savedBatchId: savedBatchId,
        idempotencyKey: idempotencyKey,
        transactionId: transactionId,
        verificationToken: verificationToken,
        perItemOverrides: perItemOverrides,
        sourceAccountId: sourceAccountId,
      );
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, BatchReceiptEntity>> getBatchReceipt(
      String batchId) async {
    try {
      final res = await remoteDataSource.getBatchReceipt(batchId);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, BatchItemReceiptEntity>> getBatchItemReceipt(
      String itemId) async {
    try {
      final res = await remoteDataSource.getBatchItemReceipt(itemId);
      return Right(res);
    } catch (e) {
      return Left(_toFailure(e));
    }
  }
}
