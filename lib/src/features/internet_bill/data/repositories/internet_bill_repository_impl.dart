import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../domain/entities/internet_payment_entity.dart';
import '../../domain/repositories/internet_bill_repository.dart';
import '../datasources/internet_bill_remote_datasource.dart';

class InternetBillRepositoryImpl implements InternetBillRepository {
  final InternetBillRemoteDataSource remoteDataSource;

  InternetBillRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<InternetProviderEntity>>> getProviders({bool activeOnly = true}) async {
    try {
      final result = await remoteDataSource.getProviders(activeOnly: activeOnly);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get internet providers', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, InternetAccountValidationEntity>> validateAccount({
    required String providerId,
    required String accountNumber,
  }) async {
    try {
      final result = await remoteDataSource.validateAccount(
        providerId: providerId,
        accountNumber: accountNumber,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to validate internet account', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<InternetPackageEntity>>> getPackages({required String providerId}) async {
    try {
      final result = await remoteDataSource.getPackages(providerId: providerId);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get internet packages', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, InternetPaymentEntity>> payBill({
    required String providerId,
    required String customerNumber,
    required String serviceType,
    required String packageId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      final result = await remoteDataSource.payBill(
        providerId: providerId,
        customerNumber: customerNumber,
        serviceType: serviceType,
        packageId: packageId,
        amount: amount,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to pay internet bill', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
