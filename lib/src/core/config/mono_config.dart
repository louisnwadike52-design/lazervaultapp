import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Mono Connect Configuration
///
/// Configuration for Mono bank account linking and DirectPay integration.
/// Uses flutter_dotenv for runtime configuration from .env files.
///
/// Environment Modes:
/// - Sandbox (test_pk_xxx keys): Free API calls, test credentials
/// - Live (live_pk_xxx keys): Real transactions, real accounts
///
/// CI/CD Configuration:
/// - Development/Staging: Uses test keys from .env (test_pk_xxx) → Sandbox mode
/// - Production: Uses live keys from .env.prod (live_pk_xxx) → Live mode
///
/// The app automatically loads the correct .env file based on device type:
/// - Emulator → .env (test keys, sandbox mode)
/// - Physical device → .env.prod (live keys, live mode)
///
/// IMPORTANT: For DirectPay testing in sandbox:
/// - Use test credentials: user_good/123456, PIN: 1234, OTP: 123456
/// - Test BVN: 12345678901, Test Account: 1234567890 with NIP code 000000
class MonoConfig {
  MonoConfig._();

  /// Mono public key
  ///
  /// Get this from Mono Dashboard: https://app.withmono.com
  /// - Development: Use test public key (starts with test_pk_)
  /// - Production: Use live public key (starts with live_pk_)
  static String get publicKey => dotenv.env['MONO_PUBLIC_KEY'] ?? '';

  /// Mono secret key (for backend API calls only)
  ///
  /// Format:
  /// - Test/Sandbox: test_sk_xxx
  /// - Live/Production: live_sk_xxx
  static String get secretKey => dotenv.env['MONO_SECRET_KEY'] ?? '';

  /// Current environment from .env
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  /// Whether Mono is enabled
  static bool get isEnabled =>
      publicKey.isNotEmpty &&
      !publicKey.startsWith('\$') &&
      publicKey != 'pk_test_your_mono_public_key_here' &&
      publicKey != 'test_pk_your_mono_public_key_here' &&
      isValidPublicKey(publicKey);

  /// Whether using test/sandbox mode
  ///
  /// Detected from public key format:
  /// - Starts with "test_pk_" → sandbox mode (Mono format)
  /// - Starts with "pk_test_" → sandbox mode (legacy format)
  /// - Contains "test" → sandbox mode (fallback)
  ///
  /// In sandbox mode:
  /// - API calls are free
  /// - Use test credentials for DirectPay
  /// - Customers appear as "Sandbox" in Mono dashboard
  static bool get isTestMode =>
      publicKey.startsWith('test_pk_') ||
      publicKey.startsWith('pk_test_') ||
      publicKey.contains('test');

  /// Alias for isTestMode for clarity
  static bool get isSandboxMode => isTestMode;

  /// Whether using live/production mode
  /// Mono live keys start with "live_pk_" or "pk_live_"
  /// In live mode:
  /// - API calls cost money
  /// - Real bank credentials required
  /// - Business approval required for Direct Debit
  static bool get isLiveMode =>
      publicKey.startsWith('live_pk_') || publicKey.startsWith('pk_live_');

  /// Whether we're in production environment (from ENVIRONMENT variable)
  static bool get isProduction => environment == 'production';

  /// Get Mono Connect base URL (same for sandbox and live)
  static String get connectUrl => 'https://connect.mono.co';

  // ========== SANDBOX TEST CREDENTIALS ==========
  // Use these for testing in sandbox mode

  /// Test username for Mono Connect widget (sandbox)
  static const String sandboxTestUsername = 'user_good';

  /// Test password for Mono Connect widget (sandbox)
  static const String sandboxTestPassword = '123456';

  /// Test PIN for banking operations (sandbox)
  static const String sandboxTestPin = '1234';

  /// Test OTP for 2FA (sandbox)
  static const String sandboxTestOtp = '123456';

  /// Test security answer (sandbox)
  static const String sandboxSecurityAnswer = 'lagos';

  /// Test BVN for identity verification (sandbox)
  static const String sandboxTestBvn = '12345678901';

  /// Test NIN for identity verification (sandbox)
  static const String sandboxTestNin = '12345678901';

  /// Test account number for DirectPay (sandbox)
  static const String sandboxTestAccountNumber = '1234567890';

  /// Test NIP code for DirectPay (sandbox)
  static const String sandboxTestNipCode = '000000';

  // ========== SCOPE CONSTANTS ==========
  // Different scopes for different Mono operations

  /// Scope for account linking only (read-only access)
  static const String scopeAuth = 'auth';

  /// Scope for payments (DirectPay, one-time debits)
  static const String scopePayments = 'payments';

  /// Get the appropriate scope based on operation type
  static String getScopeForOperation(MonoOperation operation) {
    switch (operation) {
      case MonoOperation.accountLinking:
        return scopeAuth;
      case MonoOperation.directPay:
      case MonoOperation.directDebit:
      case MonoOperation.mandate:
        return scopePayments;
    }
  }

  /// Mono Institution IDs for Nigerian Banks
  /// These are Mono's internal institution identifiers used for pre-selection
  /// Get updated list from: https://docs.mono.co/reference/institutions
  static const Map<String, MonoInstitution> institutions = {
    'Access Bank': MonoInstitution(
      id: '5f2d08bf60b92e2888287703',
      name: 'Access Bank',
      bankCode: '044',
      type: 'PERSONAL_BANKING',
    ),
    'Citibank': MonoInstitution(
      id: '5f2d08c060b92e2888287706',
      name: 'Citibank',
      bankCode: '023',
      type: 'PERSONAL_BANKING',
    ),
    'Ecobank': MonoInstitution(
      id: '5f2d08c060b92e288828770a',
      name: 'Ecobank',
      bankCode: '050',
      type: 'PERSONAL_BANKING',
    ),
    'Fidelity Bank': MonoInstitution(
      id: '5f2d08c060b92e288828770d',
      name: 'Fidelity Bank',
      bankCode: '070',
      type: 'PERSONAL_BANKING',
    ),
    'First Bank': MonoInstitution(
      id: '5f2d08c060b92e288828770f',
      name: 'First Bank of Nigeria',
      bankCode: '011',
      type: 'PERSONAL_BANKING',
    ),
    'First City Monument Bank (FCMB)': MonoInstitution(
      id: '5f2d08c060b92e2888287711',
      name: 'First City Monument Bank',
      bankCode: '214',
      type: 'PERSONAL_BANKING',
    ),
    'Guaranty Trust Bank (GTB)': MonoInstitution(
      id: '5f2d08c060b92e2888287713',
      name: 'Guaranty Trust Bank',
      bankCode: '058',
      type: 'PERSONAL_BANKING',
    ),
    'Heritage Bank': MonoInstitution(
      id: '5f2d08c160b92e2888287715',
      name: 'Heritage Bank',
      bankCode: '030',
      type: 'PERSONAL_BANKING',
    ),
    'Keystone Bank': MonoInstitution(
      id: '5f2d08c160b92e2888287718',
      name: 'Keystone Bank',
      bankCode: '082',
      type: 'PERSONAL_BANKING',
    ),
    'Polaris Bank': MonoInstitution(
      id: '5f2d08c160b92e288828771c',
      name: 'Polaris Bank',
      bankCode: '076',
      type: 'PERSONAL_BANKING',
    ),
    'Providus Bank': MonoInstitution(
      id: '5f2d08c160b92e288828771e',
      name: 'Providus Bank',
      bankCode: '101',
      type: 'PERSONAL_BANKING',
    ),
    'Stanbic IBTC Bank': MonoInstitution(
      id: '5f2d08c160b92e2888287720',
      name: 'Stanbic IBTC Bank',
      bankCode: '221',
      type: 'PERSONAL_BANKING',
    ),
    'Standard Chartered Bank': MonoInstitution(
      id: '5f2d08c160b92e2888287722',
      name: 'Standard Chartered Bank',
      bankCode: '068',
      type: 'PERSONAL_BANKING',
    ),
    'Sterling Bank': MonoInstitution(
      id: '5f2d08c160b92e2888287724',
      name: 'Sterling Bank',
      bankCode: '232',
      type: 'PERSONAL_BANKING',
    ),
    'Union Bank': MonoInstitution(
      id: '5f2d08c260b92e2888287728',
      name: 'Union Bank of Nigeria',
      bankCode: '032',
      type: 'PERSONAL_BANKING',
    ),
    'United Bank for Africa (UBA)': MonoInstitution(
      id: '5f2d08c260b92e288828772a',
      name: 'United Bank for Africa',
      bankCode: '033',
      type: 'PERSONAL_BANKING',
    ),
    'Unity Bank': MonoInstitution(
      id: '5f2d08c260b92e288828772c',
      name: 'Unity Bank',
      bankCode: '215',
      type: 'PERSONAL_BANKING',
    ),
    'Wema Bank': MonoInstitution(
      id: '5f2d08c260b92e288828772e',
      name: 'Wema Bank',
      bankCode: '035',
      type: 'PERSONAL_BANKING',
    ),
    'Zenith Bank': MonoInstitution(
      id: '5f2d08c260b92e2888287730',
      name: 'Zenith Bank',
      bankCode: '057',
      type: 'PERSONAL_BANKING',
    ),
    // Additional banks
    'Kuda Bank': MonoInstitution(
      id: '5f2d08c060b92e2888287717',
      name: 'Kuda Microfinance Bank',
      bankCode: '50211',
      type: 'PERSONAL_BANKING',
    ),
    'OPay': MonoInstitution(
      id: '5f2d08c160b92e288828771a',
      name: 'OPay Digital Services',
      bankCode: '999992',
      type: 'PERSONAL_BANKING',
    ),
    'PalmPay': MonoInstitution(
      id: '60d9b38f63aeca0720e35237',
      name: 'PalmPay',
      bankCode: '999991',
      type: 'PERSONAL_BANKING',
    ),
    'Moniepoint': MonoInstitution(
      id: '6087df8f6b29a90dc167b0a0',
      name: 'Moniepoint Microfinance Bank',
      bankCode: '50515',
      type: 'PERSONAL_BANKING',
    ),
  };

  /// Legacy bank code map (for backwards compatibility)
  static Map<String, String> get supportedBanks {
    return institutions.map((key, value) => MapEntry(key, value.bankCode));
  }

  /// Get Mono institution ID from bank name
  static String? getMonoInstitutionId(String bankName) {
    // Try exact match first
    if (institutions.containsKey(bankName)) {
      return institutions[bankName]!.id;
    }

    // Try fuzzy match (case-insensitive, contains)
    final lowerBankName = bankName.toLowerCase();
    for (var entry in institutions.entries) {
      if (entry.key.toLowerCase().contains(lowerBankName) ||
          lowerBankName.contains(entry.key.toLowerCase()) ||
          entry.value.name.toLowerCase().contains(lowerBankName)) {
        return entry.value.id;
      }
    }

    return null;
  }

  /// Get institution details from Mono institution ID
  static MonoInstitution? getInstitutionById(String institutionId) {
    for (var entry in institutions.entries) {
      if (entry.value.id == institutionId) {
        return entry.value;
      }
    }
    return null;
  }

  /// Get bank name from Mono institution ID
  static String? getBankNameFromInstitutionId(String institutionId) {
    for (var entry in institutions.entries) {
      if (entry.value.id == institutionId) {
        return entry.key;
      }
    }
    return null;
  }

  /// Get bank code from bank name
  static String? getBankCode(String bankName) {
    if (institutions.containsKey(bankName)) {
      return institutions[bankName]!.bankCode;
    }

    // Try fuzzy match
    final lowerBankName = bankName.toLowerCase();
    for (var entry in institutions.entries) {
      if (entry.key.toLowerCase().contains(lowerBankName) ||
          lowerBankName.contains(entry.key.toLowerCase())) {
        return entry.value.bankCode;
      }
    }

    return null;
  }

  /// Get bank name from bank code
  static String? getBankName(String bankCode) {
    for (var entry in institutions.entries) {
      if (entry.value.bankCode == bankCode) {
        return entry.key;
      }
    }
    return null;
  }

  /// Get institution from bank name (returns full details)
  static MonoInstitution? getInstitution(String bankName) {
    if (institutions.containsKey(bankName)) {
      return institutions[bankName];
    }

    // Try fuzzy match
    final lowerBankName = bankName.toLowerCase();
    for (var entry in institutions.entries) {
      if (entry.key.toLowerCase().contains(lowerBankName) ||
          lowerBankName.contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }

    return null;
  }

  /// Validate public key format
  /// Mono public keys can be in either format:
  /// - test_pk_xxx / live_pk_xxx (current Mono format)
  /// - pk_test_xxx / pk_live_xxx (legacy format)
  static bool isValidPublicKey(String key) {
    return key.startsWith('test_pk_') ||
        key.startsWith('live_pk_') ||
        key.startsWith('pk_test_') ||
        key.startsWith('pk_live_');
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
      'supportedBanks': institutions.length,
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
      issues.add('MONO_PUBLIC_KEY has invalid format (should start with test_pk_ or live_pk_)');
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

/// Mono Institution details
class MonoInstitution {
  final String id;
  final String name;
  final String bankCode;
  final String type;

  const MonoInstitution({
    required this.id,
    required this.name,
    required this.bankCode,
    required this.type,
  });

  @override
  String toString() => 'MonoInstitution(id: $id, name: $name, bankCode: $bankCode)';
}

/// Result from Mono Connect flow
class MonoConnectResult {
  /// The authorization code to exchange for account access
  final String code;

  /// The institution (bank) that was connected
  final MonoInstitution? institution;

  /// The institution ID from Mono
  final String? institutionId;

  /// The institution name as displayed by Mono
  final String? institutionName;

  /// Account ID if available
  final String? accountId;

  const MonoConnectResult({
    required this.code,
    this.institution,
    this.institutionId,
    this.institutionName,
    this.accountId,
  });

  /// Get the display name for the connected bank
  String get bankDisplayName {
    if (institution != null) return institution!.name;
    if (institutionName != null) return institutionName!;
    if (institutionId != null) {
      final inst = MonoConfig.getInstitutionById(institutionId!);
      if (inst != null) return inst.name;
    }
    return 'Unknown Bank';
  }

  @override
  String toString() => 'MonoConnectResult(code: ${code.substring(0, code.length > 10 ? 10 : code.length)}..., bank: $bankDisplayName)';
}

/// Mono operation types for determining the correct scope
enum MonoOperation {
  /// Account linking - read-only access to account data
  accountLinking,

  /// DirectPay - one-time payment authorization
  directPay,

  /// Direct Debit - pull funds from linked account
  directDebit,

  /// Mandate - recurring access for future debits
  mandate,
}
