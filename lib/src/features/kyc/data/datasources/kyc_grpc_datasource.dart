import 'package:grpc/grpc.dart';
import 'package:lazervault/core/errors/exceptions.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_proto;
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';

/// gRPC-based Remote data source for KYC operations
/// Uses AuthService gRPC client instead of HTTP
class KYCGrpcDataSource {
  final auth_proto.AuthServiceClient authClient;

  KYCGrpcDataSource({required this.authClient});

  /// Verify ID (BVN, NIN, etc.) via gRPC
  /// Uses AuthService.verifyIdentity gRPC method
  Future<Map<String, dynamic>> verifyID(IDVerificationRequest request) async {
    // Map IDType enum to proto IdentityType
    final identityType = request.idType == IDType.bvn
        ? auth_proto.IdentityType.IDENTITY_TYPE_BVN
        : auth_proto.IdentityType.IDENTITY_TYPE_NIN;

    // Create gRPC request
    final grpcRequest = auth_proto.VerifyIdentityRequest()
      ..identityType = identityType
      ..identityNumber = request.idNumber
      ..dateOfBirth = request.dateOfBirth;

    try {
      // Make gRPC call (call options with auth token added by caller)
      final response = await authClient.verifyIdentity(grpcRequest);

      // Check if verification was successful
      if (!response.success || !response.verified) {
        throw APIException(
          message: response.errorMessage.isNotEmpty ? response.errorMessage : 'ID verification failed',
          statusCode: 422,
        );
      }

      // Return success response
      return {
        'success': response.success,
        'verified': response.verified,
        'status': response.verified ? 'approved' : 'in_progress',
        'current_tier': KYCTier.tier2,
        'message': response.errorMessage.isNotEmpty ? response.errorMessage : 'ID verified successfully',
        'reference': response.hasIdentity() && response.identity.hasPhoneNumber()
            ? _maskPhoneNumber(response.identity.phoneNumber)
            : null,
        'identity_type': identityType.toString().split('.').last,
      };
    } on GrpcError catch (e) {
      // Handle gRPC errors
      final message = e.toString();
      if (message.contains('Unauthenticated') || message.contains('401')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      } else if (message.contains('InvalidArgument') || message.contains('400')) {
        throw APIException(
          message: 'Invalid ID details provided. Please check and try again.',
          statusCode: 422,
        );
      } else if (message.contains('AlreadyExists')) {
        throw APIException(
          message: 'This ID has already been used for another account.',
          statusCode: 409,
        );
      } else {
        throw APIException(
          message: e.message ?? 'ID verification failed. Please try again.',
          statusCode: 500,
        );
      }
    }
  }

  /// Get KYC status from auth service via gRPC
  Future<Map<String, dynamic>> getKYCStatus(String userId) async {
    try {
      final request = auth_proto.GetMeRequest();

      // Make gRPC call
      final response = await authClient.getMe(request);
      final user = response.user;

      // Determine KYC status from user data
      final status = user.hasIdentityVerified() && user.identityVerified
          ? KYCStatus.approved
          : KYCStatus.notStarted;

      final currentTier = user.hasIdentityVerified() && user.identityVerified
          ? KYCTier.tier2
          : KYCTier.tier1;

      return {
        'status': status,
        'current_tier': currentTier,
        'tier_info': [],
        'documents': [],
        'identity_verified': user.hasIdentityVerified() ? user.identityVerified : false,
        'identity_type': user.hasIdentityType() ? user.identityType : null,
        'masked_identity_number': null,
      };
    } on GrpcError catch (e) {
      throw APIException(
        message: e.message ?? 'Failed to fetch KYC status',
        statusCode: 500,
      );
    }
  }

  /// Get country requirements (returns config for supported countries)
  Future<Map<String, dynamic>> getCountryRequirements(String countryCode) async {
    // Return hardcoded requirements for Nigeria
    // In production, this could call a config service
    return {
      'country_code': countryCode,
      'accepted_id_types': [IDType.bvn, IDType.nin],
      'mandatory_id_types': [IDType.bvn],
      'address_proof_required': false,
      'liveness_check_required': false,
      'tier_1_daily_limit': 5000000,
      'tier_2_daily_limit': 50000000,
      'tier_3_daily_limit': 0,
    };
  }

  /// Initiate KYC verification flow via gRPC
  Future<Map<String, dynamic>> initiateKYC({
    required String userId,
    required KYCTier targetTier,
    String countryCode = 'NG',
  }) async {
    // Map KYCTier enum to proto KYCTier
    final protoTier = targetTier == KYCTier.tier1
        ? auth_proto.KYCTier.KYC_TIER_1
        : targetTier == KYCTier.tier2
            ? auth_proto.KYCTier.KYC_TIER_2
            : auth_proto.KYCTier.KYC_TIER_3;

    final request = auth_proto.InitiateKYCRequest()
      ..targetTier = protoTier
      ..countryCode = countryCode;

    try {
      final response = await authClient.initiateKYC(request);

      if (!response.success) {
        throw APIException(
          message: response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to initiate KYC',
          statusCode: 422,
        );
      }

      return {
        'success': response.success,
        'session_id': response.sessionId,
        'required_documents': response.requiredDocuments,
        'required_fields': response.requiredFields,
        'redirect_url': response.redirectUrl,
      };
    } on GrpcError catch (e) {
      final message = e.toString();
      if (message.contains('Unauthenticated') || message.contains('401')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      }
      throw APIException(
        message: e.message ?? 'Failed to initiate KYC',
        statusCode: 500,
      );
    }
  }

  /// Upload KYC document via gRPC
  Future<Map<String, dynamic>> uploadDocument(
    DocumentUploadRequest request,
  ) async {
    // Map IDType enum to proto DocumentType
    final docType = _mapIdTypeToDocumentType(request.documentType);

    final grpcRequest = auth_proto.UploadDocumentRequest()
      ..documentType = docType
      ..documentFrontUrl = request.documentFrontUrl ?? ''
      ..documentBackUrl = request.documentBackUrl ?? ''
      ..selfieUrl = request.selfieUrl ?? ''
      ..proofOfAddressUrl = request.proofOfAddressUrl ?? '';

    try {
      final response = await authClient.uploadDocument(grpcRequest);

      if (!response.success) {
        throw APIException(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to upload document',
          statusCode: 422,
        );
      }

      return {
        'success': response.success,
        'message': response.message,
        'document_id': response.documentId,
        'status': _mapProtoDocumentStatus(response.status),
      };
    } on GrpcError catch (e) {
      final message = e.toString();
      if (message.contains('Unauthenticated') || message.contains('401')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      }
      throw APIException(
        message: e.message ?? 'Failed to upload document',
        statusCode: 500,
      );
    }
  }

  /// Skip KYC upgrade via gRPC (progressive onboarding)
  Future<Map<String, dynamic>> skipKYCUpgrade({
    required String userId,
    bool skipTier2 = true,
  }) async {
    final request = auth_proto.SkipKYCUpgradeRequest()
      ..skipTier2 = skipTier2;

    try {
      final response = await authClient.skipKYCUpgrade(request);

      // Map proto tier to entity tier
      final assignedTier = response.assignedTier == auth_proto.KYCTier.KYC_TIER_1
          ? KYCTier.tier1
          : response.assignedTier == auth_proto.KYCTier.KYC_TIER_2
              ? KYCTier.tier2
              : KYCTier.tier3;

      return {
        'success': response.success,
        'assigned_tier': assignedTier,
        'message': response.message,
        'next_steps': response.nextSteps,
      };
    } on GrpcError catch (e) {
      final message = e.toString();
      if (message.contains('Unauthenticated') || message.contains('401')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      }
      throw APIException(
        message: e.message ?? 'Failed to skip KYC upgrade',
        statusCode: 500,
      );
    }
  }

  /// Get user's uploaded documents via gRPC
  Future<Map<String, dynamic>> getUserDocuments(String userId) async {
    final request = auth_proto.GetUserDocumentsRequest();

    try {
      final response = await authClient.getUserDocuments(request);

      final documents = response.documents.map((doc) {
        return {
          'id': doc.id,
          'document_type': _mapProtoDocumentType(doc.documentType),
          'document_url': doc.documentUrl,
          'status': _mapProtoDocumentStatus(doc.status),
          'uploaded_at': doc.uploadedAt,
          'verified_at': doc.hasVerifiedAt() ? doc.verifiedAt : null,
          'rejection_reason': doc.hasRejectionReason() ? doc.rejectionReason : null,
        };
      }).toList();

      return {
        'success': response.success,
        'documents': documents,
      };
    } on GrpcError catch (e) {
      throw APIException(
        message: e.message ?? 'Failed to fetch documents',
        statusCode: 500,
      );
    }
  }

  /// Map IDType to proto DocumentType
  auth_proto.DocumentType _mapIdTypeToDocumentType(IDType idType) {
    switch (idType) {
      case IDType.bvn:
        return auth_proto.DocumentType.DOCUMENT_TYPE_BVN;
      case IDType.nin:
        return auth_proto.DocumentType.DOCUMENT_TYPE_NIN;
      case IDType.driversLicense:
        return auth_proto.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE;
      case IDType.internationalPassport:
        return auth_proto.DocumentType.DOCUMENT_TYPE_PASSPORT;
      case IDType.votersCard:
        return auth_proto.DocumentType.DOCUMENT_TYPE_VOTERS_CARD;
      default:
        return auth_proto.DocumentType.DOCUMENT_TYPE_UNKNOWN;
    }
  }

  /// Map proto DocumentType to IDType
  IDType _mapProtoDocumentType(auth_proto.DocumentType docType) {
    switch (docType) {
      case auth_proto.DocumentType.DOCUMENT_TYPE_BVN:
        return IDType.bvn;
      case auth_proto.DocumentType.DOCUMENT_TYPE_NIN:
        return IDType.nin;
      case auth_proto.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE:
        return IDType.driversLicense;
      case auth_proto.DocumentType.DOCUMENT_TYPE_PASSPORT:
        return IDType.internationalPassport;
      case auth_proto.DocumentType.DOCUMENT_TYPE_VOTERS_CARD:
        return IDType.votersCard;
      default:
        return IDType.unknown;
    }
  }

  /// Map proto DocumentStatus to entity DocumentStatus
  DocumentStatus _mapProtoDocumentStatus(auth_proto.DocumentStatus status) {
    switch (status) {
      case auth_proto.DocumentStatus.DOCUMENT_STATUS_PENDING_UPLOAD:
        return DocumentStatus.pendingUpload;
      case auth_proto.DocumentStatus.DOCUMENT_STATUS_UPLOADED:
        return DocumentStatus.uploaded;
      case auth_proto.DocumentStatus.DOCUMENT_STATUS_UNDER_REVIEW:
        return DocumentStatus.underReview;
      case auth_proto.DocumentStatus.DOCUMENT_STATUS_APPROVED:
        return DocumentStatus.approved;
      case auth_proto.DocumentStatus.DOCUMENT_STATUS_REJECTED:
        return DocumentStatus.rejected;
      default:
        return DocumentStatus.unknown;
    }
  }

  /// Mask phone number for display (e.g., 0812****5678)
  String _maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 4) return phoneNumber;
    return '${phoneNumber.substring(0, 4)}****${phoneNumber.substring(phoneNumber.length - 4)}';
  }
}
