import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/cable_tv_provider_entity.dart';
import '../entities/tv_package_entity.dart';
import '../entities/smart_card_validation_entity.dart';
import '../entities/cable_tv_payment_entity.dart';

abstract class CableTVRepository {
  Future<Either<Failure, List<CableTVProviderEntity>>> getProviders({bool activeOnly = true});

  Future<Either<Failure, SmartCardValidationEntity>> validateSmartCard({
    required String providerId,
    required String smartCardNumber,
  });

  Future<Either<Failure, List<TVPackageEntity>>> getPackages({required String providerId});

  Future<Either<Failure, CableTVPaymentEntity>> paySubscription({
    required String providerId,
    required String smartCardNumber,
    required String variationCode,
    required double amount,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
}
