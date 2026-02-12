import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/data/datasources/batch_transfer_remote_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_batch_transfer_repository.dart';

class BatchTransferRepositoryImpl implements IBatchTransferRepository {
  final IBatchTransferRemoteDataSource remoteDataSource;

  BatchTransferRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BatchTransferEntity>> initiateBatchTransfer({
    required String fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  }) async {
    try {
      final response = await remoteDataSource.initiateBatchTransfer(
        fromAccountId: fromAccountId,
        recipients: recipients,
        transactionId: transactionId,
        verificationToken: verificationToken,
        scheduledAt: scheduledAt,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Server Error', statusCode: 500));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: 'gRPC Error: ${e.message ?? e.codeName}',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Unexpected Error: ${e.toString()}', statusCode: 500));
    }
  }
}
