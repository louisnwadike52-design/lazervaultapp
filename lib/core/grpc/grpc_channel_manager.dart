import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Manages gRPC channels and provides authentication interceptors
/// Uses an injected ClientChannel from injection_container (Investment Gateway)
class GrpcChannelManager {
  final ClientChannel _channel;
  final SecureStorageService secureStorage;

  GrpcChannelManager({
    required ClientChannel channel,
    required this.secureStorage,
  }) : _channel = channel;

  /// Get the gRPC channel (now injected from injection_container)
  ClientChannel get channel => _channel;

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

  /// Close the channel (managed externally by injection_container)
  Future<void> close() async {
    // Channel lifecycle is managed by injection_container, no action needed
  }

  /// Dispose resources (managed externally by injection_container)
  void dispose() {
    // Channel lifecycle is managed by injection_container, no action needed
  }
}
