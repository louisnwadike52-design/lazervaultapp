/// Mono Connect Configuration
///
/// Configuration for Mono bank account linking integration
class MonoConfig {
  /// Mono public key
  ///
  /// Get this from Mono Dashboard: https://app.withmono.com
  /// - Development: Use test public key (starts with pk_test_)
  /// - Production: Use live public key (starts with pk_live_)
  static const String publicKey = String.fromEnvironment(
    'MONO_PUBLIC_KEY',
    defaultValue: 'pk_test_your_mono_public_key_here',
  );

  /// Mono environment
  ///
  /// - 'test': Sandbox environment for testing
  /// - 'live': Production environment
  static const String environment = String.fromEnvironment(
    'MONO_ENVIRONMENT',
    defaultValue: 'test',
  );

  /// Whether Mono is enabled
  static bool get isEnabled => publicKey.isNotEmpty && publicKey != 'pk_test_your_mono_public_key_here';

  /// Whether we're in production
  static bool get isProduction => environment == 'live';

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

  /// Get environment-specific settings
  static Map<String, dynamic> getSettings() {
    return {
      'publicKey': publicKey,
      'environment': environment,
      'isProduction': isProduction,
      'connectUrl': connectUrl,
      'isEnabled': isEnabled,
    };
  }

  /// Log configuration (for debugging - never log keys in production)
  static void logConfiguration() {
    if (isProduction) {
      print('[MonoConfig] Running in PRODUCTION mode');
      print('[MonoConfig] Public key: ${publicKey.substring(0, 15)}...');
    } else {
      print('[MonoConfig] Running in TEST mode');
      print('[MonoConfig] Public key: $publicKey');
    }
    print('[MonoConfig] Connect URL: $connectUrl');
    print('[MonoConfig] Enabled: $isEnabled');
    print('[MonoConfig] Supported banks: ${supportedBanks.length}');
  }
}
