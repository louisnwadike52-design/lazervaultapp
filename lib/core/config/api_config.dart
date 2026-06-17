import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';

/// API Configuration for gateway URLs.
///
/// Resolution order for every URL (consistent with [GrpcChannelFactory]):
///   1. dotenv legacy override (`CORE_GATEWAY_URL`, `AUTH_GATEWAY_URL`, …)
///      so a developer pinning a local-dev server still works.
///   2. [EndpointRegistry] — the admin-managed `url_*` keys cached on
///      first launch and refreshed in the background.
///   3. Hard-coded tunnel fallback (`https://api.lazervault.app/api/v1`)
///      so initialize() never throws even before the registry is ready.
class ApiConfig {
  static late final String voiceSettingsUrl;
  static late final String coreGatewayUrl;
  static late final String authGatewayUrl;
  static late final String investmentGatewayHttpUrl;

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");

    String _resolve(String envKey, String registryValue) {
      final v = dotenv.env[envKey];
      if (v != null && v.isNotEmpty) return v;
      return registryValue;
    }

    voiceSettingsUrl = _resolve('VOICE_SETTINGS_URL', endpointRegistry.httpAdmin);
    coreGatewayUrl = _resolve('CORE_GATEWAY_URL', endpointRegistry.httpCore);
    authGatewayUrl = _resolve('AUTH_GATEWAY_URL', endpointRegistry.httpCore);
    investmentGatewayHttpUrl =
        _resolve('INVESTMENT_GATEWAY_URL', endpointRegistry.httpInvestment);

    // Note: the Android-emulator localhost→10.0.2.2 rewrite that used to
    // live here is no longer needed — Cloudflare-tunneled URLs resolve
    // identically on emulator + physical device + iOS simulator.
  }

  @factoryMethod
  static ApiConfig create() => ApiConfig._();

  ApiConfig._();
}
