import 'package:fixnum/fixnum.dart';
// Remove google_protobuf import
// import 'package:google_protobuf/google_protobuf.dart';
import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';

// Ensure correct import path for ServerException
import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/data/datasources/transfer_remote_data_source.dart';
import 'package:lazervault/src/features/funds/data/models/transfer_model.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_transfer_repository.dart';
// Import the entity
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

class TransferRepositoryImpl implements ITransferRepository {
  final ITransferRemoteDataSource remoteDataSource;

  TransferRepositoryImpl({required this.remoteDataSource});

  @override
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
  }) async {
    try {
      final remoteResponse = await remoteDataSource.initiateTransfer(
        fromAccountId: fromAccountId,
        amount: amount,
        accessToken: accessToken,
        toAccountId: toAccountId,
        recipientId: recipientId,
        category: category,
        reference: reference,
        scheduledAt: scheduledAt,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );
      // Convert the raw gRPC response to our model
      final responseModel =
          InitiateTransferResponseModel.fromProto(remoteResponse);
      // Return the model (which is a TransferEntity) wrapped in Right
      return Right(responseModel);
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
