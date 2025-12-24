import 'package:equatable/equatable.dart';
import 'package:lazervault/core/typedefs.dart';
import 'package:lazervault/core/usecase/usecase.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_batch_transfer_repository.dart';

class GetBatchTransferHistoryParams extends Equatable {
  final String accessToken;
  final int limit;
  final int offset;

  const GetBatchTransferHistoryParams({
    required this.accessToken,
    this.limit = 20,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [accessToken, limit, offset];
}

class GetBatchTransferHistoryUseCase 
    extends UseCaseWithParams<List<BatchTransferEntity>, GetBatchTransferHistoryParams> {
  final IBatchTransferRepository repository;

  GetBatchTransferHistoryUseCase({required this.repository});

  @override
  ResultFuture<List<BatchTransferEntity>> call(
    GetBatchTransferHistoryParams params,
  ) async {
    return await repository.getBatchTransferHistory(
      accessToken: params.accessToken,
      limit: params.limit,
      offset: params.offset,
    );
  }
} 