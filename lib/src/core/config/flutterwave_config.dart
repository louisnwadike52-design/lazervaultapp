import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Flutterwave Configuration
///
/// Configuration for Flutterwave payment integration (V3 API)
/// Supports both client-side SDK initialization and API mode detection.
///
/// CI/CD Configuration:
/// - Development: Uses test keys from .env (FLWPUBK_TEST-xxx)
/// - Production: Uses live keys from .env.prod (FLWPUBK-xxx)
///
/// The app automatically loads the correct .env file based on device type:
/// - Emulator → .env (test keys)
/// - Physical device → .env.prod (live keys)
class FlutterwaveConfig {
  FlutterwaveConfig._();

  /// Flutterwave public key for client-side SDK
  ///
  /// Format:
  /// - Test: FLWPUBK_TEST-xxxxxxxxxxxxxxxxxxxxx-X
  /// - Live: FLWPUBK-xxxxxxxxxxxxxxxxxxxxx-X
  static String get publicKey =>
      dotenv.env['FLUTTERWAVE_PUBLIC_KEY'] ?? '';

  /// Flutterwave encryption key for card encryption
  ///
  /// Format:
  /// - Test: FLWSECK_TESTxxxxxxxxxxxx
  /// - Live: FLWSECKxxxxxxxxxxxx
  static String get encryptionKey =>
      dotenv.env['FLUTTERWAVE_ENCRYPTION_KEY'] ?? '';

  /// Banking API URL (backend handles secret key)
  static String get bankingApiUrl =>
      dotenv.env['BANKING_API_URL'] ?? 'http://10.0.2.2:8080/api/v1';

  /// Current environment
  static String get environment =>
      dotenv.env['ENVIRONMENT'] ?? 'development';

  /// Whether using test/sandbox mode
  ///
  /// Detected from public key format:
  /// - Contains "_TEST" → test mode
  /// - No "_TEST" → live mode
  static bool get isTestMode =>
      publicKey.contains('_TEST') || publicKey.contains('_test');

  /// Whether using live/production mode
  static bool get isLiveMode => !isTestMode;

  /// Whether Flutterwave is properly configured
  static bool get isEnabled =>
      publicKey.isNotEmpty &&
      publicKey != 'FLWPUBK_TEST-xxxxxxxxxxxxxxxxxxxxx' &&
      !publicKey.startsWith('\$');

  /// Get mode string for logging
  static String get mode => isTestMode ? 'test' : 'live';

  /// V3 API base URL (same for test/live)
  static const String apiBaseUrl = 'https://api.flutterwave.com/v3';

  /// Supported payment methods in Nigeria
  static const List<String> supportedPaymentMethods = [
    'card',
    'banktransfer',
    'ussd',
    'mobilemoneyghana',
    'account',
    'nqr',
  ];

  /// Supported currencies
  static const List<String> supportedCurrencies = [
    'NGN', // Nigerian Naira
    'USD', // US Dollar
    'GBP', // British Pound
    'EUR', // Euro
    'GHS', // Ghanaian Cedi
    'KES', // Kenyan Shilling
    'ZAR', // South African Rand
    'UGX', // Ugandan Shilling
    'TZS', // Tanzanian Shilling
    'RWF', // Rwandan Franc
  ];

  /// Validate public key format
  static bool isValidPublicKey(String key) {
    // Test key format: FLWPUBK_TEST-xxx-X
    // Live key format: FLWPUBK-xxx-X
    return key.startsWith('FLWPUBK_TEST-') || key.startsWith('FLWPUBK-');
  }

  /// Validate encryption key format
  static bool isValidEncryptionKey(String key) {
    // Test key format: FLWSECK_TESTxxx
    // Live key format: FLWSECKxxx
    return key.startsWith('FLWSECK_TEST') ||
           (key.startsWith('FLWSECK') && !key.contains('_TEST'));
  }

  /// Get configuration summary (safe for logging)
  static Map<String, dynamic> getSummary() {
    return {
      'enabled': isEnabled,
      'mode': mode,
      'environment': environment,
      'hasPublicKey': publicKey.isNotEmpty,
      'hasEncryptionKey': encryptionKey.isNotEmpty,
      'publicKeyPrefix': publicKey.isNotEmpty
          ? '${publicKey.substring(0, publicKey.length > 15 ? 15 : publicKey.length)}...'
          : 'NOT_SET',
      'bankingApiUrl': bankingApiUrl,
    };
  }

  /// Log configuration (safe - masks sensitive data)
  static void logConfiguration() {
    final summary = getSummary();
    print('[FlutterwaveConfig] Mode: ${summary['mode']}');
    print('[FlutterwaveConfig] Environment: ${summary['environment']}');
    print('[FlutterwaveConfig] Enabled: ${summary['enabled']}');
    print('[FlutterwaveConfig] Public Key: ${summary['publicKeyPrefix']}');
    print('[FlutterwaveConfig] Has Encryption Key: ${summary['hasEncryptionKey']}');
    print('[FlutterwaveConfig] Banking API: ${summary['bankingApiUrl']}');
  }

  /// Validate configuration and return any issues
  static List<String> validate() {
    final issues = <String>[];

    if (publicKey.isEmpty) {
      issues.add('FLUTTERWAVE_PUBLIC_KEY not set in .env');
    } else if (!isValidPublicKey(publicKey)) {
      issues.add('FLUTTERWAVE_PUBLIC_KEY has invalid format');
    }

    if (encryptionKey.isEmpty) {
      issues.add('FLUTTERWAVE_ENCRYPTION_KEY not set in .env');
    } else if (!isValidEncryptionKey(encryptionKey)) {
      issues.add('FLUTTERWAVE_ENCRYPTION_KEY has invalid format');
    }

    // Warn if using test keys in production environment
    if (environment == 'production' && isTestMode) {
      issues.add('WARNING: Using TEST keys in production environment');
    }

    return issues;
  }
}
