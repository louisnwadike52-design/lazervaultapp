import 'package:grpc/grpc.dart';
import '../../generated/voice_session.pbgrpc.dart';

/// Wrapper class for Voice Session gRPC client
/// This provides a clean interface to interact with the lazervault-golang voice service
/// Uses the Core Gateway (7878) injected from injection_container
class VoiceGrpcClient {
  final ClientChannel _channel;
  late VoiceSessionServiceClient _client;

  /// Accepts an injected ClientChannel (Core Gateway from injection_container)
  /// This ensures all voice services go through the proper API gateway
  VoiceGrpcClient({required ClientChannel channel}) : _channel = channel {
    _client = VoiceSessionServiceClient(_channel);
  }

  /// Start a new voice session
  /// Returns room name and LiveKit token for connecting to the voice session
  Future<StartVoiceSessionResponse> startVoiceSession() async {
    try {
      final request = StartVoiceSessionRequest();
      final response = await _client.startVoiceSession(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Process a voice note (audio file)
  ///
  /// [audioData] - Audio file bytes
  /// [txHistory] - Optional transaction history JSON string
  Future<ProcessVoiceNoteResponse> processVoiceNote({
    required List<int> audioData,
    String? txHistory,
  }) async {
    try {
      final request = ProcessVoiceNoteRequest()
        ..txHistory = txHistory ?? '';

      // Note: The actual file upload might need special handling
      // depending on how the gRPC service expects the multipart data
      final response = await _client.processVoiceNote(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Close the gRPC channel
  Future<void> close() async {
    await _channel.shutdown();
  }
}
