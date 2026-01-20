import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Mono Connect Configuration
///
/// Configuration for Mono bank account linking integration.
/// Uses flutter_dotenv for runtime configuration from .env files.
///
/// CI/CD Configuration:
/// - Development: Uses test keys from .env (pk_test_xxx)
/// - Production: Uses live keys from .env.prod (pk_live_xxx)
///
/// The app automatically loads the correct .env file based on device type:
/// - Emulator → .env (test keys)
/// - Physical device → .env.prod (live keys)
class MonoConfig {
  MonoConfig._();

  /// Mono public key
  ///
  /// Get this from Mono Dashboard: https://app.withmono.com
  /// - Development: Use test public key (starts with pk_test_)
  /// - Production: Use live public key (starts with pk_live_)
  static String get publicKey => dotenv.env['MONO_PUBLIC_KEY'] ?? '';

  /// Mono secret key (for backend API calls only)
  ///
  /// Format:
  /// - Test: sk_test_xxx
  /// - Live: sk_live_xxx
  static String get secretKey => dotenv.env['MONO_SECRET_KEY'] ?? '';

  /// Current environment from .env
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  /// Whether Mono is enabled
  static bool get isEnabled =>
      publicKey.isNotEmpty &&
      !publicKey.startsWith('\$') &&
      publicKey != 'pk_test_your_mono_public_key_here';

  /// Whether using test/sandbox mode
  ///
  /// Detected from public key format:
  /// - Contains "pk_test_" → test mode
  /// - Contains "pk_live_" → live mode
  static bool get isTestMode =>
      publicKey.startsWith('pk_test_') || publicKey.contains('test_');

  /// Whether using live/production mode
  static bool get isLiveMode => publicKey.startsWith('pk_live_');

  /// Whether we're in production environment
  static bool get isProduction => environment == 'production';

  /// Get Mono Connect base URL
  static String get connectUrl {
    return isProduction
        ? 'https://connect.withmono.com'
        : 'https://connect.withmono.com'; // Mono uses same URL for both
  }

  /// Supported Nigerian banks
  ///
  /// Bank codes for pre-selecting institutions in Mono Connect
  static const Map<String, String> supportedBanks = {
    'Access Bank': '044',
    'Citibank': '023',
    'Diamond Bank': '063',
    'Ecobank': '050',
    'Fidelity Bank': '070',
    'First Bank': '011',
    'First City Monument Bank (FCMB)': '214',
    'Guaranty Trust Bank (GTB)': '058',
    'Heritage Bank': '030',
    'Keystone Bank': '082',
    'Polaris Bank': '076',
    'Providus Bank': '101',
    'Stanbic IBTC Bank': '221',
    'Standard Chartered Bank': '068',
    'Sterling Bank': '232',
    'SunTrust Bank': '100',
    'Union Bank': '032',
    'United Bank for Africa (UBA)': '033',
    'Unity Bank': '215',
    'Wema Bank': '035',
    'Zenith Bank': '057',
  };

  /// Get bank code from bank name
  static String? getBankCode(String bankName) {
    // Try exact match first
    if (supportedBanks.containsKey(bankName)) {
      return supportedBanks[bankName];
    }

    // Try fuzzy match (case-insensitive, contains)
    final lowerBankName = bankName.toLowerCase();
    for (var entry in supportedBanks.entries) {
      if (entry.key.toLowerCase().contains(lowerBankName) ||
          lowerBankName.contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }

    return null;
  }

  /// Get bank name from bank code
  static String? getBankName(String bankCode) {
    for (var entry in supportedBanks.entries) {
      if (entry.value == bankCode) {
        return entry.key;
      }
    }
    return null;
  }

  /// Validate public key format
  static bool isValidPublicKey(String key) {
    return key.startsWith('pk_test_') || key.startsWith('pk_live_');
  }

  /// Get mode string for logging
  static String get mode => isTestMode ? 'test' : 'live';

  /// Get configuration summary (safe for logging)
  static Map<String, dynamic> getSummary() {
    return {
      'enabled': isEnabled,
      'mode': mode,
      'environment': environment,
      'hasPublicKey': publicKey.isNotEmpty,
      'hasSecretKey': secretKey.isNotEmpty,
      'publicKeyPrefix': publicKey.isNotEmpty
          ? '${publicKey.substring(0, publicKey.length > 12 ? 12 : publicKey.length)}...'
          : 'NOT_SET',
      'connectUrl': connectUrl,
      'supportedBanks': supportedBanks.length,
    };
  }

  /// Log configuration (safe - masks sensitive data)
  static void logConfiguration() {
    final summary = getSummary();
    print('[MonoConfig] Mode: ${summary['mode']}');
    print('[MonoConfig] Environment: ${summary['environment']}');
    print('[MonoConfig] Enabled: ${summary['enabled']}');
    print('[MonoConfig] Public Key: ${summary['publicKeyPrefix']}');
    print('[MonoConfig] Has Secret Key: ${summary['hasSecretKey']}');
    print('[MonoConfig] Connect URL: ${summary['connectUrl']}');
    print('[MonoConfig] Supported Banks: ${summary['supportedBanks']}');
  }

  /// Validate configuration and return any issues
  static List<String> validate() {
    final issues = <String>[];

    if (publicKey.isEmpty) {
      issues.add('MONO_PUBLIC_KEY not set in .env');
    } else if (!isValidPublicKey(publicKey)) {
      issues.add('MONO_PUBLIC_KEY has invalid format (should start with pk_test_ or pk_live_)');
    }

    // Warn if using test keys in production environment
    if (isProduction && isTestMode) {
      issues.add('WARNING: Using TEST keys in production environment');
    }

    // Warn if using live keys in development environment
    if (!isProduction && isLiveMode) {
      issues.add('WARNING: Using LIVE keys in non-production environment');
    }

    return issues;
  }
}
