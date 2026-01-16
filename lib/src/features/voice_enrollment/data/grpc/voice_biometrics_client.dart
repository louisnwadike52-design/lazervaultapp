import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/voice-biometrics.pbgrpc.dart';

/// gRPC client for Voice Biometrics Service
class VoiceBiometricsClient {
  final ClientChannel _channel;
  late final VoiceBiometricsServiceClient _stub;

  VoiceBiometricsClient({
    required String host,
    required int port,
    ChannelOptions? options,
  })  : _channel = ClientChannel(
          host,
          port: port,
          options: options ?? const ChannelOptions(credentials: ChannelCredentials.insecure()),
        ) {
    _stub = VoiceBiometricsServiceClient(_channel);
  }

  /// Enroll voice for a user
  Future<EnrollVoiceResponse> enrollVoice({
    required String userId,
    required List<List<int>> audioSamples,
    String codec = 'wav',
    int sampleRate = 16000,
    int channels = 1,
    int bitDepth = 16,
    Map<String, String> metadata = const {},
  }) async {
    final request = EnrollVoiceRequest()
      ..userId = userId
      ..audioSamples.addAll(audioSamples)
      ..format = (AudioFormat()
        ..codec = codec
        ..sampleRate = sampleRate
        ..channels = channels
        ..bitDepth = bitDepth
      )
      ..metadata.addAll(metadata);

    return await _stub.enrollVoice(request);
  }

  /// Verify voice sample against enrolled user
  Future<VerifyVoiceResponse> verifyVoice({
    required String userId,
    required List<int> audioSample,
    String codec = 'wav',
    int sampleRate = 16000,
    int channels = 1,
    int bitDepth = 16,
    double threshold = 0.85,
    Map<String, String> metadata = const {},
  }) async {
    final request = VerifyVoiceRequest()
      ..userId = userId
      ..audioSample = audioSample
      ..format = (AudioFormat()
        ..codec = codec
        ..sampleRate = sampleRate
        ..channels = channels
        ..bitDepth = bitDepth
      )
      ..threshold = threshold
      ..metadata.addAll(metadata);

    return await _stub.verifyVoice(request);
  }

  /// Check if user has enrolled their voice
  Future<CheckEnrollmentStatusResponse> checkEnrollmentStatus({
    required String userId,
  }) async {
    final request = CheckEnrollmentStatusRequest()..userId = userId;
    return await _stub.checkEnrollmentStatus(request);
  }

  /// Delete user's voice enrollment
  Future<DeleteVoiceEnrollmentResponse> deleteVoiceEnrollment({
    required String userId,
  }) async {
    final request = DeleteVoiceEnrollmentRequest()..userId = userId;
    return await _stub.deleteVoiceEnrollment(request);
  }

  /// Update voice enrollment with additional samples
  Future<UpdateVoiceEnrollmentResponse> updateVoiceEnrollment({
    required String userId,
    required List<List<int>> audioSamples,
    String codec = 'wav',
    int sampleRate = 16000,
    int channels = 1,
    int bitDepth = 16,
  }) async {
    final request = UpdateVoiceEnrollmentRequest()
      ..userId = userId
      ..audioSamples.addAll(audioSamples)
      ..format = (AudioFormat()
        ..codec = codec
        ..sampleRate = sampleRate
        ..channels = channels
        ..bitDepth = bitDepth
      );

    return await _stub.updateVoiceEnrollment(request);
  }

  /// Get voice enrollment details
  Future<GetVoiceEnrollmentResponse> getVoiceEnrollment({
    required String userId,
  }) async {
    final request = GetVoiceEnrollmentRequest()..userId = userId;
    return await _stub.getVoiceEnrollment(request);
  }

  /// Shutdown the client connection
  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}
