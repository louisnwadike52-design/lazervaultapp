import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_media_options.dart';

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
    _isHost =
        session.hostUserId.isNotEmpty && session.hostUserId == currentUserId;

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

  /// Start broadcasting.
  ///
  /// [withVideo] false starts an AUDIO-ONLY live: the room, the guest boxes,
  /// the spraying and every viewer's audio work exactly as they do with video,
  /// the host's camera simply never publishes. It is a real mode, not a
  /// degraded one — a host walking round a party with the phone in their
  /// pocket still wants to be heard, and it costs a fraction of the uplink.
  ///
  /// It is also the only way voice exists outside video at all: avatar mode
  /// has no media plane, so there is nothing to carry sound. "Go live, camera
  /// off" is what "non-video mode with voice" has to mean.
  Future<void> goLive({bool recording = false, bool withVideo = true}) async {
    if (_sessionId.isEmpty || !_isHost) return;
    _leftDeliberately = false;
    _cancelReconnect();
    emit(state.copyWith(
        phase: SprayLivePhase.connecting, role: 'host', clearError: true));

    if (!await _ensureCameraMicPermissions(camera: withVideo)) {
      emit(state.copyWith(
          phase: SprayLivePhase.error,
          error: withVideo
              ? 'Camera and microphone permission are required to go live.'
              : 'Microphone permission is required to go live with audio.'));
      return;
    }

    try {
      final resp = await _repository.startStream(_sessionId,
          recordingEnabled: recording);
      final url = resp['url'] as String? ?? '';
      final token = resp['token'] as String? ?? '';
      if (url.isEmpty || token.isEmpty) {
        throw Exception('live video is not available right now');
      }
      await _connectRoom(url, token, publish: true, withCamera: withVideo);
      _cancelReconnect();
      emit(state.copyWith(
        phase: SprayLivePhase.broadcasting,
        role: 'host',
        isCameraOn: withVideo,
        isMicOn: true,
        isAudioOnly: !withVideo,
        isRecording: recording,
      ));
    } catch (e) {
      emit(state.copyWith(phase: SprayLivePhase.error, error: _clean(e)));
    }
  }

  Future<void> stopLive() async {
    if (_sessionId.isEmpty) return;
    // Deliberate: suppress the reconnect loop that an unexpected drop arms.
    _leftDeliberately = true;
    _cancelReconnect();
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
        emit(state.copyWith(
            phase: SprayLivePhase.watchingHls,
            role: 'viewer',
            hlsUrl: hls,
            isPaused: paused,
            clearRoom: true));
        return;
      }

      final url = resp['url'] as String? ?? '';
      final token = resp['token'] as String? ?? '';
      if (url.isEmpty || token.isEmpty)
        throw Exception('live stream unavailable');

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
      _cancelReconnect();
      emit(state.copyWith(
        phase: publish
            ? SprayLivePhase.broadcasting
            : SprayLivePhase.watchingWebRtc,
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

  /// Accept the host's invite to come on stage.
  ///
  /// THE INVITE IS ANSWERED ON THE SERVER FIRST, and that is the change.
  /// Before, the host's invite had already seated the guest, so this only
  /// re-fetched a token; the banner was asking permission for something that
  /// had happened. Now an invite is a pending question (seat_state "invited"),
  /// RequestSeat on a pending invite seats the guest immediately — the host has
  /// already consented, so there is nothing left to approve — and only then do
  /// we go and get a publishing token.
  ///
  /// Returns null on success, else a message to show IN THE BANNER.
  ///
  /// Failing an acceptance must leave the guest exactly where they were. They
  /// came in watching; a promotion that fails is not a reason to tear down a
  /// stream they can still perfectly well watch.
  Future<String?> acceptCoHostInvite() async {
    if (!state.coHostInvitePending || state.coHostBusy) return null;

    final priorPhase = state.phase;
    final priorRole = state.role;
    emit(state.copyWith(coHostBusy: true, clearCoHostError: true));

    // 1. Take the seat. The server decides: the stage may have filled while
    //    the banner sat there, the host may have cancelled, the host may have
    //    turned the video off.
    try {
      await _repository.requestSeat(_sessionId);
    } catch (e) {
      final reason = _clean(e);
      emit(state.copyWith(
        coHostBusy: false,
        coHostInvitePending: true, // still invited; they can retry
        coHostError: reason.isEmpty
            ? 'Could not join the stage. Please try again.'
            : reason,
      ));
      return state.coHostError;
    }

    // 2. Now that we hold a box, fetch the token that goes with it.
    await watch();

    if (state.phase == SprayLivePhase.error) {
      final reason = state.error;
      emit(state.copyWith(
        phase: priorPhase,
        role: priorRole,
        coHostBusy: false,
        coHostInvitePending: true,
        coHostError: (reason == null || reason.isEmpty)
            ? 'Could not join the stage. Please try again.'
            : reason,
        clearError: true,
      ));
      return state.coHostError;
    }

    // watch() clears coHostInvitePending itself on a publishing join. A viewer
    // token coming back anyway means the seat went away between the two calls.
    if (state.role != 'host' && state.role != 'cohost') {
      const msg =
          'The stage is full or the invite is no longer valid — you joined as a viewer.';
      emit(state.copyWith(
          coHostBusy: false, coHostInvitePending: false, coHostError: msg));
      return msg;
    }

    emit(state.copyWith(
        coHostBusy: false,
        coHostInvitePending: false,
        clearCoHostError: true));
    return null;
  }

  /// Turn the host's invite down — and tell them so.
  ///
  /// This used to clear a local flag and nothing else. The banner vanished on
  /// the guest's phone, the host was never told, and the host sat watching a
  /// box they believed was about to fill while the guest had already said no.
  /// LeaveSeat on a pending invite records a decline, frees the box for
  /// somebody else and shows the host a "Declined" badge.
  ///
  /// The local flag clears FIRST and unconditionally: a guest who says no has
  /// said no, and a network failure must not leave the banner stuck on their
  /// screen. The server call is best-effort behind it.
  Future<void> declineCoHostInvite() async {
    emit(state.copyWith(
        coHostInvitePending: false,
        coHostBusy: false,
        clearCoHostError: true));
    if (_sessionId.isEmpty) return;
    try {
      await _repository.leaveSeat(_sessionId);
    } catch (_) {
      // Best-effort: the host's view re-syncs on the next roster refresh, and
      // the invite is no longer shown here either way.
    }
  }

  /// Dismiss the inline co-host error without dismissing the invite.
  void clearCoHostError() {
    if (state.coHostError == null) return;
    emit(state.copyWith(clearCoHostError: true));
  }

  // ─── Host controls over other broadcasters ─────────────────────

  Future<String?> inviteCoHost(
      {required String userId, String userName = ''}) async {
    if (!_isHost || _sessionId.isEmpty)
      return 'only the host can invite co-hosts';
    try {
      await _repository.inviteCoHost(_sessionId,
          userId: userId, userName: userName);
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
      final pub =
          lp.videoTrackPublications.where((p) => p.track != null).firstOrNull;
      final track = pub?.track;
      if (track is LocalVideoTrack) {
        _frontCamera = !_frontCamera;
        await track.setCameraPosition(
            _frontCamera ? CameraPosition.front : CameraPosition.back);
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
          _leftDeliberately = false;
          _cancelReconnect();
          unawaited(watch());
        }
      case 'stream_stopped':
        // THE HOST TURNED THE CAMERA OFF. THE PARTY IS STILL ON.
        //
        // This used to be handled identically to session_ended, so a host
        // switching back to avatar mode looked to everyone else exactly like
        // the session finishing. The room, the comments, the spraying and the
        // wallet are all still live; only the video is gone. The distinction
        // is carried in state so the room can say the right thing.
        if (!_isHost) {
          _leftDeliberately = true; // the host's choice, not a failure
          _cancelReconnect();
          unawaited(_teardownRoom());
          emit(const SprayLiveState(videoEndedByHost: true));
        }
      case 'session_ended':
        // The whole session ended — drop any live video for everyone (host too).
        if (state.isLiveActive || state.phase == SprayLivePhase.connecting) {
          _leftDeliberately = true;
          _cancelReconnect();
          unawaited(_teardownRoom());
          emit(const SprayLiveState(sessionEnded: true));
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
          unawaited(
              watch()); // re-resolve — server will now hand back an HLS url
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

  Future<void> _connectRoom(String url, String token,
      {required bool publish, bool withCamera = true}) async {
    await _teardownRoom();

    final room = Room(roomOptions: SprayMediaOptions.room());
    _roomListener = room.createListener()
      ..on<RoomDisconnectedEvent>((e) {
        if (isClosed) return;
        emit(state.copyWith(
            phase: SprayLivePhase.idle, clearRoom: true, tracks: const []));
        // A DROPPED CONNECTION IS NOT THE END OF THE STREAM.
        //
        // This used to be the whole handler: any disconnect — a tunnel, a
        // Wi-Fi/4G handover, iOS suspending the socket while the app sat in
        // the background — dropped the phase to idle and nothing ever brought
        // it back. The stream went black and stayed black until the viewer
        // left the room and came in again. That is the "minimised the app and
        // the video stopped" report.
        //
        // LiveKit already retries internally; by the time this event fires it
        // has given up, so reconnecting is ours to do. Only when the host is
        // still live and we did not leave on purpose.
        _scheduleReconnect();
      })
      ..on<TrackSubscribedEvent>((_) => _refreshTracks())
      ..on<TrackUnsubscribedEvent>((_) => _refreshTracks())
      ..on<LocalTrackPublishedEvent>((_) => _refreshTracks())
      ..on<LocalTrackUnpublishedEvent>((_) => _refreshTracks())
      ..on<ParticipantConnectedEvent>((_) => _refreshTracks())
      ..on<ParticipantDisconnectedEvent>((_) => _refreshTracks());

    await room.connect(url, token,
        connectOptions: SprayMediaOptions.connect());

    if (publish) {
      // MIC FIRST, AND ALWAYS.
      //
      // The camera used to be enabled first and the mic second, and both were
      // tied to video mode. Two consequences: a camera permission prompt or a
      // slow capture-session start delayed the voice behind it, and an
      // audio-only broadcast had no audio at all because nothing ever asked
      // for the mic outside live video. Voice is the part of a party nobody
      // can do without, so it goes up first and independently.
      await room.localParticipant?.setMicrophoneEnabled(true);
      if (withCamera) {
        await room.localParticipant?.setCameraEnabled(true);
      }
    }

    // Route to the loudspeaker rather than the earpiece. Without this a
    // viewer holds the phone like a handset to hear anything, which reads
    // as "there is no sound".
    try {
      await Hardware.instance.setSpeakerphoneOn(true);
    } catch (_) {
      // Routing is best-effort; never fail a connection over it.
    }

    emit(state.copyWith(room: room));
    _refreshTracks();
  }

  // ─── Reconnection ──────────────────────────────────────────────

  Timer? _reconnectTimer;
  int _reconnectAttempt = 0;
  bool _leftDeliberately = false;

  /// Try to get back on the stream after an unexpected disconnect.
  ///
  /// Backs off 1s, 2s, 4s, 8s, 16s and then every 16s, so a long outage keeps
  /// retrying without hammering the gateway. Cancelled the moment a connection
  /// succeeds, the user leaves, or the host stops the stream.
  void _scheduleReconnect() {
    if (isClosed || _leftDeliberately || _sessionId.isEmpty) return;
    if (_session?.isLiveVideo != true) return;
    _reconnectTimer?.cancel();
    final seconds = [1, 2, 4, 8, 16][
        _reconnectAttempt.clamp(0, 4)];
    _reconnectAttempt++;
    _reconnectTimer = Timer(Duration(seconds: seconds), () {
      if (isClosed || _leftDeliberately) return;
      if (state.isLiveActive) return; // something else already recovered us
      unawaited(watch());
    });
  }

  void _cancelReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempt = 0;
  }

  /// The app came back to the foreground.
  ///
  /// iOS suspends the media socket and the camera a few seconds after the app
  /// leaves the screen, and Android can kill the capture under memory
  /// pressure. Coming back needs an explicit nudge: re-publish the host's
  /// camera if the OS stopped it, and reconnect if we were dropped.
  Future<void> onAppResumed() async {
    if (isClosed || _sessionId.isEmpty) return;
    _leftDeliberately = false;

    final room = state.room;
    if (room != null && state.isLiveActive) {
      if (state.isBroadcaster && !state.isPaused) {
        final lp = room.localParticipant;
        try {
          // Idempotent: re-asserting an already-live track is a no-op, and it
          // re-acquires one the OS tore down while we were away.
          if (state.isMicOn) await lp?.setMicrophoneEnabled(true);
          if (state.isCameraOn) await lp?.setCameraEnabled(true);
        } catch (_) {
          // If the devices cannot be re-acquired, a reconnect will.
          _scheduleReconnect();
          return;
        }
      }
      _refreshTracks();
      return;
    }

    // We were dropped while backgrounded. Come back now rather than waiting
    // out the backoff — the user is looking at the screen.
    if (_session?.isLiveVideo == true) {
      _cancelReconnect();
      unawaited(watch());
    }
  }

  /// The app went to the background. Nothing is torn down — a host walking
  /// between rooms with the app still open must stay live — this only records
  /// that any disconnect from here is expected rather than a failure.
  void onAppPaused() {
    _refreshTracks();
  }

  /// Rebuild the renderable track list from the current room participants.
  void _refreshTracks() {
    final room = state.room;
    if (room == null || isClosed) return;
    final tracks = <SprayLiveTrack>[];
    // Does the HOST have live audio? Used below to tell an audio-only
    // broadcast apart from a stream that simply has not arrived — see
    // SprayLiveState.isAudioOnly.
    var hostHasAudio = false;

    // LiveKit identity is "user-<userId>" (gateway MintToken), so the host is
    // identifiable — the video layer always makes the host the full-screen
    // primary and everyone else a guest box.
    final hostIdentity = (_session?.hostUserId.isNotEmpty ?? false)
        ? 'user-${_session!.hostUserId}'
        : '';

    final lp = room.localParticipant;
    if (lp != null) {
      if (hostIdentity.isNotEmpty && lp.identity == hostIdentity) {
        hostHasAudio = lp.audioTrackPublications.any((p) => !p.muted);
      }
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

    // Nova's presence comes from LiveKit's own participant kind, which the
    // server sets for a dispatched agent. She publishes audio only, so she is
    // invisible to the video-track loop below and has to be detected here.
    var novaPresent = false;

    for (final rp in room.remoteParticipants.values) {
      if (rp.kind == ParticipantKind.AGENT) novaPresent = true;
      if (hostIdentity.isNotEmpty && rp.identity == hostIdentity) {
        hostHasAudio = rp.audioTrackPublications.any((p) => !p.muted);
      }
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

    // AUDIO-ONLY = the host is carrying live audio but published no video.
    // Derived rather than stored so it follows the actual media state: a host
    // toggling the camera flips this without any extra signalling, and a viewer
    // still connecting (no host audio yet) is correctly NOT called audio-only,
    // so they keep the honest "Waiting for video…" message.
    final hostVideo = tracks.any((t) => t.isHost);
    emit(state.copyWith(
      tracks: tracks,
      isAudioOnly: hostHasAudio && !hostVideo,
      novaInLive: novaPresent,
    ));
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

  /// The microphone is ALWAYS required to broadcast; the camera only when
  /// video is actually going out. Asking for the camera to start an audio-only
  /// live is a prompt the host has no reason to accept, and refusing it used
  /// to block a broadcast that needed no camera at all.
  Future<bool> _ensureCameraMicPermissions({bool camera = true}) async {
    final mic = await Permission.microphone.request();
    if (!mic.isGranted) return false;
    if (!camera) return true;
    final cam = await Permission.camera.request();
    return cam.isGranted;
  }

  String _clean(Object e) => e.toString().replaceAll('Exception: ', '');

  @override
  Future<void> close() async {
    _leftDeliberately = true;
    _cancelReconnect();
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
