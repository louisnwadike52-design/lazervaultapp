import 'package:dartz/dartz.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

abstract class IBatchTransferRepository {
  Future<Either<Failure, BatchTransferEntity>> initiateBatchTransfer({
    required String fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  });
}
