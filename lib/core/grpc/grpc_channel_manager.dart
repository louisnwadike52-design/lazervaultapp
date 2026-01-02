import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Manages gRPC channels and provides authentication interceptors
class GrpcChannelManager {
  final String host;
  final int port;
  final SecureStorageService secureStorage;

  ClientChannel? _channel;

  GrpcChannelManager({
    required this.host,
    required this.port,
    required this.secureStorage,
  });

  /// Get or create the gRPC channel
  ClientChannel get channel {
    if (_channel == null) {
      _channel = ClientChannel(
        host,
        port: port,
        options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          connectionTimeout: const Duration(seconds: 10),
          idleTimeout: const Duration(seconds: 60),
        ),
      );
    }
    return _channel!;
  }

  /// Create call options with authentication token
  Future<CallOptions> getAuthCallOptions() async {
    final accessToken = await secureStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      return CallOptions(
        metadata: {
          'authorization': 'Bearer $accessToken',
        },
        timeout: const Duration(seconds: 30),
      );
    }

    return CallOptions(
      timeout: const Duration(seconds: 30),
    );
  }

  /// Create call options without authentication
  CallOptions getCallOptions() {
    return CallOptions(
      timeout: const Duration(seconds: 30),
    );
  }

  /// Close the channel
  Future<void> close() async {
    await _channel?.shutdown();
    _channel = null;
  }

  /// Dispose resources
  void dispose() {
    _channel?.shutdown();
    _channel = null;
  }
}
