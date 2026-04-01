import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:lazervault/core/errors/exceptions.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_proto;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';

/// gRPC-based Remote data source for KYC operations
/// All KYC RPCs are on AuthService (auth-service backend)
class KYCGrpcDataSource {
  final auth_proto.AuthServiceClient authClient;

  KYCGrpcDataSource({required this.authClient});

  /// Verify ID (BVN, NIN, Ghana Card, UK Passport, SSN, etc.) via gRPC
  /// Uses AuthService.verifyIdentity gRPC method
  /// Handles both synchronous (BVN/NIN/Ghana Card/SSN) and async (UK Passport/US State ID) flows
  Future<Map<String, dynamic>> verifyID(IDVerificationRequest request) async {
    // Map IDType enum to proto IdentityType
    final identityType = _mapIDTypeToProto(request.idType);

    // Create gRPC request with all fields
    final grpcRequest = auth_proto.VerifyIdentityRequest()
      ..identityType = identityType
      ..identityNumber = request.idNumber
      ..dateOfBirth = request.dateOfBirth
      ..firstName = request.firstName
      ..lastName = request.lastName
      ..phoneNumber = request.phoneNumber;

    // Set country code if determinable from ID type
    final countryCode = _resolveCountryCode(request.idType);
    if (countryCode.isNotEmpty) {
      grpcRequest.countryCode = countryCode;
    }

    try {
      // Make gRPC call with 45s timeout (providers may take time)
      final response = await authClient.verifyIdentity(
        grpcRequest,
        options: CallOptions(timeout: const Duration(seconds: 45)),
      );

      // Check for async verification (Onfido/Persona - returns session URL)
      final hasSessionUrl = response.hasSessionUrl() && response.sessionUrl.isNotEmpty;
      final isPending = response.hasStatus() && response.status == 'pending';

      // For async flows, don't require verified=true
      if (!response.success && !hasSessionUrl) {
        throw APIException(
          message: response.errorMessage.isNotEmpty ? response.errorMessage : 'ID verification failed',
          statusCode: 422,
        );
      }

      // Determine status from response
      String status = 'in_progress';
      if (response.hasStatus() && response.status.isNotEmpty) {
        status = response.status;
      } else if (response.verified) {
        status = 'approved';
      }

      // Determine tier from status (don't hardcode — respect server response)
      KYCTier currentTier;
      if (response.verified) {
        currentTier = KYCTier.tier2;
      } else if (isPending || hasSessionUrl) {
        currentTier = KYCTier.tier1; // Still tier1 until async completes
      } else {
        currentTier = KYCTier.tier1;
      }

      // Return success response
      return {
        'success': response.success,
        'verified': response.verified,
        'status': status,
        'current_tier': currentTier,
        'message': response.errorMessage.isNotEmpty
            ? response.errorMessage
            : (isPending ? 'Verification in progress' : 'ID verified successfully'),
        'reference': response.hasIdentity() && response.identity.hasPhoneNumber()
            ? _maskPhoneNumber(response.identity.phoneNumber)
            : null,
        'identity_type': identityType.toString().split('.').last,
        // Async verification fields
        if (response.hasVerificationId()) 'verification_id': response.verificationId,
        if (hasSessionUrl) 'session_url': response.sessionUrl,
        if (response.hasSessionToken() && response.sessionToken.isNotEmpty)
          'session_token': response.sessionToken,
      };
    } on GrpcError catch (e) {
      // Handle gRPC-specific errors
      final message = e.toString();
      if (e.code == StatusCode.unauthenticated || message.contains('Unauthenticated')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      } else if (e.code == StatusCode.invalidArgument || message.contains('InvalidArgument')) {
        throw APIException(
          message: friendlyGrpcError(e, 'Invalid ID details provided. Please check and try again.'),
          statusCode: 422,
        );
      } else if (e.code == StatusCode.alreadyExists || message.contains('AlreadyExists')) {
        throw APIException(
          message: 'This ID has already been used for another account.',
          statusCode: 409,
        );
      } else if (e.code == StatusCode.deadlineExceeded) {
        throw APIException(
          message: 'Verification is taking longer than expected. Please try again.',
          statusCode: 504,
        );
      } else {
        throw APIException(
          message: friendlyGrpcError(e, 'ID verification failed. Please try again.'),
          statusCode: 500,
        );
      }
    } on TimeoutException {
      throw APIException(
        message: 'Verification timed out. Please check your connection and try again.',
        statusCode: 504,
      );
    } on SocketException {
      throw APIException(
        message: 'No internet connection. Please check your network and try again.',
        statusCode: 503,
      );
    } catch (e) {
      // Catch any other unexpected exceptions
      throw APIException(
        message: 'An unexpected error occurred. Please try again.',
        statusCode: 500,
      );
    }
  }

  /// Map IDType enum to proto IdentityType
  auth_proto.IdentityType _mapIDTypeToProto(IDType idType) {
    switch (idType) {
      case IDType.bvn:
        return auth_proto.IdentityType.IDENTITY_TYPE_BVN;
      case IDType.nin:
        return auth_proto.IdentityType.IDENTITY_TYPE_NIN;
      case IDType.ghanaCard:
        return auth_proto.IdentityType.IDENTITY_TYPE_GHANA_CARD;
      case IDType.kenyaNationalId:
        return auth_proto.IdentityType.IDENTITY_TYPE_KENYA_NATIONAL_ID;
      case IDType.kraPin:
        return auth_proto.IdentityType.IDENTITY_TYPE_KRA_PIN;
      case IDType.saIdCard:
        return auth_proto.IdentityType.IDENTITY_TYPE_SA_ID;
      case IDType.saPassport:
        return auth_proto.IdentityType.IDENTITY_TYPE_SA_PASSPORT;
      case IDType.ukPassport:
        return auth_proto.IdentityType.IDENTITY_TYPE_UK_PASSPORT;
      case IDType.ukDrivingLicense:
        return auth_proto.IdentityType.IDENTITY_TYPE_UK_DRIVING_LICENSE;
      case IDType.usSsn:
        return auth_proto.IdentityType.IDENTITY_TYPE_US_SSN;
      case IDType.usStateId:
        return auth_proto.IdentityType.IDENTITY_TYPE_US_STATE_ID;
      case IDType.usPassport:
        return auth_proto.IdentityType.IDENTITY_TYPE_US_PASSPORT;
      case IDType.driversLicense:
        return auth_proto.IdentityType.IDENTITY_TYPE_DRIVERS_LICENSE;
      case IDType.internationalPassport:
        return auth_proto.IdentityType.IDENTITY_TYPE_INTERNATIONAL_PASSPORT;
      case IDType.votersCard:
        throw APIException(
          message: "Voter's Card verification is not yet available. Please use BVN or NIN instead.",
          statusCode: 422,
        );
      default:
        throw APIException(
          message: 'Unsupported ID type: ${idType.name}',
          statusCode: 422,
        );
    }
  }

  /// Resolve country code from ID type for the proto request
  String _resolveCountryCode(IDType idType) {
    switch (idType) {
      case IDType.bvn:
      case IDType.nin:
      case IDType.votersCard:
      case IDType.driversLicense:
      case IDType.internationalPassport:
        return 'NG';
      case IDType.ghanaCard:
        return 'GH';
      case IDType.kenyaNationalId:
      case IDType.kraPin:
        return 'KE';
      case IDType.saIdCard:
      case IDType.saPassport:
        return 'ZA';
      case IDType.ukPassport:
      case IDType.ukDrivingLicense:
        return 'GB';
      case IDType.usSsn:
      case IDType.usStateId:
      case IDType.usPassport:
        return 'US';
      default:
        return '';
    }
  }

  /// Get KYC status from auth service via gRPC
  Future<Map<String, dynamic>> getKYCStatus(String userId) async {
    try {
      final request = auth_proto.GetMeRequest();

      // Make gRPC call
      final response = await authClient.getMe(request);
      final user = response.user;

      // Determine KYC status from user data — prefer explicit kyc fields, fallback to identity_verified
      KYCStatus status;
      KYCTier currentTier;

      if (user.kycTier > 0) {
        // Use explicit KYC fields from proto (Phase 3 fields)
        currentTier = user.kycTier >= 3
            ? KYCTier.tier3
            : user.kycTier >= 2
                ? KYCTier.tier2
                : KYCTier.tier1;
        switch (user.kycStatus) {
          case 'approved':
            status = KYCStatus.approved;
          case 'in_progress':
            status = KYCStatus.inProgress;
          case 'pending_review':
            status = KYCStatus.pendingReview;
          case 'rejected':
            status = KYCStatus.rejected;
          case 'expired':
            status = KYCStatus.expired;
          default:
            status = KYCStatus.notStarted;
        }
      } else {
        // Fallback for backward compatibility
        status = user.hasIdentityVerified() && user.identityVerified
            ? KYCStatus.approved
            : KYCStatus.notStarted;
        currentTier = user.hasIdentityVerified() && user.identityVerified
            ? KYCTier.tier2
            : KYCTier.tier1;
      }

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
        message: friendlyGrpcError(e, 'Failed to fetch KYC status'),
        statusCode: 500,
      );
    }
  }

  /// Get country requirements from server via gRPC
  Future<Map<String, dynamic>> getCountryRequirements(String countryCode) async {
    try {
      final grpcRequest = auth_pb.GetCountryRequirementsRequest()
        ..countryCode = countryCode;

      final response = await authClient
          .getCountryRequirements(grpcRequest, options: CallOptions(timeout: const Duration(seconds: 15)));

      if (!response.success) {
        throw APIException(
          message: 'Country requirements not available for $countryCode',
          statusCode: 404,
        );
      }

      final reqs = response.requirements;
      return {
        'country_code': reqs.countryCode,
        'accepted_id_types': reqs.acceptedIdTypes
            .map((t) => _mapProtoIDTypeToEntity(t))
            .toList(),
        'mandatory_id_types': reqs.mandatoryIdTypes
            .map((t) => _mapProtoIDTypeToEntity(t))
            .toList(),
        'address_proof_required': reqs.addressProofRequired,
        'liveness_check_required': reqs.livenessCheckRequired,
        'tier_1_daily_limit': reqs.tier1DailyLimit.toInt(),
        'tier_2_daily_limit': reqs.tier2DailyLimit.toInt(),
        'tier_3_daily_limit': reqs.tier3DailyLimit.toInt(),
      };
    } on GrpcError catch (e) {
      throw APIException(
        message: friendlyGrpcError(e, 'Failed to fetch country requirements'),
        statusCode: e.code,
      );
    } on TimeoutException {
      throw const APIException(
        message: 'Request timed out. Please try again.',
        statusCode: 504,
      );
    }
  }

  /// Maps proto IDType enum to entity IDType
  IDType _mapProtoIDTypeToEntity(dynamic protoType) {
    final name = protoType.toString().toLowerCase();
    if (name.contains('bvn')) return IDType.bvn;
    if (name.contains('nin')) return IDType.nin;
    if (name.contains('ghana')) return IDType.ghanaCard;
    if (name.contains('kenya')) return IDType.kenyaNationalId;
    if (name.contains('kra')) return IDType.kraPin;
    if (name.contains('sa_id')) return IDType.saIdCard;
    if (name.contains('sa_passport')) return IDType.saPassport;
    if (name.contains('uk_passport')) return IDType.ukPassport;
    if (name.contains('uk_driv')) return IDType.ukDrivingLicense;
    if (name.contains('us_ssn') || name.contains('ssn')) return IDType.usSsn;
    if (name.contains('us_state')) return IDType.usStateId;
    if (name.contains('us_passport')) return IDType.usPassport;
    if (name.contains('driver')) return IDType.driversLicense;
    if (name.contains('passport')) return IDType.internationalPassport;
    if (name.contains('voter')) return IDType.votersCard;
    return IDType.unknown;
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
        message: friendlyGrpcError(e, 'Failed to initiate KYC'),
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
        message: friendlyGrpcError(e, 'Failed to upload document'),
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
        message: friendlyGrpcError(e, 'Failed to skip KYC upgrade'),
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
        message: friendlyGrpcError(e, 'Failed to fetch documents'),
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
      case IDType.ghanaCard:
      case IDType.kenyaNationalId:
      case IDType.kraPin:
      case IDType.saIdCard:
        return auth_proto.DocumentType.DOCUMENT_TYPE_NIN; // National ID equivalent
      case IDType.driversLicense:
      case IDType.ukDrivingLicense:
      case IDType.usStateId:
        return auth_proto.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE;
      case IDType.internationalPassport:
      case IDType.ukPassport:
      case IDType.usPassport:
      case IDType.saPassport:
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

  /// Create a verification session with an external provider
  Future<VerificationSession> createVerificationSession({
    required String userId,
    required int targetTier,
    required String countryCode,
    required String idType,
    required String idNumber,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    String? phoneNumber,
  }) async {
    // Map target tier int to proto KYCTier enum
    final protoTier = targetTier == 1
        ? auth_enum.KYCTier.KYC_TIER_1
        : targetTier == 2
            ? auth_enum.KYCTier.KYC_TIER_2
            : auth_enum.KYCTier.KYC_TIER_3;

    // Map idType string to proto IdentityType
    final protoIdType = _mapIDTypeStringToAuthProto(idType);

    final grpcRequest = auth_pb.CreateVerificationSessionRequest()
      ..targetTier = protoTier
      ..countryCode = countryCode
      ..idType = protoIdType
      ..idNumber = idNumber
      ..firstName = firstName
      ..lastName = lastName
      ..dateOfBirth = dateOfBirth;

    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      grpcRequest.phoneNumber = phoneNumber;
    }

    try {
      final response = await authClient.createVerificationSession(
        grpcRequest,
        options: CallOptions(timeout: const Duration(seconds: 45)),
      );

      if (!response.success) {
        throw APIException(
          message: response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to create verification session',
          statusCode: 422,
        );
      }

      // Map proto status to entity KYCStatus
      final status = _mapAuthProtoKYCStatus(response.status);

      return VerificationSession(
        verificationId: response.verificationId,
        sessionUrl: response.hasSessionUrl() && response.sessionUrl.isNotEmpty
            ? response.sessionUrl
            : null,
        sessionToken: response.hasSessionToken() && response.sessionToken.isNotEmpty
            ? response.sessionToken
            : null,
        provider: response.provider,
        status: status,
      );
    } on GrpcError catch (e) {
      final message = e.toString();
      if (e.code == StatusCode.unauthenticated || message.contains('Unauthenticated')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      } else if (e.code == StatusCode.invalidArgument) {
        throw APIException(
          message: friendlyGrpcError(e, 'Invalid details provided. Please check and try again.'),
          statusCode: 422,
        );
      } else if (e.code == StatusCode.deadlineExceeded) {
        throw APIException(
          message: 'Request timed out. Please try again.',
          statusCode: 504,
        );
      }
      throw APIException(
        message: friendlyGrpcError(e, 'Failed to create verification session'),
        statusCode: 500,
      );
    } on TimeoutException {
      throw APIException(
        message: 'Request timed out. Please check your connection and try again.',
        statusCode: 504,
      );
    } on SocketException {
      throw APIException(
        message: 'No internet connection. Please check your network and try again.',
        statusCode: 503,
      );
    } catch (e) {
      throw APIException(
        message: 'An unexpected error occurred. Please try again.',
        statusCode: 500,
      );
    }
  }

  /// Confirm a verification session after provider callback
  Future<ConfirmVerificationResult> confirmVerification({
    required String verificationId,
    required String provider,
    String? providerAuthCode,
    Map<String, String>? metadata,
  }) async {
    final grpcRequest = auth_pb.ConfirmVerificationRequest()
      ..verificationId = verificationId
      ..provider = provider;

    if (providerAuthCode != null && providerAuthCode.isNotEmpty) {
      grpcRequest.providerAuthCode = providerAuthCode;
    }
    if (metadata != null && metadata.isNotEmpty) {
      grpcRequest.metadata.addAll(metadata);
    }

    try {
      final response = await authClient.confirmVerification(
        grpcRequest,
        options: CallOptions(timeout: const Duration(seconds: 30)),
      );

      // Map proto KYCTier to entity KYCTier
      final currentTier = response.currentTier == auth_enum.KYCTier.KYC_TIER_3
          ? KYCTier.tier3
          : response.currentTier == auth_enum.KYCTier.KYC_TIER_2
              ? KYCTier.tier2
              : KYCTier.tier1;

      final status = _mapAuthProtoKYCStatus(response.status);

      BVNNameReconciliation? recon;
      if (response.hasBvnNameReconciliation()) {
        final r = response.bvnNameReconciliation;
        recon = BVNNameReconciliation(
          nameAction: r.nameAction,
          nameMatchScore: r.nameMatchScore,
          verifiedName: r.verifiedName,
          profileName: r.profileName,
        );
      }

      return ConfirmVerificationResult(
        success: response.success,
        status: status,
        currentTier: currentTier,
        message: response.message,
        bvnNameReconciliation: recon,
      );
    } on GrpcError catch (e) {
      final message = e.toString();
      if (e.code == StatusCode.unauthenticated || message.contains('Unauthenticated')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      } else if (e.code == StatusCode.notFound) {
        throw APIException(
          message: 'Verification session not found.',
          statusCode: 404,
        );
      } else if (e.code == StatusCode.deadlineExceeded) {
        throw APIException(
          message: 'Request timed out. Please try again.',
          statusCode: 504,
        );
      }
      throw APIException(
        message: friendlyGrpcError(e, 'Failed to confirm verification'),
        statusCode: 500,
      );
    } on TimeoutException {
      throw APIException(
        message: 'Request timed out. Please check your connection and try again.',
        statusCode: 504,
      );
    } on SocketException {
      throw APIException(
        message: 'No internet connection. Please check your network and try again.',
        statusCode: 503,
      );
    } catch (e) {
      throw APIException(
        message: 'An unexpected error occurred. Please try again.',
        statusCode: 500,
      );
    }
  }

  /// Get a pre-signed URL for document upload
  Future<DocumentUploadURL> getDocumentUploadURL({
    required String documentType,
    required String contentType,
  }) async {
    final grpcRequest = auth_pb.GetDocumentUploadURLRequest()
      ..documentType = documentType
      ..contentType = contentType;

    try {
      final response = await authClient.getDocumentUploadURL(
        grpcRequest,
        options: CallOptions(timeout: const Duration(seconds: 30)),
      );

      if (!response.success) {
        throw const APIException(
          message: 'Failed to get upload URL',
          statusCode: 422,
        );
      }

      return DocumentUploadURL(
        uploadUrl: response.uploadUrl,
        storageKey: response.storageKey,
        expiresAt: DateTime.fromMillisecondsSinceEpoch(response.expiresAt.toInt() * 1000),
      );
    } on GrpcError catch (e) {
      final message = e.toString();
      if (e.code == StatusCode.unauthenticated || message.contains('Unauthenticated')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      } else if (e.code == StatusCode.deadlineExceeded) {
        throw APIException(
          message: 'Request timed out. Please try again.',
          statusCode: 504,
        );
      }
      throw APIException(
        message: friendlyGrpcError(e, 'Failed to get document upload URL'),
        statusCode: 500,
      );
    } on TimeoutException {
      throw APIException(
        message: 'Request timed out. Please check your connection and try again.',
        statusCode: 504,
      );
    } on SocketException {
      throw APIException(
        message: 'No internet connection. Please check your network and try again.',
        statusCode: 503,
      );
    } catch (e) {
      throw APIException(
        message: 'An unexpected error occurred. Please try again.',
        statusCode: 500,
      );
    }
  }

  /// Submit uploaded documents for review
  Future<String> submitDocumentsForReview({
    required String userId,
    required List<DocumentSubmissionItem> documents,
  }) async {
    final grpcRequest = auth_pb.SubmitDocumentsForReviewRequest();

    for (final doc in documents) {
      final protoDoc = auth_pb.DocumentSubmissionItem()
        ..storageKey = doc.storageKey
        ..documentType = doc.documentType
        ..contentType = doc.contentType;
      grpcRequest.documents.add(protoDoc);
    }

    try {
      final response = await authClient.submitDocumentsForReview(
        grpcRequest,
        options: CallOptions(timeout: const Duration(seconds: 30)),
      );

      if (!response.success) {
        throw APIException(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to submit documents',
          statusCode: 422,
        );
      }

      return response.message;
    } on GrpcError catch (e) {
      final message = e.toString();
      if (e.code == StatusCode.unauthenticated || message.contains('Unauthenticated')) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      } else if (e.code == StatusCode.deadlineExceeded) {
        throw APIException(
          message: 'Request timed out. Please try again.',
          statusCode: 504,
        );
      }
      throw APIException(
        message: friendlyGrpcError(e, 'Failed to submit documents for review'),
        statusCode: 500,
      );
    } on TimeoutException {
      throw APIException(
        message: 'Request timed out. Please check your connection and try again.',
        statusCode: 504,
      );
    } on SocketException {
      throw APIException(
        message: 'No internet connection. Please check your network and try again.',
        statusCode: 503,
      );
    } catch (e) {
      throw APIException(
        message: 'An unexpected error occurred. Please try again.',
        statusCode: 500,
      );
    }
  }

  /// Confirm BVN name after reconciliation
  Future<String> confirmBVNName({
    required String verificationId,
    required String action,
  }) async {
    final grpcRequest = auth_pb.ConfirmBVNNameRequest()
      ..verificationId = verificationId
      ..action = action;

    try {
      final response = await authClient.confirmBVNName(
        grpcRequest,
        options: CallOptions(timeout: const Duration(seconds: 30)),
      );

      if (!response.success) {
        throw APIException(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to confirm name',
          statusCode: 422,
        );
      }

      return response.message;
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw APIException(
          message: 'Session expired. Please log in again.',
          statusCode: 401,
        );
      }
      throw APIException(
        message: friendlyGrpcError(e, 'Failed to confirm name'),
        statusCode: 500,
      );
    }
  }

  /// Map ID type string to KYC proto IDType enum (for new KYCService RPCs)
  auth_enum.IdentityType _mapIDTypeStringToAuthProto(String idType) {
    switch (idType) {
      case 'bvn': return auth_enum.IdentityType.IDENTITY_TYPE_BVN;
      case 'nin': return auth_enum.IdentityType.IDENTITY_TYPE_NIN;
      case 'ghanaCard': return auth_enum.IdentityType.IDENTITY_TYPE_GHANA_CARD;
      case 'kenyaNationalId': return auth_enum.IdentityType.IDENTITY_TYPE_KENYA_NATIONAL_ID;
      case 'kraPin': return auth_enum.IdentityType.IDENTITY_TYPE_KRA_PIN;
      case 'saIdCard': return auth_enum.IdentityType.IDENTITY_TYPE_SA_ID;
      case 'saPassport': return auth_enum.IdentityType.IDENTITY_TYPE_SA_PASSPORT;
      case 'ukPassport': return auth_enum.IdentityType.IDENTITY_TYPE_UK_PASSPORT;
      case 'ukDrivingLicense': return auth_enum.IdentityType.IDENTITY_TYPE_UK_DRIVING_LICENSE;
      case 'usSsn': return auth_enum.IdentityType.IDENTITY_TYPE_US_SSN;
      case 'usStateId': return auth_enum.IdentityType.IDENTITY_TYPE_US_STATE_ID;
      case 'usPassport': return auth_enum.IdentityType.IDENTITY_TYPE_US_PASSPORT;
      case 'driversLicense': return auth_enum.IdentityType.IDENTITY_TYPE_DRIVERS_LICENSE;
      case 'internationalPassport': return auth_enum.IdentityType.IDENTITY_TYPE_INTERNATIONAL_PASSPORT;
      default: return auth_enum.IdentityType.IDENTITY_TYPE_UNSPECIFIED;
    }
  }

  /// Map auth proto KYC verification status to entity KYCStatus
  KYCStatus _mapAuthProtoKYCStatus(auth_enum.KYCVerificationStatus status) {
    switch (status) {
      case auth_enum.KYCVerificationStatus.KYC_STATUS_APPROVED: return KYCStatus.approved;
      case auth_enum.KYCVerificationStatus.KYC_STATUS_IN_PROGRESS: return KYCStatus.inProgress;
      case auth_enum.KYCVerificationStatus.KYC_STATUS_PENDING_REVIEW: return KYCStatus.pendingReview;
      case auth_enum.KYCVerificationStatus.KYC_STATUS_REJECTED: return KYCStatus.rejected;
      case auth_enum.KYCVerificationStatus.KYC_STATUS_EXPIRED: return KYCStatus.expired;
      case auth_enum.KYCVerificationStatus.KYC_STATUS_NOT_STARTED: return KYCStatus.notStarted;
      default: return KYCStatus.inProgress;
    }
  }

  /// Mask phone number for display (e.g., 0812****5678)
  String _maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 8) {
      // For short numbers, mask all but first 2 and last 2
      if (phoneNumber.length <= 4) return '****';
      return '${phoneNumber.substring(0, 2)}${'*' * (phoneNumber.length - 4)}${phoneNumber.substring(phoneNumber.length - 2)}';
    }
    return '${phoneNumber.substring(0, 4)}****${phoneNumber.substring(phoneNumber.length - 4)}';
  }
}
