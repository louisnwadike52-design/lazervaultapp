import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

abstract class IBatchTransferRepository {
  Future<Either<Failure, BatchTransferEntity>> initiateBatchTransfer({
    required Int64 fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String accessToken,
    String? category,
    String? reference,
    DateTime? scheduledAt,
  });

  Future<Either<Failure, BatchTransferEntity>> getBatchTransferStatus({
    required Int64 batchId,
    required String accessToken,
  });

  Future<Either<Failure, List<BatchTransferEntity>>> getBatchTransferHistory({
    required String accessToken,
    int limit = 20,
    int offset = 0,
  });
} 