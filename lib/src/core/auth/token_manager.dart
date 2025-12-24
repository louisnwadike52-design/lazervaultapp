import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../features/authentication/domain/entities/session_entity.dart';

/// Manages JWT tokens for gRPC authentication
class TokenManager {
  static const String _sessionKey = 'user_session';
  final FlutterSecureStorage _secureStorage;

  TokenManager({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Get the current access token
  Future<String?> getAccessToken() async {
    final session = await getSession();
    if (session == null) return null;

    // Check if token is expired
    if (session.accessTokenExpiresAt.isBefore(DateTime.now())) {
      // Token expired - should trigger refresh
      return null;
    }

    return session.accessToken;
  }

  /// Get the current session
  Future<SessionEntity?> getSession() async {
    try {
      final sessionJson = await _secureStorage.read(key: _sessionKey);
      if (sessionJson == null) return null;

      final Map<String, dynamic> sessionMap = json.decode(sessionJson);
      return SessionEntity(
        id: sessionMap['id'] as String,
        userId: sessionMap['userId'] as String,
        accessToken: sessionMap['accessToken'] as String,
        refreshToken: sessionMap['refreshToken'] as String,
        accessTokenExpiresAt: DateTime.parse(sessionMap['accessTokenExpiresAt'] as String),
        refreshTokenExpiresAt: DateTime.parse(sessionMap['refreshTokenExpiresAt'] as String),
      );
    } catch (e) {
      print('Error reading session: $e');
      return null;
    }
  }

  /// Save session
  Future<void> saveSession(SessionEntity session) async {
    try {
      final sessionMap = {
        'id': session.id,
        'userId': session.userId,
        'accessToken': session.accessToken,
        'refreshToken': session.refreshToken,
        'accessTokenExpiresAt': session.accessTokenExpiresAt.toIso8601String(),
        'refreshTokenExpiresAt': session.refreshTokenExpiresAt.toIso8601String(),
      };
      await _secureStorage.write(key: _sessionKey, value: json.encode(sessionMap));
    } catch (e) {
      print('Error saving session: $e');
      rethrow;
    }
  }

  /// Clear session (logout)
  Future<void> clearSession() async {
    await _secureStorage.delete(key: _sessionKey);
  }

  /// Check if access token is valid (not expired)
  Future<bool> isAccessTokenValid() async {
    final session = await getSession();
    if (session == null) return false;

    return session.accessTokenExpiresAt.isAfter(DateTime.now());
  }

  /// Check if refresh token is valid (not expired)
  Future<bool> isRefreshTokenValid() async {
    final session = await getSession();
    if (session == null) return false;

    return session.refreshTokenExpiresAt.isAfter(DateTime.now());
  }

  /// Get user ID from current session
  Future<String?> getUserId() async {
    final session = await getSession();
    return session?.userId;
  }
}
