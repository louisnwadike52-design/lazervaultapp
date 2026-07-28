import 'package:livekit_client/livekit_client.dart';

/// Phase of the live-video layer, independent of the money/gift room state.
enum SprayLivePhase {
  /// No live video — the room shows the avatar/cover background.
  idle,

  /// Connecting to (or negotiating) the LiveKit room / HLS stream.
  connecting,

  /// Broadcasting our own camera (host or co-host).
  broadcasting,

  /// Watching someone else's broadcast over WebRTC.
  watchingWebRtc,

  /// Watching over HLS (large room, few-seconds latency).
  watchingHls,

  /// Something went wrong; [SprayLiveState.error] holds the message.
  error,
}

/// A renderable video track (local preview or a remote broadcaster).
class SprayLiveTrack {
  final String participantId;
  final String name;
  final VideoTrack track;
  final bool isLocal;
  final bool isHost; // the session host — always rendered as the primary view

  const SprayLiveTrack({
    required this.participantId,
    required this.name,
    required this.track,
    required this.isLocal,
    this.isHost = false,
  });
}

class SprayLiveState {
  final SprayLivePhase phase;
  final String role; // 'host' | 'cohost' | 'viewer'
  final Room? room;
  final List<SprayLiveTrack> tracks;
  final String hlsUrl;

  // Local broadcaster controls
  final bool isCameraOn;
  final bool isMicOn;
  final bool isRecording;

  // The host has paused the broadcast (camera/mic suspended, room still alive).
  // For a broadcaster it reflects their own pause; for a viewer it reflects the
  // host's paused state so we render the paused overlay.
  final bool isPaused;

  // A co-host invite addressed to the current user (awaiting accept).
  final bool coHostInvitePending;

  final String? error;

  const SprayLiveState({
    this.phase = SprayLivePhase.idle,
    this.role = 'viewer',
    this.room,
    this.tracks = const [],
    this.hlsUrl = '',
    this.isCameraOn = true,
    this.isMicOn = true,
    this.isRecording = false,
    this.isPaused = false,
    this.coHostInvitePending = false,
    this.error,
  });

  bool get isBroadcaster => role == 'host' || role == 'cohost';
  bool get isLiveActive =>
      phase == SprayLivePhase.broadcasting ||
      phase == SprayLivePhase.watchingWebRtc ||
      phase == SprayLivePhase.watchingHls;

  SprayLiveState copyWith({
    SprayLivePhase? phase,
    String? role,
    Room? room,
    bool clearRoom = false,
    List<SprayLiveTrack>? tracks,
    String? hlsUrl,
    bool? isCameraOn,
    bool? isMicOn,
    bool? isRecording,
    bool? isPaused,
    bool? coHostInvitePending,
    String? error,
    bool clearError = false,
  }) {
    return SprayLiveState(
      phase: phase ?? this.phase,
      role: role ?? this.role,
      room: clearRoom ? null : (room ?? this.room),
      tracks: tracks ?? this.tracks,
      hlsUrl: hlsUrl ?? this.hlsUrl,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      isMicOn: isMicOn ?? this.isMicOn,
      isRecording: isRecording ?? this.isRecording,
      isPaused: isPaused ?? this.isPaused,
      coHostInvitePending: coHostInvitePending ?? this.coHostInvitePending,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
