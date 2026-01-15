import 'dart:io';

/// Result of voice enrollment
class VoiceEnrollmentResult {
  final String enrollmentId;
  final double qualityScore;
  final int samplesCount;
  final bool success;
  final String message;

  VoiceEnrollmentResult({
    required this.enrollmentId,
    required this.qualityScore,
    required this.samplesCount,
    required this.success,
    required this.message,
  });
}

/// Recording stream with sound level
class VoiceRecordingStream {
  final Stream<double> soundLevel;
  final Future<File> Function() stop;

  VoiceRecordingStream({
    required this.soundLevel,
    required this.stop,
  });
}

/// Abstract repository interface for voice enrollment operations
abstract class VoiceEnrollmentRepository {
  /// Check if microphone permission is granted
  Future<bool> checkMicrophonePermission();

  /// Request microphone permission
  Future<bool> requestMicrophonePermission();

  /// Start recording audio
  Future<VoiceRecordingStream> startRecording();

  /// Stop recording and return audio file
  Future<File> stopRecording();

  /// Get current user ID from authentication
  Future<String> getCurrentUserId();

  /// Enroll voice with audio samples
  Future<VoiceEnrollmentResult> enrollVoice({
    required String userId,
    required List<File> audioSamples,
  });

  /// Check voice enrollment status
  Future<bool> checkEnrollmentStatus(String userId);

  /// Delete voice enrollment
  Future<bool> deleteEnrollment(String userId);

  /// Clean up resources
  void dispose();
}
