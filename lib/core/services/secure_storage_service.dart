import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserId = 'user_id';
  static const String _keyUserFirstName = 'user_first_name';
  static const String _keyUserLastName = 'user_last_name';
  static const String _keyHasPasscode = 'has_passcode';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  // BVN / NIN. PII so we keep them encrypted-at-rest (FlutterSecureStorage
  // uses Keychain on iOS + EncryptedSharedPreferences on Android). Written
  // by the KYC verification flow on successful tier-2 verification, read
  // by the insurance purchase form's auto-fill so users don't retype.
  // Cleared by `deleteIdentityNumbers` on logout (called from clearAll).
  static const String _keyBvn = 'kyc_bvn';
  static const String _keyNin = 'kyc_nin';

  /// Last-picked chat session id for the multi-tab general chat (drawer).
  /// Restored at app launch so users land back on the last conversation.
  /// Wiped by `clearAll` on logout.
  static const String _keyChatCurrentSessionId = 'chat_current_session_id';

  /// Biometric-login opt-in flags (per method). Device biometrics (fingerprint/
  /// face) gate the locally-cached session (refresh_token); voice login uses the
  /// voice-biometrics enrollment. Managed from Settings → Biometric Login.
  static const String _keyFingerprintLogin = 'fingerprint_login_enabled';
  static const String _keyFaceLogin = 'face_login_enabled';
  static const String _keyVoiceLogin = 'voice_login_enabled';

  /// LEGACY durable-biometric keys. These were a SECOND copy of the refresh
  /// token that biometric unlock re-minted from. They are gone: the auth-service
  /// rotates refresh tokens one-time-use and revokes the WHOLE token family on
  /// any replay, so a second copy inevitably diverged from the volatile
  /// `refresh_token`, replayed a revoked token, and killed the session (the
  /// "fingerprint always asks for passcode" bug). Biometric now unlocks over the
  /// single `refresh_token` directly. These constants remain ONLY so
  /// [clearBiometricSession] can delete any values left on existing installs.
  static const String _keyBiometricRefreshToken = 'biometric_refresh_token';
  static const String _keyBiometricUserId = 'biometric_user_id';

  /// Local mirror of the backend self-lock deadline (RFC3339), written when the
  /// user arms an account lock / emergency lock. Lets the login screens surface
  /// the lock PROACTIVELY (on arrival, with a live countdown) instead of only
  /// after a failed login attempt. Backend `self_locked_until` remains the source
  /// of truth for the actual gate. Deliberately written AFTER clearAll() when
  /// arming, and self-clears once it elapses (see `getSelfLockUntil`).
  static const String _keySelfLockUntil = 'self_lock_until';
  static const String _keySelfLockReason = 'self_lock_reason';

  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  // Self-lock (proactive login reflection) --------------------------------
  Future<void> setSelfLockUntil(DateTime until, {String? reason}) async {
    await _storage.write(key: _keySelfLockUntil, value: until.toUtc().toIso8601String());
    if (reason != null && reason.isNotEmpty) {
      await _storage.write(key: _keySelfLockReason, value: reason);
    }
  }

  /// The stored self-lock reason (e.g. 'emergency' | 'scheduled'), if any.
  Future<String?> getSelfLockReason() async =>
      _storage.read(key: _keySelfLockReason);

  /// Returns the self-lock deadline if it is still in the FUTURE; if it has
  /// elapsed, clears the key and returns null (so the login screen stops showing
  /// the lock the instant it expires without needing a server round-trip).
  Future<DateTime?> getSelfLockUntil() async {
    final raw = await _storage.read(key: _keySelfLockUntil);
    if (raw == null || raw.isEmpty) return null;
    final until = DateTime.tryParse(raw);
    if (until == null) {
      await _storage.delete(key: _keySelfLockUntil);
      return null;
    }
    if (until.toUtc().isAfter(DateTime.now().toUtc())) return until.toLocal();
    await _storage.delete(key: _keySelfLockUntil);
    return null;
  }

  Future<void> clearSelfLock() async {
    await _storage.delete(key: _keySelfLockUntil);
    await _storage.delete(key: _keySelfLockReason);
  }

  // Biometric login preferences
  Future<void> setFingerprintLoginEnabled(bool v) async =>
      _storage.write(key: _keyFingerprintLogin, value: v.toString());
  Future<bool> getFingerprintLoginEnabled() async =>
      (await _storage.read(key: _keyFingerprintLogin)) == 'true';

  Future<void> setFaceLoginEnabled(bool v) async =>
      _storage.write(key: _keyFaceLogin, value: v.toString());
  Future<bool> getFaceLoginEnabled() async =>
      (await _storage.read(key: _keyFaceLogin)) == 'true';

  Future<void> setVoiceLoginEnabled(bool v) async =>
      _storage.write(key: _keyVoiceLogin, value: v.toString());
  Future<bool> getVoiceLoginEnabled() async =>
      (await _storage.read(key: _keyVoiceLogin)) == 'true';

  // Legacy durable-biometric cleanup. -----------------------------------------
  /// Delete any legacy durable-biometric keys left on an existing install. There
  /// is no writer anymore — biometric unlock uses the single `refresh_token`.
  /// Safe to call anytime (logout, user switch, biometric disable).
  Future<void> clearBiometricSession() async {
    await _storage.delete(key: _keyBiometricRefreshToken);
    await _storage.delete(key: _keyBiometricUserId);
  }

  // Dark mode (display preference). Cached locally for an instant, offline theme
  // at startup; reconciled with the server preference after profile load.
  static const String _keyDarkMode = 'dark_mode';
  Future<void> setDarkMode(bool v) async =>
      _storage.write(key: _keyDarkMode, value: v.toString());
  Future<bool> getDarkMode() async =>
      (await _storage.read(key: _keyDarkMode)) == 'true';

  // User email
  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: _keyUserEmail, value: email);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: _keyUserEmail);
  }

  Future<void> deleteUserEmail() async {
    await _storage.delete(key: _keyUserEmail);
  }

  // User ID (stored during login by AuthenticationCubit)
  Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  /// The user signed in RIGHT NOW, resolved from the current access token's
  /// `sub` claim first and only falling back to the stored `user_id` key.
  ///
  /// Why not just [getUserId]: the stored `user_id` key is written by
  /// `_saveSession` (email/passcode logins) but NOT by every path — biometric/
  /// Face-ID unlock and the phone `hydrateProfile` path don't rewrite it, and
  /// some logout paths don't clear it. After logging out of account A and into
  /// account B via one of those paths, the stale account-A id lingered in the
  /// key. The access token, by contrast, is minted fresh for whoever logs in
  /// (any path) and deleted on logout, so its `sub` is the authoritative
  /// "current user". Use this anywhere a feature needs the live account id and
  /// must never act on a previous account (voice enrollment/recognition, etc.).
  Future<String?> getCurrentUserId() async {
    final token = await _storage.read(key: _keyAccessToken);
    final fromToken = _userIdFromJwt(token);
    if (fromToken != null && fromToken.isNotEmpty) return fromToken;
    return await _storage.read(key: _keyUserId);
  }

  /// Decode a JWT and return its `sub` (falling back to a `user_id` claim).
  /// Returns null on any malformed input — callers fall back to the stored key.
  static String? _userIdFromJwt(String? token) {
    if (token == null || token.isEmpty) return null;
    try {
      final parts = token.split('.');
      if (parts.length < 2) return null;
      var payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final claims =
          jsonDecode(utf8.decode(base64Url.decode(payload))) as Map<String, dynamic>;
      final id = (claims['sub'] ?? claims['user_id'] ?? '').toString();
      return id.isEmpty ? null : id;
    } catch (_) {
      return null;
    }
  }

  // User full name (stored during login by AuthenticationCubit)
  Future<String?> getUserFullName() async {
    final firstName = await _storage.read(key: _keyUserFirstName);
    final lastName = await _storage.read(key: _keyUserLastName);
    if (firstName == null && lastName == null) return null;
    return [
      if (firstName != null && firstName.isNotEmpty) firstName,
      if (lastName != null && lastName.isNotEmpty) lastName,
    ].join(' ');
  }

  // Passcode flag
  Future<void> setHasPasscode(bool hasPasscode) async {
    await _storage.write(key: _keyHasPasscode, value: hasPasscode.toString());
  }

  Future<bool> getHasPasscode() async {
    final value = await _storage.read(key: _keyHasPasscode);
    return value == 'true';
  }

  // Tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
  }

  // ─── Identity numbers (BVN / NIN) ─────────────────────────────────────
  // Both are 11-digit Nigerian identity numbers. Stored only after a
  // successful KYC verification — the user typed them once during
  // BVN/Mono onboarding and we cache them encrypted so the insurance
  // purchase form can pre-fill the same value instead of asking the
  // user to retype. The form keeps the field editable so the user can
  // override (e.g. if they're buying for someone else).

  Future<void> saveBvn(String bvn) async {
    final trimmed = bvn.trim();
    if (trimmed.isEmpty) return;
    await _storage.write(key: _keyBvn, value: trimmed);
  }

  Future<String?> getBvn() async => _storage.read(key: _keyBvn);

  Future<void> saveNin(String nin) async {
    final trimmed = nin.trim();
    if (trimmed.isEmpty) return;
    await _storage.write(key: _keyNin, value: trimmed);
  }

  Future<String?> getNin() async => _storage.read(key: _keyNin);

  /// Wipe identity numbers. Called from `clearAll` (logout) and exposed
  /// independently so a future "revoke KYC" action can clear the cache
  /// without touching tokens.
  Future<void> deleteIdentityNumbers() async {
    await _storage.delete(key: _keyBvn);
    await _storage.delete(key: _keyNin);
  }

  // ─── Multi-tab chat session id ────────────────────────────────────────

  /// Read the last-active general-chat session id (drawer selection).
  /// Returns `null` if the user has never opened a multi-tab chat yet.
  Future<String?> readChatCurrentSessionId() async {
    return _storage.read(key: _keyChatCurrentSessionId);
  }

  /// Persist the active general-chat session id so the next launch lands
  /// on the same conversation. Called by `ChatSessionManager.switchTo`.
  Future<void> writeChatCurrentSessionId(String sessionId) async {
    if (sessionId.isEmpty) {
      await _storage.delete(key: _keyChatCurrentSessionId);
      return;
    }
    await _storage.write(key: _keyChatCurrentSessionId, value: sessionId);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if user has logged in before on this device
  Future<bool> hasLoggedInBefore() async {
    final email = await getUserEmail();
    return email != null && email.isNotEmpty;
  }
}
