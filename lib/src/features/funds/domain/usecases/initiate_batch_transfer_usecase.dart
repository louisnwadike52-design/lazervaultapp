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

class GetBatchTransfersUseCase
    extends UseCaseWithParams<(List<BatchTransferHistoryEntity>, int), GetBatchTransfersParams> {
  final IBatchTransferRepository repository;

  GetBatchTransfersUseCase(this.repository);

  @override
  Future<Either<Failure, (List<BatchTransferHistoryEntity>, int)>> call(
      GetBatchTransfersParams params) async {
    return await repository.getBatchTransfers(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class GetBatchTransfersParams extends Equatable {
  final int page;
  final int pageSize;

  const GetBatchTransfersParams({required this.page, this.pageSize = 20});

  @override
  List<Object?> get props => [page, pageSize];
}

class GetBatchTransferDetailParams extends Equatable {
  final String batchId;

  const GetBatchTransferDetailParams({required this.batchId});

  @override
  List<Object?> get props => [batchId];
}

class GetBatchTransferDetailUseCase
    extends UseCaseWithParams<BatchTransferDetailEntity, GetBatchTransferDetailParams> {
  final IBatchTransferRepository repository;

  GetBatchTransferDetailUseCase(this.repository);

  @override
  Future<Either<Failure, BatchTransferDetailEntity>> call(GetBatchTransferDetailParams params) async {
    return await repository.getBatchTransferDetail(batchId: params.batchId);
  }
}
