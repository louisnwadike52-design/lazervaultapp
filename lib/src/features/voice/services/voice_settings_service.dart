import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/injection_container.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../core/utils/logger.dart';
import '../models/voice_settings_models.dart';
import '../../voice_session/cubit/voice_session_cubit.dart';

/// Voice Settings API Service
/// Handles fetching languages, voices, and managing user voice preferences
class VoiceSettingsService {
  final http.Client _client;
  final String _languageApiUrl;
  final String _voiceGatewayUrl;
  final GetIt _getIt;

  VoiceSettingsService([
    http.Client? client,
    GetIt? getIt,
  ])  : _client = client ?? http.Client(),
        _getIt = getIt ?? serviceLocator,
        _languageApiUrl = dotenv.env['VOICE_LANGUAGE_API_URL'] ?? endpointRegistry.httpVoiceLang,
        _voiceGatewayUrl = dotenv.env['VOICE_AGENT_GATEWAY_URL'] ?? endpointRegistry.httpVoiceAgent;

  Future<List<VoiceLanguage>> getSupportedLanguages({String country = 'NG'}) async {
    try {
      final token = await _getAuthToken();
      final response = await _client.get(
        Uri.parse('$_languageApiUrl/api/v1/voice/languages?country=$country'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final languagesJson = data['languages'] as List<dynamic>? ?? [];
        return languagesJson.map((e) {
          final map = e as Map<String, dynamic>;
          return VoiceLanguage(
            id: 0,
            code: map['code'] as String? ?? '',
            name: map['name'] as String? ?? '',
            nativeName: map['nativeName'] as String? ?? map['name'] as String? ?? '',
            flagEmoji: map['flag'] as String?,
            ttsProvider: map['provider'] as String? ?? 'openai',
            supportsCustomVoice: map['supportsVoiceCustomization'] as bool? ?? false,
            supportsVoiceCloning: map['supportsVoiceCloning'] as bool? ?? false,
            cloningProvider: map['cloningProvider'] as String?,
            requiresTranslation: false,
            displayOrder: 0,
          );
        }).toList();
      } else {
        AppLogger.error('Failed to fetch languages: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      AppLogger.error('Error fetching languages', error: e);
      return [];
    }
  }

  Future<List<VoiceOption>> getVoicesForLanguage(String languageCode) async {
    try {
      final token = await _getAuthToken();
      final response = await _client.get(
        Uri.parse('$_languageApiUrl/api/v1/voice/languages/$languageCode'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final voicesJson = data['availableVoices'] as List<dynamic>? ?? [];
        int idx = 0;
        return voicesJson.map((e) {
          final map = e as Map<String, dynamic>;
          return VoiceOption(
            id: idx++,
            languageCode: languageCode,
            provider: data['provider'] as String? ?? 'openai',
            voiceId: map['id'] as String? ?? '',
            name: map['name'] as String? ?? '',
            gender: map['gender'] as String?,
            description: map['accent'] as String?,
            previewUrl: map['previewUrl'] as String?,
            isCustomCapable: false,
            displayOrder: idx,
          );
        }).toList();
      } else if (response.statusCode == 404) {
        AppLogger.error('Language $languageCode not found');
        return [];
      } else {
        AppLogger.error('Failed to fetch voices: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      AppLogger.error('Error fetching voices', error: e);
      return [];
    }
  }

  /// Get custom voice cloning status for a user
  Future<CustomVoiceStatus?> getCustomVoiceStatus(String userId) async {
    try {
      final token = await _getAuthToken();
      final response = await _client.get(
        Uri.parse('$_voiceGatewayUrl/voice/clone/status/$userId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return CustomVoiceStatus.fromJson(data);
      }
      return null;
    } catch (e) {
      AppLogger.error('Error fetching custom voice status', error: e);
      return null;
    }
  }

  /// Enable or disable custom voice for a user
  Future<bool> setCustomVoiceEnabled(String userId, bool enabled) async {
    try {
      final token = await _getAuthToken();
      final response = await _client.post(
        Uri.parse('$_voiceGatewayUrl/voice/clone/enable/$userId?enabled=$enabled'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));
      final ok = response.statusCode == 200;
      if (ok) {
        // The enabled flag is now persisted server-side. If a voice call is live,
        // also signal the active session so it swaps its TTS mid-conversation
        // (clone ON / default OFF). When no session is active the cubit's
        // sendToVoiceAgent no-ops silently and the next session picks up the flag
        // at start (Fix 1 background clone resolve). Never break the toggle on
        // a signalling failure — the HTTP result is the source of truth.
        try {
          if (_getIt.isRegistered<VoiceSessionCubit>()) {
            await _getIt<VoiceSessionCubit>().notifyCustomVoiceChanged(enabled);
          }
        } catch (e) {
          AppLogger.error('Failed to signal active voice session of custom voice change', error: e);
        }
      }
      return ok;
    } catch (e) {
      AppLogger.error('Error setting custom voice enabled', error: e);
      return false;
    }
  }

  /// Read the per-user voice transaction-PIN override (through the voice gateway,
  /// which forwards the JWT to auth-service). Returns null on failure.
  Future<VoiceTxPinSettings?> getTxPinSettings() async {
    try {
      final token = await _getAuthToken();
      final response = await _client.get(
        Uri.parse('$_voiceGatewayUrl/voice/txpin/settings'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return VoiceTxPinSettings.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      AppLogger.error('Error fetching voice txpin settings', error: e);
      return null;
    }
  }

  /// Update the per-user voice transaction-PIN override. Pass null for require_pin/
  /// threshold_kobo to CLEAR that override (defer to the platform default). [entryMode]
  /// is tri-state: null = leave untouched, '' = clear the override (defer to admin),
  /// 'sheet'/'voice' = pin the choice. Returns true on success.
  Future<bool> updateTxPinSettings({
    required bool? requirePin,
    required int? thresholdKobo,
    String? entryMode,
    String? interactionMode,
  }) async {
    try {
      final token = await _getAuthToken();
      final body = <String, dynamic>{
        'require_pin': requirePin,
        'threshold_kobo': thresholdKobo,
      };
      // Only include entry_mode when the caller is changing it, so a require_pin /
      // threshold save never wipes the entry-mode choice server-side.
      if (entryMode != null) {
        body['entry_mode'] = entryMode;
      }
      // Same tri-state rule for interaction_mode ('' clears → defer to admin).
      if (interactionMode != null) {
        body['interaction_mode'] = interactionMode;
      }
      final response = await _client.put(
        Uri.parse('$_voiceGatewayUrl/voice/txpin/settings'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      ).timeout(const Duration(seconds: 8));
      return response.statusCode == 200;
    } catch (e) {
      AppLogger.error('Error updating voice txpin settings', error: e);
      return false;
    }
  }

  Future<String?> _getAuthToken() async {
    // Get auth token from secure storage
    try {
      // Try to get token from SecureStorageService if available
      if (_getIt.isRegistered<SecureStorageService>()) {
        final secureStorage = _getIt<SecureStorageService>();
        return await secureStorage.getAccessToken();
      }
      return null;
    } catch (e) {
      AppLogger.error('Error getting auth token', error: e);
      return null;
    }
  }
}

/// Per-user voice transaction-PIN override + the resolved platform defaults.
class VoiceTxPinSettings {
  /// null = defer to the platform default; true = always ask the PIN in voice;
  /// false = always skip (session-auth-only) for this user.
  final bool? requirePin;

  /// null = defer to the platform default; otherwise, when a PIN is required, still
  /// skip it for voice amounts at/below this many kobo.
  final int? thresholdKobo;

  /// Per-user PIN-entry override: '' = defer to the admin default; 'sheet' = enter on
  /// the on-screen sheet; 'voice' = say the digits.
  final String entryMode;

  /// Resolved platform defaults (for showing "(default: skip)" hints).
  final bool adminRequirePin;
  final int adminThresholdKobo;

  /// Resolved platform default entry mode ('sheet'|'voice').
  final String adminEntryMode;

  /// Per-user INTERACTION-mode override: '' = defer to the admin default;
  /// 'continuous'|'hold'|'tap'|'double_tap' = pin the choice. UX preference for
  /// how the user talks to the voice agent (NOT a security control).
  final String interactionMode;

  /// Resolved platform default interaction mode ('continuous'|'hold'|'tap'|'double_tap').
  final String adminInteractionMode;

  const VoiceTxPinSettings({
    this.requirePin,
    this.thresholdKobo,
    this.entryMode = '',
    this.adminRequirePin = false,
    this.adminThresholdKobo = 0,
    this.adminEntryMode = 'sheet',
    this.interactionMode = '',
    this.adminInteractionMode = 'continuous',
  });

  factory VoiceTxPinSettings.fromJson(Map<String, dynamic> j) => VoiceTxPinSettings(
        requirePin: j['require_pin'] as bool?,
        thresholdKobo: (j['threshold_kobo'] as num?)?.toInt(),
        entryMode: (j['entry_mode'] as String?) ?? '',
        adminRequirePin: j['admin_require_pin'] as bool? ?? false,
        adminThresholdKobo: (j['admin_threshold_kobo'] as num?)?.toInt() ?? 0,
        adminEntryMode: (j['admin_entry_mode'] as String?)?.isNotEmpty == true
            ? j['admin_entry_mode'] as String
            : 'sheet',
        interactionMode: (j['interaction_mode'] as String?) ?? '',
        adminInteractionMode:
            (j['admin_interaction_mode'] as String?)?.isNotEmpty == true
                ? j['admin_interaction_mode'] as String
                : 'continuous',
      );

  /// The effective "PIN required in voice" the user experiences right now.
  bool get effectiveRequirePin => requirePin ?? adminRequirePin;

  /// The effective threshold in kobo.
  int get effectiveThresholdKobo => thresholdKobo ?? adminThresholdKobo;

  /// The effective PIN-entry mode ('sheet'|'voice') — per-user override wins.
  String get effectiveEntryMode =>
      entryMode.isNotEmpty ? entryMode : adminEntryMode;

  /// The effective interaction mode the user experiences right now — per-user
  /// override wins, else the admin default. Never empty (falls back to 'continuous').
  String get effectiveInteractionMode {
    final v = interactionMode.isNotEmpty ? interactionMode : adminInteractionMode;
    return v.isNotEmpty ? v : 'continuous';
  }
}
