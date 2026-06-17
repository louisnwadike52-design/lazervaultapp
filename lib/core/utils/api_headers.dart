import 'package:uuid/uuid.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Utility for building standardized HTTP headers for all API requests.
///
/// This ensures all outbound requests include:
/// - Authorization (JWT Bearer token)
/// - X-User-Id (from secure storage)
/// - X-Service-Name (fixed "lazervault-flutter")
/// - X-Request-ID (unique UUID per request)
/// - X-Account-Id (from AccountManager when available)
/// - X-Country (from LocaleManager)
/// - X-Currency (from LocaleManager)
/// - X-User-Country (alternative header name used by some gateways)
class ApiHeaders {
  static const String _serviceName = 'lazervault-flutter';

  /// Build complete HTTP headers for API requests.
  ///
  /// All headers are optional - only includes non-null/non-empty values.
  ///
  /// Parameters:
  /// - [secureStorage]: Required for access token and user ID
  /// - [accountManager]: Optional for X-Account-Id header
  /// - [localeManager]: Optional for X-Country and X-Currency headers
  /// - [customHeaders]: Optional additional headers to include/override
  ///
  /// Returns a Map of header names to values.
  static Future<Map<String, String>> build({
    required SecureStorageService secureStorage,
    AccountManager? accountManager,
    LocaleManager? localeManager,
    Map<String, String>? customHeaders,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Service-Name': _serviceName,
      'X-Request-ID': _generateRequestId(),
    };

    // Add Authorization header
    final accessToken = await secureStorage.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    // Add X-User-Id header
    final userId = await secureStorage.getUserId();
    if (userId != null && userId.isNotEmpty) {
      headers['X-User-Id'] = userId;
    }

    // Add X-Account-Id header if available
    final accountId = accountManager?.activeAccountId;
    if (accountId != null && accountId.isNotEmpty) {
      headers['X-Account-Id'] = accountId;
    }

    // Add X-Country header if locale manager is available
    if (localeManager != null) {
      final country = localeManager.currentCountry;
      if (country.isNotEmpty) {
        headers['X-Country'] = country;
        headers['X-User-Country'] = country; // Alternative header name
      }

      // Add X-Currency header
      final currency = localeManager.currentCurrency;
      if (currency.isNotEmpty) {
        headers['X-Currency'] = currency;
      }
    }

    // Merge custom headers (can override defaults)
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  /// Generate a unique request ID using UUID v4.
  ///
  /// Format: UUID string (e.g., "550e8400-e29b-41d4-a716-446655440000")
  static String _generateRequestId() {
    return const Uuid().v4();
  }

  /// Generate a request ID with a prefix for easier log searching.
  ///
  /// [prefix] will be prepended to the UUID.
  /// Example: "flutter-550e8400-e29b-41d4-a716-446655440000"
  static String generateRequestIdWithPrefix(String prefix) {
    return '$prefix-${_generateRequestId()}';
  }

  /// Get just the service name header (useful for non-authenticated requests).
  static Map<String, String> get baseHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Service-Name': _serviceName,
        'X-Request-ID': _generateRequestId(),
      };

  /// Build headers for WebSocket connections.
  ///
  /// WebSocket connections don't use all HTTP headers but need
  /// service identification for tracking.
  static Future<Map<String, String>> buildWebSocketHeaders({
    required SecureStorageService secureStorage,
    AccountManager? accountManager,
    LocaleManager? localeManager,
  }) async {
    final headers = <String, String>{
      'X-Service-Name': _serviceName,
    };

    // Add Authorization header for WebSocket
    final accessToken = await secureStorage.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    // Add X-User-Id header
    final userId = await secureStorage.getUserId();
    if (userId != null && userId.isNotEmpty) {
      headers['X-User-Id'] = userId;
    }

    // Add X-Account-Id header if available
    final accountId = accountManager?.activeAccountId;
    if (accountId != null && accountId.isNotEmpty) {
      headers['X-Account-Id'] = accountId;
    }

    // Add X-Country header if locale manager is available
    if (localeManager != null) {
      final country = localeManager.currentCountry;
      if (country.isNotEmpty) {
        headers['X-Country'] = country;
      }

      final currency = localeManager.currentCurrency;
      if (currency.isNotEmpty) {
        headers['X-Currency'] = currency;
      }
    }

    return headers;
  }
}
