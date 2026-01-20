import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application Environment Configuration
///
/// Centralized environment detection and configuration.
/// The app automatically loads the correct .env file:
/// - Emulator → .env (development)
/// - Physical device → .env.prod (production)
///
/// Environment Hierarchy:
/// ┌─────────────────┬─────────────────────────────────────────────────┐
/// │ Environment     │ Behavior                                        │
/// ├─────────────────┼─────────────────────────────────────────────────┤
/// │ development     │ Test APIs, sandbox mode, verbose logging        │
/// │ staging         │ Test APIs, sandbox mode, limited logging        │
/// │ production      │ Live APIs, strict security, minimal logging     │
/// └─────────────────┴─────────────────────────────────────────────────┘
enum AppEnvironment {
  development,
  staging,
  production;

  /// Parse environment from string
  static AppEnvironment fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'production':
      case 'prod':
        return AppEnvironment.production;
      case 'staging':
      case 'stage':
        return AppEnvironment.staging;
      case 'development':
      case 'dev':
      default:
        return AppEnvironment.development;
    }
  }

  /// Get display name
  String get displayName {
    switch (this) {
      case AppEnvironment.development:
        return 'Development';
      case AppEnvironment.staging:
        return 'Staging';
      case AppEnvironment.production:
        return 'Production';
    }
  }

  /// Whether this is a production environment
  bool get isProduction => this == AppEnvironment.production;

  /// Whether this is a development environment
  bool get isDevelopment => this == AppEnvironment.development;

  /// Whether this is a staging environment
  bool get isStaging => this == AppEnvironment.staging;

  /// Whether to use sandbox/test APIs
  bool get useSandbox => this != AppEnvironment.production;

  /// Whether verbose logging is enabled
  bool get verboseLogging => this == AppEnvironment.development;

  /// Whether to show debug UI elements
  bool get showDebugUI => this == AppEnvironment.development;
}

/// Application Configuration
///
/// Provides centralized access to all environment-based configuration.
class AppConfig {
  AppConfig._();

  static AppConfig? _instance;
  static AppConfig get instance => _instance ??= AppConfig._();

  /// Current environment
  static AppEnvironment get environment =>
      AppEnvironment.fromString(dotenv.env['ENVIRONMENT']);

  /// Whether running in production
  static bool get isProduction => environment.isProduction;

  /// Whether running in development
  static bool get isDevelopment => environment.isDevelopment;

  /// Whether to use sandbox/test APIs
  static bool get useSandbox => environment.useSandbox;

  // =========================================================================
  // API ENDPOINTS
  // =========================================================================

  /// Banking Service API URL
  static String get bankingApiUrl =>
      dotenv.env['BANKING_API_URL'] ?? _defaultBankingUrl;

  /// Chat Gateway URL
  static String get chatGatewayUrl =>
      dotenv.env['CHAT_GATEWAY_URL'] ?? _defaultChatGatewayUrl;

  /// HTTP API Host
  static String get httpApiHost =>
      dotenv.env['HTTP_API_HOST'] ?? _defaultHttpApiHost;

  /// gRPC API Host
  static String get grpcApiHost =>
      dotenv.env['GRPC_API_HOST'] ?? _defaultGrpcApiHost;

  /// gRPC API Port
  static int get grpcApiPort =>
      int.tryParse(dotenv.env['GRPC_API_PORT'] ?? '') ?? _defaultGrpcApiPort;

  // =========================================================================
  // DEFAULT VALUES (Development)
  // =========================================================================

  static const String _defaultBankingUrl = 'http://10.0.2.2:8080/api/v1';
  static const String _defaultChatGatewayUrl = 'http://10.0.2.2:3011';
  static const String _defaultHttpApiHost = 'http://10.0.2.2:7878';
  static const String _defaultGrpcApiHost = '10.0.2.2';
  static const int _defaultGrpcApiPort = 50070;

  // =========================================================================
  // FEATURE FLAGS
  // =========================================================================

  /// Whether international transfers are enabled
  static bool get internationalTransfersEnabled =>
      _getBool('INTERNATIONAL_ENABLED', false);

  /// Whether multi-currency is enabled
  static bool get multiCurrencyEnabled =>
      _getBool('MULTI_CURRENCY_ENABLED', false);

  /// Whether scheduled transfers are enabled
  static bool get scheduledTransfersEnabled =>
      _getBool('SCHEDULED_TRANSFERS_ENABLED', false);

  // =========================================================================
  // HELPER METHODS
  // =========================================================================

  static bool _getBool(String key, bool defaultValue) {
    final value = dotenv.env[key]?.toLowerCase();
    if (value == null) return defaultValue;
    return value == 'true' || value == '1';
  }

  /// Get configuration summary (safe for logging)
  static Map<String, dynamic> getSummary() {
    return {
      'environment': environment.displayName,
      'isProduction': isProduction,
      'useSandbox': useSandbox,
      'bankingApiUrl': bankingApiUrl,
      'chatGatewayUrl': chatGatewayUrl,
      'grpcApiHost': grpcApiHost,
      'grpcApiPort': grpcApiPort,
    };
  }

  /// Log configuration (safe - no secrets)
  static void logConfiguration() {
    final summary = getSummary();
    print('════════════════════════════════════════════════════════════');
    print('APP CONFIGURATION');
    print('════════════════════════════════════════════════════════════');
    print('Environment:     ${summary['environment']}');
    print('Is Production:   ${summary['isProduction']}');
    print('Use Sandbox:     ${summary['useSandbox']}');
    print('Banking API:     ${summary['bankingApiUrl']}');
    print('Chat Gateway:    ${summary['chatGatewayUrl']}');
    print('gRPC Host:       ${summary['grpcApiHost']}:${summary['grpcApiPort']}');
    print('════════════════════════════════════════════════════════════');
  }

  /// Validate configuration and return issues
  static List<String> validate() {
    final issues = <String>[];

    // Check required environment variables
    if (dotenv.env['ENVIRONMENT'] == null) {
      issues.add('ENVIRONMENT not set in .env');
    }

    // Production-specific validations
    if (isProduction) {
      if (bankingApiUrl.contains('10.0.2.2') ||
          bankingApiUrl.contains('localhost')) {
        issues.add('BANKING_API_URL should not be localhost in production');
      }

      if (!bankingApiUrl.startsWith('https://')) {
        issues.add('BANKING_API_URL should use HTTPS in production');
      }

      if (chatGatewayUrl.contains('10.0.2.2') ||
          chatGatewayUrl.contains('localhost')) {
        issues.add('CHAT_GATEWAY_URL should not be localhost in production');
      }
    }

    return issues;
  }
}
