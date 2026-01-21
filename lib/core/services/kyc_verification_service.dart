import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/country_config.dart'
    show
        CountryConfigs,
        KycLevel,
        IdentityDocumentType,
        DocumentRequirement;

/// Verification status
enum VerificationStatus {
  pending,
  inProgress,
  approved,
  rejected,
  requiresManualReview,
  failed,
}

/// Document upload result
class DocumentUploadResult {
  final String documentId;
  final String? extractedData;
  final String? errorMessage;

  const DocumentUploadResult({
    required this.documentId,
    this.extractedData,
    this.errorMessage,
  });

  factory DocumentUploadResult.success(String documentId, String? extractedData) {
    return DocumentUploadResult(
      documentId: documentId,
      extractedData: extractedData,
    );
  }

  factory DocumentUploadResult.failure(String errorMessage) {
    return DocumentUploadResult(errorMessage: errorMessage, documentId: '');
  }

  bool get isSuccess => errorMessage == null;
}

/// KYC verification result
class KycVerificationResult {
  final String verificationId;
  final VerificationStatus status;
  final KycLevel achievedLevel;
  final Map<String, dynamic>? extractedData;
  final String? errorMessage;

  const KycVerificationResult({
    required this.verificationId,
    required this.status,
    required this.achievedLevel,
    this.extractedData,
    this.errorMessage,
  });

  factory KycVerificationResult.success({
    required String verificationId,
    required KycLevel achievedLevel,
    Map<String, dynamic>? extractedData,
  }) {
    return KycVerificationResult(
      verificationId: verificationId,
      status: VerificationStatus.approved,
      achievedLevel: achievedLevel,
      extractedData: extractedData,
    );
  }

  factory KycVerificationResult.pending({
    required String verificationId,
    required KycLevel currentLevel,
  }) {
    return KycVerificationResult(
      verificationId: verificationId,
      status: VerificationStatus.pending,
      achievedLevel: currentLevel,
    );
  }

  factory KycVerificationResult.failure(String errorMessage) {
    return KycVerificationResult(
      verificationId: '',
      status: VerificationStatus.failed,
      achievedLevel: KycLevel.basic,
      errorMessage: errorMessage,
    );
  }

  bool get isSuccess => status == VerificationStatus.approved;
  bool get isPending => status == VerificationStatus.pending;
}

/// Service for KYC verification operations
class KycVerificationService {
  static String get _defaultApiUrl =>
      dotenv.env['KYC_API_URL'] ??
      dotenv.env['CHAT_GATEWAY_URL'] ??
      'https://api.lazervault.com/v1';

  static String get _defaultApiKey =>
      dotenv.env['KYC_API_KEY'] ??
      dotenv.env['API_KEY'] ??
      '';

  final String baseUrl;
  final String apiKey;

  KycVerificationService({
    String? baseUrl,
    String? apiKey,
  })  : baseUrl = baseUrl ?? _defaultApiUrl,
        apiKey = apiKey ?? _defaultApiKey;

  /// Create a new verification session
  Future<KycVerificationResult> createVerification({
    required String userId,
    required String countryCode,
    required KycLevel targetLevel,
    Map<String, dynamic>? userData,
  }) async {
    try {
      final countryConfig = CountryConfigs.getByCode(countryCode);
      if (countryConfig == null) {
        return KycVerificationResult.failure('Country not supported');
      }

      // Check if country is active for signup
      if (!countryConfig.isAvailableForSignup) {
        return KycVerificationResult.failure('Country not available for signup');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/kyc/verification'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'user_id': userId,
          'country_code': countryCode,
          'target_level': targetLevel.level,
          'user_data': userData,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return KycVerificationResult.pending(
          verificationId: data['verification_id'] as String,
          currentLevel: KycLevel.basic,
        );
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return KycVerificationResult.failure(
          error['message'] ?? 'Invalid request',
        );
      } else {
        return KycVerificationResult.failure(
          'Failed to create verification: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating verification: $e');
      }
      // Only use mock in development mode
      final isDev = dotenv.env['ENVIRONMENT'] == 'development' ||
                   dotenv.env['ENVIRONMENT'] == 'dev';
      if (isDev) {
        return KycVerificationResult.pending(
          verificationId: 'mock_verification_${DateTime.now().millisecondsSinceEpoch}',
          currentLevel: KycLevel.basic,
        );
      }
      return KycVerificationResult.failure(
        'Failed to create verification: ${e.toString()}',
      );
    }
  }

  /// Upload a document for verification
  Future<DocumentUploadResult> uploadDocument({
    required String verificationId,
    required File imageFile,
    required IdentityDocumentType documentType,
    required DocumentSide side,
  }) async {
    try {
      // Read image file
      final imageBytes = await imageFile.readAsBytes();

      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/kyc/verification/$verificationId/documents'),
      );

      // Add headers
      request.headers['Authorization'] = 'Bearer $apiKey';

      // Add fields
      request.fields['document_type'] = documentType.id;
      request.fields['side'] = side.name;

      // Add file
      request.files.add(http.MultipartFile.fromBytes(
        'document',
        imageBytes,
        filename: 'document_${side.name}.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return DocumentUploadResult.success(
          data['document_id'] as String,
          data['extracted_data'] as String?,
        );
      } else {
        final error = jsonDecode(response.body);
        return DocumentUploadResult.failure(
          error['message'] ?? 'Upload failed',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading document: $e');
      }
      // Only use mock in development mode
      final isDev = dotenv.env['ENVIRONMENT'] == 'development' ||
                   dotenv.env['ENVIRONMENT'] == 'dev';
      if (isDev) {
        return DocumentUploadResult.success(
          'mock_doc_${DateTime.now().millisecondsSinceEpoch}',
          null,
        );
      }
      return DocumentUploadResult.failure(
        'Failed to upload document: ${e.toString()}',
      );
    }
  }

  /// Upload selfie for liveness verification
  Future<DocumentUploadResult> uploadSelfie({
    required String verificationId,
    required File selfieImage,
  }) async {
    try {
      final imageBytes = await selfieImage.readAsBytes();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/kyc/verification/$verificationId/selfie'),
      );

      request.headers['Authorization'] = 'Bearer $apiKey';

      request.files.add(http.MultipartFile.fromBytes(
        'selfie',
        imageBytes,
        filename: 'selfie.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return DocumentUploadResult.success(
          data['selfie_id'] as String,
          null,
        );
      } else {
        final error = jsonDecode(response.body);
        return DocumentUploadResult.failure(
          error['message'] ?? 'Selfie upload failed',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading selfie: $e');
      }
      // Only use mock in development mode
      final isDev = dotenv.env['ENVIRONMENT'] == 'development' ||
                   dotenv.env['ENVIRONMENT'] == 'dev';
      if (isDev) {
        return DocumentUploadResult.success(
          'mock_selfie_${DateTime.now().millisecondsSinceEpoch}',
          null,
        );
      }
      return DocumentUploadResult.failure(
        'Failed to upload selfie: ${e.toString()}',
      );
    }
  }

  /// Submit verification for processing
  Future<KycVerificationResult> submitVerification({
    required String verificationId,
    Map<String, dynamic>? manualData,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/kyc/verification/$verificationId/submit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          if (manualData != null) 'manual_data': manualData,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final status = _parseVerificationStatus(data['status'] as String?);
        final level = _parseKycLevel(data['achieved_level'] as int?);

        return KycVerificationResult(
          verificationId: verificationId,
          status: status,
          achievedLevel: level,
          extractedData: data['extracted_data'] as Map<String, dynamic>?,
        );
      } else {
        final error = jsonDecode(response.body);
        return KycVerificationResult.failure(
          error['message'] ?? 'Submission failed',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting verification: $e');
      }
      return KycVerificationResult.pending(
        verificationId: verificationId,
        currentLevel: KycLevel.basic,
      );
    }
  }

  /// Get verification status
  Future<KycVerificationResult?> getVerificationStatus(
    String verificationId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/kyc/verification/$verificationId'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final status = _parseVerificationStatus(data['status'] as String?);
        final level = _parseKycLevel(data['achieved_level'] as int?);

        return KycVerificationResult(
          verificationId: verificationId,
          status: status,
          achievedLevel: level,
          extractedData: data['extracted_data'] as Map<String, dynamic>?,
        );
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting verification status: $e');
      }
      return null;
    }
  }

  /// Verify identity using ID number (for countries that support API verification)
  Future<KycVerificationResult> verifyIdentityWithApi({
    required String countryCode,
    required IdentityDocumentType documentType,
    required String documentNumber,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
  }) async {
    try {
      final countryConfig = CountryConfigs.getByCode(countryCode);
      if (countryConfig == null) {
        return KycVerificationResult.failure('Country not supported');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/kyc/identity-verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'country_code': countryCode,
          'document_type': documentType.id,
          'document_number': documentNumber,
          if (firstName != null) 'first_name': firstName,
          if (lastName != null) 'last_name': lastName,
          if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final verified = data['verified'] as bool? ?? false;

        if (verified) {
          return KycVerificationResult.success(
            verificationId: data['verification_id'] as String? ?? '',
            achievedLevel: KycLevel.standard,
            extractedData: data['data'] as Map<String, dynamic>?,
          );
        } else {
          return KycVerificationResult.failure(
            data['reason'] as String? ?? 'Verification failed',
          );
        }
      } else {
        final error = jsonDecode(response.body);
        return KycVerificationResult.failure(
          error['message'] ?? 'Verification failed',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying identity: $e');
      }
      return KycVerificationResult.failure('Verification error: $e');
    }
  }

  /// Upload proof of address document
  Future<DocumentUploadResult> uploadProofOfAddress({
    required String verificationId,
    required File documentFile,
    required String addressLine1,
    required String city,
    required String postalCode,
  }) async {
    try {
      final imageBytes = await documentFile.readAsBytes();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/kyc/verification/$verificationId/address'),
      );

      request.headers['Authorization'] = 'Bearer $apiKey';

      request.fields['address_line1'] = addressLine1;
      request.fields['city'] = city;
      request.fields['postal_code'] = postalCode;

      request.files.add(http.MultipartFile.fromBytes(
        'document',
        imageBytes,
        filename: 'proof_of_address.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return DocumentUploadResult.success(
          data['document_id'] as String,
          null,
        );
      } else {
        final error = jsonDecode(response.body);
        return DocumentUploadResult.failure(
          error['message'] ?? 'Upload failed',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading proof of address: $e');
      }
      // Only use mock in development mode
      final isDev = dotenv.env['ENVIRONMENT'] == 'development' ||
                   dotenv.env['ENVIRONMENT'] == 'dev';
      if (isDev) {
        return DocumentUploadResult.success(
          'mock_address_${DateTime.now().millisecondsSinceEpoch}',
          null,
        );
      }
      return DocumentUploadResult.failure(
        'Failed to upload proof of address: ${e.toString()}',
      );
    }
  }

  /// Get required documents for a country and KYC level
  List<DocumentRequirement> getRequiredDocuments({
    required String countryCode,
    required KycLevel targetLevel,
  }) {
    final config = CountryConfigs.getByCode(countryCode);
    if (config == null) return [];

    return config.getRequirementsForLevel(targetLevel);
  }

  /// Check if a document type requires manual entry for a country
  bool requiresManualEntry({
    required String countryCode,
    required IdentityDocumentType documentType,
  }) {
    // Some document types require manual entry (like BVN, SSN)
    // while others support OCR extraction
    switch (documentType) {
      case IdentityDocumentType.bvn:
      case IdentityDocumentType.nin:
      case IdentityDocumentType.ssn:
      case IdentityDocumentType.ssnLast4:
      case IdentityDocumentType.niNumber:
        return true; // These require manual entry + API verification
      default:
        return false; // These support OCR extraction
    }
  }

  /// Parse verification status from API response
  VerificationStatus _parseVerificationStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return VerificationStatus.pending;
      case 'in_progress':
      case 'processing':
        return VerificationStatus.inProgress;
      case 'approved':
      case 'verified':
        return VerificationStatus.approved;
      case 'rejected':
      case 'failed':
        return VerificationStatus.rejected;
      case 'manual_review':
        return VerificationStatus.requiresManualReview;
      default:
        return VerificationStatus.pending;
    }
  }

  /// Parse KYC level from API response
  KycLevel _parseKycLevel(int? level) {
    switch (level) {
      case 1:
        return KycLevel.basic;
      case 2:
        return KycLevel.standard;
      case 3:
        return KycLevel.advanced;
      default:
        return KycLevel.basic;
    }
  }

  /// Get user-friendly error message for verification failures
  static String getUserErrorMessage(String errorCode) {
    final errorMessages = {
      'IMAGE_BLURRY': 'The image is blurry. Please take a clearer photo.',
      'IMAGE_DARK': 'The image is too dark. Please retake in better lighting.',
      'IMAGE_GLARE': 'There\'s glare on the document. Please retake.',
      'DOCUMENT_NOT_VISIBLE': 'Please ensure all corners of the document are visible.',
      'FACE_NOT_DETECTED': 'We couldn\'t detect a face. Please retake the selfie.',
      'FACE_MULTIPLE': 'Multiple faces detected. Please take the photo alone.',
      'DOCUMENT_TYPE_MISMATCH': 'The document doesn\'t match the selected type.',
      'EXPIRED_DOCUMENT': 'This document has expired. Please use a valid document.',
      'COUNTRY_NOT_SUPPORTED': 'This country is not currently supported.',
      'NETWORK_ERROR': 'Network error. Please check your connection and try again.',
    };

    return errorMessages[errorCode] ??
        'Verification failed. Please try again.';
  }
}

/// Document side for upload
enum DocumentSide {
  front,
  back,
}
