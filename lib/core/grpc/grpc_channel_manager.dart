import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/access_token_shape.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/network/network_timeouts.dart';

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
  /// The gRPC deadline for every authenticated call.
  ///
  /// This is the single biggest lever on whether the app works on a
  /// congested Nigerian cell: it caps EVERY backend request. It was 30s,
  /// which sounds generous on wifi and is not — DNS, TCP, TLS and the round
  /// trip can each cost seconds there, and a call cut off at 30s had often
  /// not failed, it was still arriving. See NetworkTimeouts.
  Future<CallOptions> getAuthCallOptions() async {
    final accessToken = await secureStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      return CallOptions(
        metadata: {
          ...authHeader(accessToken, key: 'authorization'),
        },
        timeout: NetworkTimeouts.interactive,
      );
    }

    return CallOptions(
      timeout: NetworkTimeouts.interactive,
    );
  }

  /// Create call options without authentication
  CallOptions getCallOptions() {
    return CallOptions(
      timeout: NetworkTimeouts.interactive,
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
