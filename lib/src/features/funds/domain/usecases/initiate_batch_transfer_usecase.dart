import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/usecase/usecase.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_batch_transfer_repository.dart';

class InitiateBatchTransferUseCase
    extends UseCaseWithParams<BatchTransferEntity, InitiateBatchTransferParams> {
  final IBatchTransferRepository repository;

  InitiateBatchTransferUseCase(this.repository);

  @override
  Future<Either<Failure, BatchTransferEntity>> call(
      InitiateBatchTransferParams params) async {
    return await repository.initiateBatchTransfer(
      fromAccountId: params.fromAccountId,
      recipients: params.recipients,
      transactionId: params.transactionId,
      verificationToken: params.verificationToken,
      scheduledAt: params.scheduledAt,
    );
  }
}

class InitiateBatchTransferParams extends Equatable {
  final String fromAccountId;
  final List<BatchTransferRecipient> recipients;
  final String transactionId;
  final String verificationToken;
  final DateTime? scheduledAt;

  const InitiateBatchTransferParams({
    required this.fromAccountId,
    required this.recipients,
    required this.transactionId,
    required this.verificationToken,
    this.scheduledAt,
  });

  @override
  List<Object?> get props => [
        fromAccountId,
        recipients,
        transactionId,
        verificationToken,
        scheduledAt,
      ];
}
