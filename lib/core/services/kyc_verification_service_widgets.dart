part of 'kyc_verification_service.dart';

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

/// Document side for upload
enum DocumentSide {
  front,
  back,
}
