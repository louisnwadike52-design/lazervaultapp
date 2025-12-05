import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const String _keyUserEmail = 'user_email';
  static const String _keyHasPasscode = 'has_passcode';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';

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
