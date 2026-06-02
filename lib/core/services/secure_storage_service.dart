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

  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

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
