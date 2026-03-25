import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/injection_container.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../core/utils/logger.dart';
import '../models/voice_settings_models.dart';

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
        _languageApiUrl = dotenv.env['VOICE_LANGUAGE_API_URL'] ?? 'http://localhost:3013',
        _voiceGatewayUrl = dotenv.env['VOICE_AGENT_GATEWAY_URL'] ?? 'http://localhost:3010';

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
      return response.statusCode == 200;
    } catch (e) {
      AppLogger.error('Error setting custom voice enabled', error: e);
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
