import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/subscriptions/data/datasources/subscription_remote_datasource.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_spending_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/repositories/i_subscription_repository.dart';

class SubscriptionRepositoryImpl implements ISubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, (List<ActiveSubscriptionEntity>, int)>>
      getActiveSubscriptions({
    String? type,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final result = await remoteDataSource.getActiveSubscriptions(
        type: type,
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get active subscriptions',
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
  Future<Either<Failure, SubscriptionSummaryEntity>>
      getSubscriptionSummary() async {
    try {
      final result = await remoteDataSource.getSubscriptionSummary();
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get subscription summary',
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
  Future<Either<Failure, SubscriptionSpendingEntity>>
      getSubscriptionSpending({
    int months = 6,
  }) async {
    try {
      final result =
          await remoteDataSource.getSubscriptionSpending(months: months);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get subscription spending',
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
