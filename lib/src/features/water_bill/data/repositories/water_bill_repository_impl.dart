import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../../domain/entities/customer_validation_result.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../../domain/repositories/water_bill_repository.dart';
import '../datasources/water_bill_remote_datasource.dart';

class WaterBillRepositoryImpl implements WaterBillRepository {
  final WaterBillRemoteDataSource remoteDataSource;

  WaterBillRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WaterProviderEntity>>> getProviders({
    String? country,
  }) async {
    try {
      final providers = await remoteDataSource.getProviders(country: country);
      return Right(providers);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> syncProviders() async {
    try {
      await remoteDataSource.syncProviders();
      return const Right(null);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, CustomerValidationResult>> validateCustomer({
    required String providerCode,
    required String customerNumber,
  }) async {
    try {
      final result = await remoteDataSource.validateCustomer(
        providerCode: providerCode,
        customerNumber: customerNumber,
      );
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, WaterPaymentEntity>> initiatePayment({
    required String providerCode,
    required String customerNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  }) async {
    try {
      final payment = await remoteDataSource.initiatePayment(
        providerCode: providerCode,
        customerNumber: customerNumber,
        amount: amount,
        currency: currency,
        accountId: accountId,
        paymentGateway: paymentGateway,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );
      return Right(payment);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, WaterPaymentEntity>> verifyPayment({
    required String paymentId,
  }) async {
    try {
      final payment = await remoteDataSource.verifyPayment(paymentId: paymentId);
      return Right(payment);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<WaterPaymentEntity>>> getPaymentHistory({
    int? limit,
    int? offset,
  }) async {
    try {
      final payments = await remoteDataSource.getPaymentHistory(
        limit: limit,
        offset: offset,
      );
      return Right(payments);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, WaterPaymentEntity>> getPaymentReceipt({
    required String paymentId,
  }) async {
    try {
      final receipt = await remoteDataSource.getPaymentReceipt(paymentId: paymentId);
      return Right(receipt);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }
}
