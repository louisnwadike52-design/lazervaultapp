import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
part 'voice_biometrics_service_widgets.dart';


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
    // ECAPA-TDNN cosine similarity for the SAME speaker across different
    // sessions/devices commonly lands in the 0.6–0.85 band, so the old 0.85
    // default rejected many legitimate logins as "not recognised". 0.70 keeps
    // genuine users in while still separating them from impostors (whose
    // cross-speaker similarity is typically < 0.5).
    double threshold = 0.70,
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

  /// SERVER-ATTESTED voice login ("voice = password"). Sends the voice sample +
  /// cached identity to the gateway, which verifies the voiceprint with a
  /// SERVER-enforced threshold and — only on a match — mints a REAL session
  /// (bound to the same user). Returns the fresh tokens; the caller persists
  /// them exactly like a passcode login. This does NOT depend on a still-valid
  /// cached session, so it works as a primary credential.
  Future<VoiceLoginResult> loginWithVoice({
    required String userId,
    required String phone,
    required Uint8List audioSample,
  }) async {
    if (userId.isEmpty || phone.isEmpty) {
      throw VoiceBiometricsException('userId and phone are required');
    }
    if (audioSample.isEmpty) {
      throw VoiceBiometricsException('audioSample cannot be empty');
    }
    try {
      final uri = Uri.parse('$baseUrl/voice/auth/login');
      final response = await _retryRequest(
        () => _client
            .post(
              uri,
              headers: _buildHeaders(),
              body: json.encode({
                'user_id': userId,
                'phone': phone,
                'audio_sample': base64Encode(audioSample),
              }),
            )
            .timeout(timeout),
      );

      if (response.statusCode == 200) {
        return VoiceLoginResult.fromJson(_parseJson(response.body));
      }
      // Map the server's typed failures so the UI can message precisely.
      String status;
      switch (response.statusCode) {
        case 401:
          status = 'VOICE_NOT_RECOGNIZED';
          break;
        case 403:
          status = 'IDENTITY_MISMATCH';
          break;
        case 404:
          status = 'NOT_ENROLLED';
          break;
        default:
          if (response.statusCode >= 500) {
            throw VoiceBiometricsServerException(
                'Voice login server error: ${response.statusCode}',
                statusCode: response.statusCode);
          }
          status = 'ERROR';
      }
      return VoiceLoginResult(verified: false, status: status);
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException('No internet connection: ${e.message}');
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
          'Voice login timed out after ${timeout.inSeconds} seconds');
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException('Network error during voice login: ${e.message}');
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error during voice login: $e');
    }
  }

  /// EMAIL-based voice login (email sign-in screen). The server resolves the
  /// account from [email], verifies the voiceprint with a server-enforced
  /// threshold, and — only on a match — mints a real session. The client never
  /// decides "verified". Mirrors [loginWithVoice] but keyed by email.
  Future<VoiceLoginResult> loginWithEmail({
    required String email,
    required Uint8List audioSample,
  }) async {
    if (email.isEmpty) {
      throw VoiceBiometricsException('email is required');
    }
    if (audioSample.isEmpty) {
      throw VoiceBiometricsException('audioSample cannot be empty');
    }
    try {
      final uri = Uri.parse('$baseUrl/voice/auth/login');
      final response = await _retryRequest(
        () => _client
            .post(
              uri,
              headers: _buildHeaders(),
              body: json.encode({
                'email': email,
                'audio_sample': base64Encode(audioSample),
              }),
            )
            .timeout(timeout),
      );

      if (response.statusCode == 200) {
        return VoiceLoginResult.fromJson(_parseJson(response.body));
      }
      String status;
      switch (response.statusCode) {
        case 401:
          status = 'VOICE_NOT_RECOGNIZED';
          break;
        case 403:
          status = 'IDENTITY_MISMATCH';
          break;
        case 404:
          status = 'NOT_ENROLLED';
          break;
        default:
          if (response.statusCode >= 500) {
            throw VoiceBiometricsServerException(
                'Voice login server error: ${response.statusCode}',
                statusCode: response.statusCode);
          }
          status = 'ERROR';
      }
      return VoiceLoginResult(verified: false, status: status);
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException('No internet connection: ${e.message}');
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
          'Voice login timed out after ${timeout.inSeconds} seconds');
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException('Network error during voice login: ${e.message}');
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error during voice login: $e');
    }
  }

  /// Whether the account owning [email] has a voice enrollment — used by the
  /// email sign-in screen to decide whether to offer Voice login. An unknown
  /// email resolves to not-enrolled (the server never leaks account existence).
  Future<VoiceEnrollmentStatus> checkEnrollmentByEmail(String email) async {
    if (email.isEmpty) {
      throw VoiceBiometricsException('email cannot be empty');
    }
    try {
      final uri = Uri.parse('$baseUrl/voice/auth/status')
          .replace(queryParameters: {'email': email});
      final response = await _retryRequest(
        () => _client.get(uri, headers: _buildHeaders()).timeout(timeout),
      );
      if (response.statusCode == 200) {
        return VoiceEnrollmentStatus.fromJson(_parseJson(response.body));
      } else if (response.statusCode == 404) {
        return VoiceEnrollmentStatus(isEnrolled: false);
      } else if (response.statusCode >= 500) {
        throw VoiceBiometricsServerException('Server error: ${response.statusCode}',
            statusCode: response.statusCode);
      }
      throw VoiceBiometricsException(
          'Failed to check enrollment status: ${response.statusCode}');
    } on SocketException catch (e) {
      throw VoiceBiometricsNetworkException('No internet connection: ${e.message}');
    } on TimeoutException catch (_) {
      throw VoiceBiometricsNetworkException(
          'Request timed out after ${timeout.inSeconds} seconds');
    } on http.ClientException catch (e) {
      throw VoiceBiometricsNetworkException('Network error: ${e.message}');
    } catch (e) {
      if (e is VoiceBiometricsException) rethrow;
      throw VoiceBiometricsException('Error checking enrollment: $e');
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


  /// Soft availability probe for the voice agent.
  ///
  /// FAIL-OPEN by design. This is only a *hint* for the entry points — the
  /// authoritative gate is `POST /voice/session/start`, which returns a
  /// specific 503 (`voice_recognition_disabled` / `service_voice_disabled`)
  /// when an admin has actually turned voice off, and which the cubit surfaces
  /// with the real reason. A bare `/voice/health` 200-check used to fail CLOSED
  /// on any timeout / DNS blip / mis-seeded `url_voice_agent_gateway` base URL,
  /// which permanently showed "voice not available" even when voice worked. So:
  ///   - 200                    → available.
  ///   - explicit 503 "disabled" → unavailable (admin turned it off).
  ///   - anything else / error   → available (open the sheet; session-start
  ///                                decides). We never block on a transient probe.
  Future<bool> isServiceAvailable() async {
    try {
      // `/voice/health` (not `/health`) because the cloudflared edge only
      // routes the `/voice/...` path family to voice-agent-gateway. The
      // gateway exposes both paths as aliases so this works with any
      // baseUrl shape (with or without a trailing `/voice` segment).
      final root = baseUrl.endsWith('/voice')
          ? baseUrl.substring(0, baseUrl.length - '/voice'.length)
          : baseUrl;
      final uri = Uri.parse('$root/voice/health');
      final response = await _client.get(uri).timeout(
        const Duration(seconds: 5),
      );
      if (response.statusCode == 200) return true;
      // Only treat an EXPLICIT admin-disabled signal as unavailable; every other
      // non-200 (gateway warming up, 404 through a mis-seeded base, 5xx) fails open.
      if (response.statusCode == 503 &&
          response.body.toLowerCase().contains('disabled')) {
        return false;
      }
      return true;
    } catch (e) {
      // Unreachable / timeout / TLS-DNS error: fail OPEN. Let /voice/session/start
      // report the real reason instead of a permanent "not available".
      print('VoiceBiometricsService: health probe failed, failing open: $e');
      return true;
    }
  }

  /// Dispose resources
  void dispose() {
    _client.close();
  }
}
