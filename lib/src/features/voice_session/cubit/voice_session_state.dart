import 'package:equatable/equatable.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';


abstract class VoiceSessionState extends Equatable {
  const VoiceSessionState();

  @override
  List<Object?> get props => [];
}

class VoiceSessionInitial extends VoiceSessionState {}

/// Language selection state — shown before starting the voice session.
class VoiceSessionLanguageSelection extends VoiceSessionState {
  final List<VoiceLanguage> availableLanguages;
  final String? selectedLanguageCode;

  const VoiceSessionLanguageSelection({
    required this.availableLanguages,
    this.selectedLanguageCode,
  });

  @override
  List<Object?> get props => [availableLanguages, selectedLanguageCode];
}

class VoiceSessionLoadingCredentials extends VoiceSessionState {}

class VoiceSessionCredentialsLoaded extends VoiceSessionState {
  final String roomName;
  final String livekitToken;
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
  final Room room;
  const VoiceSessionLocalUserSpeaking(this.room);
  @override
  List<Object?> get props => [room];
}

class VoiceSessionLocalUserNotSpeaking extends VoiceSessionState {
  final Room room;
  const VoiceSessionLocalUserNotSpeaking(this.room);
  @override
  List<Object?> get props => [room];
}

class VoiceSessionAgentProcessing extends VoiceSessionState {
  final Room room;
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

/// Visual feedback states — triggered by voice agent WebSocket events

class VoiceSessionUserSearchRequired extends VoiceSessionState {
  final Room room;
  final List<Map<String, dynamic>> users;
  final String query;
  const VoiceSessionUserSearchRequired(this.room, this.users, this.query);
  @override
  List<Object?> get props => [room, users, query];
}

class VoiceSessionTransferConfirmation extends VoiceSessionState {
  final Room room;
  final Map<String, dynamic> transferDetails;
  const VoiceSessionTransferConfirmation(this.room, this.transferDetails);
  @override
  List<Object?> get props => [room, transferDetails];
}

class VoiceSessionPinRequired extends VoiceSessionState {
  final Room room;
  final Map<String, dynamic> transactionPayload;
  const VoiceSessionPinRequired(this.room, this.transactionPayload);
  @override
  List<Object?> get props => [room, transactionPayload];
}

class VoiceSessionTransactionSuccess extends VoiceSessionState {
  final Room room;
  final Map<String, dynamic> result;
  const VoiceSessionTransactionSuccess(this.room, this.result);
  @override
  List<Object?> get props => [room, result];
}

/// Voice biometrics verification failed - user cannot proceed
class VoiceSessionVerificationFailed extends VoiceSessionState {
  final String message;
  const VoiceSessionVerificationFailed(this.message);
  @override
  List<Object?> get props => [message];
}
