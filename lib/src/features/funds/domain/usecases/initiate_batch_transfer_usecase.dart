import 'package:fixnum/fixnum.dart';
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
      accessToken: params.accessToken,
      category: params.category,
      reference: params.reference,
      scheduledAt: params.scheduledAt,
    );
  }
}

class InitiateBatchTransferParams extends Equatable {
  final Int64 fromAccountId;
  final List<BatchTransferRecipient> recipients;
  final String accessToken;
  final String? category;
  final String? reference;
  final DateTime? scheduledAt;

  const InitiateBatchTransferParams({
    required this.fromAccountId,
    required this.recipients,
    required this.accessToken,
    this.category,
    this.reference,
    this.scheduledAt,
  });

  @override
  List<Object?> get props => [
        fromAccountId,
        recipients,
        accessToken,
        category,
        reference,
        scheduledAt,
      ];
}

class GetBatchTransferStatusUseCase
    extends UseCaseWithParams<BatchTransferEntity, GetBatchTransferStatusParams> {
  final IBatchTransferRepository repository;

  GetBatchTransferStatusUseCase(this.repository);

  @override
  Future<Either<Failure, BatchTransferEntity>> call(
      GetBatchTransferStatusParams params) async {
    return await repository.getBatchTransferStatus(
      batchId: params.batchId,
      accessToken: params.accessToken,
    );
  }
}

class GetBatchTransferStatusParams extends Equatable {
  final Int64 batchId;
  final String accessToken;

  const GetBatchTransferStatusParams({
    required this.batchId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [batchId, accessToken];
} 