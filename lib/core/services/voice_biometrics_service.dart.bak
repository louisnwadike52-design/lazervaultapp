import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// Voice Biometrics Service for speaker recognition and verification
/// Communicates with voice-agent-gateway for voice enrollment and authentication
///
/// Production-ready with:
/// - Comprehensive error handling
/// - Retry mechanisms
/// - Network connectivity checks
/// - Timeout management
/// - Input validation
class VoiceBiometricsService {
  final String baseUrl;
  final http.Client _client;
  final Duration timeout;
  final int maxRetries;

  VoiceBiometricsService({
    required this.baseUrl,
    http.Client? client,
    this.timeout = const Duration(seconds: 30),
    this.maxRetries = 3,
  }) : _client = client ?? http.Client() {
    if (baseUrl.isEmpty) {
      throw VoiceBiometricsException('baseUrl cannot be empty');
    }
  }

  /// Check if user has enrolled their voice
  Future<VoiceEnrollmentStatus> checkEnrollmentStatus(String userId) async {
    if (userId.isEmpty) {
      throw VoiceBiometricsException('userId cannot be empty');
    }

    try {
      final uri = Uri.parse('$baseUrl/voice/auth/status').replace(
        queryParameters: {'user_id': userId},
      );

      final response = await _retryRequest(
        () => _client.get(
          uri,
          headers: _buildHeaders(),
        ).timeout(timeout),
      );

      if (response.statusCode == 200) {
        final data = _parseJson(response.body);
        return VoiceEnrollmentStatus.fromJson(data);
      } else if (response.statusCode == 404) {
        // User not found - return not enrolled
        return VoiceEnrollmentStatus(isEnrolled: false);
      } else if (response.statusCode >= 500) {
        throw VoiceBiometricsServerException(
          'Server error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      } else {
        throw VoiceBiometricsException(
          'Failed to check enrollment status: ${response.statusCode} - ${response.body}',
        );
      }
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException(
        'No internet connection: ${e.message}',
      );
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
        'Request timed out after ${timeout.inSeconds} seconds',
      );
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException(
        'Network error: ${e.message}',
      );
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error checking enrollment: $e');
    }
  }

  /// Enroll user's voice with multiple samples
  Future<VoiceEnrollmentResult> enrollVoice({
    required String userId,
    required List<Uint8List> audioSamples,
    int sampleRate = 16000,
    int channels = 1,
  }) async {
    // Input validation
    if (userId.isEmpty) {
      throw VoiceBiometricsException('userId cannot be empty');
    }

    if (audioSamples.isEmpty) {
      throw VoiceBiometricsException('audioSamples cannot be empty');
    }

    if (audioSamples.length < 3) {
      throw VoiceBiometricsException(
        'At least 3 audio samples required, got ${audioSamples.length}',
      );
    }

    if (audioSamples.length > 10) {
      throw VoiceBiometricsException(
        'Maximum 10 audio samples allowed, got ${audioSamples.length}',
      );
    }

    if (sampleRate < 8000 || sampleRate > 48000) {
      throw VoiceBiometricsException(
        'Invalid sample rate: $sampleRate (must be 8000-48000)',
      );
    }

    if (channels < 1 || channels > 2) {
      throw VoiceBiometricsException(
        'Invalid channels: $channels (must be 1 or 2)',
      );
    }

    // Validate audio sample sizes
    for (int i = 0; i < audioSamples.length; i++) {
      if (audioSamples[i].isEmpty) {
        throw VoiceBiometricsException('Audio sample $i is empty');
      }
      if (audioSamples[i].length > 10 * 1024 * 1024) {
        // 10MB max per sample
        throw VoiceBiometricsException(
          'Audio sample $i is too large (max 10MB)',
        );
      }
    }

    try {
      // Convert audio samples to base64
      final encodedSamples = audioSamples
          .map((sample) => base64Encode(sample))
          .toList();

      final body = {
        'user_id': userId,
        'audio_samples': encodedSamples,
        'sample_rate': sampleRate,
        'channels': channels,
      };

      final uri = Uri.parse('$baseUrl/voice/auth/enroll');

      final response = await _retryRequest(
        () => _client.post(
          uri,
          headers: _buildHeaders(),
          body: json.encode(body),
        ).timeout(timeout * 2), // Double timeout for enrollment
      );

      if (response.statusCode == 200) {
        final data = _parseJson(response.body);
        return VoiceEnrollmentResult.fromJson(data);
      } else if (response.statusCode == 409) {
        // Already enrolled
        final data = _parseJson(response.body);
        throw VoiceBiometricsException(
          data['error'] ?? 'User already enrolled',
        );
      } else if (response.statusCode >= 500) {
        throw VoiceBiometricsServerException(
          'Server error during enrollment: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      } else {
        final data = _parseJson(response.body);
        throw VoiceBiometricsException(
          data['error'] ?? 'Enrollment failed: ${response.statusCode}',
        );
      }
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException(
        'No internet connection: ${e.message}',
      );
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
        'Enrollment timed out after ${timeout.inSeconds * 2} seconds',
      );
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException(
        'Network error during enrollment: ${e.message}',
      );
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error enrolling voice: $e');
    }
  }

  /// Verify user's voice against enrolled voiceprint
  Future<VoiceVerificationResult> verifyVoice({
    required String userId,
    required Uint8List audioSample,
    double threshold = 0.85,
  }) async {
    // Input validation
    if (userId.isEmpty) {
      throw VoiceBiometricsException('userId cannot be empty');
    }

    if (audioSample.isEmpty) {
      throw VoiceBiometricsException('audioSample cannot be empty');
    }

    if (audioSample.length > 10 * 1024 * 1024) {
      // 10MB max
      throw VoiceBiometricsException('Audio sample is too large (max 10MB)');
    }

    if (threshold < 0.0 || threshold > 1.0) {
      throw VoiceBiometricsException(
        'Invalid threshold: $threshold (must be 0.0-1.0)',
      );
    }

    try {
      final encodedSample = base64Encode(audioSample);

      final body = {
        'user_id': userId,
        'audio_sample': encodedSample,
        'threshold': threshold,
      };

      final uri = Uri.parse('$baseUrl/voice/auth/verify');

      final response = await _retryRequest(
        () => _client.post(
          uri,
          headers: _buildHeaders(),
          body: json.encode(body),
        ).timeout(timeout),
      );

      if (response.statusCode == 200) {
        final data = _parseJson(response.body);
        return VoiceVerificationResult.fromJson(data);
      } else if (response.statusCode == 404) {
        // User not enrolled
        return VoiceVerificationResult(
          verified: false,
          message: 'User has not enrolled voice',
          status: 'VERIFICATION_NO_ENROLLMENT',
        );
      } else if (response.statusCode >= 500) {
        throw VoiceBiometricsServerException(
          'Server error during verification: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      } else {
        final data = _parseJson(response.body);
        throw VoiceBiometricsException(
          data['error'] ?? 'Verification failed: ${response.statusCode}',
        );
      }
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException(
        'No internet connection: ${e.message}',
      );
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
        'Verification timed out after ${timeout.inSeconds} seconds',
      );
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException(
        'Network error during verification: ${e.message}',
      );
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error verifying voice: $e');
    }
  }

  /// Delete user's voice enrollment
  Future<bool> deleteVoiceEnrollment(String userId) async {
    if (userId.isEmpty) {
      throw VoiceBiometricsException('userId cannot be empty');
    }

    try {
      final uri = Uri.parse('$baseUrl/voice/auth/enroll').replace(
        queryParameters: {'user_id': userId},
      );

      final response = await _retryRequest(
        () => _client.delete(
          uri,
          headers: _buildHeaders(),
        ).timeout(timeout),
      );

      if (response.statusCode == 200) {
        final data = _parseJson(response.body);
        return data['success'] == true;
      } else if (response.statusCode == 404) {
        // Not enrolled - consider it success
        return true;
      } else if (response.statusCode >= 500) {
        throw VoiceBiometricsServerException(
          'Server error during deletion: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      } else {
        throw VoiceBiometricsException(
          'Failed to delete enrollment: ${response.statusCode}',
        );
      }
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException(
        'No internet connection: ${e.message}',
      );
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
        'Deletion timed out after ${timeout.inSeconds} seconds',
      );
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException(
        'Network error during deletion: ${e.message}',
      );
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error deleting enrollment: $e');
    }
  }

  /// Build HTTP headers
  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// Parse JSON with error handling
  Map<String, dynamic> _parseJson(String body) {
    try {
      final decoded = json.decode(body);
      if (decoded is! Map<String, dynamic>) {
        throw VoiceBiometricsException('Invalid response format');
      }
      return decoded;
    } on FormatException catch (e) {
      throw VoiceBiometricsException('Invalid JSON response: ${e.message}');
    }
  }

  /// Retry request with exponential backoff
  Future<http.Response> _retryRequest(
    Future<http.Response> Function() request,
  ) async {
    int attempt = 0;
    Duration delay = const Duration(milliseconds: 500);

    while (attempt < maxRetries) {
      try {
        return await request();
      } on SocketException catch (_) {
        // Network error - retry with backoff
        if (attempt == maxRetries - 1) rethrow;

        attempt++;
        await Future.delayed(delay);
        delay *= 2; // Exponential backoff
      } on TimeoutException catch (_) {
        // Timeout - retry
        if (attempt == maxRetries - 1) rethrow;

        attempt++;
        await Future.delayed(delay);
        delay *= 2;
      } on http.ClientException catch (_) {
        // HTTP client error - retry
        if (attempt == maxRetries - 1) rethrow;

        attempt++;
        await Future.delayed(delay);
        delay *= 2;
      }
    }

    throw VoiceBiometricsException('Max retries exceeded');
  }

  /// Dispose resources
  void dispose() {
    _client.close();
  }
}

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
