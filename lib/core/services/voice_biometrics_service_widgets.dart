part of 'voice_biometrics_service.dart';

/// Voice enrollment status
class VoiceEnrollmentStatus {
  final bool isEnrolled;
  final String? enrollmentId;
  final int? enrolledAt;
  final int? samplesCount;
  final double? qualityScore;

  VoiceEnrollmentStatus({
    required this.isEnrolled,
    this.enrollmentId,
    this.enrolledAt,
    this.samplesCount,
    this.qualityScore,
  });

  factory VoiceEnrollmentStatus.fromJson(Map<String, dynamic> json) {
    try {
      return VoiceEnrollmentStatus(
        isEnrolled: json['is_enrolled'] == true,
        enrollmentId: json['enrollment_id'] as String?,
        enrolledAt: json['enrolled_at'] as int?,
        samplesCount: json['samples_count'] as int?,
        qualityScore: (json['quality_score'] as num?)?.toDouble(),
      );
    } catch (e) {
      throw VoiceBiometricsException('Invalid enrollment status format: $e');
    }
  }

  @override
  String toString() {
    return 'VoiceEnrollmentStatus(isEnrolled: $isEnrolled, enrollmentId: $enrollmentId, qualityScore: $qualityScore)';
  }
}

/// Voice enrollment result
class VoiceEnrollmentResult {
  final bool success;
  final String? enrollmentId;
  final int? samplesCount;
  final double? qualityScore;
  final String? message;

  VoiceEnrollmentResult({
    required this.success,
    this.enrollmentId,
    this.samplesCount,
    this.qualityScore,
    this.message,
  });

  factory VoiceEnrollmentResult.fromJson(Map<String, dynamic> json) {
    try {
      return VoiceEnrollmentResult(
        success: json['success'] == true,
        enrollmentId: json['enrollment_id'] as String?,
        samplesCount: json['samples_count'] as int?,
        qualityScore: (json['quality_score'] as num?)?.toDouble(),
        message: json['message'] as String?,
      );
    } catch (e) {
      throw VoiceBiometricsException('Invalid enrollment result format: $e');
    }
  }

  @override
  String toString() {
    return 'VoiceEnrollmentResult(success: $success, qualityScore: $qualityScore, message: $message)';
  }
}

/// Result of a server-attested voice LOGIN (voice = password). On success it
/// carries a FRESH minted session the caller persists like a passcode login.
class VoiceLoginResult {
  final bool verified;
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  final int? expiresIn;
  final String? firstName;
  final String? lastName;
  final double? similarityScore;
  /// Failure classifier when not verified: VOICE_NOT_RECOGNIZED / NOT_ENROLLED
  /// / IDENTITY_MISMATCH / ERROR.
  final String? status;

  VoiceLoginResult({
    required this.verified,
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.expiresIn,
    this.firstName,
    this.lastName,
    this.similarityScore,
    this.status,
  });

  bool get hasSession =>
      verified &&
      (accessToken?.isNotEmpty ?? false) &&
      (refreshToken?.isNotEmpty ?? false);
  bool get isNotEnrolled => status == 'NOT_ENROLLED';

  factory VoiceLoginResult.fromJson(Map<String, dynamic> json) => VoiceLoginResult(
        verified: json['verified'] == true,
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
        userId: json['user_id'] as String?,
        expiresIn: (json['expires_in'] as num?)?.toInt(),
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        similarityScore: (json['similarity_score'] as num?)?.toDouble(),
        status: json['status'] as String?,
      );
}

/// Voice verification result
class VoiceVerificationResult {
  final bool verified;
  final double? similarityScore;
  final double? confidence;
  final String? message;
  final String? status;
  final int? timestamp;

  VoiceVerificationResult({
    required this.verified,
    this.similarityScore,
    this.confidence,
    this.message,
    this.status,
    this.timestamp,
  });

  factory VoiceVerificationResult.fromJson(Map<String, dynamic> json) {
    try {
      return VoiceVerificationResult(
        verified: json['verified'] == true,
        similarityScore: (json['similarity_score'] as num?)?.toDouble(),
        confidence: (json['confidence'] as num?)?.toDouble(),
        message: json['message'] as String?,
        status: json['status'] as String?,
        timestamp: json['timestamp'] as int?,
      );
    } catch (e) {
      throw VoiceBiometricsException('Invalid verification result format: $e');
    }
  }

  /// Get similarity percentage (0-100)
  double get similarityPercentage => (similarityScore ?? 0) * 100;

  /// Check if verification failed due to no enrollment
  bool get isNotEnrolled => status == 'VERIFICATION_NO_ENROLLMENT';

  /// Check if verification failed due to poor quality
  bool get isPoorQuality => status == 'VERIFICATION_POOR_QUALITY';

  /// Check if verification failed due to threshold
  bool get isBelowThreshold => status == 'VERIFICATION_THRESHOLD_NOT_MET';

  @override
  String toString() {
    return 'VoiceVerificationResult(verified: $verified, similarity: ${similarityPercentage.toStringAsFixed(1)}%, message: $message)';
  }
}

/// Base voice biometrics exception
class VoiceBiometricsException implements Exception {
  final String message;

  VoiceBiometricsException(this.message);

  @override
  String toString() => message;

  /// Get user-friendly error message
  String get userMessage {
    if (message.contains('cannot be empty')) {
      return 'Missing required information';
    } else if (message.contains('At least 3 audio samples')) {
      return 'Please record at least 3 voice samples';
    } else if (message.contains('too large')) {
      return 'Audio file is too large. Please try again';
    } else if (message.contains('Invalid')) {
      return 'Invalid input. Please try again';
    } else {
      return 'An error occurred. Please try again';
    }
  }
}

/// Network-related exception
class VoiceBiometricsNetworkException extends VoiceBiometricsException {
  VoiceBiometricsNetworkException(super.message);

  @override
  String get userMessage {
    if (message.contains('No internet')) {
      return 'No internet connection. Please check your network';
    } else if (message.contains('timed out')) {
      return 'Request timed out. Please try again';
    } else {
      return 'Network error. Please check your connection';
    }
  }
}

/// Server error exception
class VoiceBiometricsServerException extends VoiceBiometricsException {
  final int? statusCode;

  VoiceBiometricsServerException(
    super.message, {
    this.statusCode,
  });

  @override
  String get userMessage {
    if (statusCode == 503) {
      return 'Service temporarily unavailable. Please try again later';
    } else if (statusCode == 500) {
      return 'Server error. Please try again later';
    } else {
      return 'Service error. Please try again';
    }
  }
}
