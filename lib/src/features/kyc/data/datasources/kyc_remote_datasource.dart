import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/errors/exceptions.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/domain/repositories/kyc_repository.dart';

/// Remote data source for KYC operations
class KYCRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final FlutterSecureStorage storage;

  KYCRemoteDataSource({
    required this.client,
    required this.baseUrl,
    FlutterSecureStorage? storage,
  }) : storage = storage ?? const FlutterSecureStorage();

  /// Get KYC status from API
  Future<Map<String, dynamic>> getKYCStatus(String userId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/v1/kyc/status'),
      headers: {'user-id': userId},
    );

    if (response.statusCode == 200) {
      // In real implementation, parse JSON response
      return {
        'status': KYCStatus.notStarted,
        'current_tier': KYCTier.tier1,
        'tier_info': [],
        'documents': [],
      };
    } else {
      throw APIException(
        message: 'Failed to fetch KYC status',
        statusCode: response.statusCode,
      );
    }
  }

  /// Get country requirements from API
  Future<Map<String, dynamic>> getCountryRequirements(String countryCode) async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/v1/kyc/requirements/$countryCode'),
    );

    if (response.statusCode == 200) {
      // In real implementation, parse JSON response
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
    } else {
      throw APIException(
        message: 'Failed to fetch country requirements',
        statusCode: response.statusCode,
      );
    }
  }

  /// Initiate KYC verification
  Future<Map<String, dynamic>> initiateKYC({
    required String userId,
    required KYCTier targetTier,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/v1/kyc/initiate'),
      headers: {
        'Content-Type': 'application/json',
        'user-id': userId,
      },
      body: '''{
        "user_id": "$userId",
        "target_tier": ${targetTier.index}
      }''',
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'session_id': 'kyc_session_${DateTime.now().millisecondsSinceEpoch}',
        'required_documents': ['BVN or NIN', 'Selfie'],
        'required_fields': ['First Name', 'Last Name', 'Date of Birth'],
      };
    } else {
      throw APIException(
        message: 'Failed to initiate KYC',
        statusCode: response.statusCode,
      );
    }
  }

  /// Verify ID (BVN, NIN, etc.)
  /// Uses the auth-service /api/v1/auth/verify-identity endpoint
  Future<Map<String, dynamic>> verifyID(IDVerificationRequest request) async {
    // Get auth token from secure storage
    final token = await storage.read(key: 'auth_token');
    if (token == null || token.isEmpty) {
      throw APIException(
        message: 'Authentication token not found. Please log in again.',
        statusCode: 401,
      );
    }

    // Map IDType enum to proto IdentityType
    final identityType = request.idType == IDType.bvn ? 'IDENTITY_TYPE_BVN' : 'IDENTITY_TYPE_NIN';

    final response = await client.post(
      Uri.parse('$baseUrl/api/v1/auth/verify-identity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'identity_type': identityType,
        'identity_number': request.idNumber,
        'date_of_birth': request.dateOfBirth,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return {
        'success': data['success'] ?? true,
        'status': data['verified'] == true ? KYCStatus.approved : KYCStatus.inProgress,
        'current_tier': KYCTier.tier2,
        'message': data['error_message'] ?? 'Verification submitted successfully',
        'reference': data['virtual_account']?['account_number'],
      };
    } else if (response.statusCode == 401) {
      throw APIException(
        message: 'Session expired. Please log in again.',
        statusCode: response.statusCode,
      );
    } else if (response.statusCode == 422) {
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      throw APIException(
        message: data['error_message'] ?? 'ID verification failed. Please check your details.',
        statusCode: response.statusCode,
      );
    } else {
      throw APIException(
        message: 'Failed to verify ID',
        statusCode: response.statusCode,
      );
    }
  }

  /// Upload document
  Future<Map<String, dynamic>> uploadDocument(
    DocumentUploadRequest request,
  ) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/v1/kyc/upload-document'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '''{
        "user_id": "${request.userId}",
        "document_type": "${request.documentType.name}",
        "document_front_url": "${request.documentFrontUrl ?? ''}",
        "document_back_url": "${request.documentBackUrl ?? ''}",
        "selfie_url": "${request.selfieUrl ?? ''}"
      }''',
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'status': KYCStatus.inProgress,
        'message': 'Document uploaded successfully',
      };
    } else {
      throw APIException(
        message: 'Failed to upload document',
        statusCode: response.statusCode,
      );
    }
  }

  /// Skip KYC upgrade
  Future<Map<String, dynamic>> skipKYCUpgrade({
    required String userId,
    bool skipTier2 = true,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/v1/kyc/skip'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '''{
        "user_id": "$userId",
        "skip_tier_2": $skipTier2
      }''',
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'assigned_tier': KYCTier.tier1,
        'message': 'You can complete verification later in Settings',
        'next_steps': [
          'Go to Settings > Identity Verification',
          'Complete Tier 2 verification to increase limits',
        ],
      };
    } else {
      throw APIException(
        message: 'Failed to skip KYC',
        statusCode: response.statusCode,
      );
    }
  }
}
