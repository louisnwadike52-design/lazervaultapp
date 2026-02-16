import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/internet_provider_entity.dart';
import '../entities/internet_package_entity.dart';
import '../entities/internet_account_validation_entity.dart';
import '../entities/internet_payment_entity.dart';

abstract class InternetBillRepository {
  Future<Either<Failure, List<InternetProviderEntity>>> getProviders({bool activeOnly = true});

  Future<Either<Failure, InternetAccountValidationEntity>> validateAccount({
    required String providerId,
    required String accountNumber,
  });

  Future<Either<Failure, List<InternetPackageEntity>>> getPackages({required String providerId});

  Future<Either<Failure, InternetPaymentEntity>> payBill({
    required String providerId,
    required String customerNumber,
    required String serviceType,
    required String packageId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
}
