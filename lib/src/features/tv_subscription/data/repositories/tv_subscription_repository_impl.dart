import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/smartcard_validation_result.dart';
import '../../domain/entities/tv_payment_entity.dart';
import '../../domain/repositories/tv_subscription_repository.dart';
import '../datasources/tv_subscription_remote_datasource.dart';

class TVSubscriptionRepositoryImpl implements TVSubscriptionRepository {
  final TVSubscriptionRemoteDataSource remoteDataSource;

  TVSubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TVProviderEntity>>> getProviders({
    String? category,
  }) async {
    try {
      final providers = await remoteDataSource.getProviders(category: category);
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
  Future<Either<Failure, List<TVPackageEntity>>> getPackages({
    required String providerCode,
  }) async {
    try {
      final packages = await remoteDataSource.getPackages(providerCode: providerCode);
      return Right(packages);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, SmartcardValidationResult>> validateSmartcard({
    required String providerCode,
    required String smartcardNumber,
  }) async {
    try {
      final result = await remoteDataSource.validateSmartcard(
        providerCode: providerCode,
        smartcardNumber: smartcardNumber,
      );
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, TVPaymentEntity>> initiatePayment({
    required String providerCode,
    required String packageCode,
    required String smartcardNumber,
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
        packageCode: packageCode,
        smartcardNumber: smartcardNumber,
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
  Future<Either<Failure, TVPaymentEntity>> verifyPayment({
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
  Future<Either<Failure, List<TVPaymentEntity>>> getPaymentHistory({
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
  Future<Either<Failure, TVPaymentEntity>> getPaymentReceipt({
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
