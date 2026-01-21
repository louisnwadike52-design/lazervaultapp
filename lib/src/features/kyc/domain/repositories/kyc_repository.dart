import 'package:dartz/dartz.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';

/// Abstract repository for KYC operations
abstract class KYCRepository {
  /// Get user's current KYC status
  Future<Either<Failure, UserKYCProfile>> getKYCStatus(String userId);

  /// Get country-specific KYC requirements
  Future<Either<Failure, CountryKYCRequirements>> getCountryRequirements(
    String countryCode,
  );

  /// Initiate KYC verification flow
  Future<Either<Failure, KYCInitiationResponse>> initiateKYC({
    required String userId,
    required KYCTier targetTier,
  });

  /// Verify ID (BVN, NIN, etc.)
  Future<Either<Failure, VerifyIDResponse>> verifyID(
    IDVerificationRequest request,
  );

  /// Upload KYC document
  Future<Either<Failure, VerifyIDResponse>> uploadDocument(
    DocumentUploadRequest request,
  );

  /// Get user's uploaded documents
  Future<Either<Failure, List<VerificationDocument>>> getUserDocuments(
    String userId,
  );

  /// Skip KYC upgrade (progressive onboarding)
  Future<Either<Failure, SkipKYCResponse>> skipKYCUpgrade({
    required String userId,
    bool skipTier2 = true,
  });
}
