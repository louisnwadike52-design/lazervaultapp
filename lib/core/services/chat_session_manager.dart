import 'package:lazervault/core/services/secure_storage_service.dart';

/// Manages deterministic session IDs for chat conversations.
///
/// General chat uses `general_{userId}` so history persists across app restarts.
/// Per-service chats use `svc_{userId}_{sourceContext}` so each service has its own thread.
class ChatSessionManager {
  final SecureStorageService _secureStorageService;

  ChatSessionManager({required SecureStorageService secureStorageService})
      : _secureStorageService = secureStorageService;

  /// Get deterministic session ID for the general AI chat (bottom nav).
  Future<String> getGeneralSessionId() async {
    final userId = await _secureStorageService.getUserId() ?? 'unknown';
    return 'general_$userId';
  }

  /// Get deterministic session ID for a per-service chat bottom sheet.
  Future<String> getServiceSessionId(String sourceContext) async {
    final userId = await _secureStorageService.getUserId() ?? 'unknown';
    return 'svc_${userId}_$sourceContext';
  }
}
