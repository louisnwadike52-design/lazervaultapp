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

/// Agent detected a mid-conversation language switch (e.g., user spoke Yoruba).
/// UI should update the language indicator without interrupting the session.
class VoiceSessionLanguageChanged extends VoiceSessionState {
  final Room room;
  final String language;
  final String locale;
  const VoiceSessionLanguageChanged(this.room, this.language, this.locale);
  @override
  List<Object?> get props => [room, language, locale];
}

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

/// Voice biometrics low confidence — warn user but allow session to continue
class VoiceSessionLowConfidenceWarning extends VoiceSessionState {
  final Room room;
  final String message;
  const VoiceSessionLowConfidenceWarning(this.room, this.message);
  @override
  List<Object?> get props => [room, message];
}

/// Transaction-specific error from voice agent (insufficient funds, daily limit, etc.)
class VoiceSessionTransactionError extends VoiceSessionState {
  final Room room;
  final String message;
  final String errorType;
  const VoiceSessionTransactionError(this.room, this.message, this.errorType);
  @override
  List<Object?> get props => [room, message, errorType];
}

/// WebSocket permanently failed after max reconnect attempts.
/// Voice session still works (audio) but visual feedback (PIN, transfers) won't appear.
class VoiceSessionWebSocketFailed extends VoiceSessionState {
  final Room room;
  const VoiceSessionWebSocketFailed(this.room);
  @override
  List<Object?> get props => [room];
}

/// Session ended — show rating/thank-you screen
class VoiceSessionEnded extends VoiceSessionState {
  final String sessionId;
  const VoiceSessionEnded({required this.sessionId});
  @override
  List<Object?> get props => [sessionId];
}

/// Real-time caption states for YouTube-style transcription display

/// Interim (partial) transcription of user speech — updates continuously
class VoiceSessionUserCaptionInterim extends VoiceSessionState {
  final Room room;
  final String text;
  const VoiceSessionUserCaptionInterim(this.room, this.text);
  @override
  List<Object?> get props => [room, text];
}

/// Final transcription of user speech — complete sentence/phrase
class VoiceSessionUserCaptionFinal extends VoiceSessionState {
  final Room room;
  final String text;
  const VoiceSessionUserCaptionFinal(this.room, this.text);
  @override
  List<Object?> get props => [room, text];
}

/// AI agent started speaking — prepare caption display
class VoiceSessionAgentCaptionStart extends VoiceSessionState {
  final Room room;
  final String text;  // Full text that will be spoken
  const VoiceSessionAgentCaptionStart(this.room, this.text);
  @override
  List<Object?> get props => [room, text];
}

/// Chunk of text as AI agent speaks — for word-by-word streaming effect
class VoiceSessionAgentCaptionText extends VoiceSessionState {
  final Room room;
  final String text;  // Current chunk being spoken
  final String fullText;  // Full response for context
  const VoiceSessionAgentCaptionText(this.room, this.text, this.fullText);
  @override
  List<Object?> get props => [room, text, fullText];
}

/// AI agent finished speaking — clear agent caption
class VoiceSessionAgentCaptionEnd extends VoiceSessionState {
  final Room room;
  const VoiceSessionAgentCaptionEnd(this.room);
  @override
  List<Object?> get props => [room];
}

/// Combined state for captions — allows captions to overlay any other state
/// This wraps the current state with caption data
class VoiceSessionWithCaption extends VoiceSessionState {
  final VoiceSessionState baseState;
  final String? userCaption;  // Current user caption (null if none)
  final String? agentCaption;  // Current agent caption (null if none)
  final bool isAgentSpeaking;  // True if agent is currently speaking

  const VoiceSessionWithCaption({
    required this.baseState,
    this.userCaption,
    this.agentCaption,
    this.isAgentSpeaking = false,
  });

  @override
  List<Object?> get props => [baseState, userCaption, agentCaption, isAgentSpeaking];
}
