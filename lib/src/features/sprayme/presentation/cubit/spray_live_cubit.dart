import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_state.dart';

/// Owns the SprayMe live-video MEDIA plane (LiveKit). The money/gift/comment
/// signalling stays on [SprayMeWebSocketService] and [SprayRoomCubit]; this cubit
/// only handles camera/broadcast + viewer subscription, reacting to the same WS
/// events (stream_started/stopped, cohost_invited/revoked, topology_switched).
class SprayLiveCubit extends Cubit<SprayLiveState> {
  final ISprayMeRepository _repository;
  final SprayMeWebSocketService _wsService;

  StreamSubscription<SprayRoomEvent>? _wsSub;
  EventsListener<RoomEvent>? _roomListener;

  SpraySession? _session;
  String _currentUserId = '';
  bool _isHost = false;
  bool _frontCamera = true;

  SprayLiveCubit({
    required ISprayMeRepository repository,
    required SprayMeWebSocketService wsService,
  })  : _repository = repository,
        _wsService = wsService,
        super(const SprayLiveState());

  String get _sessionId => _session?.id ?? '';

  /// Wire the cubit to a session. Subscribes to WS lifecycle events and, if the
  /// session is already live and we are not the host, starts watching.
  void bind(SpraySession session, String currentUserId) {
    _session = session;
    _currentUserId = currentUserId;
    _isHost = session.hostUserId.isNotEmpty && session.hostUserId == currentUserId;

    _wsSub ??= _wsService.events.listen(_onWsEvent);

    if (!_isHost && session.isLiveVideo) {
      // Someone is already broadcasting — join as a viewer.
      unawaited(watch());
    }
  }

  /// Keep the cubit's view of the session fresh (e.g. after a room refresh).
  ///
  /// Also recovers a MISSED `stream_started` WS frame: if the host is now live
  /// (per the refreshed session) but we're a viewer who isn't watching or
  /// connecting yet, start watching. Without this, a viewer whose socket was
  /// mid-reconnect when the host went live would sit on the avatar background
  /// forever. Skip the error phase to avoid a tight retry loop.
  void updateSession(SpraySession session) {
    _session = session;
    if (!_isHost &&
        session.isLiveVideo &&
        !state.isLiveActive &&
        state.phase != SprayLivePhase.connecting &&
        state.phase != SprayLivePhase.error) {
      unawaited(watch());
    }
  }

  // ─── Host: start / stop broadcast ──────────────────────────────

  Future<void> goLive({bool recording = false}) async {
    if (_sessionId.isEmpty || !_isHost) return;
    emit(state.copyWith(phase: SprayLivePhase.connecting, role: 'host', clearError: true));

    if (!await _ensureCameraMicPermissions()) {
      emit(state.copyWith(phase: SprayLivePhase.error, error: 'Camera and microphone permission are required to go live.'));
      return;
    }

    try {
      final resp = await _repository.startStream(_sessionId, recordingEnabled: recording);
      final url = resp['url'] as String? ?? '';
      final token = resp['token'] as String? ?? '';
      if (url.isEmpty || token.isEmpty) {
        throw Exception('live video is not available right now');
      }
      await _connectRoom(url, token, publish: true);
      emit(state.copyWith(
        phase: SprayLivePhase.broadcasting,
        role: 'host',
        isCameraOn: true,
        isMicOn: true,
        isRecording: recording,
      ));
    } catch (e) {
      emit(state.copyWith(phase: SprayLivePhase.error, error: _clean(e)));
    }
  }

  Future<void> stopLive() async {
    if (_sessionId.isEmpty) return;
    try {
      if (_isHost) {
        await _repository.stopStream(_sessionId);
      }
    } catch (_) {
      // best-effort — tear down locally regardless
    }
    await _teardownRoom();
    emit(const SprayLiveState());
  }

  /// Host: pause the broadcast without ending it. Suspends the local camera/mic and
  /// tells the room (viewers render a paused overlay). The LiveKit room, co-hosts and
  /// any recording stay intact so [resume] is instant.
  Future<String?> pause() async {
    if (!_isHost || _sessionId.isEmpty || !state.isLiveActive) return null;
    // Optimistically suspend media + flag paused so the UI reacts immediately.
    final lp = state.room?.localParticipant;
    await lp?.setCameraEnabled(false);
    await lp?.setMicrophoneEnabled(false);
    emit(state.copyWith(isPaused: true, isCameraOn: false, isMicOn: false));
    _refreshTracks();
    try {
      await _repository.pauseStream(_sessionId);
      return null;
    } catch (e) {
      // Roll back the flag but keep media off — the host can retry.
      emit(state.copyWith(isPaused: false));
      return _clean(e);
    }
  }

  /// Host: resume a paused broadcast.
  Future<String?> resume() async {
    if (!_isHost || _sessionId.isEmpty) return null;
    final lp = state.room?.localParticipant;
    await lp?.setCameraEnabled(true);
    await lp?.setMicrophoneEnabled(true);
    emit(state.copyWith(isPaused: false, isCameraOn: true, isMicOn: true));
    _refreshTracks();
    try {
      await _repository.resumeStream(_sessionId);
      return null;
    } catch (e) {
      return _clean(e);
    }
  }

  // ─── Viewer / co-host: watch ───────────────────────────────────

  Future<void> watch() async {
    if (_sessionId.isEmpty) return;
    emit(state.copyWith(phase: SprayLivePhase.connecting, clearError: true));
    try {
      final resp = await _repository.getStreamToken(_sessionId);
      final mode = resp['mode'] as String? ?? 'webrtc';
      final role = resp['role'] as String? ?? 'viewer';
      final paused = resp['paused'] as bool? ?? false;

      if (mode == 'hls') {
        final hls = resp['hls_url'] as String? ?? '';
        await _teardownRoom(); // drop any WebRTC room if we were on one
        emit(state.copyWith(phase: SprayLivePhase.watchingHls, role: 'viewer', hlsUrl: hls, isPaused: paused, clearRoom: true));
        return;
      }

      final url = resp['url'] as String? ?? '';
      final token = resp['token'] as String? ?? '';
      if (url.isEmpty || token.isEmpty) throw Exception('live stream unavailable');

      var publish = role == 'host' || role == 'cohost';
      if (publish && !await _ensureCameraMicPermissions()) {
        // Permission declined — DON'T drop the stream they were watching. Join
        // as a viewer instead (the publish token simply goes unused) and tell
        // them why they're not on the stage.
        publish = false;
        emit(state.copyWith(
            error: 'Camera/microphone denied — you joined as a viewer.'));
      }
      await _connectRoom(url, token, publish: publish);
      emit(state.copyWith(
        phase: publish ? SprayLivePhase.broadcasting : SprayLivePhase.watchingWebRtc,
        role: publish ? role : 'viewer',
        coHostInvitePending: false,
        isCameraOn: publish,
        isMicOn: publish,
        isPaused: paused,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(phase: SprayLivePhase.error, error: _clean(e)));
    }
  }

  /// Accept a co-host invite addressed to the current user — re-requests a token,
  /// which now carries publish grants (the server promoted us).
  Future<void> acceptCoHostInvite() async {
    if (!state.coHostInvitePending) return;
    await watch();
  }

  void declineCoHostInvite() {
    emit(state.copyWith(coHostInvitePending: false));
  }

  // ─── Host controls over other broadcasters ─────────────────────

  Future<String?> inviteCoHost({required String userId, String userName = ''}) async {
    if (!_isHost || _sessionId.isEmpty) return 'only the host can invite co-hosts';
    try {
      await _repository.inviteCoHost(_sessionId, userId: userId, userName: userName);
      return null;
    } catch (e) {
      return _clean(e);
    }
  }

  Future<void> revokeCoHost(String userId) async {
    if (!_isHost || _sessionId.isEmpty) return;
    try {
      await _repository.revokeCoHost(_sessionId, userId: userId);
    } catch (_) {}
  }

  // ─── Local broadcaster media controls ──────────────────────────

  Future<void> toggleCamera() async {
    final lp = state.room?.localParticipant;
    if (lp == null) return;
    final next = !state.isCameraOn;
    // Turning the camera back on while paused IS a resume: otherwise the paused
    // overlay (gated on isPaused) stays over a live camera and viewers still see
    // "Live paused" while the host is actually broadcasting again.
    if (next && state.isPaused) {
      await resume();
      return;
    }
    await lp.setCameraEnabled(next);
    emit(state.copyWith(isCameraOn: next));
    _refreshTracks();
  }

  Future<void> toggleMic() async {
    final lp = state.room?.localParticipant;
    if (lp == null) return;
    final next = !state.isMicOn;
    await lp.setMicrophoneEnabled(next);
    emit(state.copyWith(isMicOn: next));
  }

  Future<void> flipCamera() async {
    final lp = state.room?.localParticipant;
    if (lp == null) return;
    try {
      final pub = lp.videoTrackPublications.where((p) => p.track != null).firstOrNull;
      final track = pub?.track;
      if (track is LocalVideoTrack) {
        _frontCamera = !_frontCamera;
        await track.setCameraPosition(_frontCamera ? CameraPosition.front : CameraPosition.back);
      }
    } catch (e) {
      debugPrint('flipCamera error: $e');
    }
  }

  Future<String?> toggleRecording() async {
    if (!_isHost || _sessionId.isEmpty) return 'only the host can record';
    final next = !state.isRecording;
    try {
      await _repository.toggleRecording(_sessionId, enabled: next);
      emit(state.copyWith(isRecording: next));
      return null;
    } catch (e) {
      return _clean(e);
    }
  }

  // ─── WebSocket lifecycle events ────────────────────────────────

  void _onWsEvent(SprayRoomEvent event) {
    if (isClosed) return;
    switch (event.type) {
      case 'stream_started':
        if (!_isHost && !state.isLiveActive) {
          unawaited(watch());
        }
      case 'stream_stopped':
        if (!_isHost) {
          unawaited(_teardownRoom());
          emit(const SprayLiveState());
        }
      case 'session_ended':
        // The whole session ended — drop any live video for everyone (host too).
        if (state.isLiveActive || state.phase == SprayLivePhase.connecting) {
          unawaited(_teardownRoom());
          emit(const SprayLiveState());
        }
      case 'stream_paused':
        // The host paused — reflect it for viewers/co-hosts (the host set it locally).
        if (!_isHost && state.isLiveActive) {
          emit(state.copyWith(isPaused: true));
        }
      case 'stream_resumed':
        if (!_isHost && state.isLiveActive) {
          emit(state.copyWith(isPaused: false));
        }
      case 'topology_switched':
        final topology = event.data['topology'] as String? ?? '';
        // Only affects non-broadcasting viewers on WebRTC.
        if (topology == 'hls' && state.phase == SprayLivePhase.watchingWebRtc) {
          unawaited(watch()); // re-resolve — server will now hand back an HLS url
        }
      case 'cohost_invited':
        final target = event.data['user_id'] as String? ?? '';
        if (target == _currentUserId && !state.isBroadcaster) {
          emit(state.copyWith(coHostInvitePending: true));
        }
      case 'cohost_revoked':
        final target = event.data['user_id'] as String? ?? '';
        if (target == _currentUserId && state.role == 'cohost') {
          // We were demoted — fall back to viewing.
          unawaited(watch());
        }
      // Guest "boxes": the host approved MY request → re-resolve the token
      // (now cohost) and start publishing into a box. Removed/left → drop back
      // to viewing (same as a cohost revoke).
      case 'seat_approved':
        final target = event.data['user_id'] as String? ?? '';
        if (target == _currentUserId && !state.isBroadcaster) {
          unawaited(watch());
        }
      case 'seat_removed':
      case 'seat_left':
        final target = event.data['user_id'] as String? ?? '';
        if (target == _currentUserId && state.isBroadcaster && !_isHost) {
          unawaited(watch());
        }
    }
  }

  // ─── LiveKit room plumbing ─────────────────────────────────────

  Future<void> _connectRoom(String url, String token, {required bool publish}) async {
    await _teardownRoom();

    final room = Room();
    _roomListener = room.createListener()
      ..on<RoomDisconnectedEvent>((_) {
        if (isClosed) return;
        emit(state.copyWith(phase: SprayLivePhase.idle, clearRoom: true, tracks: const []));
      })
      ..on<TrackSubscribedEvent>((_) => _refreshTracks())
      ..on<TrackUnsubscribedEvent>((_) => _refreshTracks())
      ..on<LocalTrackPublishedEvent>((_) => _refreshTracks())
      ..on<LocalTrackUnpublishedEvent>((_) => _refreshTracks())
      ..on<ParticipantConnectedEvent>((_) => _refreshTracks())
      ..on<ParticipantDisconnectedEvent>((_) => _refreshTracks());

    await room.connect(url, token);

    if (publish) {
      await room.localParticipant?.setCameraEnabled(true);
      await room.localParticipant?.setMicrophoneEnabled(true);
    }

    emit(state.copyWith(room: room));
    _refreshTracks();
  }

  /// Rebuild the renderable track list from the current room participants.
  void _refreshTracks() {
    final room = state.room;
    if (room == null || isClosed) return;
    final tracks = <SprayLiveTrack>[];

    // LiveKit identity is "user-<userId>" (gateway MintToken), so the host is
    // identifiable — the video layer always makes the host the full-screen
    // primary and everyone else a guest box.
    final hostIdentity = (_session?.hostUserId.isNotEmpty ?? false)
        ? 'user-${_session!.hostUserId}'
        : '';

    final lp = room.localParticipant;
    if (lp != null) {
      for (final pub in lp.videoTrackPublications) {
        final VideoTrack? t = pub.track;
        if (t == null) continue;
        tracks.add(SprayLiveTrack(
          participantId: lp.identity,
          name: lp.name.isNotEmpty ? lp.name : 'You',
          track: t,
          isLocal: true,
          isHost: hostIdentity.isNotEmpty && lp.identity == hostIdentity,
        ));
      }
    }

    for (final rp in room.remoteParticipants.values) {
      for (final pub in rp.videoTrackPublications) {
        final VideoTrack? t = pub.track;
        if (t == null || !pub.subscribed) continue;
        tracks.add(SprayLiveTrack(
          participantId: rp.identity,
          name: rp.name.isNotEmpty ? rp.name : rp.identity,
          track: t,
          isLocal: false,
          isHost: hostIdentity.isNotEmpty && rp.identity == hostIdentity,
        ));
      }
    }

    emit(state.copyWith(tracks: tracks));
  }

  Future<void> _teardownRoom() async {
    await _roomListener?.dispose();
    _roomListener = null;
    final room = state.room;
    if (room != null) {
      try {
        await room.disconnect();
      } catch (_) {}
      await room.dispose();
    }
  }

  // ─── Helpers ───────────────────────────────────────────────────

  Future<bool> _ensureCameraMicPermissions() async {
    final cam = await Permission.camera.request();
    final mic = await Permission.microphone.request();
    return cam.isGranted && mic.isGranted;
  }

  String _clean(Object e) => e.toString().replaceAll('Exception: ', '');

  @override
  Future<void> close() async {
    await _wsSub?.cancel();
    await _teardownRoom();
    return super.close();
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
