import 'package:grpc/grpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GrpcConfig {
  static const String _cryptoHostKey = 'CRYPTO_GRPC_HOST';
  static const String _cryptoPortKey = 'CRYPTO_GRPC_PORT';
  static const String _voiceHostKey = 'VOICE_GRPC_HOST';
  static const String _voicePortKey = 'VOICE_GRPC_PORT';

  // Default values for development
  static const String _defaultCryptoHost = 'localhost';
  static const int _defaultCryptoPort = 50053;
  static const String _defaultVoiceHost = 'localhost';
  static const int _defaultVoicePort = 50051;

  static String get cryptoHost =>
      dotenv.env[_cryptoHostKey] ?? _defaultCryptoHost;

  static int get cryptoPort =>
      int.tryParse(dotenv.env[_cryptoPortKey] ?? '') ?? _defaultCryptoPort;

  static String get voiceHost =>
      dotenv.env[_voiceHostKey] ?? _defaultVoiceHost;

  static int get voicePort =>
      int.tryParse(dotenv.env[_voicePortKey] ?? '') ?? _defaultVoicePort;

  static ClientChannel createCryptoChannel() {
    return ClientChannel(
      cryptoHost,
      port: cryptoPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
  }

  static ClientChannel createVoiceChannel() {
    return ClientChannel(
      voiceHost,
      port: voicePort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
  }
}
