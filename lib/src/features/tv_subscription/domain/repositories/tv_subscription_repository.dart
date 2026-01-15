import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/tv_provider_entity.dart';
import '../entities/tv_package_entity.dart';
import '../entities/smartcard_validation_result.dart';
import '../entities/tv_payment_entity.dart';

abstract class TVSubscriptionRepository {
  // Provider Management
  Future<Either<Failure, List<TVProviderEntity>>> getProviders({
    String? category, // 'tv' or 'internet'
  });

  Future<Either<Failure, void>> syncProviders();

  // Package Management
  Future<Either<Failure, List<TVPackageEntity>>> getPackages({
    required String providerCode,
  });

  // Smartcard Validation
  Future<Either<Failure, SmartcardValidationResult>> validateSmartcard({
    required String providerCode,
    required String smartcardNumber,
  });

  // Payment Operations
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
  });

  Future<Either<Failure, TVPaymentEntity>> verifyPayment({
    required String paymentId,
  });

  Future<Either<Failure, List<TVPaymentEntity>>> getPaymentHistory({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, TVPaymentEntity>> getPaymentReceipt({
    required String paymentId,
  });
}
