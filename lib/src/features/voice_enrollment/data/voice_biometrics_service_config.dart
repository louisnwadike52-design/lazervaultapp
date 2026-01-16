/// Configuration for Voice Biometrics Service
library;
import 'package:grpc/grpc.dart';

class VoiceBiometricsServiceConfig {
  /// Service host
  final String host;

  /// Service port
  final int port;

  /// Channel options
  final ChannelOptions? options;

  /// Timeout for gRPC calls
  final Duration timeout;

  VoiceBiometricsServiceConfig({
    this.host = 'voice-biometrics-service',
    this.port = 50060,
    this.options,
    this.timeout = const Duration(seconds: 30),
  });

  /// Production configuration
  factory VoiceBiometricsServiceConfig.production() {
    return VoiceBiometricsServiceConfig(
      host: 'voice-biometrics-service.lazervault.com',
      port: 50060,
      timeout: const Duration(seconds: 30),
    );
  }

  /// Development configuration
  factory VoiceBiometricsServiceConfig.development() {
    return VoiceBiometricsServiceConfig(
      host: 'localhost',
      port: 50060,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
      timeout: const Duration(seconds: 30),
    );
  }

  /// Staging configuration
  factory VoiceBiometricsServiceConfig.staging() {
    return VoiceBiometricsServiceConfig(
      host: 'staging-voice-biometrics.lazervault.com',
      port: 50060,
      timeout: const Duration(seconds: 30),
    );
  }
}
