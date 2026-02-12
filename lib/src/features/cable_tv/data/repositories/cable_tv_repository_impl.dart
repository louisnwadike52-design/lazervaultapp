import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/smart_card_validation_entity.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import '../../domain/repositories/cable_tv_repository.dart';
import '../datasources/cable_tv_remote_datasource.dart';

class CableTVRepositoryImpl implements CableTVRepository {
  final CableTVRemoteDataSource remoteDataSource;

  CableTVRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CableTVProviderEntity>>> getProviders({bool activeOnly = true}) async {
    try {
      final result = await remoteDataSource.getProviders(activeOnly: activeOnly);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get cable TV providers', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, SmartCardValidationEntity>> validateSmartCard({
    required String providerId,
    required String smartCardNumber,
  }) async {
    try {
      final result = await remoteDataSource.validateSmartCard(
        providerId: providerId,
        smartCardNumber: smartCardNumber,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to validate smart card', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<TVPackageEntity>>> getPackages({required String providerId}) async {
    try {
      final result = await remoteDataSource.getPackages(providerId: providerId);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get TV packages', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, CableTVPaymentEntity>> paySubscription({
    required String providerId,
    required String smartCardNumber,
    required String variationCode,
    required double amount,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      final result = await remoteDataSource.paySubscription(
        providerId: providerId,
        smartCardNumber: smartCardNumber,
        variationCode: variationCode,
        amount: amount,
        phone: phone,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to pay cable TV subscription', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
