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

  @override
  Future<Either<Failure, List<DataPurchaseEntity>>> getPurchaseHistory({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final rows =
          await remoteDataSource.getHistory(limit: limit, offset: offset);
      return Right(rows);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to load purchase history',
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
  Future<Either<Failure, void>> enableAutoRenew({
    required String subscriptionId,
    required String variationId,
    required String network,
    required double amount,
  }) async {
    try {
      await remoteDataSource.enableAutoRenew(
        subscriptionId: subscriptionId,
        variationId: variationId,
        network: network,
        amount: amount,
      );
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to enable auto-renewal',
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
  Future<Either<Failure, void>> disableAutoRenew({
    required String subscriptionId,
  }) async {
    try {
      await remoteDataSource.disableAutoRenew(subscriptionId: subscriptionId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to disable auto-renewal',
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
  Future<Either<Failure, List<Map<String, dynamic>>>> getAutoRenewSubscriptions({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await remoteDataSource.getAutoRenewSubscriptions(
        limit: limit,
        offset: offset,
      );
      final subs = response.subscriptions.map((s) => {
        'id': s.id,
        'planName': s.planName,
        'amount': s.amount,
        'currency': s.currency,
        'network': s.autoRenewNetwork,
        'variationId': s.autoRenewVariationId,
        'phoneNumber': s.customerNumber,
        'status': s.status,
        'autoRenewEnabled': s.autoRenewEnabled,
        'nextRenewalAt': s.nextRenewalAt,
        'renewalAttempts': s.renewalAttempts,
        'daysRemaining': s.daysRemaining,
        'progressPercentage': s.progressPercentage,
        'autoRenewAmount': s.autoRenewAmount,
        'disabledReason': s.autoRenewDisabledReason,
      }).toList();
      return Right(subs);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get auto-renew subscriptions',
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
