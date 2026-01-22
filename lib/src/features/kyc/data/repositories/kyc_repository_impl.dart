import 'package:dartz/dartz.dart';
import 'package:lazervault/core/errors/exceptions.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/src/features/kyc/data/datasources/kyc_grpc_datasource.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/domain/repositories/kyc_repository.dart';

/// KYC Repository Implementation (gRPC-based)
/// Uses AuthService gRPC client instead of HTTP
class KYCRepositoryImpl implements KYCRepository {
  final KYCGrpcDataSource grpcDataSource;

  KYCRepositoryImpl({required this.grpcDataSource});

  @override
  Future<Either<Failure, UserKYCProfile>> getKYCStatus(String userId) async {
    try {
      final data = await grpcDataSource.getKYCStatus(userId);
      return Right(_parseKYCProfile(data));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, CountryKYCRequirements>> getCountryRequirements(
    String countryCode,
  ) async {
    try {
      final data = await grpcDataSource.getCountryRequirements(countryCode);
      return Right(_parseCountryRequirements(data));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, KYCInitiationResponse>> initiateKYC({
    required String userId,
    required KYCTier targetTier,
  }) async {
    try {
      final data = await grpcDataSource.initiateKYC(
        userId: userId,
        targetTier: targetTier,
      );
      return Right(KYCInitiationResponse(
        success: data['success'] as bool,
        sessionId: data['session_id'] as String?,
        requiredDocuments:
            (data['required_documents'] as List<dynamic>).cast<String>(),
        requiredFields:
            (data['required_fields'] as List<dynamic>).cast<String>(),
        redirectUrl: data['redirect_url'] as String?,
      ));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, VerifyIDResponse>> verifyID(
    IDVerificationRequest request,
  ) async {
    try {
      final data = await grpcDataSource.verifyID(request);
      return Right(VerifyIDResponse(
        success: data['success'] as bool,
        message: data['message'] as String?,
        status: data['status'] as KYCStatus? ??
            (data['status'] as String == 'in_progress'
                ? KYCStatus.inProgress
                : KYCStatus.approved),
        currentTier: data['current_tier'] as KYCTier? ?? KYCTier.tier1,
        verifiedAt: DateTime.now(),
        reference: data['reference'] as String?,
      ));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, VerifyIDResponse>> uploadDocument(
    DocumentUploadRequest request,
  ) async {
    try {
      final data = await grpcDataSource.uploadDocument(request);
      return Right(VerifyIDResponse(
        success: data['success'] as bool,
        message: data['message'] as String?,
        status: data['status'] as KYCStatus? ?? KYCStatus.inProgress,
        currentTier: KYCTier.tier1,
        verifiedAt: DateTime.now(),
      ));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<VerificationDocument>>> getUserDocuments(
    String userId,
  ) async {
    try {
      final data = await grpcDataSource.getUserDocuments(userId);
      final docs = (data['documents'] as List<dynamic>?)
              ?.map((e) => _parseDocument(e as Map<String, dynamic>))
              .toList() ??
          <VerificationDocument>[];
      return Right(docs);
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, SkipKYCResponse>> skipKYCUpgrade({
    required String userId,
    bool skipTier2 = true,
  }) async {
    try {
      final data = await grpcDataSource.skipKYCUpgrade(
        userId: userId,
        skipTier2: skipTier2,
      );
      return Right(SkipKYCResponse(
        success: data['success'] as bool,
        assignedTier: data['assigned_tier'] as KYCTier? ?? KYCTier.tier1,
        message: data['message'] as String,
        nextSteps:
            (data['next_steps'] as List<dynamic>).cast<String>(),
      ));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(APIFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  UserKYCProfile _parseKYCProfile(Map<String, dynamic> data) {
    return UserKYCProfile(
      status: data['status'] as KYCStatus? ?? KYCStatus.notStarted,
      currentTier: data['current_tier'] as KYCTier? ?? KYCTier.tier1,
      tierInfo: (data['tier_info'] as List<dynamic>?)
              ?.map((e) => _parseTierInfo(e as Map<String, dynamic>))
              .toList() ??
          [],
      lastUpdated: DateTime.now(),
      rejectionReason: data['rejection_reason'] as String?,
      documents: (data['documents'] as List<dynamic>?)
              ?.map((e) => _parseDocument(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  KYCTierInfo _parseTierInfo(Map<String, dynamic> data) {
    return KYCTierInfo(
      tier: data['tier'] as KYCTier? ?? KYCTier.tier1,
      status: data['status'] as KYCStatus? ?? KYCStatus.notStarted,
      displayName: data['display_name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      benefits: (data['benefits'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      dailyTransactionLimit: data['daily_transaction_limit'] as int? ?? 0,
      dailyReceiveLimit: data['daily_receive_limit'] as int? ?? 0,
      maxBalance: data['max_balance'] as int? ?? 0,
      verifiedAt: data['verified_at'] as DateTime?,
      expiresAt: data['expires_at'] as DateTime?,
      isCurrent: data['is_current'] as bool? ?? false,
      isLocked: data['is_locked'] as bool? ?? false,
    );
  }

  VerificationDocument _parseDocument(Map<String, dynamic> data) {
    return VerificationDocument(
      id: data['id'] as String,
      documentType: data['document_type'] as IDType? ?? IDType.unknown,
      documentUrl: data['document_url'] as String,
      status: data['status'] as DocumentStatus? ?? DocumentStatus.pendingUpload,
      uploadedAt: data['uploaded_at'] as DateTime?,
      verifiedAt: data['verified_at'] as DateTime?,
      rejectionReason: data['rejection_reason'] as String?,
    );
  }

  CountryKYCRequirements _parseCountryRequirements(
    Map<String, dynamic> data,
  ) {
    return CountryKYCRequirements(
      countryCode: data['country_code'] as String,
      acceptedIdTypes: (data['accepted_id_types'] as List<dynamic>?)
              ?.map((e) => e as IDType)
              .toList() ??
          [],
      mandatoryIdTypes: (data['mandatory_id_types'] as List<dynamic>?)
              ?.map((e) => e as IDType)
              .toList() ??
          [],
      addressProofRequired: data['address_proof_required'] as bool? ?? false,
      livenessCheckRequired: data['liveness_check_required'] as bool? ?? false,
      tier1DailyLimit: data['tier_1_daily_limit'] as int? ?? 5000000,
      tier2DailyLimit: data['tier_2_daily_limit'] as int? ?? 50000000,
      tier3DailyLimit: data['tier_3_daily_limit'] as int? ?? 0,
    );
  }
}
