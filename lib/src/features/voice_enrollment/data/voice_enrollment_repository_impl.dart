import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/generated/voice-biometrics.pbgrpc.dart';
import 'package:lazervault/src/features/voice_enrollment/domain/repositories/voice_enrollment_repository.dart';

/// Repository for voice enrollment operations using real gRPC backend
@injectable
class VoiceEnrollmentRepositoryImpl implements VoiceEnrollmentRepository {
  final VoiceBiometricsServiceClient _voiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final SecureStorageService _secureStorage;

  final AudioRecorder _recorder = AudioRecorder();
  Timer? _amplitudeTimer;
  final StreamController<double> _amplitudeController = StreamController<double>.broadcast();
  String? _currentRecordingPath;

  VoiceEnrollmentRepositoryImpl(
    this._voiceClient,
    this._callOptionsHelper,
    this._secureStorage,
  );

  /// Check if microphone permission is granted
  @override
  Future<bool> checkMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }

  /// Request microphone permission
  @override
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Start recording audio
  @override
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

      // Start recording with settings optimized for voice biometrics
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000, // Standard for voice recognition
          numChannels: 1,     // Mono audio
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
  @override
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

      // Validate file size (should be at least 10KB for a meaningful recording)
      if (fileSize < 10000) {
        throw Exception('Recording too short or empty ($fileSize bytes)');
      }

      // Reset path for next recording
      _currentRecordingPath = null;

      return file;
    } catch (e) {
      throw Exception('Failed to stop recording: $e');
    }
  }

  /// Get current user ID from secure storage
  @override
  Future<String> getCurrentUserId() async {
    try {
      // First try reading the stored user ID directly (set during login)
      final storedUserId = await _secureStorage.getUserId();
      if (storedUserId != null && storedUserId.isNotEmpty) {
        return storedUserId;
      }

      // Fallback: extract from JWT token payload
      final token = await _secureStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        final userId = _extractUserIdFromToken(token);
        if (userId.isNotEmpty) {
          return userId;
        }
      }

      throw Exception('User ID not found in storage or token');
    } catch (e) {
      throw Exception('Failed to get current user ID: $e');
    }
  }

  /// Extract user ID from JWT token by decoding the payload (base64 middle segment)
  String _extractUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return '';

      // Pad base64 if needed
      String payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }

      final decoded = utf8.decode(base64Url.decode(payload));
      final Map<String, dynamic> claims = jsonDecode(decoded);

      // Try 'sub' first (standard JWT claim), then 'user_id'
      return (claims['sub'] ?? claims['user_id'] ?? '').toString();
    } catch (e) {
      return '';
    }
  }

  /// Enroll voice with audio samples via gRPC
  @override
  Future<VoiceEnrollmentResult> enrollVoice({
    required String userId,
    required List<File> audioSamples,
  }) async {
    try {
      print('🎙️  Starting voice enrollment for user: $userId');

      // Validate inputs
      if (audioSamples.isEmpty) {
        throw Exception('No audio samples provided');
      }

      if (audioSamples.length < 3) {
        throw Exception('At least 3 audio samples required for enrollment');
      }

      // Verify all files exist and read as bytes
      final audioBytes = <List<int>>[];
      for (var i = 0; i < audioSamples.length; i++) {
        final file = audioSamples[i];
        if (!await file.exists()) {
          throw Exception('Audio sample $i does not exist: ${file.path}');
        }

        final fileSize = await file.length();
        if (fileSize == 0) {
          throw Exception('Audio sample $i is empty: ${file.path}');
        }

        // Read file as bytes
        final bytes = await file.readAsBytes();
        audioBytes.add(bytes);
        print('✅ Loaded sample $i: $fileSize bytes');
      }

      // Create enrollment request
      final request = EnrollVoiceRequest()
        ..userId = userId
        ..audioSamples.addAll(audioBytes)
        ..format = (AudioFormat()
          ..codec = 'wav'
          ..sampleRate = 16000
          ..channels = 1
          ..bitDepth = 16);

      print('📤 Sending enrollment request to voice-biometrics service...');

      // Get call options with authentication
      final callOptions = await _callOptionsHelper.withAuth();

      // Call voice biometrics service
      final response = await _voiceClient.enrollVoice(
        request,
        options: callOptions,
      );

      print('📥 Enrollment response received');
      print('   - Success: ${response.success}');
      print('   - Enrollment ID: ${response.enrollmentId}');
      print('   - Quality Score: ${response.qualityScore}');
      print('   - Samples Count: ${response.samplesCount}');

      if (!response.success) {
        throw Exception(response.message.isNotEmpty
          ? response.message
          : 'Voice enrollment failed');
      }

      return VoiceEnrollmentResult(
        enrollmentId: response.enrollmentId,
        qualityScore: response.qualityScore.toDouble(),
        samplesCount: response.samplesCount,
        success: response.success,
        message: response.message,
      );
    } on GrpcError catch (e) {
      print('❌ gRPC Error during enrollment: ${e.code} - ${e.message}');
      throw Exception('Voice enrollment failed: ${e.message}');
    } catch (e) {
      print('❌ Error during enrollment: $e');
      throw Exception('Voice enrollment failed: $e');
    }
  }

  /// Check voice enrollment status via gRPC
  @override
  Future<bool> checkEnrollmentStatus(String userId) async {
    try {
      print('🔍 Checking enrollment status for user: $userId');

      final request = CheckEnrollmentStatusRequest()
        ..userId = userId;

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _voiceClient.checkEnrollmentStatus(
        request,
        options: callOptions,
      );

      print('✅ Enrollment status: ${response.isEnrolled}');

      return response.isEnrolled;
    } on GrpcError catch (e) {
      print('❌ gRPC Error checking enrollment: ${e.code} - ${e.message}');
      // If user not found or service unavailable, return false (not enrolled)
      return false;
    } catch (e) {
      print('❌ Error checking enrollment status: $e');
      return false;
    }
  }

  /// Delete voice enrollment
  @override
  Future<bool> deleteEnrollment(String userId) async {
    try {
      final request = DeleteVoiceEnrollmentRequest()
        ..userId = userId;

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _voiceClient.deleteVoiceEnrollment(
        request,
        options: callOptions,
      );

      return response.success;
    } on GrpcError catch (e) {
      print('❌ gRPC Error deleting enrollment: ${e.code} - ${e.message}');
      throw Exception('Failed to delete enrollment: ${e.message}');
    } catch (e) {
      print('❌ Error deleting enrollment: $e');
      throw Exception('Failed to delete enrollment: $e');
    }
  }

  /// Clean up resources
  @override
  void dispose() {
    _amplitudeTimer?.cancel();
    _amplitudeController.close();
    _recorder.dispose();
  }
}
