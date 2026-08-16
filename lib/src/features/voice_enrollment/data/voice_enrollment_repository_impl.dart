import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart' as vbs;
import 'package:lazervault/src/features/voice_enrollment/domain/repositories/voice_enrollment_repository.dart';

/// Repository for voice enrollment. Enrollment + status + delete all go over
/// the voice-agent-gateway HTTP path (`/voice/auth/*`) — the same reachable,
/// Cloudflare-routed transport the login/verify flow uses.
@injectable
class VoiceEnrollmentRepositoryImpl implements VoiceEnrollmentRepository {
  final SecureStorageService _secureStorage;

  final AudioRecorder _recorder = AudioRecorder();
  Timer? _amplitudeTimer;
  final StreamController<double> _amplitudeController = StreamController<double>.broadcast();
  String? _currentRecordingPath;

  VoiceEnrollmentRepositoryImpl(this._secureStorage);

  /// Check if microphone permission is granted
  @override
  Future<bool> checkMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }

  /// Request microphone permission
  @override
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    // Once permanently denied, request() is a no-op forever, so the enrollment
    // screen's "Grant Permission" button would loop with no effect. Route the
    // user to the app's settings page where they can actually flip it.
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
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

      // Stop any previous amplitude timer to prevent duplicates
      _amplitudeTimer?.cancel();
      _amplitudeTimer = null;

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
      // Clean up amplitude timer if recording setup failed after timer started
      _amplitudeTimer?.cancel();
      _amplitudeTimer = null;
      _currentRecordingPath = null;
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

      // Reset amplitude visualization to 0
      if (!_amplitudeController.isClosed) {
        _amplitudeController.add(0.0);
      }

      // Capture the path before any state changes
      final recordingPath = _currentRecordingPath;

      // Stop recording — the recorder.stop() may return the path as well
      String? stoppedPath;
      if (await _recorder.isRecording()) {
        stoppedPath = await _recorder.stop();
      }

      // Use the path from stop() if our stored path is null (race condition guard)
      final finalPath = recordingPath ?? stoppedPath;

      if (finalPath == null || finalPath.isEmpty) {
        throw Exception(
          'No recording path available. The recorder may not have been started properly. '
          'Please try recording again.',
        );
      }

      final file = File(finalPath);
      if (!await file.exists()) {
        throw Exception('Recording file not found at $finalPath');
      }

      // Log file size for debugging
      final fileSize = await file.length();
      print('Recording saved: ${file.path} ($fileSize bytes)');

      // Validate file size (should be at least 10KB for a meaningful recording)
      if (fileSize < 10000) {
        throw Exception('Recording too short or empty ($fileSize bytes). Please speak louder and try again.');
      }

      // Reset path for next recording
      _currentRecordingPath = null;

      return file;
    } catch (e) {
      // Clean up orphaned temp file on error
      final orphanPath = _currentRecordingPath;
      if (orphanPath != null) {
        try {
          final orphanFile = File(orphanPath);
          if (await orphanFile.exists()) {
            await orphanFile.delete();
          }
        } catch (_) {
          // Best effort cleanup
        }
      }
      // Reset path on error to allow fresh start
      _currentRecordingPath = null;
      throw Exception('Failed to stop recording: $e');
    }
  }

  /// Get current user ID from secure storage
  @override
  Future<String> getCurrentUserId() async {
    try {
      // Derive the id from the CURRENT access token FIRST. The access token is
      // written fresh on every login and deleted on logout, so its `sub` claim
      // always reflects the user who is signed in RIGHT NOW.
      //
      // The stored `user_id` key is NOT a reliable source of "current user":
      // it is written by the email/passcode login paths but not by every path
      // (e.g. biometric/Face-ID login writes `biometric_user_id`, not this key),
      // and some logout paths don't clear it. So after logging out of account A
      // and back into account B via a path that doesn't rewrite it, the stale
      // account-A id lingered here — which made voice enrollment/status run
      // against the WRONG account (the classic "it says enroll again even though
      // I already enrolled" symptom). Prefer the token; fall back to the stored
      // key only when there is no usable token.
      final token = await _secureStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        final userId = _extractUserIdFromToken(token);
        if (userId.isNotEmpty) {
          return userId;
        }
      }

      final storedUserId = await _secureStorage.getUserId();
      if (storedUserId != null && storedUserId.isNotEmpty) {
        return storedUserId;
      }

      throw Exception('User ID not found in token or storage');
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

  /// Enroll voice with audio samples via the voice-agent-gateway HTTP path
  /// (`POST /voice/auth/enroll`) — the SAME transport the login/verify path
  /// uses. The previous implementation went over native gRPC direct to
  /// :50060, which a device can't reach and the Cloudflare tunnel doesn't route
  /// (it only proxies the HTTP `/voice/...` family), so enrollment silently
  /// failed → no voiceprint stored → login always reported "not enrolled".
  @override
  Future<VoiceEnrollmentResult> enrollVoice({
    required String userId,
    required List<File> audioSamples,
  }) async {
    try {
      print('🎙️  Starting voice enrollment (HTTP) for user: $userId');

      if (audioSamples.length < 3) {
        throw Exception('At least 3 audio samples required for enrollment');
      }

      // Read the WAV samples as bytes.
      final samples = <Uint8List>[];
      for (var i = 0; i < audioSamples.length; i++) {
        final file = audioSamples[i];
        if (!await file.exists()) {
          throw Exception('Audio sample $i does not exist: ${file.path}');
        }
        final bytes = await file.readAsBytes();
        if (bytes.isEmpty) {
          throw Exception('Audio sample $i is empty: ${file.path}');
        }
        samples.add(bytes);
        print('✅ Loaded sample $i: ${bytes.length} bytes');
      }

      final result = await serviceLocator<vbs.VoiceBiometricsService>().enrollVoice(
        userId: userId,
        audioSamples: samples,
        sampleRate: 16000,
        channels: 1,
      );

      print('📥 Enrollment response: success=${result.success} '
          'quality=${result.qualityScore} id=${result.enrollmentId}');

      if (!result.success) {
        throw Exception((result.message?.isNotEmpty ?? false)
            ? result.message!
            : 'Voice enrollment failed');
      }

      return VoiceEnrollmentResult(
        enrollmentId: result.enrollmentId ?? '',
        qualityScore: result.qualityScore ?? 0.0,
        samplesCount: result.samplesCount ?? samples.length,
        success: result.success,
        message: result.message ?? '',
      );
    } on vbs.VoiceBiometricsException catch (e) {
      final msg = e.message;
      // Normalize "already enrolled" so the cubit's auto-delete-and-retry
      // (which matches ALREADY_EXISTS / "already has voice") triggers.
      if (msg.toLowerCase().contains('already')) {
        throw Exception('ALREADY_EXISTS: $msg');
      }
      throw Exception('Voice enrollment failed: $msg');
    } catch (e) {
      print('❌ Error during enrollment: $e');
      throw Exception('Voice enrollment failed: $e');
    }
  }

  /// Check voice enrollment status via the HTTP gateway path.
  @override
  Future<bool> checkEnrollmentStatus(String userId) async {
    try {
      final status =
          await serviceLocator<vbs.VoiceBiometricsService>().checkEnrollmentStatus(userId);
      return status.isEnrolled;
    } catch (e) {
      print('❌ Error checking enrollment status: $e');
      return false; // not enrolled / service unavailable
    }
  }

  /// Delete voice enrollment via the HTTP gateway path.
  @override
  Future<bool> deleteEnrollment(String userId) async {
    try {
      return await serviceLocator<vbs.VoiceBiometricsService>().deleteVoiceEnrollment(userId);
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
