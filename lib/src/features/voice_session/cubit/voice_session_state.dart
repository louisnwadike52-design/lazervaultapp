import 'package:equatable/equatable.dart';
import 'package:livekit_client/livekit_client.dart';


abstract class VoiceSessionState extends Equatable {
  const VoiceSessionState();

  @override
  List<Object?> get props => [];
}

class VoiceSessionInitial extends VoiceSessionState {}

class VoiceSessionLoadingCredentials extends VoiceSessionState {}

class VoiceSessionCredentialsLoaded extends VoiceSessionState {
  final String roomName;
  final String livekitToken;
  // You'll need the LiveKit URL, fetch from config or hardcode for now
  final String livekitUrl; 

  const VoiceSessionCredentialsLoaded({
    required this.roomName,
    required this.livekitToken,
    required this.livekitUrl,
  });

  @override
  List<Object?> get props => [roomName, livekitToken, livekitUrl];
}

class VoiceSessionCredentialsError extends VoiceSessionState {
  final String message;
  const VoiceSessionCredentialsError(this.message);
  @override
  List<Object?> get props => [message];
}

class VoiceSessionConnectingToRoom extends VoiceSessionState {}

class VoiceSessionConnected extends VoiceSessionState {
  final Room room;
  const VoiceSessionConnected(this.room);
  @override
  List<Object?> get props => [room];
}

class VoiceSessionDisconnected extends VoiceSessionState {}

class VoiceSessionError extends VoiceSessionState {
  final String message;
  const VoiceSessionError(this.message);
  @override
  List<Object?> get props => [message];
}

class VoiceSessionMicPermissionDenied extends VoiceSessionState {}

class VoiceSessionMicPermissionGranted extends VoiceSessionState {}

class VoiceSessionLocalUserSpeaking extends VoiceSessionState {
  final Room room; // Keep room reference if needed for UI updates
  const VoiceSessionLocalUserSpeaking(this.room);
  @override
  List<Object?> get props => [room];
}

class VoiceSessionLocalUserNotSpeaking extends VoiceSessionState {
  final Room room; // Keep room reference
  const VoiceSessionLocalUserNotSpeaking(this.room);
  @override
  List<Object?> get props => [room];
}

class VoiceSessionAgentProcessing extends VoiceSessionState {
  final Room room; // Keep room reference if UI needs it
  const VoiceSessionAgentProcessing(this.room);
  @override
  List<Object?> get props => [room];
}

class VoiceSessionTransferCompleted extends VoiceSessionState {
  final Map<String, dynamic> transferDetails;
  const VoiceSessionTransferCompleted(this.transferDetails);
  @override
  List<Object?> get props => [transferDetails];
} 