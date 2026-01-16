import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lazervault/src/features/voice_enrollment/data/grpc/voice_biometrics_client.dart';
import 'package:lazervault/src/features/voice_enrollment/data/voice_biometrics_service_config.dart';

/// Result of voice enrollment
class VoiceEnrollmentResult {
  final String enrollmentId;
  final double qualityScore;
  final int samplesCount;

  VoiceEnrollmentResult({
    required this.enrollmentId,
    required this.qualityScore,
    required this.samplesCount,
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

/// Repository for voice enrollment operations
@injectable
class VoiceEnrollmentRepository {
  final AudioRecorder _recorder = AudioRecorder();
  Timer? _amplitudeTimer;
  final StreamController<double> _amplitudeController = StreamController<double>.broadcast();
  String? _currentRecordingPath;

  // gRPC client (lazy loaded)
  VoiceBiometricsClient? _grpcClient;
  final VoiceBiometricsServiceConfig _config;

  VoiceEnrollmentRepository(this._config);

  /// Get or create gRPC client
  VoiceBiometricsClient _getGrpcClient() {
    _grpcClient ??= VoiceBiometricsClient(
      host: _config.host,
      port: _config.port,
      options: _config.options,
    );
    return _grpcClient!;
  }

  /// Check if microphone permission is granted
  Future<bool> checkMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }

  /// Request microphone permission
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Start recording audio
  Future<VoiceRecordingStream> startRecording() async {
    try {
      // Check permission first
      final hasPermission = await checkMicrophonePermission();
      if (!hasPermission) {
        throw Exception('Microphone permission not granted');
      }

      // Check if recorder is already recording
      if (await _recorder.isRecording()) {
        await _recorder.stop();
      }

      // Generate output file path
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _currentRecordingPath = '${tempDir.path}/voice_sample_$timestamp.wav';

      // Start recording
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: _currentRecordingPath!,
      );

      // Start amplitude monitoring for sound level visualization
      _startAmplitudeMonitoring();

      return VoiceRecordingStream(
        soundLevel: _amplitudeController.stream,
        stop: () => stopRecording(),
      );
    } catch (e) {
      throw Exception('Failed to start recording: $e');
    }
  }

  /// Start monitoring audio amplitude for visualization
  void _startAmplitudeMonitoring() {
    _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      try {
        if (await _recorder.isRecording()) {
          final amplitude = await _recorder.getAmplitude();
          // Convert amplitude to 0.0-1.0 range for visualization
          final normalizedLevel = _normalizeAmplitude(amplitude.current);
          _amplitudeController.add(normalizedLevel);
        }
      } catch (e) {
        // Silently handle errors during amplitude checking
      }
    });
  }

  /// Normalize amplitude to 0.0-1.0 range
  double _normalizeAmplitude(double amplitude) {
    // Typical amplitude range is -60dB to 0dB
    // Convert to 0.0-1.0 range
    final minDb = -60.0;
    final maxDb = 0.0;
    final normalized = (amplitude - minDb) / (maxDb - minDb);
    return normalized.clamp(0.0, 1.0);
  }

  /// Stop recording and return audio file
  Future<File> stopRecording() async {
    try {
      // Stop amplitude monitoring
      _amplitudeTimer?.cancel();
      _amplitudeTimer = null;

      // Stop recording
      if (await _recorder.isRecording()) {
        await _recorder.stop();
      }

      // Verify file exists
      if (_currentRecordingPath == null) {
        throw Exception('No recording path available');
      }

      final file = File(_currentRecordingPath!);
      if (!await file.exists()) {
        throw Exception('Recording file not found at $_currentRecordingPath');
      }

      // Log file size for debugging
      final fileSize = await file.length();
      print('Recording saved: ${file.path} ($fileSize bytes)');

      // Reset path for next recording
      _currentRecordingPath = null;

      return file;
    } catch (e) {
      throw Exception('Failed to stop recording: $e');
    }
  }

  /// Get current user ID from authentication
  Future<String> getCurrentUserId() async {
    // TODO: Get from authentication state
    // This should retrieve the actual logged-in user's ID
    // For now, returning a placeholder
    return 'user_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Enroll voice with audio samples (with retry logic)
  Future<VoiceEnrollmentResult> enrollVoice({
    required String userId,
    required List<File> audioSamples,
    int retryCount = 0,
    int maxRetries = 3,
  }) async {
    try {
      // Validate inputs (only on first attempt)
      if (retryCount == 0) {
        if (audioSamples.isEmpty) {
          throw Exception('No audio samples provided');
        }

        if (audioSamples.length < 3) {
          throw Exception('At least 3 audio samples required for enrollment');
        }

        // Verify all files exist
        for (var i = 0; i < audioSamples.length; i++) {
          final file = audioSamples[i];
          if (!await file.exists()) {
            throw Exception('Audio sample $i does not exist: ${file.path}');
          }

          final fileSize = await file.length();
          if (fileSize == 0) {
            throw Exception('Audio sample $i is empty: ${file.path}');
          }

          print('Sample $i: ${file.path} ($fileSize bytes)');
        }
      }

      // Read all audio files as bytes
      final audioBytes = await Future.wait(
        audioSamples.map((file) => file.readAsBytes()),
      );

      print('Calling voice biometrics service for enrollment...');
      print('User: $userId');
      print('Samples: ${audioBytes.length}');
      if (retryCount > 0) {
        print('Retry attempt: $retryCount/$maxRetries');
      }

      // Call gRPC service
      final response = await _getGrpcClient().enrollVoice(
        userId: userId,
        audioSamples: audioBytes,
        codec: 'wav',
        sampleRate: 16000,
        channels: 1,
        bitDepth: 16,
      );

      if (!response.success) {
        // Clean up files on failure
        await _cleanupAudioFiles(audioSamples);
        throw Exception('Enrollment failed: ${response.message}');
      }

      print('Voice enrollment successful: ${response.enrollmentId}');
      print('Quality score: ${response.qualityScore}');
      print('Samples processed: ${response.samplesCount}');

      // Clean up audio files after successful enrollment
      await _cleanupAudioFiles(audioSamples);

      return VoiceEnrollmentResult(
        enrollmentId: response.enrollmentId,
        qualityScore: response.qualityScore,
        samplesCount: response.samplesCount,
      );
    } catch (e) {
      print('Voice enrollment error: $e');

      // Check if error is retryable (network/service unavailable)
      final isNetworkError = _isNetworkError(e);

      // Retry logic with exponential backoff
      if (isNetworkError && retryCount < maxRetries) {
        final delaySeconds = 2 * (retryCount + 1); // 2s, 4s, 6s
        print('Network error detected. Retrying in ${delaySeconds}s...');

        await Future.delayed(Duration(seconds: delaySeconds));

        // Retry the enrollment
        return enrollVoice(
          userId: userId,
          audioSamples: audioSamples,
          retryCount: retryCount + 1,
          maxRetries: maxRetries,
        );
      }

      // Clean up files on final error
      await _cleanupAudioFiles(audioSamples);

      if (retryCount >= maxRetries) {
        throw Exception(
            'Voice enrollment failed after $maxRetries retries: $e');
      }

      throw Exception('Voice enrollment failed: $e');
    }
  }

  /// Check if error is a network/connectivity error that can be retried
  bool _isNetworkError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('network') ||
        errorString.contains('connection') ||
        errorString.contains('timeout') ||
        errorString.contains('unavailable') ||
        errorString.contains('refused') ||
        errorString.contains('unreachable');
  }

  /// Clean up audio files after enrollment (security best practice)
  Future<void> _cleanupAudioFiles(List<File> files) async {
    try {
      for (final file in files) {
        if (await file.exists()) {
          await file.delete();
          print('Cleaned up audio file: ${file.path}');
        }
      }
    } catch (e) {
      print('Warning: Failed to clean up some audio files: $e');
      // Don't throw - cleanup failure shouldn't break the flow
    }
  }

  /// Clean up old/unused voice samples from temp directory
  Future<void> cleanupOldVoiceSamples() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final entities = tempDir.listSync();

      int cleanedCount = 0;
      for (final entity in entities) {
        if (entity.path.contains('voice_sample_')) {
          final file = File(entity.path);
          // Delete files older than 1 hour
          final stat = await file.stat();
          final age = DateTime.now().difference(stat.modified);
          if (age.inHours > 1) {
            await file.delete();
            cleanedCount++;
          }
        }
      }

      if (cleanedCount > 0) {
        print('Cleaned up $cleanedCount old voice sample files');
      }
    } catch (e) {
      print('Warning: Failed to clean up old voice samples: $e');
    }
  }

  /// Check voice enrollment status
  Future<bool> checkEnrollmentStatus(String userId) async {
    try {
      print('Checking enrollment status for user: $userId');

      final response = await _getGrpcClient().checkEnrollmentStatus(
        userId: userId,
      );

      print('Enrollment status: ${response.isEnrolled}');
      if (response.isEnrolled) {
        print('Enrollment ID: ${response.enrollmentId}');
        print('Quality score: ${response.qualityScore}');
        print('Samples: ${response.samplesCount}');
      }

      return response.isEnrolled;
    } catch (e) {
      print('Error checking enrollment status: $e');
      // Return false on error so user can attempt enrollment
      return false;
    }
  }

  /// Clean up resources
  void dispose() {
    _amplitudeTimer?.cancel();
    _amplitudeController.close();
    _grpcClient?.shutdown();
    // Clean up any lingering audio files
    cleanupOldVoiceSamples();
  }
}
