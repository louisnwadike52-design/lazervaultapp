import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

/// API Configuration for gateway URLs
class ApiConfig {
  static late final String voiceSettingsUrl;
  static late final String coreGatewayUrl;
  static late final String authGatewayUrl;
  static late final String investmentGatewayHttpUrl;

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");

    // Voice settings API (hosted by auth-service)
    voiceSettingsUrl = dotenv.env['VOICE_SETTINGS_URL'] ??
        dotenv.env['AUTH_GATEWAY_URL'] ??
        'http://localhost:8081'; // auth-service HTTP port

    // Core gateway
    coreGatewayUrl = dotenv.env['CORE_GATEWAY_URL'] ?? 'http://localhost:7878';

    // Auth gateway
    authGatewayUrl = dotenv.env['AUTH_GATEWAY_URL'] ?? 'http://localhost:7878';

    // Investment gateway
    investmentGatewayHttpUrl =
        dotenv.env['INVESTMENT_GATEWAY_URL'] ?? 'http://localhost:9090';

    // For Android emulator, use 10.0.2.2
    if (voiceSettingsUrl.contains('localhost')) {
      voiceSettingsUrl = voiceSettingsUrl.replaceAll('localhost', '10.0.2.2');
      coreGatewayUrl = coreGatewayUrl.replaceAll('localhost', '10.0.2.2');
      investmentGatewayHttpUrl =
          investmentGatewayHttpUrl.replaceAll('localhost', '10.0.2.2');
    }
  }

  @factoryMethod
  static ApiConfig create() => ApiConfig._();

  ApiConfig._();
}
