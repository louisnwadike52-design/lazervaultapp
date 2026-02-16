import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../../domain/repositories/data_bundles_repository.dart';
import '../datasources/data_bundles_remote_datasource.dart';

class DataBundlesRepositoryImpl implements DataBundlesRepository {
  final DataBundlesRemoteDataSource remoteDataSource;

  DataBundlesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DataPlanEntity>>> getDataPlans({
    required String network,
  }) async {
    try {
      final result = await remoteDataSource.getDataPlans(network: network);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get data plans',
        statusCode: e.codeName,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 'UNKNOWN',
      ));
    }
  }

  @override
  Future<Either<Failure, DataPurchaseEntity>> buyData({
    required String phoneNumber,
    required String network,
    required String variationId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      final result = await remoteDataSource.buyData(
        phoneNumber: phoneNumber,
        network: network,
        variationId: variationId,
        amount: amount,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to buy data',
        statusCode: e.codeName,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 'UNKNOWN',
      ));
    }
  }
}
