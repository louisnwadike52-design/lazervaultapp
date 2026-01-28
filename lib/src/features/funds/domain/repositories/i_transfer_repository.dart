import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

abstract class ITransferRepository {
  Future<Either<Failure, TransferEntity>> initiateTransfer({
    required String fromAccountId,
    required Int64 amount,
    required String accessToken,
    Int64? toAccountId,
    Int64? recipientId,
    String? category,
    String? reference,
    DateTime? scheduledAt,
    String? transactionId,
    String? verificationToken,
  });
}
