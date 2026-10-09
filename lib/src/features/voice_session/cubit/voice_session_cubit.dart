import 'dart:convert';
import 'dart:async';
import 'dart:io' show File, Platform;
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_pkg;
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_quota_sheet.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_customization_sheet.dart'
    show kMyVoiceSentinelId;

import 'package:lazervault/src/features/voice_session/voice_session_activity.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/services/remote_log_sink.dart';
import 'package:lazervault/src/features/voice_session/voice_echo_guard.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';
import 'package:lazervault/src/features/voice_session/models/voice_conversation.dart';
import 'package:lazervault/src/features/voice_session/models/voice_transfer_context.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_chat_history_cubit.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:lazervault/src/features/voice/models/voice_settings_models.dart'
    show CustomVoiceLiveState;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/logger.dart';
import '../services/voice_note_capture.dart';
import '../../../../core/config/voice_language_availability.dart';

class VoiceSessionCubit extends Cubit<VoiceSessionState> {

  // ── Voice session failures: one message for the user, the truth for ops ──
  //
  // These exist because the failure in the field showed the user
  // `500 {"error":"Failed to create voice session. Please try again."}` in a
  // red banner. Two things were wrong with that: it is our internals on their
  // screen, and the detail that would have identified the fault (which status,
  // which body, which error code) was going nowhere an operator could read it.
  // So the split is deliberate — the user gets a sentence they can act on, and
  // the raw text goes to the ops log sink, which already scrubs tokens and
  // bearer headers before shipping.

  /// What OPS sees — the real status, body and error, to Loki.
  void _reportSessionFailure(
    String reason, {
    int? statusCode,
    String? body,
    Object? error,
  }) {
    // Keep the console line for local debugging; it never reaches a user.
    print('VoiceSessionCubit: $reason '
        '(status=${statusCode ?? "-"}) ${error ?? body ?? ""}');
    try {
      RemoteLogSink.instance.log(
        level: 'error',
        flow: 'voice_session',
        message: 'voice session start failed: $reason',
        screen: 'voice_session',
        fields: {
          'reason': reason,
          if (statusCode != null) 'status_code': statusCode,
          // Bounded: a runaway body must not blow the log queue.
          if (body != null && body.isNotEmpty)
            'response_body':
                body.length > 600 ? '${body.substring(0, 600)}…' : body,
          if (error != null) 'error': error.toString(),
        },
      );
    } catch (_) {
      // Telemetry must never be the reason a voice session fails louder than
      // it already has.
    }
  }
  // --- Configuration ---
  // LiveKit Cloud's URL stays dotenv-only — LiveKit lives outside the
  // Cloudflare tunnel (it has its own SFU edge). The voice-ws, voice-
  // agent and voice-language URLs all come from the EndpointRegistry so
  // an admin URL rotation propagates without an app rebuild; dotenv
  // overrides are still honoured for local-dev (10.0.2.2 dialling).
  final String _livekitWsUrl = dotenv.env['LIVEKIT_URL'] ??
      (throw Exception('LIVEKIT_URL environment variable is not set.'));
  final String _voiceWsUrl = (dotenv.env['VOICE_WS_URL']?.isNotEmpty == true)
      ? dotenv.env['VOICE_WS_URL']!
      : endpointRegistry.wsVoice;
  final String _voiceLanguageApiUrl =
      (dotenv.env['VOICE_LANGUAGE_API_URL']?.isNotEmpty == true)
          ? dotenv.env['VOICE_LANGUAGE_API_URL']!
          : endpointRegistry.httpVoiceLang;
  final String _voiceAgentGatewayUrl =
      (dotenv.env['VOICE_AGENT_GATEWAY_URL']?.isNotEmpty == true)
          ? dotenv.env['VOICE_AGENT_GATEWAY_URL']!
          : endpointRegistry.httpVoiceAgent;

  static const String _prefKeyLanguage = 'voice_selected_language';
  static const String _prefKeyVoice = 'voice_selected_voice_id';

  /// Set once the user picks a voice THEMSELVES, which stops the cloned-voice
  /// auto-adoption from overriding them later.
  static const String _prefKeyVoiceChosenByUser = 'voice_chosen_by_user';
  // Remembers whether THIS user was granted African languages by the server's per-email
  // allowlist (the /voice/languages response includes yo/ig/ha/pcm only for granted
  // users). Used ONLY to gate the OFFLINE fallback picker so a non-granted user never
  // sees African chips when the server is unreachable. Refreshed on every online fetch.
  static const String _prefKeyAfricanPermitted = 'voice_african_permitted_user';
  bool _africanPermittedCached = false;

  Room? _room;
  EventsListener<RoomEvent>? _roomEventsListener;
  WebSocketChannel? _wsChannel;
  StreamSubscription? _wsSubscription;
  String? _currentSessionId;
  String? _currentAccessToken;

  /// Re-entrancy guard: true while a startVoiceSession() call is in flight.
  /// A single user action (sheet-open + language-selected + enrollment-proceed)
  /// can fire startVoiceSession() more than once; without this guard each call
  /// POSTs /voice/session/start and (server-dedupe aside) the client would race
  /// two LiveKit connects. We refuse a re-entrant start while one is already
  /// running so a single user action starts exactly one session.
  bool _isStartingSession = false;

  /// Set when a teardown (dismiss/disconnect/end) has been requested, so an
  /// in-flight connectToLiveKitRoom() that completes AFTER the user dismissed the
  /// sheet immediately disconnects the freshly-connected room instead of leaving a
  /// ghost session on the server (the gateway otherwise has to sweep stale
  /// `voice:active` keys on its next startup). Reset at the start of each connect.
  bool _teardownRequested = false;

  /// De-dupes concurrent _disposeRoomResources() calls. The widget's dispose()
  /// fires a (fire-and-forget) disconnect while a user-driven _closeSheet() or an
  /// agent-ended teardown may run the same path — without this both race on the
  /// same Room and can leave a half-released connection.
  Future<void>? _disposingRoom;

  /// Get the current session ID
  String? get currentSessionId => _currentSessionId;

  /// Live custom-voice clone state pushed by the agent over the active WS
  /// (`custom_voice_state` event). Widgets (e.g. the voice settings custom-voice
  /// card) can watch this to re-render in real time as a clone is created,
  /// processed, toggled, enabled or fails — without waiting for the 10s status
  /// poll. Null until the first push of a session. Outlives `emit`/state so it
  /// is exposed as a [ValueNotifier] rather than a cubit state (clone changes
  /// must not disturb the live-call state machine).
  final ValueNotifier<CustomVoiceLiveState?> customVoiceLive =
      ValueNotifier<CustomVoiceLiveState?>(null);

  /// Whether a voice WS is currently connected (used by the cloning screen to
  /// decide whether pause/resume events are worth sending).
  bool get hasActiveVoiceSession => _wsChannel != null;

  // Language & voice selection
  String? _selectedLanguageCode;
  String? _selectedVoiceId;
  List<VoiceLanguage> _availableLanguages = [];

  /// Whether a visual feedback dialog is currently showing (user search, transfer summary, PIN).
  /// When true, SpeakingChangedEvent should NOT overwrite the state.
  bool _isVisualFeedbackActive = false;

  /// Safety timeout guarding [_isVisualFeedbackActive]. If the terminal
  /// `transaction_result` (or equivalent resolving) event is dropped, the flag
  /// would otherwise stay true forever and suppress all subsequent
  /// status/processing updates — freezing the UI on a stale dialog. This timer
  /// force-clears the flag after [_visualFeedbackTimeout] as a last resort.
  ///
  /// 75s: long enough to outlast the PIN-entry sheet's own 60s guard (so this
  /// watchdog never clears the flag while the user is mid-PIN), but shorter than
  /// the old 90s so a genuinely-dropped terminal event un-freezes the
  /// status/processing UI sooner.
  Timer? _visualFeedbackTimer;
  static const Duration _visualFeedbackTimeout = Duration(seconds: 75);

  /// Set the visual-feedback suppression flag with a safety timeout.
  ///
  /// When [active] is true the flag is set and a watchdog timer is (re)started;
  /// if it fires while the flag is still set, the flag is cleared so a dropped
  /// terminal event can't freeze the UI indefinitely. When [active] is false
  /// the flag is cleared and the watchdog cancelled.
  /// Set when the SERVER refused to start this session for quota. Terminal for
  /// the session, and load-bearing: the agent closes its side immediately
  /// after sending the refusal, so a RoomDisconnectedEvent follows within
  /// milliseconds and would otherwise replace the quota sheet's state with a
  /// generic "disconnected". The user would see a dead call instead of the
  /// reason and the way to continue.
  VoiceQuotaInfo? _quotaRefusal;

  VoiceQuotaInfo? get quotaRefusal => _quotaRefusal;

  /// Emit a session-death state unless this session was refused for quota.
  void _emitSessionDeath(VoiceSessionState state) {
    if (_quotaRefusal != null) {
      print('VoiceSessionCubit: suppressing ${state.runtimeType} — '
          'session was refused for quota');
      return;
    }
    emit(state);
  }

  void _setVisualFeedbackActive(bool active) {
    _isVisualFeedbackActive = active;
    _visualFeedbackTimer?.cancel();
    if (active) {
      _visualFeedbackTimer = Timer(_visualFeedbackTimeout, () {
        if (_isVisualFeedbackActive) {
          _isVisualFeedbackActive = false;
          AppLogger.warning(
            'VoiceSessionCubit: visual-feedback safety timeout fired — '
            'force-clearing stale dialog flag (terminal event likely dropped)',
          );
        }
      });
    }
  }

  /// Called by the UI when the user dismisses/closes a transfer-summary card,
  /// user-search dialog, or PIN sheet WITHOUT a terminal event resolving it
  /// (e.g. they swiped the sheet away). Stops stale-event suppression so the
  /// agent's subsequent status/processing updates render normally.
  void onVisualFeedbackDismissed() {
    _setVisualFeedbackActive(false);
  }

  /// True while a modal sheet the user has to READ owns the screen — today
  /// that is the transfer receipt shown after a completed money move.
  ///
  /// WHY THE MIC MUST BE SHUT WHILE ONE IS UP
  ///
  /// [_isVisualFeedbackActive] does not cover this: it suppresses state
  /// EMISSION, and `transaction_result` deliberately clears it before the
  /// receipt is shown so the receipt can render at all. Nothing then stopped
  /// the re-arm, so the sequence after every voice transfer was:
  ///
  ///   transaction_result -> receipt sheet opens
  ///   agent speaks "sent ₦x to y" -> agent_caption_end -> _reArmListeningSoon
  ///   -> mic LIVE behind the receipt the user is reading
  ///
  /// Two things went wrong with that. The mild one is cosmetic and is what got
  /// reported: ambient noise reaches `_setUserSpeaking`, so the avatar lights
  /// up as though the user were talking, and closing the receipt reveals a UI
  /// already sitting in "listening" — which reads as "closing the receipt
  /// started listening". The serious one is that a hot mic sits behind a
  /// receipt in the seconds right after money moved, so a stray sentence in
  /// the room is transcribed and dispatched to a financial agent as a fresh
  /// command.
  ///
  /// Gating [_listeningPermitted] is the whole fix: every auto-listen path
  /// (greeting, agent-end re-arm, barge-in, recognizer-restart) already funnels
  /// through it, so there is exactly one place to be right.
  bool _modalOwnsScreen = false;

  /// Last-resort release for [_modalOwnsScreen].
  ///
  /// The flag is cleared by the sheet's own dismissal callback, which is
  /// reliable — but a mic wedged shut is a dead conversation with no error to
  /// explain it, so a dropped callback must not be able to end the session's
  /// usefulness. Deliberately long: it is a backstop, not a policy, and must
  /// never fire while somebody is genuinely still reading a receipt.
  Timer? _modalOwnsScreenTimer;
  static const Duration _modalOwnsScreenTimeout = Duration(minutes: 3);

  /// The UI is presenting a modal sheet the user must read or dismiss.
  ///
  /// Closes the mic if it is already open — the sheet can appear mid-turn, and
  /// gating future re-arms would otherwise leave the current capture running.
  void onBlockingSheetShown() {
    if (isClosed) return;
    _modalOwnsScreen = true;
    _modalOwnsScreenTimer?.cancel();
    _modalOwnsScreenTimer = Timer(_modalOwnsScreenTimeout, () {
      if (_modalOwnsScreen) {
        AppLogger.warning(
          'VoiceSessionCubit: modal-sheet safety timeout fired — releasing the '
          'mic gate (a sheet dismissal callback was likely dropped)',
        );
        onBlockingSheetDismissed();
      }
    });
    unawaited(stopLocalListening());
  }

  /// The modal sheet is gone. Hands the mic back to the conversation.
  ///
  /// Re-arms rather than merely un-gating, because the agent's turn ended while
  /// the sheet was up: the `agent_caption_end` that would normally re-arm has
  /// already been and gone, so without an explicit re-arm here the user would
  /// close the receipt onto a permanently deaf session. [_reArmListeningSoon]
  /// re-checks [_listeningPermitted], so a muted, push-to-talk, torn-down or
  /// agent-speaking session is still left alone.
  void onBlockingSheetDismissed() {
    _modalOwnsScreenTimer?.cancel();
    _modalOwnsScreenTimer = null;
    if (!_modalOwnsScreen) return;
    _modalOwnsScreen = false;
    if (isClosed || _teardownRequested) return;
    _reArmListeningSoon();
  }

  /// Whether the local microphone is muted.
  bool _isMuted = false;

  // ── On-device speech capture (admin voice_stt_input_mode = on_device) ──
  // In on_device mode the app owns the mic: speech_to_text transcribes locally
  // (instant live captions, best English accuracy, no server round-trip) and the
  // FINAL text is sent to the agent over the LiveKit data channel. The LiveKit mic
  // is NOT published in this mode. Resolved per-session from the start response's
  // `inputMode` field; defaults to on_device. "livekit" restores the legacy
  // server-STT path (publish mic, server captions) verbatim.
  bool _onDeviceMode = true;

  /// Records a gesture-bounded turn as a clip, for the voice-note path.
  ///
  /// Null until the admin enables it. Created lazily so a device that never turns
  /// it on never constructs a third mic consumer.
  VoiceNoteCapture? _noteCapture;

  /// Admin switch for the voice-note turn path, from /voice/session/start.
  ///
  /// OFF by default, deliberately. This adds `record` as a third mic consumer
  /// beside LiveKit and speech_to_text, and there is no explicit AVAudioSession
  /// category set anywhere in the app — whichever plugin grabs it first wins. That
  /// is exactly the contention case, and it needs verifying on a real iOS device
  /// before it becomes the default for everyone. Until then the working on-device
  /// path is untouched and this is opt-in per deployment.
  bool _voiceNoteCapture = false;

  /// LiveKit's own voice-activity detection on the LOCAL mic.
  ///
  /// The mic indicator was driven by [isLocalListening], which is permanently
  /// false whenever the server configures `inputMode: 'livekit'` — startLocal-
  /// Listening is gated on [_onDeviceMode]. So in hands-free on a livekit server
  /// the user's mic never turned green while they spoke, and the one piece of
  /// feedback telling them they were being heard was simply absent.
  ///
  /// This is mode-independent: LiveKit reports it from the published track, so it
  /// is true in exactly the case on-device listening cannot cover.
  bool _localUserSpeaking = false;

  /// What the SERVER asked for this session ('livekit' or on-device). Kept so a
  /// mid-session talk-mode switch can re-resolve capture without a reconnect.
  String? _serverInputMode;

  /// How the user talks to the agent (UX preference; on-device mode only):
  ///   'continuous'  — hands-free VAD (default; auto re-arms hands-free);
  ///   'hold'        — press-and-hold the talk button, release to send;
  ///   'tap'         — tap to start, tap again to stop/send;
  ///   'double_tap'  — double-tap to toggle a capture window.
  /// In any push-to-talk mode the recognizer opens ONLY while a gesture holds a
  /// capture window open ([_pttActive]) — the greeting/agent-end/re-arm auto-listen
  /// paths are all gated off via [_listeningPermitted]. Resolved from the user's
  /// voice settings (admin default → per-user override) and set by the sheet.
  String _interactionMode = 'continuous';

  /// True while a push-to-talk gesture is holding a capture window open. Only
  /// meaningful when [isPushToTalk]; [_listeningPermitted] requires it in PTT modes.
  bool _pttActive = false;

  /// On-device recognizer (Apple Speech / Android SpeechRecognizer).
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _sttInitialized = false;
  bool _sttAvailable = false;

  /// True while the local recognizer is actively listening for a turn.
  bool _isLocalListening = false;

  /// True between sending a final user turn and the agent finishing its reply.
  /// Normal (non-barge-in) listening is paused while this holds; we re-arm on
  /// agent_caption_end for natural hands-free turn-taking.
  bool _awaitingAgentReply = false;

  /// True between agent_caption_start and agent_caption_end — the agent is
  /// actively producing speech. While true, the recognizer may stay open in a
  /// BARGE-IN window (echo-filtered) so the user can interrupt and be reasoned on.
  bool _agentSpeaking = false;

  /// Keeps the agent's own voice out of the user's turn — including AFTER the
  /// agent stops, while the loudspeaker is still emitting the tail. See
  /// [VoiceEchoGuard]; the failure it was written for put Nova's sentence in
  /// the user's bubble mid-transfer.
  final VoiceEchoGuard _echoGuard = VoiceEchoGuard();

  /// Guards a single barge-in per agent turn (so we interrupt once, not per word).
  bool _bargedInThisTurn = false;

  /// Master switch for OPEN-MIC acoustic barge-in (interrupt the agent by talking
  /// over it) in on_device mode.
  ///
  /// OFF for CONTINUOUS: on a loudspeaker there is NO acoustic echo cancellation
  /// on the raw `speech_to_text` mic (unlike LiveKit mode, which has hardware AEC),
  /// so keeping the recognizer open while the agent speaks makes it transcribe the
  /// agent's OWN TTS and fire a false barge-in that cuts the audio — the user then
  /// hears nothing. So we PAUSE the recognizer while the agent speaks and re-arm on
  /// agent_caption_end (clean hands-free turn-taking). Barge-in stays fully working
  /// in LiveKit mode (native interruption + AEC).
  ///
  /// ON for PUSH-TO-TALK, and the echo argument above is exactly why it is safe
  /// there: the mic is not open. It opens only inside a gesture the user is
  /// physically making, so the recognizer cannot drift into transcribing the
  /// agent's own speech — there is no open window for the echo to arrive in. A
  /// user who holds the talk button while the agent is mid-sentence is
  /// unambiguously interrupting on purpose, and the old blanket `false` meant that
  /// press was swallowed: `_listeningPermitted()` returned false for the whole
  /// agent turn, so the one gesture that says "stop talking and listen to me" did
  /// nothing at all.
  bool get _bargeInEnabled => isPushToTalk;

  /// Minimum non-echo words before we treat speech-over-agent as a real
  /// interruption (avoids cutting the agent off on a stray blip / partial echo).
  static const int _bargeInMinWords = 2;

  /// HYBRID AEC barge-in (on_device mode): the mic is TIME-SHARED by turn phase to
  /// avoid dual-capture contention —
  ///   • USER phase  → speech_to_text owns the mic (LiveKit mic OFF), transcribes;
  ///   • AGENT phase → speech_to_text is paused anyway, so we publish the mic to
  ///     LiveKit WITH echo cancellation. The server's adaptive interruption
  ///     detector then hears clean (AEC'd) audio and stops the agent the moment the
  ///     user talks over it — true barge-in without the loudspeaker feedback loop.
  ///   • On interruption the agent ends its turn (agent_caption_end) → we drop the
  ///     LiveKit mic and re-arm speech_to_text to capture the user's turn.
  /// Server STT stays gated off (client text drives turns); the published mic only
  /// feeds the interruption detector during agent speech.
  static const bool _hybridAecBargeIn = true;

  /// Topic for the on-device user-text data packets the agent listens for.
  static const String _userTextTopic = 'lv-user-text';

  /// Current user id (for once-per-session on-device voice biometrics).
  String? _currentUserId;

  // ── Admin biometrics policy (from /voice/session/start response) ──
  // Mirrors the server-side policy so on_device verification enforces identically.
  bool _bioEnabled = false;
  bool _bioEnrollmentRequired = true;
  String _bioMismatchAction =
      'warn'; // 'warn' (continue) | 'exit' (end session)
  bool _bioFailOpen = false;
  double _bioThreshold = 0.85;

  /// One-time-per-session biometric verification guard + recorder.
  final AudioRecorder _bioRecorder = AudioRecorder();
  bool _bioAttemptedThisSession = false;

  /// True while the biometric recorder owns the mic — listening must not start
  /// then (only one mic consumer at a time on iOS).
  bool _bioInProgress = false;

  /// Set when a biometric capture is aborted (teardown/mute), so it bails without
  /// verifying a stale/partial sample.
  bool _bioCancelled = false;

  /// True until the one-time-per-session verification capture has been attempted.
  /// Verification is captured on the FIRST confirmed USER-speech window AFTER the
  /// greeting (amplitude-gated) — never during the greeting, never on silence.
  bool _bioPending = false;

  // ── Client-side turn detection (end-of-turn endpointing) ──
  // speech_to_text exposes `pauseFor`, but platform recognizers (notably Android)
  // don't always honour it / reliably emit a FINAL result. So we ALSO run our own
  // silence timer: every partial result resets it; if it elapses with text
  // pending, we treat the turn as finished even if the OS never fired finalResult.
  // A dispatch guard dedupes the native-final and silence-timer paths so a turn is
  // sent exactly once.
  Timer? _turnSilenceTimer;
  String _lastPartialText = '';
  bool _turnDispatched = false;

  // iOS-vs-Android endpointing. iOS SFSpeechRecognizer endpoints more
  // aggressively (fires finalResult after a SHORTER pause) AND has higher
  // recognizer-restart latency than Android's SpeechRecognizer. With the
  // Android-tuned windows, an iOS user pausing mid-sentence gets cut off (turn
  // dispatched during the pause) or loses the continuation captured during the
  // slower iOS re-arm. So iOS gets MORE generous endpointing windows + a faster
  // re-arm; Android keeps the snappier values it already worked well with.
  static final bool _isIOS = Platform.isIOS;

  // Client-side silence timer (reset on every partial). Longer on iOS to tolerate
  // natural pauses before we finalise a turn ourselves.
  //
  // Raised from 3200/2500: people asked for room to pause mid-sentence without
  // the turn being sent. This only delays the END of a turn — a short complete
  // command still dispatches as soon as the recognizer finalises it — so the cost
  // of being generous here is small and the cost of being mean is a sentence cut
  // in half.
  static int get _turnSilenceDefaultMs => _isIOS ? 4000 : 3200;
  static int get _graceDefaultMs => _isIOS ? 2800 : 2000;

  /// Server overrides for the two endpointing windows, from
  /// `/voice/session/start`. Null until the session reports them, and null
  /// forever on an older server — so the platform defaults above stay in force.
  ///
  /// Tunable from the admin console because the right value depends on speech
  /// rate and language, which is not something an app release should have to
  /// guess at per market.
  int? _silenceWindowMsOverride;
  int? _graceWindowMsOverride;

  Duration get _turnSilenceWindow => Duration(
        milliseconds: _silenceWindowMsOverride ?? _turnSilenceDefaultMs,
      );

  // ── Long-turn coalescing (don't split a long sentence) ──
  // Platform recognizers (notably Android) fire finalResult MID-thought after a
  // brief pause, so a long utterance gets chopped into several native-final
  // segments — and dispatching each one made the agent reply to half a sentence
  // (the "truncating / splitting / unnatural" symptom). Instead of dispatching a
  // native-final immediately, we FOLD it into [_turnAccumulator] and start a
  // short grace timer; the recognizer auto-restarts (onStatus 'done' →
  // _reArmListeningSoon) so a continuation is captured, and a partial there
  // cancels the grace. We only dispatch the WHOLE accumulated turn once the user
  // has been genuinely silent for [_endOfTurnGraceWindow].
  String _turnAccumulator = '';
  Timer? _endOfTurnTimer;
  // Grace after a native finalResult to absorb a continuation. iOS needs a
  // longer grace: its recognizer restart is slower, so a mid-sentence pause +
  // the re-arm dead window can otherwise exceed the Android grace and dispatch
  // half a sentence.
  //
  // Raised from 2200/1400 for the same reason as the silence window: this is the
  // gap after the recognizer says "final" in which a continuation is still
  // absorbed, and it was firing while people were still thinking.
  Duration get _endOfTurnGraceWindow => Duration(
        milliseconds: _graceWindowMsOverride ?? _graceDefaultMs,
      );

  // ── Adaptive (semantic) endpointing — stop splitting speeches ──
  // A big cause of "split speeches" on BOTH platforms is a fixed timeout firing
  // while the user is mid-thought (e.g. they say "send five thousand to…" then
  // pause to recall the name). When the utterance ENDS in a continuation word
  // (conjunction/preposition/article/filler), the user almost certainly isn't
  // done, so we wait noticeably longer before finalising. Short, complete
  // commands ("yes", "check balance") don't end in these, so they stay snappy —
  // this only ever EXTENDS the wait, never shortens it, so it can't cut anyone off.
  static const Set<String> _incompleteTrailers = {
    'and',
    'or',
    'but',
    'so',
    'because',
    'if',
    'then',
    'to',
    'too',
    'for',
    'with',
    'of',
    'the',
    'a',
    'an',
    'my',
    'your',
    'our',
    'their',
    'his',
    'her',
    'at',
    'on',
    'in',
    'into',
    'from',
    'by',
    'as',
    'plus',
    'minus',
    'about',
    'um',
    'uh',
    'er',
    'erm',
    'hmm',
    'like',
    'send',
    'pay',
    'transfer',
  };
  static const Duration _incompleteExtraWait = Duration(milliseconds: 1600);

  /// Accepts a server-supplied endpointing window, or null.
  ///
  /// Null for anything unusable — absent, non-numeric, or outside the range a
  /// human would tolerate — so a bad admin value falls back to the platform
  /// default instead of breaking turn-taking for everyone on that build.
  static int? _clampWindowMs(dynamic raw) {
    final num? value = raw is num ? raw : num.tryParse(raw?.toString() ?? '');
    if (value == null) return null;
    final ms = value.round();
    if (ms < 600 || ms > 15000) return null;
    return ms;
  }

  Duration get _endOfTurnGraceWindowLong =>
      _endOfTurnGraceWindow + _incompleteExtraWait;
  Duration get _turnSilenceWindowLong =>
      _turnSilenceWindow + _incompleteExtraWait;

  /// True when [text] most likely isn't a finished thought — it ends in a
  /// continuation word (see [_incompleteTrailers]) or a dangling short digit run
  /// like "send 5000 <pause>". Used to pick the LONGER endpointing window.
  bool _looksIncomplete(String text) {
    final t = text.trim().toLowerCase();
    if (t.isEmpty) return false;
    final words = t.split(RegExp(r'\s+'));
    final last = words.last.replaceAll(RegExp(r'[^a-z0-9]'), '');
    if (last.isEmpty) return false;
    if (_incompleteTrailers.contains(last)) return true;
    // A trailing bare number often means an amount mid-dictation ("...five oh…")
    // or "send 5000" before the recipient — give it the longer window too.
    if (RegExp(r'^\d+$').hasMatch(last)) return true;
    return false;
  }

  /// Join already-accumulated turn segments with the current session text,
  /// collapsing whitespace, so a split long utterance reaches the agent as ONE
  /// turn. Safe on empty parts, and idempotent against a recognizer re-emitting
  /// the SAME cumulative segment (some engines fire finalResult more than once):
  /// if the accumulator already ends with [b], we don't append it twice.
  String _joinTurn(String a, String b) {
    final at = a.trim();
    final bt = b.trim();
    if (bt.isEmpty) return at;
    if (at.isEmpty) return bt;
    if (at.toLowerCase().endsWith(bt.toLowerCase())) return at;
    return '$at $bt'.replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Whether the general voice agent is running in on-device speech mode.
  bool get isOnDeviceMode => _onDeviceMode;

  /// Whether the on-device recognizer is currently listening.
  bool get isLocalListening => _isLocalListening;

  /// True when the microphone is genuinely picking the user up, whichever input
  /// path this session is using.
  ///
  /// The mic indicator must mean ONE thing — "I can hear you" — in all four
  /// modes, and no single underlying flag covers them:
  ///   * hold / tap / double-tap: the PTT capture window is open.
  ///   * hands-free, on-device STT: local listening is running.
  ///   * hands-free, livekit STT: neither of the above is ever true, so this
  ///     falls to LiveKit's voice-activity detection on the published track.
  bool get micIsHearingUser =>
      isPttCapturing || _isLocalListening || _localUserSpeaking;

  // ── Caption state for real-time transcription display ──

  /// Current user caption (what the user is saying)
  String? _currentUserCaption;

  /// Current agent caption (what the AI is responding with)
  String? _currentAgentCaption;

  /// True when the next committed agent reply should REPLACE the previous one
  /// (the agent_caption_start carried `replace=true` because this answer
  /// supersedes/merges an interrupted reply) — so a merged exchange shows ONE
  /// AI answer instead of several.
  bool _pendingAgentReplace = false;

  /// Whether the AI agent is currently speaking
  bool _isAgentSpeaking = false;

  /// The base state before adding caption overlay (used to restore when captions clear)
  VoiceSessionState? _baseStateBeforeCaption;

  // ── Transfer HUD context (accumulated across chunked transfer events) ──

  /// Lightweight value object the sci-fi transfer HUD renders. Updated
  /// incrementally as the (chunked) transfer states arrive — recipient on
  /// selection, amount/account/fee/total on the summary, status transitions on
  /// PIN / result / error / cancel. The state objects only carry partial data
  /// per turn, so we ACCUMULATE here and the UI reads [transferContext].
  VoiceTransferContext _transferContext = VoiceTransferContext.idle;

  /// The most recent recipient candidates from a `show_user_search` event,
  /// kept so [selectUser] can resolve the chosen user's name / avatar / initials
  /// for the HUD (the user_selected round-trip only carries userId + username).
  List<Map<String, dynamic>> _lastSearchCandidates = const [];

  /// Current accumulated transfer context for the sci-fi HUD.
  VoiceTransferContext get transferContext => _transferContext;

  VoiceSessionCubit() : super(VoiceSessionInitial());

  /// Chat history cubit for tracking conversation messages
  late final VoiceChatHistoryCubit _chatHistoryCubit =
      serviceLocator<VoiceChatHistoryCubit>();

  /// Currently selected language code (e.g., "en", "yo", "ig").
  String? get selectedLanguageCode => _selectedLanguageCode;

  /// Currently selected voice ID.
  String? get selectedVoiceId => _selectedVoiceId;

  /// Check if currently connected to LiveKit room
  bool get isConnected => _room?.connectionState == ConnectionState.connected;

  /// Whether the local microphone is muted.
  bool get isMuted => _isMuted;

  /// Current user caption (what user is saying)
  String? get currentUserCaption => _currentUserCaption;

  /// Current agent caption (what AI is responding with)
  String? get currentAgentCaption => _currentAgentCaption;

  /// Whether the AI agent is currently speaking
  bool get isAgentSpeaking => _isAgentSpeaking;

  /// Chat history cubit for tracking conversation messages
  VoiceChatHistoryCubit get chatHistoryCubit => _chatHistoryCubit;

  /// Get the FULL conversation transcript for the current session, oldest →
  /// newest. The UI renders this as a scrollable running transcript that
  /// ACCUMULATES across turns (user complaint #1: history must not disappear
  /// each turn and must be scrollable). The backing store
  /// (VoiceChatHistoryCubit) already caps each conversation at 500 messages
  /// for memory safety, so we return the whole list here rather than the old
  /// last-10 window which prevented scrollback.
  /// Edge cases handled:
  /// - Null session ID
  /// - Missing conversation
  /// - Null/invalid message fields
  /// - Empty message lists
  List<VoiceConversationMessage> get recentConversationMessages {
    // Edge case: No active session
    if (_currentSessionId == null || _currentSessionId!.isEmpty) {
      return [];
    }

    try {
      final conversation =
          _chatHistoryCubit.getConversation(_currentSessionId!);
      if (conversation == null) {
        return [];
      }

      // Edge case: Null or empty messages list
      final messages = conversation.messages;
      if (messages == null || messages.isEmpty) {
        return [];
      }

      // Edge case: Filter out invalid messages. Return the WHOLE transcript
      // (no take(10) cap) so the user can scroll back through the full
      // session; memory is already bounded by the history cubit's 500-msg cap.
      final validMessages = messages.where((msg) {
        // Validate message has required fields
        return msg != null &&
            msg.text != null &&
            msg.text.trim().isNotEmpty &&
            msg.timestamp != null;
      }).toList();

      return validMessages;
    } catch (e) {
      // Edge case: Catch any errors during message retrieval
      print('VoiceSessionCubit: Error retrieving conversation messages: $e');
      return [];
    }
  }

  /// Toggle microphone mute/unmute. Returns the new mute state.
  Future<bool> toggleMute() async {
    if (_room == null) return _isMuted;
    _isMuted = !_isMuted;
    try {
      if (_onDeviceMode) {
        // On-device mode owns the mic via speech_to_text (the LiveKit mic stays
        // unpublished). Mute = stop the recognizer (and abort any in-flight
        // verification capture); unmute = re-arm listening.
        if (_isMuted) {
          if (_bioInProgress) await _abortBiometricsCapture();
          await stopLocalListening();
        } else if (!_awaitingAgentReply) {
          await startLocalListening();
        }
      } else {
        await _room?.localParticipant?.setMicrophoneEnabled(!_isMuted);
      }
    } catch (e) {
      // Room may have disconnected between null check and call
      print('VoiceSessionCubit: Error toggling mute: $e');
      _isMuted = !_isMuted; // Revert on failure
    }
    return _isMuted;
  }

  /// Available languages for the user's country.
  List<VoiceLanguage> get availableLanguages => _availableLanguages;

  // ── Language & Voice Selection ──

  /// Load persisted language preference and available languages for the country.
  Future<void> loadLanguagePreferences(String countryCode) async {
    // Edge case: Handle empty or null country code
    final effectiveCountry = (countryCode != null && countryCode.isNotEmpty)
        ? countryCode.toUpperCase()
        : 'NG'; // Default to Nigeria

    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedLanguageCode = prefs.getString(_prefKeyLanguage);
      _selectedVoiceId = prefs.getString(_prefKeyVoice);
      _africanPermittedCached =
          prefs.getBool(_prefKeyAfricanPermitted) ?? false;

      // Fetch available languages from voice gateway API
      _availableLanguages = await _fetchSupportedLanguages(effectiveCountry);

      // Edge case: Handle empty available languages list
      if (_availableLanguages.isEmpty) {
        print(
            'VoiceSessionCubit: No languages available from API, using hardcoded defaults');
        _availableLanguages =
            VoiceLanguageDefaults.forCountry(effectiveCountry);
      }

      // OPERATOR ALLOWLIST — applied at the ONE place every consumer reads.
      //
      // The gateway advertises every language in SUPPORTED_LANGUAGES, but TTS
      // routing, the voice catalogue and the agent prompts are production-ready
      // for English alone today. Offering the rest makes the picker lie: the
      // user selects Yoruba, nothing changes, and they conclude it is broken.
      //
      // Filtering HERE rather than in each picker is deliberate — the general
      // Voice & Language sheet and anything else reading `availableLanguages`
      // follow automatically, so no surface can be forgotten.
      final allowed = _availableLanguages
          .where((l) => VoiceLanguageAvailability.isAllowed(l.code))
          .toList();
      if (allowed.isNotEmpty) {
        _availableLanguages = allowed;
      } else {
        // The allowlist matched nothing the gateway offers — a misconfiguration.
        // Leaving the user with NO language would make the assistant
        // unusable, so keep the unfiltered list and say so, rather than
        // enforcing a rule into a dead end.
        print('VoiceSessionCubit: language allowlist '
            '${VoiceLanguageAvailability.allowedCodes} matched none of the '
            '${_availableLanguages.length} offered — leaving the list unfiltered');
      }

      // If no persisted language, or it's not available for this country, auto-select default
      final hasPersistedLanguage = _selectedLanguageCode != null &&
          _availableLanguages.any((l) => l.code == _selectedLanguageCode);

      if (!hasPersistedLanguage) {
        // Auto-select English for Nigerian users (Domestic English with en-NG locale)
        if (effectiveCountry == 'NG' &&
            _availableLanguages.any((l) => l.code == 'en')) {
          _selectedLanguageCode = 'en';

          // Pre-select default voice for English
          final english =
              _availableLanguages.where((l) => l.code == 'en').firstOrNull;
          if (english != null) {
            // Edge case: Use defaultVoiceOption with fallback to first available voice
            final defaultVoiceOption = english.defaultVoiceOption;
            if (defaultVoiceOption != null) {
              _selectedVoiceId = defaultVoiceOption.id;
            } else if (english.availableVoices.isNotEmpty) {
              // Edge case: No default voice set, use first available voice
              _selectedVoiceId = english.availableVoices.first.id;
              print(
                  'VoiceSessionCubit: No default voice for English, using first available: $_selectedVoiceId');
            }
          }

          // Persist the auto-selection
          await prefs.setString(_prefKeyLanguage, 'en');
          if (_selectedVoiceId != null) {
            await prefs.setString(_prefKeyVoice, _selectedVoiceId!);
          }
        } else {
          // Edge case: Not Nigeria or English not available
          _selectedLanguageCode = null;
        }
      }
    } catch (e) {
      // Edge case: Handle SharedPreferences or network errors gracefully
      AppLogger.error('Error loading language preferences', error: e);
      // Fallback to defaults
      _availableLanguages = VoiceLanguageDefaults.forCountry(effectiveCountry);
      _selectedLanguageCode = null;
      _selectedVoiceId = null;
    }
  }

  /// Set the voice language for the session.
  Future<void> setLanguage(String languageCode) async {
    // Edge case: Validate language code is not empty
    if (languageCode.isEmpty) {
      AppLogger.error('setLanguage: Empty language code provided');
      return;
    }

    _selectedLanguageCode = languageCode;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKeyLanguage, languageCode);

      // If no voice preference exists or the current voice is not available for the new language,
      // set the default voice for the new language
      final lang =
          _availableLanguages.where((l) => l.code == languageCode).firstOrNull;
      if (lang != null) {
        final hasValidVoice = _selectedVoiceId != null &&
            lang.availableVoices.any((v) => v.id == _selectedVoiceId);
        if (!hasValidVoice) {
          // Edge case: Use defaultVoiceOption with fallback
          final defaultVoiceOption = lang.defaultVoiceOption;
          if (defaultVoiceOption != null) {
            _selectedVoiceId = defaultVoiceOption.id;
            await prefs.setString(_prefKeyVoice, defaultVoiceOption.id);
          } else if (lang.availableVoices.isNotEmpty) {
            // Edge case: No default voice set, use first available voice
            _selectedVoiceId = lang.availableVoices.first.id;
            if (_selectedVoiceId != null) {
              await prefs.setString(_prefKeyVoice, _selectedVoiceId!);
            }
            print(
                'VoiceSessionCubit: No default voice for $languageCode, using first available: $_selectedVoiceId');
          } else {
            // Edge case: No voices available for this language
            print(
                'VoiceSessionCubit: No voices available for language $languageCode');
            _selectedVoiceId = null;
          }
        }
      } else {
        // Edge case: Language not found in available list
        AppLogger.error(
            'setLanguage: Language $languageCode not found in available languages');
      }

      // Send language change to backend via WebSocket if session is active
      if (_wsChannel != null && isConnected) {
        final localeManager = serviceLocator<LocaleManager>();
        final currentCountry = localeManager.currentCountry;
        final locale = currentCountry.isNotEmpty
            ? '$languageCode-$currentCountry'
            : languageCode;

        await sendToVoiceAgent('language_changed', {
          'language': languageCode,
          'locale': locale,
          // Carry the (auto-selected) voice for the new language so the agent
          // re-resolves TTS with a voice that's VALID for it — without this the
          // backend kept the old language's voice and audio could break.
          if (_selectedVoiceId != null && _selectedVoiceId!.isNotEmpty)
            'voice_preference': _selectedVoiceId,
        });
        print(
            'VoiceSessionCubit: Sent language change to backend: $languageCode ($locale) voice=$_selectedVoiceId');
      }
    } catch (e) {
      // Edge case: Handle SharedPreferences errors
      AppLogger.error('Error setting language preference', error: e);
    }
  }

  /// Set the preferred TTS voice.
  Future<void> setVoice(String voiceId) async {
    _selectedVoiceId = voiceId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyVoice, voiceId);
    // An explicit pick ends auto-adoption. Without this, a user who cloned
    // their voice and then deliberately chose a stock one would be pulled back
    // to their clone on the next session that saw "ready".
    await prefs.setBool(_prefKeyVoiceChosenByUser, true);
  }

  /// Adopt the user's cloned voice as soon as it is ready.
  ///
  /// Cloning a voice IS the request to use it — the extra "use my voice for the
  /// assistant" step was a second confirmation of something the user had just
  /// spent a minute recording, and until they found it the clone sat unused.
  ///
  /// Runs at most once, and never overrides a voice the user picked
  /// deliberately: [setVoice] marks that, and this checks it. So the sequence
  /// "clone → auto-adopt → user switches to a stock voice" sticks on the stock
  /// voice, which is what choosing it meant.
  Future<void> adoptClonedVoiceIfReady({required bool cloneReady}) async {
    if (!cloneReady) return;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_prefKeyVoiceChosenByUser) ?? false) return;
    if (_selectedVoiceId == kMyVoiceSentinelId) return;

    _selectedVoiceId = kMyVoiceSentinelId;
    await prefs.setString(_prefKeyVoice, kMyVoiceSentinelId);
    // NOT marked as a user choice: this was our decision, so a later explicit
    // pick still wins and we do not re-adopt after one.
    if (hasActiveVoiceSession) {
      await notifyCustomVoiceChanged(true);
    }
    _emitCaptionUpdate();
  }

  /// Check if language has been selected (for gating session start).
  bool get hasLanguageSelected => _selectedLanguageCode != null;

  /// Whether the selected language supports voice customization.
  bool get supportsVoiceCustomization {
    if (_selectedLanguageCode == null) return false;
    final lang = _availableLanguages
        .where((l) => l.code == _selectedLanguageCode)
        .firstOrNull;
    return lang?.supportsVoiceCustomization ?? false;
  }

  /// Get the selected VoiceLanguage object.
  VoiceLanguage? get selectedLanguage {
    if (_selectedLanguageCode == null) return null;
    return _availableLanguages
        .where((l) => l.code == _selectedLanguageCode)
        .firstOrNull;
  }

  /// Emit language selection state (called from voice_command_sheet).
  void showLanguageSelection() {
    if (isClosed) return;
    emit(VoiceSessionLanguageSelection(
      availableLanguages: _availableLanguages,
      selectedLanguageCode: _selectedLanguageCode,
    ));
  }

  /// Fetch supported languages from voice gateway API with fallback.
  Future<List<VoiceLanguage>> _fetchSupportedLanguages(
      String countryCode) async {
    try {
      // Send the bearer so the gateway can read the email claim and return African
      // languages ONLY when this user is on the admin per-email allowlist — the picker
      // then never offers a language the session would silently coerce back to English.
      final headers = <String, String>{};
      try {
        final token =
            await serviceLocator<SecureStorageService>().getAccessToken();
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {
        // No token (picker opened pre-login) — server returns the English-safe set.
      }

      final response = await http
          .get(
            Uri.parse(
                '$_voiceLanguageApiUrl/api/v1/voice/languages?country=$countryCode'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final languages = (data['languages'] as List<dynamic>?)
            ?.map((l) => VoiceLanguage.fromJson(l as Map<String, dynamic>))
            .toList();
        if (languages != null && languages.isNotEmpty) {
          // The server already applied THIS user's per-email African grant. Remember
          // whether it granted African languages so the offline fallback matches.
          final hasAfrican = languages.any((l) => _africanLangCodes
              .contains(l.code.toLowerCase().split('-').first));
          await _persistAfricanPermitted(hasAfrican);
          return _gateAfricanLanguages(languages, serverAuthoritative: true);
        }
      }
    } catch (e) {
      // Fall through to hardcoded defaults
    }
    return _gateAfricanLanguages(
      VoiceLanguageDefaults.forCountry(countryCode),
      serverAuthoritative: false,
    );
  }

  Future<void> _persistAfricanPermitted(bool granted) async {
    _africanPermittedCached = granted;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefKeyAfricanPermitted, granted);
    } catch (_) {
      // Non-fatal — the cached field still gates this session.
    }
  }

  // Gate for the "display African languages on the app" picker. African options
  // (yo/ig/ha/pcm) require BOTH the admin master toggle AND this user's per-email grant.
  static const Set<String> _africanLangCodes = {'yo', 'ig', 'ha', 'pcm'};
  List<VoiceLanguage> _gateAfricanLanguages(
    List<VoiceLanguage> langs, {
    required bool serverAuthoritative,
  }) {
    // Master feature off → never show African (defense-in-depth), regardless of source.
    if (!FeatureFlags.africanVoiceLanguagesEnabled) {
      final filtered = langs
          .where((l) => !_africanLangCodes
              .contains(l.code.toLowerCase().split('-').first))
          .toList();
      return filtered.isEmpty ? langs : filtered;
    }
    // Online server result already reflects THIS user's per-email grant — trust it.
    if (serverAuthoritative) return langs;
    // Offline fallback: only surface African if this user was previously granted them
    // (so a non-allowlisted user never sees African chips when the server is down).
    if (_africanPermittedCached) return langs;
    final filtered = langs
        .where((l) =>
            !_africanLangCodes.contains(l.code.toLowerCase().split('-').first))
        .toList();
    return filtered.isEmpty ? langs : filtered;
  }

  // ── Session Start ──

  /// Applies the PER-SERVICE voice settings for [serviceName], when the user
  /// has configured any.
  ///
  /// The per-service screen (Settings → Per-service voice, and the same screen
  /// from the in-call sheet) writes languageCode/voiceId/promptHint per
  /// service, and nothing read them: a session always used the GLOBAL language
  /// and voice from SharedPreferences. So "Crypto speaks Yoruba" was saved,
  /// shown as saved, and silently ignored on every call.
  ///
  /// Only overrides what the user actually set. An unconfigured service, or a
  /// language that is not in the available set for this country, falls through
  /// to the global choice rather than leaving the session with a voice the
  /// agent cannot speak.
  Future<void> _applyPerServiceVoice(String? serviceName) async {
    final svc = (serviceName ?? '').trim();
    if (svc.isEmpty) return;
    try {
      final saved = await SharedPrefsPerServiceVoiceSettingsStorage().read(svc);
      if (saved == null || !saved.isConfigured) return;

      final lang = saved.languageCode;
      if (lang != null && lang.isNotEmpty) {
        // Guard against a stale saved language the agent no longer offers —
        // applying it would start a session in a voice that cannot speak.
        final known = _availableLanguages.any((l) => l.code == lang);
        if (known || _availableLanguages.isEmpty) {
          _selectedLanguageCode = lang;
        }
      }
      final voice = saved.voiceId;
      if (voice != null && voice.isNotEmpty) {
        _selectedVoiceId = voice;
      }
      _perServicePromptHint = saved.promptHint.trim();
    } catch (_) {
      // A settings read must never stop a call starting. The global choice
      // still applies, which is exactly today's behaviour.
    }
  }

  /// The per-service prompt hint for the session now starting, or ''.
  /// Passed to the agent so a service can steer its own phrasing.
  String _perServicePromptHint = '';
  String get perServicePromptHint => _perServicePromptHint;

  Future<void> startVoiceSession({
    required String? accessToken,
    String? serviceName,
    String? conversationId,
    String? accountId,
    String? currency,
    String? userId,
  }) async {
    if (isClosed) return;
    // Remember the user for once-per-session on-device voice biometrics.
    if (userId != null && userId.isNotEmpty) _currentUserId = userId;

    // Per-service language/voice BEFORE the room is created, so the agent is
    // started with the voice the user chose for THIS service rather than the
    // global one. Awaited: it is a local read, and racing it against room
    // creation is how a setting appears to work only sometimes.
    await _applyPerServiceVoice(serviceName);

    // Re-entrancy guard: a single user action can dispatch startVoiceSession()
    // more than once (sheet-open path + language-selected + enrollment-proceed).
    // Refuse a second start while one is already in flight so exactly one
    // LiveKit room/agent is created. The legitimate restart path (startNewSession)
    // tears the old room down and awaits before reaching here, so it is not
    // blocked. Cleared in the finally below.
    if (_isStartingSession) {
      print(
          'VoiceSessionCubit: startVoiceSession ignored — a start is already in flight');
      return;
    }
    _isStartingSession = true;
    // A previous attempt's quota refusal must not silence this one's states.
    // Cleared here rather than only in startNewSession because the sheet can
    // be reopened from scratch, which comes through this entry point.
    _quotaRefusal = null;

    emit(VoiceSessionLoadingCredentials());

    if (accessToken == null || accessToken.isEmpty) {
      _isStartingSession = false;
      if (isClosed) return;
      emit(const VoiceSessionCredentialsError(
          'Authentication token is invalid or user not logged in.'));
      return;
    }

    _currentAccessToken = accessToken;

    // Clean restart: if a session is already live (e.g. the user changed the
    // language or voice mid-call from the picker), tear down the existing
    // LiveKit room + WS first so the new STT/TTS choice takes effect
    // deterministically instead of leaking a second room.
    if (_room != null) {
      print(
          'VoiceSessionCubit: restarting — disposing existing room before new session');
      _disconnectWebSocket();
      await _disposeRoomResources();
      _setVisualFeedbackActive(false);
      _clearCaptions();
    }

    try {
      final requestBody = <String, dynamic>{};
      if (serviceName != null && serviceName.isNotEmpty) {
        requestBody['serviceName'] = serviceName;
      }
      // Scoped-context id (e.g. a P2P conversation) → carried in the LiveKit
      // room metadata so the voice worker pins the agent to this conversation.
      if (conversationId != null && conversationId.isNotEmpty) {
        requestBody['conversationId'] = conversationId;
      }
      // Per-screen active account pin (e.g. user picked a non-primary
      // source account on select_recipients before opening voice).
      // Optional — backend falls back to primary account lookup when
      // unset, so the general dashboard mic still works without it.
      if (accountId != null && accountId.isNotEmpty) {
        requestBody['accountId'] = accountId;
      }
      if (currency != null && currency.isNotEmpty) {
        requestBody['currency'] = currency;
      }
      // Include language and voice preference in room metadata
      if (_selectedLanguageCode != null) {
        requestBody['language'] = _selectedLanguageCode;
      }
      if (_selectedVoiceId != null) {
        requestBody['voicePreference'] = _selectedVoiceId;
      }
      // Dashboard locale (e.g. en-NG) for voice-agent TTS routing (YarnGPT vs OpenAI for English)
      final localeManager = serviceLocator<LocaleManager>();
      requestBody['locale'] = localeManager.currentLocale;
      requestBody['userCountry'] = localeManager.currentCountry;

      // Call the voice-agent-gateway DIRECTLY (same base the rate/clone/
      // process voice endpoints already use). The core-gateway gRPC proxy
      // re-serialises this response through a fixed protobuf struct, which
      // drops every field beyond roomName/livekitToken/agentUrl — including
      // sessionId and the languageCoerced notice. The Python endpoint does
      // its own JWT validation and accepts this exact body (camelCase via
      // Pydantic AliasChoices), so the direct call is lossless and safe.
      final url = '$_voiceAgentGatewayUrl/voice/session/start';
      print('VoiceSessionCubit: POST $url');
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(const Duration(seconds: 30));
      print('VoiceSessionCubit: Response status=${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> &&
            data.containsKey('roomName') &&
            data['roomName'] is String &&
            data.containsKey('livekitToken') &&
            data['livekitToken'] is String) {
          final roomName = data['roomName'] as String;
          final livekitToken = data['livekitToken'] as String;
          _currentSessionId = data['sessionId'] as String? ?? roomName;
          // Admin speech-capture mode. on_device → run the on-device recognizer
          // + suppress the LiveKit mic; livekit → legacy server-side STT.
          //
          // PUSH-TO-TALK ALWAYS CAPTURES ON DEVICE, whatever the admin setting
          // says. In hold/tap/double-tap the user has already told us exactly
          // when their turn starts and ends, so there is nothing for server-side
          // VAD to decide — and routing those turns through the LiveKit mic is
          // what produced split and half-missed transcripts. The device path is
          // the same one voice notes use, which transcribes these turns
          // noticeably better.
          //
          // Hands-free (continuous) keeps following the admin setting, because
          // there the server's turn detection and barge-in handling are doing
          // real work that a gesture is not replacing.
          _serverInputMode = (data['inputMode'] as String?);
          _onDeviceMode = _resolveOnDeviceMode();
          print(
              'VoiceSessionCubit: inputMode=${data['inputMode'] ?? 'on_device(default)'} -> onDeviceMode=$_onDeviceMode');
          // Endpointing windows, admin-tunable. Same rail as inputMode above.
          //
          // Clamped rather than trusted: a zero or negative value would dispatch
          // a turn the instant the recognizer paused, and an absurdly large one
          // would make the agent look dead. The bounds are the usable range, not
          // a guess — below ~600ms is inside a normal mid-sentence pause, and
          // above 15s the user has long since assumed it is broken.
          // Voice-note turn capture for the gesture modes. Absent or false keeps
          // the on-device streaming path.
          _voiceNoteCapture = data['voiceNoteCapture'] == true;
          _silenceWindowMsOverride = _clampWindowMs(data['turnSilenceMs']);
          _graceWindowMsOverride = _clampWindowMs(data['endOfTurnGraceMs']);
          if (_silenceWindowMsOverride != null ||
              _graceWindowMsOverride != null) {
            print(
                'VoiceSessionCubit: endpointing override silence=$_silenceWindowMsOverride grace=$_graceWindowMsOverride');
          }

          // Admin biometrics policy (drives on_device verification + enforcement).
          final bio = data['biometrics'];
          if (bio is Map) {
            _bioEnabled = bio['enabled'] == true;
            _bioEnrollmentRequired = bio['enrollmentRequired'] != false;
            _bioMismatchAction = (bio['action'] == 'exit') ? 'exit' : 'warn';
            _bioFailOpen = bio['failOpen'] == true;
            final t = bio['threshold'];
            if (t is num) _bioThreshold = t.toDouble();
            // Arm a one-time verification capture for the first user-speech window.
            _bioPending = _bioEnabled;
            print(
                'VoiceSessionCubit: biometrics policy enabled=$_bioEnabled action=$_bioMismatchAction failOpen=$_bioFailOpen');
          }

          // Start tracking chat history for this session
          if (_currentSessionId != null) {
            _chatHistoryCubit.startSession(
              _currentSessionId!,
              language: _selectedLanguageCode,
            );
          }

          if (roomName.isNotEmpty && livekitToken.isNotEmpty) {
            if (isClosed) return;
            // If the admin language allow-list blocked the requested language,
            // the backend coerced it to English. Surface that to the user
            // (one transient state, just before credentials) instead of
            // silently switching their language mid-flow.
            if (data['languageCoerced'] == true) {
              final coercedFrom = data['coercedFrom'] as String? ?? '';
              final effectiveLanguage =
                  data['effectiveLanguage'] as String? ?? 'en';
              if (coercedFrom.isNotEmpty) {
                emit(VoiceSessionLanguageCoerced(
                    coercedFrom, effectiveLanguage));
              }
            }
            print(
                'VoiceSessionCubit: Credentials loaded, room=$roomName, url=$_livekitWsUrl');
            emit(VoiceSessionCredentialsLoaded(
              roomName: roomName,
              livekitToken: livekitToken,
              livekitUrl: _livekitWsUrl,
            ));
          } else {
            if (isClosed) return;
            _reportSessionFailure('session_start_empty_credentials',
                statusCode: response.statusCode, body: response.body);
            emit(const VoiceSessionCredentialsError(serverErrorMessage));
          }
        } else {
          if (isClosed) return;
          _reportSessionFailure('session_start_bad_shape',
              statusCode: response.statusCode, body: response.body);
          emit(const VoiceSessionCredentialsError(serverErrorMessage));
        }
      } else {
        if (isClosed) return;
        // The user used to see the literal status line and the raw JSON body:
        //   "Failed to get voice session credentials: 500 {"error":"Failed to
        //    create voice session. Please try again."}"
        // That tells them nothing they can act on, shows our internals in a
        // red banner, and reads as though they broke something. The real text
        // belongs in ops, where someone can actually use it.
        _reportSessionFailure(
          'session_start_http_${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
        emit(VoiceSessionCredentialsError(
            voiceSessionStartMessage(response.statusCode, response.body)));
      }
    } catch (e) {
      if (isClosed) {
        _isStartingSession = false;
        return;
      }
      _reportSessionFailure('session_start_exception', error: e);
      // friendlyError() already distinguishes "your connection" from "our
      // servers" — the distinction that matters here, because telling someone
      // to check their wifi when our gateway is down sends them to restart a
      // router that was never the problem.
      emit(VoiceSessionCredentialsError(
          friendlyError(e, context: 'voice session')));
    } finally {
      // Release the re-entrancy guard. Credentials are loaded (or failed) by
      // now; the LiveKit connect itself runs in connectToLiveKitRoom().
      _isStartingSession = false;
    }
  }

  Future<void> connectToLiveKitRoom(
      String roomName, String token, String url) async {
    if (isClosed) return;
    _teardownRequested =
        false; // fresh connect — clear any stale teardown request
    emit(VoiceSessionConnectingToRoom());

    final micPermissionStatus = await Permission.microphone.request();
    if (micPermissionStatus.isDenied ||
        micPermissionStatus.isPermanentlyDenied) {
      if (isClosed) return;
      emit(VoiceSessionMicPermissionDenied());
      return;
    }
    if (isClosed) return;
    emit(VoiceSessionMicPermissionGranted());

    // Dispose previous room if one exists (prevents resource leaks)
    if (_room != null) {
      await _disposeRoomResources();
    }

    // Noise cancellation from the Flutter/device side: make the WebRTC audio
    // processing the DEFAULT for every mic publish on this room (the mute
    // toggle, the livekit-mode capture, and the hybrid barge-in track) instead
    // of relying on SDK defaults / passing options at only one call site.
    //  • echoCancellation strips the agent's own TTS out of the mic,
    //  • noiseSuppression strips background sound (the #1 recognition-accuracy
    //    win on a phone in a noisy place), and
    //  • autoGainControl keeps a soft/low voice audible.
    // Server-side LiveKit Krisp BVC (background-voice cancellation) layers on
    // top of this whenever audio flows to server STT (livekit input mode).
    _room = Room(
      roomOptions: const RoomOptions(
        defaultAudioCaptureOptions: AudioCaptureOptions(
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true,
          // KEEP THE MIC TRACK ALIVE WHILE MUTED.
          //
          // Two reported symptoms, one cause: the system volume audibly
          // ramping up and down while Nova talks, and Nova sounding quieter
          // than she should.
          //
          // Default is true — muting STOPS capture, which unpublishes the
          // track. LiveKit reconfigures the iOS AVAudioSession CATEGORY on
          // every audio-track state change: `playback` when only the agent is
          // audible, `playAndRecord` once a mic track exists. This session
          // toggles the mic constantly (_setAecMicPublished around every agent
          // turn, _applyCaptureOwnership on each mode switch), so the category
          // was being rewritten several times per conversational turn. Each
          // rewrite is an audio ROUTE CHANGE — that is the ramp the user
          // hears — and the two categories differ in output gain, so the agent
          // really did get quieter whenever the mic went live.
          //
          // false keeps the track published-but-muted, so the track state
          // never drops and the category is set once for the whole call. It
          // also keeps Apple's voice-processing I/O unit (hardware echo
          // cancellation) engaged continuously instead of being torn down in
          // `playback` — which is exactly when the agent is the thing playing,
          // and exactly when its voice was leaking into the recognizer.
          // VoiceEchoGuard is the belt; this is the braces.
          stopAudioCaptureOnMute: false,
        ),
        // PLAY THROUGH THE LOUDSPEAKER, NOT THE EARPIECE.
        //
        // Only capture options were set here, so playback took WebRTC's
        // default: on iOS a voice-call audio session routes to the EARPIECE,
        // which is why the agent was "so quiet you can hardly hear it" unless
        // the phone was held to the ear. Nothing was wrong with the TTS level
        // — the audio was coming out of the wrong speaker.
        //
        // This is a hands-free assistant shown on a full-screen sheet, so the
        // loudspeaker is the right default. Echo cancellation above is what
        // makes it safe: without AEC, loudspeaker output feeds straight back
        // into the mic and the agent interrupts itself.
        defaultAudioOutputOptions: AudioOutputOptions(speakerOn: true),
      ),
    );

    // Setup LiveKit listeners
    _roomEventsListener = _room!.createListener()
      ..on<RoomDisconnectedEvent>((event) {
        // Same reason as in teardown: no trailing SpeakingChangedEvent arrives
        // when the room drops, so the flag has to be cleared here or the mic
        // reads as live on a dead session.
        _localUserSpeaking = false;
        if (isClosed) return;
        _disconnectWebSocket();
        _emitSessionDeath(VoiceSessionDisconnected());
      })
      ..on<SpeakingChangedEvent>((event) {
        if (event.participant == _room?.localParticipant) {
          // Recorded BEFORE the visual-feedback guard below. That guard exists to
          // stop a dialog's state being overwritten, but the mic indicator should
          // still tell the truth about whether we can hear the user while one is
          // open.
          _localUserSpeaking = event.participant.isSpeaking;

          // Don't overwrite visual feedback states (dialogs are showing)
          if (_isVisualFeedbackActive) return;

          if (event.participant.isSpeaking) {
            if (_room != null && !isClosed)
              emit(VoiceSessionLocalUserSpeaking(_room!));
          } else {
            if (_room != null &&
                _room!.connectionState == ConnectionState.connected) {
              if (isClosed) return;
              emit(VoiceSessionAgentProcessing(_room!));
            } else if (_room?.connectionState != ConnectionState.connected) {
              if (isClosed) return;
              emit(VoiceSessionDisconnected());
            }
          }
        }
      });

    try {
      print('VoiceSessionCubit: Connecting to LiveKit room=$roomName url=$url');
      // Use extended timeouts — Android emulator ICE negotiation can exceed the default 10s
      const connectOptions = ConnectOptions(
        timeouts: Timeouts(
          connection: Duration(seconds: 30),
          debounce: Duration(milliseconds: 100),
          publish: Duration(seconds: 20),
          peerConnection: Duration(seconds: 30),
          iceRestart: Duration(seconds: 20),
        ),
      );
      await _room!.connect(url, token, connectOptions: connectOptions);
      print('VoiceSessionCubit: Connected to LiveKit room');

      // The user may have dismissed the sheet (or the agent ended the call) WHILE
      // this connect was in flight — up to 30s. If so, immediately leave the room
      // we just joined instead of going live on a session nobody is watching.
      if (isClosed || _teardownRequested) {
        print(
            'VoiceSessionCubit: teardown requested during connect — disconnecting immediately');
        await _disposeRoomResources();
        if (!isClosed) emit(VoiceSessionDisconnected());
        return;
      }

      // Force the LOUDSPEAKER once the session exists.
      //
      // RoomOptions.defaultAudioOutputOptions sets the intent, but on iOS the
      // AVAudioSession category is (re)configured as the connection comes up,
      // and a voice-call session routes to the earpiece. Asserting it here —
      // after connect, with the room live — is what actually moves the audio,
      // and it is the difference between an agent you can barely hear and one
      // you can.
      //
      // Best-effort: an unsupported platform (desktop/web) logs a warning
      // inside the SDK and changes nothing, so a failure here must never take
      // down a working session.
      try {
        await Hardware.instance.setSpeakerphoneOn(true);
      } catch (e) {
        print('VoiceSessionCubit: could not force speakerphone: $e');
      }

      await _applyCaptureOwnership();

      // Connect to voice WebSocket service for visual feedback events
      _connectWebSocket();

      if (isClosed) return;
      emit(VoiceSessionConnected(_room!));

      // Declare who owns the mic BEFORE any capture starts. The agent gates its
      // STT, its turn handling and its audio-biometrics wait on this; announcing
      // late means it spends the first turn (and a 30s biometrics timeout)
      // believing it should be transcribing a track we never publish.
      _announceCaptureMode();

      // Kick off on-device capture: a once-per-session background voice
      // verification (fail-open) followed by the live listening loop.
      if (_onDeviceMode && !isClosed) {
        unawaited(_startOnDeviceCapture());
      }
    } catch (e) {
      if (isClosed) return;
      print('VoiceSessionCubit: LiveKit connect error: $e');
      emit(VoiceSessionError('Failed to connect to LiveKit room: $e'));
      await _disposeRoomResources();
    }
  }

  // ── On-device speech capture (on_device mode) ──

  /// Orchestrates on-device capture once connected. The agent greets FIRST, so we
  /// begin in the "agent's turn" (_awaitingAgentReply) and only start listening on
  /// greeting-end (agent_caption_end) — or via a fallback if the greeting is
  /// skipped/silent. This avoids transcribing the agent's own greeting.
  ///
  /// Verification is NOT captured here — it would overlap the greeting (the agent's
  /// own voice). Instead it runs once, in the background, on the first CONFIRMED
  /// user-speech window after the greeting (see _runVerificationCapture, triggered
  /// from startLocalListening). Startup is therefore instant and the sample is
  /// always genuine user audio.
  Future<void> _startOnDeviceCapture() async {
    await _initSpeech();
    if (isClosed || _teardownRequested || !_onDeviceMode) return;
    // Greeting comes first — listening starts on greeting-end (or the fallback).
    _awaitingAgentReply = true;
    _scheduleListenFallback();
  }

  /// Safety net: if the greeting is skipped (duplicate-greeting guard) or its
  /// caption markers never arrive, start listening anyway after a bounded wait so
  /// the user is never stuck unable to talk.
  void _scheduleListenFallback() {
    Future.delayed(const Duration(seconds: 8), () {
      if (_onDeviceMode &&
          _awaitingAgentReply &&
          !_bioInProgress &&
          !_isAgentSpeaking &&
          !isClosed &&
          !_teardownRequested) {
        print(
            'VoiceSessionCubit: greeting-end not observed — starting on-device listening (fallback)');
        _awaitingAgentReply = false;
        startLocalListening();
      }
    });
  }

  /// Lazily initialise the on-device recognizer once per cubit.
  Future<void> _initSpeech() async {
    if (_sttInitialized) return;
    try {
      _sttAvailable = await _speech.initialize(
        onError: (err) {
          print(
              'VoiceSessionCubit: speech_to_text error: ${err.errorMsg} (permanent=${err.permanent})');
          _isLocalListening = false;
          // Transient errors (error_no_match / error_speech_timeout) just end a
          // listen window — re-arm whenever listening is currently permitted
          // (covers both the user's turn and the barge-in window).
          if (!err.permanent) _reArmListeningSoon();
        },
        onStatus: (status) {
          // 'done'/'notListening' = the recognizer finalised this window. Re-arm
          // whenever listening is permitted so the conversation flows hands-free
          // (and the barge-in watch stays open while the agent speaks).
          if (status == 'done' || status == 'notListening') {
            _isLocalListening = false;
            _reArmListeningSoon();
          }
        },
      );
      _sttInitialized = true;
      print(
          'VoiceSessionCubit: speech_to_text initialized available=$_sttAvailable');
      _reportSttUnavailable();
    } catch (e) {
      _sttAvailable = false;
      _sttInitialized = true;
      print('VoiceSessionCubit: speech_to_text init failed: $e');
      _reportSttUnavailable();
    }
  }

  /// Tell the user when the recognizer is unusable.
  ///
  /// An unavailable recognizer (permission refused, no speech service on the
  /// device, locale unsupported) used to produce a single `print` and nothing
  /// else: every listen path then returned false at the `!_sttAvailable` gate, so
  /// the session looked completely normal — orb, captions, connected state — and
  /// simply never heard anything. The user has no way to tell that from "the
  /// agent is ignoring me", and no reason to go looking in system settings.
  ///
  /// A caption is used rather than a hard error state so an already-running
  /// conversation is not torn down: in LiveKit capture mode the session is still
  /// perfectly usable without the on-device recognizer.
  void _reportSttUnavailable() {
    if (_sttAvailable || isClosed) return;
    _currentAgentCaption =
        'Microphone or speech recognition is unavailable. Check that Lazervault '
        'has microphone and speech-recognition permission in system settings.';
    _emitCaptionUpdate();
  }

  /// True when on-device capture is required but the recognizer is unusable.
  ///
  /// The UI reads this to explain a mic that will never hear anything, instead of
  /// leaving the user pressing a talk button that silently does nothing.
  bool get sttUnavailable => _onDeviceMode && _sttInitialized && !_sttAvailable;

  /// Start a listening window. speech_to_text auto-finalises the turn after
  /// [pauseFor] of trailing silence (automatic end-of-turn detection) and streams
  /// partial results meanwhile for live captions.
  /// Whether the recognizer should be open right now.
  /// - while the agent speaks → only if barge-in is enabled (interrupt window);
  /// - while waiting for the agent to START replying → no;
  /// - otherwise (user's turn) → yes.
  bool _listeningPermitted() {
    if (!_onDeviceMode ||
        isClosed ||
        _teardownRequested ||
        _isMuted ||
        !_sttAvailable) {
      return false;
    }
    if (_bioInProgress) return false; // verification capture owns the mic
    // A receipt (or any sheet the user must read) owns the screen: the person
    // is reading, not talking, and anything the mic picks up here would be
    // dispatched to the agent as a command. See [_modalOwnsScreen].
    if (_modalOwnsScreen) return false;
    // Push-to-talk: the mic opens ONLY inside a gesture-held capture window. This
    // single gate turns every auto-listen path (greeting, re-arm, agent-end,
    // barge-in) into a no-op unless the user is actively pressing/holding to talk.
    if (isPushToTalk && !_pttActive) return false;
    if (_agentSpeaking) return _bargeInEnabled;
    return !_awaitingAgentReply;
  }

  /// Capture owner for the CURRENT talk mode.
  ///
  /// Push-to-talk always captures on device; hands-free follows the admin
  /// setting. See the session-start handler for why.
  bool _resolveOnDeviceMode() => isPushToTalk || _serverInputMode != 'livekit';

  /// Whether the current interaction mode is a push-to-talk style (not continuous).
  bool get isPushToTalk =>
      _interactionMode == 'hold' ||
      _interactionMode == 'tap' ||
      _interactionMode == 'double_tap';

  /// The resolved interaction mode ('continuous'|'hold'|'tap'|'double_tap').
  String get interactionMode => _interactionMode;

  /// True while a PTT capture window is open (for the talk button's active visual).
  bool get isPttCapturing => _pttActive;

  /// Set the interaction mode (from the user's resolved voice settings, or a live
  /// in-sheet toggle). Switching INTO a PTT mode stops any in-flight continuous
  /// capture and cancels the auto-re-arm so the mic falls silent until a gesture;
  /// switching back to continuous re-arms hands-free listening.
  void setInteractionMode(String mode) {
    final m = mode.trim().toLowerCase();
    const valid = {'continuous', 'hold', 'tap', 'double_tap'};
    final next = valid.contains(m) ? m : 'continuous';
    if (next == _interactionMode) return;
    final wasPtt = isPushToTalk;
    final wasOnDevice = _onDeviceMode;
    // A turn captured under the OLD mode must not be silently binned. Switching
    // mid-hold (the user changes mode from the settings sheet without releasing)
    // used to drop whatever had been said so far on the floor.
    final pending = _joinTurn(_turnAccumulator, _lastPartialText);
    _interactionMode = next;
    // Switching between hands-free and tap-to-speak changes WHO captures the
    // mic, so re-resolve it here too: the session-start value was correct only
    // for the mode in force at connect time.
    _onDeviceMode = _resolveOnDeviceMode();
    // Move the LiveKit mic track to match the new owner. Without this the track
    // keeps the previous mode's state — see _applyCaptureOwnership.
    if (wasOnDevice != _onDeviceMode) {
      unawaited(_applyCaptureOwnership());
    }
    // The capture owner may have just flipped; tell the agent so its STT
    // gating follows, instead of waiting for the next spoken turn to correct it.
    // Announced unconditionally: 'interaction' changes even when the owner does
    // not, and the agent's turn handling reads it.
    _announceCaptureMode();
    // A new mode starts a fresh turn — one barge-in per agent turn, and the old
    // mode's accumulator must not bleed into the next capture.
    _bargedInThisTurn = false;
    // The gesture the button binds, its label, and the docked bar's hint all
    // read the mode — repaint them, or the UI keeps offering the old gesture.
    _emitCaptionUpdate();
    if (isPushToTalk) {
      // Entering PTT: flush anything already spoken, then close the mic; it
      // reopens only on a gesture.
      _pttActive = false;
      if (pending.isNotEmpty) _dispatchUserTurn(pending);
      unawaited(stopLocalListening());
    } else if (wasPtt) {
      // Back to continuous: flush the in-flight PTT turn (the release that would
      // have dispatched it is never coming), then resume hands-free listening.
      _pttActive = false;
      if (pending.isNotEmpty) _dispatchUserTurn(pending);
      // Only the device path re-arms itself. When capture has just moved to
      // LiveKit the server owns the mic and there is nothing local to re-arm.
      if (_onDeviceMode) _reArmListeningSoon();
    }
  }

  /// Begin a push-to-talk capture window (hold-down / tap-to-start / double-tap).
  /// Opens the recognizer; the turn is sent when [pttEnd] is called.
  Future<void> pttBegin() async {
    if (!isPushToTalk) return;
    _pttActive = true;
    // REACHING FOR THE BUTTON *IS* THE INTERRUPTION.
    //
    // Acoustic barge-in still runs, but it needs two non-echo words before it
    // fires (_bargeInMinWords), so Nova talked over the first half of the
    // sentence and the user ended up competing with her. A deliberate press is
    // a far clearer signal of intent than the audio is, and it arrives earlier.
    //
    // _triggerBargeIn clears the speaking flags and publishes {'type':'interrupt'}
    // on lv-user-text, which the gateway turns into session.interrupt(force=True).
    // Guarded on _agentSpeaking so a press in silence costs nothing.
    if (_agentSpeaking) {
      _triggerBargeIn();
    }
    _awaitingAgentReply = false; // a fresh user turn overrides any pending wait
    // Tell the UI the capture window is OPEN.
    //
    // _pttActive is a plain field, and VoiceSessionState is Equatable — without
    // a nudge no BlocBuilder re-runs, so the talk button never lit up while the
    // user was holding it and the only feedback that the mic was live was the
    // agent eventually replying.
    _emitCaptionUpdate();
    // On-device STT keeps running whatever happens here: it is what draws the
    // live captions, so the user still sees words appear while they speak. Its
    // DISPATCH is already disabled in a gesture mode, so the two do not race to
    // submit the turn.
    if (_voiceNoteCapture) {
      _noteCapture ??= VoiceNoteCapture();
      // A failed start is not an error the user should see — the on-device
      // transcript is still being accumulated and will carry the turn.
      final started = await _noteCapture!.start();
      if (!started) {
        print('VoiceSessionCubit: voice-note capture could not start; '
            'falling back to the on-device transcript');
      }
    }
    await startLocalListening();
  }

  /// End a push-to-talk capture window (release / tap-to-stop). Force-finalises the
  /// accumulated turn immediately (PTT never waits for trailing silence), then
  /// closes the mic until the next gesture.
  Future<void> pttEnd() async {
    if (!isPushToTalk) return;
    _pttActive = false;
    // Same reason as pttBegin: without this the button stays lit after release.
    _emitCaptionUpdate();
    // Dispatch whatever we have NOW (accumulated finals + the live partial), the
    // same join the silence-timer/native-final paths use. _dispatchUserTurn dedups
    // and drops an empty turn, so a no-speech press is a clean no-op.
    // The on-device transcript, always computed: it is the fallback for every way
    // the clip path can fail, and the only text available when it is off.
    final onDevice = _joinTurn(_turnAccumulator, _lastPartialText);

    if (_voiceNoteCapture && _noteCapture != null) {
      final clip = await _noteCapture!.stop();
      if (clip != null) {
        final transcript = await _transcribeTurnClip(clip);
        // Prefer the clip ONLY when it produced something. An empty or failed
        // transcription must not discard a turn the on-device recognizer heard.
        if (transcript != null && transcript.trim().isNotEmpty) {
          _dispatchUserTurn(transcript.trim());
          await stopLocalListening();
          return;
        }
      }
    }

    _dispatchUserTurn(onDevice);
    await stopLocalListening();
  }

  /// POSTs a recorded turn to the gateway and returns its transcript, or null.
  ///
  /// Null on every failure — unreachable, rejected, malformed — because the
  /// caller's response to all of them is the same: use the on-device transcript.
  /// A turn is never lost to a transcription problem.
  Future<String?> _transcribeTurnClip(VoiceNoteClip clip) async {
    try {
      // The session's own token, captured at start — the same one the LiveKit
      // connect and every other voice call on this cubit already use.
      final token = _currentAccessToken;
      if (token == null || token.isEmpty) return null;
      final bytes = await clip.file.readAsBytes();
      final response = await http
          .post(
            Uri.parse('\$_voiceAgentGatewayUrl/voice/transcribe'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'session_id': _currentSessionId ?? '',
              'audio_b64': base64Encode(bytes),
              'mime': 'audio/m4a',
              // The selected language, so an African voice note gets its
              // Whisper prompt instead of drifting into English.
              'language': _selectedLanguageCode ?? '',
            }),
          )
          // Bounded so a slow transcription cannot leave the user staring at a
          // turn that never submits; the fallback is immediate and local.
          .timeout(const Duration(seconds: 12));
      if (response.statusCode != 200) {
        print('VoiceSessionCubit: transcribe returned ${response.statusCode}');
        return null;
      }
      final data = jsonDecode(response.body);
      if (data is Map && data['text'] is String) return data['text'] as String;
      return null;
    } catch (e) {
      print('VoiceSessionCubit: transcribe failed: $e');
      return null;
    } finally {
      // The clip has done its job either way.
      try {
        if (await clip.file.exists()) await clip.file.delete();
      } catch (_) {/* a stray temp file is the OS's problem */}
    }
  }

  Future<void> startLocalListening() async {
    // Initialise the recognizer HERE, on demand, not only at connect.
    //
    // THE DEAD-MIC BUG THIS FIXES
    // ---------------------------
    // _initSpeech() used to be reachable only from _startOnDeviceCapture(), which
    // runs at connect behind `if (_onDeviceMode)`. _onDeviceMode is resolved from
    // the session-start response as `isPushToTalk || serverInputMode != 'livekit'`
    // — and at that moment _interactionMode is still its 'continuous' default,
    // because the real mode arrives from VoiceTalkModeController.load(), a NETWORK
    // call the sheet fires unawaited in initState.
    //
    // So with the server's default stt_input_mode ('livekit'), connect evaluated
    // _onDeviceMode = false, skipped _startOnDeviceCapture(), and never
    // initialised the recognizer. load() then delivered 'hold', setInteractionMode
    // flipped _onDeviceMode to true — but nothing re-ran init. _sttAvailable stayed
    // false, _listeningPermitted() returned false forever, and pttBegin opened a
    // capture window onto a recognizer that was never started: the user held the
    // button, spoke, and NOTHING happened, silently, for the whole session.
    //
    // Demand-driven init removes the ordering dependency entirely — whoever needs
    // the mic first initialises it. _initSpeech is idempotent (_sttInitialized).
    if (_onDeviceMode && !_sttInitialized) {
      await _initSpeech();
      if (isClosed || _teardownRequested) return;
    }
    if (!_listeningPermitted()) return;
    if (_speech.isListening || _isLocalListening) return;
    // ONE-TIME VERIFICATION: on the first user-listen after the greeting (not a
    // barge-in window), capture a biometric sample from genuine user speech BEFORE
    // transcription. _runVerificationCapture re-arms listening when done.
    if (_bioPending && !_agentSpeaking) {
      unawaited(_runVerificationCapture());
      return;
    }
    try {
      _isLocalListening = true;
      // Fresh turn: clear dedup guard + partial buffer + any stale silence timer.
      _turnDispatched = false;
      _lastPartialText = '';
      _turnSilenceTimer?.cancel();
      await _speech.listen(
        onResult: _onSpeechResult,
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
          listenMode: stt.ListenMode.dictation,
          listenFor: const Duration(seconds: 60),
          // Trailing-silence window that finalises a turn — long enough to tolerate
          // a mid-sentence breath, short enough to feel responsive. iOS endpoints
          // more eagerly, so give it a longer native pause window to reduce
          // mid-sentence finals (the client silence timer above is the backstop).
          //
          // PUSH-TO-TALK gets the full listen window instead. This was the third
          // and last clock that could end a gesture turn early: the platform
          // recognizer simply STOPS after pauseFor, so holding the button through
          // a long pause left the mic dead with no further partials, and whatever
          // had been said up to that point was all the turn ever contained.
          // In a gesture mode nothing but the gesture may end capture.
          pauseFor: isPushToTalk
              ? const Duration(seconds: 60)
              : Duration(milliseconds: _isIOS ? 3200 : 2500),
          localeId: await _resolveSttLocaleId(),
        ),
      );
    } catch (e) {
      _isLocalListening = false;
      print('VoiceSessionCubit: startLocalListening failed: $e');
    }
  }

  /// Stop the current listening window (no-op if not listening).
  Future<void> stopLocalListening() async {
    _isLocalListening = false;
    _turnSilenceTimer?.cancel();
    try {
      if (_speech.isListening) await _speech.stop();
    } catch (_) {}
  }

  /// HYBRID AEC: publish (with echo cancellation) or drop the LiveKit mic for the
  /// AGENT phase so the server can detect barge-in on clean audio. No-op unless in
  /// on_device hybrid mode. Echo cancellation + noise suppression + AGC keep the
  /// agent's own TTS out of the signal the interruption detector sees.
  /// Capture options for the hybrid-AEC mic.
  ///
  /// `stopAudioCaptureOnMute: false` is the important one, and it has to be
  /// passed on BOTH the enable and the disable call — setSourceEnabled reads it
  /// off the options it is given to decide `stopOnMute`, and it defaults to
  /// TRUE.
  ///
  /// With the default, every agent turn tore the native capture down and stood
  /// it back up. On Android that re-acquires audio focus and re-enters
  /// MODE_IN_COMMUNICATION, which moves playback onto the voice-call stream:
  /// the agent's own voice dropped to the call volume mid-sentence and the
  /// system volume HUD appeared over the UI, every single time it spoke. Keeping
  /// the track alive and merely flipping its mute flag leaves the audio session
  /// untouched, so the route and the volume stay put.
  static const AudioCaptureOptions _aecMicOptions = AudioCaptureOptions(
    echoCancellation: true,
    noiseSuppression: true,
    autoGainControl: true,
    stopAudioCaptureOnMute: false,
  );

  Future<void> _setAecMicPublished(bool enabled) async {
    if (!_onDeviceMode || !_hybridAecBargeIn) return;
    final lp = _room?.localParticipant;
    if (lp == null) return;
    try {
      await lp.setMicrophoneEnabled(
        enabled,
        audioCaptureOptions: _aecMicOptions,
      );
    } catch (e) {
      print('VoiceSessionCubit: _setAecMicPublished($enabled) failed: $e');
    }
  }

  /// Debounced re-arm so a 'done' status that fires immediately after stop()
  /// doesn't recurse; also lets a pending agent reply land first.
  void _reArmListeningSoon() {
    // Push-to-talk never auto-re-arms — the mic reopens only on the next gesture.
    if (isPushToTalk) return;
    // iOS recognizer restart is slower; re-arm sooner there to shrink the dead
    // window where a user's continuation after a mid-sentence pause would be
    // dropped. Android already re-arms fast enough at 350ms (kept to avoid a
    // 'done'-status recursion right after stop()).
    Future.delayed(Duration(milliseconds: _isIOS ? 200 : 350), () {
      if (_listeningPermitted() && !_speech.isListening && !_isLocalListening) {
        startLocalListening();
      }
    });
  }

  /// Handle a recognizer result: render live partial captions (reuses the same
  /// caption state the server-STT path drives), and on the FINAL (auto-endpointed)
  /// result commit the turn to history and send the exact text to the agent.
  void _onSpeechResult(SpeechRecognitionResult result) {
    if (isClosed || !_onDeviceMode) return;
    final words = _sanitizeCaptionText(result.recognizedWords);

    // ── ECHO GATE ──
    // Runs BEFORE the barge-in window, and critically also when
    // _agentSpeaking is already false: the agent's audio keeps playing out of
    // the speaker after the flag clears, and everything arriving in that gap
    // used to be handed through as the user. That is how Nova's own "would you
    // like to try entering your pin again" ended up in the user's bubble
    // during a transfer.
    if (words.isNotEmpty &&
        _echoGuard.isEcho(words, DateTime.now(),
            agentIsSpeaking: _agentSpeaking)) {
      return;
    }

    // ── BARGE-IN WINDOW: recognizer is open while the agent is speaking ──
    if (_agentSpeaking && !_bargedInThisTurn) {
      if (!_bargeInEnabled) return;
      // Echo already filtered above; _looksLikeEcho stays as a second,
      // caption-exact check for the during-speech case.
      if (words.isEmpty || _looksLikeEcho(words)) return;
      // Require a couple of clearly-new words before cutting the agent off, so a
      // stray blip or partial echo can't false-trigger an interruption.
      if (_wordCount(words) < _bargeInMinWords && !result.finalResult) return;
      // Genuine interruption — stop the agent NOW; the rest of this utterance is
      // captured below and dispatched as the superseding turn.
      _triggerBargeIn();
      // fall through (now _agentSpeaking == false) into normal handling
    }

    if (result.finalResult) {
      // NATIVE END-OF-SEGMENT — but NOT necessarily end-of-TURN. Platform STT
      // (esp. Android) finalises mid-sentence after a short pause, so dispatching
      // here would split a long utterance. Instead: fold this segment into the
      // running turn, keep the caption showing the whole thing, and start a grace
      // timer. The recognizer auto-restarts (onStatus 'done' → _reArmListeningSoon)
      // so a continuation is captured as a fresh partial (which cancels this
      // grace). Only if the user stays silent through the grace do we dispatch.
      _turnAccumulator = _joinTurn(_turnAccumulator, words);
      _lastPartialText = '';
      if (_turnAccumulator.isNotEmpty) {
        _currentUserCaption = _turnAccumulator;
        _setUserSpeaking();
        _emitCaptionUpdate();
      }
      _turnSilenceTimer?.cancel();
      _endOfTurnTimer?.cancel();
      // PUSH-TO-TALK NEVER ARMS A CLOCK.
      //
      // In hold / tap / double_tap the user tells us when they are done — by
      // releasing, tapping back, or double-tapping again. That gesture is the
      // whole point of the mode, and pttEnd() already force-dispatches on it.
      //
      // This timer used to arm regardless, so a natural pause of ~2.2s (iOS) /
      // 1.4s (Android) mid-sentence dispatched the turn while the finger was
      // still down — the turn was sent before the user had finished, and the
      // rest of the sentence became the NEXT turn. Returning here is what makes
      // "pause shouldn't affect it sending" true.
      if (isPushToTalk) return;
      // Wait longer when the coalesced turn clearly isn't finished (ends in a
      // continuation word) so a mid-thought pause doesn't split the speech.
      final graceWindow = _looksIncomplete(_turnAccumulator)
          ? _endOfTurnGraceWindowLong
          : _endOfTurnGraceWindow;
      _endOfTurnTimer = Timer(graceWindow, () {
        // Dispatch the whole coalesced turn once the user is genuinely done.
        // Guards: not already sent, not mid-agent-reply (barge-in resets that
        // flag first, so an interruption still dispatches), and the session is
        // still live + unmuted so we never emit on a closed cubit or push stale
        // speech the user muted away.
        if (_onDeviceMode &&
            !isClosed &&
            !_isMuted &&
            !_turnDispatched &&
            !_awaitingAgentReply) {
          _dispatchUserTurn(_joinTurn(_turnAccumulator, _lastPartialText));
        }
      });
      return;
    }

    // PARTIAL: the user is (still) talking → this is NOT the end of the turn, so
    // cancel any end-of-turn grace armed by a prior native-final segment.
    _endOfTurnTimer?.cancel();
    _lastPartialText = words;
    final display = _joinTurn(_turnAccumulator, words);
    const minInterimChars = 3;
    final hasPreview =
        _currentUserCaption != null && _currentUserCaption!.isNotEmpty;
    if (display.length >= minInterimChars || hasPreview) {
      _currentUserCaption = display.isNotEmpty ? display : _currentUserCaption;
      _setUserSpeaking(); // reflect "you're talking" in the UI
      _emitCaptionUpdate();
    }
    // CLIENT-SIDE TURN DETECTION: reset the silence timer on every partial. If it
    // elapses (no new speech for the window) we finalise the turn ourselves — this
    // is what makes end-of-turn detection reliable even when the platform STT never
    // emits a finalResult after the pause. Dispatch the WHOLE accumulated turn.
    _turnSilenceTimer?.cancel();
    // Same reason as the grace timer above: in a gesture mode the user's finger
    // (or their second tap) decides when the turn ends, not a stopwatch. This
    // one fired at ~3.2s (iOS) / 2.5s (Android) of silence, so a slower speaker
    // was cut off mid-thought even while actively holding the button.
    if (isPushToTalk) return;
    // Same adaptive rule for the pure-silence path: an unfinished-sounding turn
    // gets the longer window so a natural pause doesn't finalise it early.
    final silenceWindow =
        _looksIncomplete(display) ? _turnSilenceWindowLong : _turnSilenceWindow;
    _turnSilenceTimer = Timer(silenceWindow, () {
      if (_onDeviceMode && !_turnDispatched && _isLocalListening) {
        _dispatchUserTurn(_joinTurn(_turnAccumulator, _lastPartialText));
      }
    });
  }

  /// Number of whitespace-separated words in [text].
  int _wordCount(String text) =>
      text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;

  /// True when recognized [text] is (mostly) the agent's current spoken caption —
  /// i.e. speaker echo of the agent's own TTS, not the user. Used to suppress
  /// false barge-ins while the agent is talking on a loudspeaker.
  bool _looksLikeEcho(String text) {
    final agent = (_currentAgentCaption ?? '').toLowerCase();
    if (agent.isEmpty) return false;
    final t = text.toLowerCase().trim();
    if (t.isEmpty) return true;
    if (agent.contains(t)) return true;
    final agentTokens = agent.split(RegExp(r'\s+')).toSet();
    final tTokens = t.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (tTokens.isEmpty) return true;
    final overlap = tTokens.where(agentTokens.contains).length / tTokens.length;
    return overlap >= 0.6; // most words are the agent's → echo
  }

  /// React to a confirmed barge-in: stop the agent immediately (so it stops
  /// talking and will reason on the new input), clear its bubble, and flip to the
  /// user's turn. The full superseding utterance is dispatched on end-of-turn.
  void _triggerBargeIn() {
    print('VoiceSessionCubit: barge-in detected — interrupting agent');
    _bargedInThisTurn = true;
    _agentSpeaking = false;
    // A barge-in stops the agent, but audio already in the output buffer still
    // plays out — so the tail window starts here too.
    _echoGuard.noteAgentStoppedSpeaking(DateTime.now());
    _awaitingAgentReply = false;
    _isAgentSpeaking = false;
    _currentAgentCaption = null; // the new reply will replace the bubble
    _publishInterrupt();
    _setUserSpeaking();
    _emitCaptionUpdate();
  }

  /// Tell the agent to stop speaking immediately (barge-in). The superseding
  /// turn text follows via _publishUserText once the utterance ends.
  void _publishInterrupt() {
    final room = _room;
    if (room == null) return;
    try {
      final payload = utf8.encode(jsonEncode({'type': 'interrupt'}));
      unawaited(room.localParticipant?.publishData(
            payload,
            reliable: true,
            topic: _userTextTopic,
          ) ??
          Future.value());
    } catch (e) {
      print('VoiceSessionCubit: publishInterrupt failed: $e');
    }
  }

  /// Reflect "user is speaking" in the UI (parity with the LiveKit
  /// SpeakingChangedEvent path, which doesn't fire in on_device mode since the
  /// mic isn't published). Skipped while a visual-feedback dialog owns the state.
  void _setUserSpeaking() {
    if (_isVisualFeedbackActive || _room == null || isClosed) return;
    if (state is! VoiceSessionLocalUserSpeaking) {
      emit(VoiceSessionLocalUserSpeaking(_room!));
    }
  }

  /// Finalise exactly one user turn (deduped across the native-final and
  /// silence-timer paths): commit to history, clear the live bubble, pause the
  /// recognizer until the agent replies, and send the text to the agent.
  void _dispatchUserTurn(String words) {
    if (_turnDispatched) return; // already sent this turn
    _turnSilenceTimer?.cancel();
    _endOfTurnTimer?.cancel();
    // The turn is being consumed — clear the coalescing accumulator so the NEXT
    // turn starts clean (dispatch is the single point that ends a coalesced turn).
    _turnAccumulator = '';
    final text = _sanitizeCaptionText(words);
    if (text.isEmpty) {
      // Nothing recognised — drop the empty turn and allow a fresh one.
      _currentUserCaption = null;
      _emitCaptionUpdate();
      return;
    }
    _turnDispatched = true;
    if (_currentSessionId != null) {
      _chatHistoryCubit.addUserMessage(_currentSessionId!, text);
    }
    _currentUserCaption = null;
    // Pause listening until the agent has finished replying (re-armed on
    // agent_caption_end) so we never transcribe the agent's own TTS.
    _awaitingAgentReply = true;
    _bargedInThisTurn = false; // reset for the upcoming agent turn
    unawaited(stopLocalListening());
    // Show "processing" while we wait for the agent (parity with the LiveKit
    // path's agent-processing state); falls back to a caption tick otherwise.
    if (_room != null && !_isVisualFeedbackActive && !isClosed) {
      emit(VoiceSessionAgentProcessing(_room!));
    } else {
      _emitCaptionUpdate();
    }
    _publishUserText(text);
  }

  /// Tell the agent, on connect, that THIS client owns the mic.
  ///
  /// The server otherwise decides from an admin setting resolved before the app
  /// joined, and it gates three things on that decision: whether on-device text
  /// packets are accepted, whether server-STT turns are dropped, and whether it
  /// waits for a mic track to run audio biometrics. Push-to-talk captures on
  /// device regardless of the setting, so without this announcement the two
  /// sides disagree for the whole session — the first spoken turn is what would
  /// otherwise correct it, and by then biometrics has already started waiting
  /// for a track that will never be published.
  ///
  /// Best-effort: the agent also adopts on-device on the first user_text packet,
  /// so a dropped announcement costs a slower correction, never a lost turn.
  /// Point the LiveKit microphone track at whoever owns capture RIGHT NOW.
  ///
  /// In on-device mode the app owns the mic for `speech_to_text`, so the track is
  /// NOT published (publishing both causes iOS audio-session contention and makes
  /// the server transcribe the same speech a second time). In LiveKit mode the
  /// track must be published or the gateway has no audio to transcribe.
  ///
  /// THE BUG THIS FIXES: this ran ONLY at connect, so a live talk-mode switch left
  /// the track in the previous mode's state. Switching hands-free → push-to-talk
  /// left the mic PUBLISHED while the device recognizer also ran (dual capture:
  /// every turn transcribed twice, by two engines, arriving split); switching back
  /// left it UNPUBLISHED with the device recognizer stopped, so the server had no
  /// audio and hands-free heard nothing at all.
  ///
  /// Mute wins over everything — a muted session must never publish, whatever the
  /// capture owner is.
  Future<void> _applyCaptureOwnership() async {
    final lp = _room?.localParticipant;
    if (lp == null) return;
    final shouldPublish = !_onDeviceMode && !_isMuted;
    try {
      await lp.setMicrophoneEnabled(shouldPublish);
      print(
          'VoiceSessionCubit: capture owner=${_onDeviceMode ? 'device' : 'livekit'} '
          'micPublished=$shouldPublish mode=$_interactionMode');
    } catch (e) {
      // A failed track toggle must not kill the session — the other capture path
      // may still work, and the next switch retries.
      print(
          'VoiceSessionCubit: setMicrophoneEnabled($shouldPublish) failed: $e');
    }
  }

  void _announceCaptureMode() {
    final room = _room;
    // Announce BOTH directions.
    //
    // This used to `return` when !_onDeviceMode, so it could only ever say
    // "on_device" — there was no packet that meant "I have STOPPED capturing,
    // you take over". Combined with the server latching _client_stt on the first
    // announcement, one push-to-talk turn disabled server STT for the rest of the
    // session, and switching back to hands-free left NOBODY transcribing: the app
    // had stopped its recognizer and the server was still gated off.
    if (room == null) return;
    try {
      final payload = utf8.encode(jsonEncode({
        'type': 'client_capture',
        'mode': _onDeviceMode ? 'on_device' : 'livekit',
        'interaction': _interactionMode,
      }));
      unawaited(room.localParticipant?.publishData(
            payload,
            reliable: true,
            topic: _userTextTopic,
          ) ??
          Future.value());
      print(
          'VoiceSessionCubit: announced on-device capture ($_interactionMode)');
    } catch (e) {
      print('VoiceSessionCubit: capture announcement failed: $e');
    }
  }

  /// Send the final recognized text to the agent over the LiveKit data channel.
  void _publishUserText(String text) {
    final room = _room;
    if (room == null) return;
    try {
      final payload =
          utf8.encode(jsonEncode({'type': 'user_text', 'text': text}));
      unawaited(room.localParticipant?.publishData(
            payload,
            reliable: true,
            topic: _userTextTopic,
          ) ??
          Future.value());
      print(
          'VoiceSessionCubit: published on-device user text (${text.length} chars)');
    } catch (e) {
      print('VoiceSessionCubit: publishData failed: $e');
      // If we couldn't hand off the turn, don't strand the mic — re-arm.
      _awaitingAgentReply = false;
      _reArmListeningSoon();
    }
  }

  /// Resolve the best installed recognizer locale for the session language so the
  /// on-device English model (and others) transcribes accurately. For English we
  /// PREFER en-US (the most broadly-trained model), then any other English, then
  /// any locale whose code matches; null falls back to the device default.
  Future<String?> _resolveSttLocaleId() async {
    final lang = (_selectedLanguageCode ?? 'en')
        .split(RegExp('[-_]'))
        .first
        .toLowerCase();
    try {
      final locales = await _speech.locales();
      String? firstLangMatch;
      String? preferred;
      for (final l in locales) {
        final id = l.localeId.replaceAll('-', '_').toLowerCase();
        if (id == lang || id.startsWith('${lang}_')) {
          firstLangMatch ??= l.localeId;
          // Prefer the canonical region for the language (en_US for English).
          if (lang == 'en' && (id == 'en_us')) preferred = l.localeId;
        }
      }
      return preferred ?? firstLangMatch;
    } catch (_) {}
    return null;
  }

  /// One-time-per-session, background, on-device speaker verification — the
  /// on_device counterpart to the legacy LiveKit-track biometrics (which can't run
  /// here because the mic isn't published). Captured ONLY from a CONFIRMED
  /// user-speech window after the greeting (amplitude-gated) — never during the
  /// greeting, never on silence, never the agent's voice. Admin-driven, identical
  /// policy to the server-side path:
  ///   • skipped entirely when admin `voice_biometrics_enabled` is off;
  ///   • only verifies enrolled users;
  ///   • CONFIRMED match → brief success overlay;
  ///   • MISMATCH → admin `voice_biometrics_mismatch_action_app`:
  ///       'warn' → non-blocking warning, session continues;
  ///       'exit' → end the session;
  ///   • service error / silent user → FAIL-OPEN (continue) unless fail-open is
  ///     off AND the action is 'exit'.
  /// When done it hands the mic to the recognizer (startLocalListening).
  Future<void> _runVerificationCapture() async {
    if (!_bioPending) return;
    _bioPending = false; // one attempt per session
    _bioAttemptedThisSession = true;
    final uid = _currentUserId;
    bool reArm = true;
    String? path;
    try {
      if (!_bioEnabled || uid == null || uid.isEmpty) return;
      final bio = serviceLocator<VoiceBiometricsService>();
      final status = await bio.checkEnrollmentStatus(uid);
      if (!status.isEnrolled) {
        print(_bioEnrollmentRequired
            ? 'VoiceSessionCubit: enrollment required but user unenrolled (guard bypass?) — skipping verification (fail-open)'
            : 'VoiceSessionCubit: user not voice-enrolled (optional) — skipping verification');
        return;
      }
      if (!await _bioRecorder.hasPermission()) return;
      final tmp = await getTemporaryDirectory();
      path =
          '${tmp.path}/voice_verify_${DateTime.now().millisecondsSinceEpoch}.wav';
      _bioCancelled = false;
      _bioInProgress = true; // recorder owns the mic
      await _bioRecorder.start(
        const RecordConfig(
            encoder: AudioEncoder.wav, sampleRate: 16000, numChannels: 1),
        path: path,
      );
      // Gate on REAL speech: wait until the mic actually hears the user before we
      // accept the sample. If they stay silent, skip (fail-open) — we never verify
      // against silence or the agent's own audio.
      final heardUser = await _waitForUserSpeech();
      if (_bioCancelled || isClosed || !heardUser) {
        print(
            'VoiceSessionCubit: no user speech for verification — skipping (fail-open)');
        return;
      }
      // Capture a short slice of their speech for the embedding, then hand the mic
      // straight to the recognizer so the conversation isn't held up.
      await Future.delayed(const Duration(milliseconds: 1500));
      if (_bioCancelled || isClosed) return;
      final recorded = await _bioRecorder.stop();
      _bioInProgress = false;
      if (recorded == null) return;
      final bytes = await File(recorded).readAsBytes();
      if (bytes.isEmpty) return;
      final result = await bio.verifyVoice(
        userId: uid,
        audioSample: Uint8List.fromList(bytes),
        threshold: _bioThreshold,
      );
      print(
          'VoiceSessionCubit: on-device voice verification → verified=${result.verified} (${result.status})');
      // _applyBiometricVerdict may end the session on a mismatch+exit; don't then
      // re-arm listening into a torn-down room.
      reArm = !(result.verified == false && _bioMismatchAction == 'exit');
      _applyBiometricVerdict(
          verified: result.verified, message: result.message);
    } catch (e) {
      print('VoiceSessionCubit: on-device biometrics error: $e');
      if (!_bioFailOpen && _bioMismatchAction == 'exit') {
        reArm = false;
        await _endSessionForVerification(
          "We couldn't verify your voice. Please try again.",
        );
      }
    } finally {
      _bioInProgress = false;
      if (path != null) {
        try {
          final f = File(path);
          if (await f.exists()) await f.delete();
        } catch (_) {}
      }
      // Hand the mic to the recognizer for the conversation (unless the session
      // was ended by an 'exit' verdict).
      if (reArm && _onDeviceMode && !isClosed && !_teardownRequested) {
        startLocalListening();
      }
    }
  }

  /// Poll the recorder's input level until it crosses a speech threshold (the user
  /// is actually talking) or a bounded wait elapses. Returns true once real speech
  /// is heard — this is what guarantees we verify against the USER, not silence or
  /// the agent's voice.
  Future<bool> _waitForUserSpeech() async {
    const maxPolls = 33; // 33 × 150ms ≈ 5s budget for the user to start talking
    const speechDbThreshold =
        -35.0; // dBFS; quiet room floor is well below this
    for (var i = 0; i < maxPolls; i++) {
      if (_bioCancelled || isClosed || !_bioInProgress) return false;
      try {
        final amp = await _bioRecorder.getAmplitude();
        if (amp.current > speechDbThreshold) return true;
      } catch (_) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 150));
    }
    return false; // user stayed silent — skip verification this session
  }

  /// Apply a verification verdict with admin-driven enforcement + a UI overlay.
  /// Reuses the SAME states the server-side (livekit) path emits over WS, so both
  /// modes look identical to the sheet.
  void _applyBiometricVerdict({required bool verified, String? message}) {
    if (isClosed || _room == null) return;
    if (verified) {
      emit(VoiceSessionVerificationSuccess(
        _room!,
        (message != null && message.isNotEmpty)
            ? message
            : "Voice verified — it's really you.",
      ));
      // Auto-dismiss back to the live session after ~3s.
      Future.delayed(const Duration(seconds: 3), () {
        if (!isClosed &&
            state is VoiceSessionVerificationSuccess &&
            _room != null &&
            _room!.connectionState == ConnectionState.connected) {
          emit(VoiceSessionConnected(_room!));
        }
      });
      return;
    }
    // MISMATCH — enforce the admin action.
    if (_bioMismatchAction == 'exit') {
      unawaited(_endSessionForVerification(
        (message != null && message.isNotEmpty)
            ? message
            : "We couldn't confirm it's you. Ending the session for your security.",
      ));
    } else {
      // warn → continue.
      emit(VoiceSessionLowConfidenceWarning(
        _room!,
        (message != null && message.isNotEmpty)
            ? message
            : "We couldn't fully confirm your voice — continuing, but please re-enroll if this keeps happening.",
      ));
      Future.delayed(const Duration(seconds: 5), () {
        if (!isClosed &&
            state is VoiceSessionLowConfidenceWarning &&
            _room != null &&
            _room!.connectionState == ConnectionState.connected) {
          emit(VoiceSessionConnected(_room!));
        }
      });
    }
  }

  /// End the session because speaker verification failed and the admin policy is
  /// 'exit'. Tears down audio + room and surfaces the terminal verification state.
  Future<void> _endSessionForVerification(String message) async {
    _teardownRequested = true;
    await stopLocalListening();
    if (!isClosed) emit(VoiceSessionVerificationFailed(message));
    _disconnectWebSocket();
    await _disposeRoomResources();
    if (!isClosed) {
      emit(VoiceSessionEnded(
        sessionId: _currentSessionId ?? '',
        endReason: 'voice_verification',
      ));
    }
  }

  /// Preempt an in-flight lazy biometric capture so the conversation can start
  /// immediately (the recorder must release the mic before the recognizer takes
  /// it). Best-effort; the capture coroutine sees _bioCancelled and bails.
  Future<void> _abortBiometricsCapture() async {
    _bioCancelled = true;
    try {
      if (await _bioRecorder.isRecording()) await _bioRecorder.stop();
    } catch (_) {}
    _bioInProgress = false;
  }

  // ── WebSocket connection to voice-ws-service ──

  void _connectWebSocket() {
    if (_currentSessionId == null || _currentAccessToken == null) return;

    // Clean up any existing connection before reconnecting
    _wsSubscription?.cancel();
    _wsSubscription = null;
    _wsChannel?.sink.close();
    _wsChannel = null;

    final wsUri = Uri.parse('$_voiceWsUrl/ws/voice/$_currentSessionId'
        '?token=$_currentAccessToken');

    try {
      _wsChannel = IOWebSocketChannel.connect(
        wsUri,
        pingInterval: const Duration(seconds: 30),
      );

      _wsSubscription = _wsChannel!.stream.listen(
        _onWebSocketMessage,
        onError: (error) {
          print('VoiceSessionCubit: WebSocket error: $error');
          _scheduleWebSocketReconnect();
        },
        onDone: () {
          print('VoiceSessionCubit: WebSocket closed');
          _scheduleWebSocketReconnect();
        },
      );

      _wsReconnectAttempts = 0; // Reset on successful connect
      print('VoiceSessionCubit: WebSocket connected to $_voiceWsUrl');
    } catch (e) {
      print('VoiceSessionCubit: WebSocket connection failed: $e');
    }
  }

  int _wsReconnectAttempts = 0;
  static const int _maxWsReconnectAttempts = 5;

  Timer? _wsReconnectTimer;

  void _scheduleWebSocketReconnect() {
    _wsReconnectAttempts++;
    if (_wsReconnectAttempts > _maxWsReconnectAttempts) {
      print('VoiceSessionCubit: Max WebSocket reconnect attempts reached');
      // Notify UI that visual feedback is unavailable
      if (!isClosed && _room != null) {
        emit(VoiceSessionWebSocketFailed(_room!));
      }
      return;
    }
    // Cancel any existing reconnect timer to prevent duplicates
    _wsReconnectTimer?.cancel();
    // Exponential backoff: 2s, 4s, 8s, 16s, 32s
    final delay = Duration(seconds: 2 * _wsReconnectAttempts);
    _wsReconnectTimer = Timer(delay, () {
      if (!isClosed &&
          _currentSessionId != null &&
          _room?.connectionState == ConnectionState.connected) {
        _connectWebSocket();
      }
    });
  }

  void _onWebSocketMessage(dynamic message) {
    try {
      final decoded = jsonDecode(message as String) as Map<String, dynamic>;
      final eventType = decoded['event'] as String?;
      final eventData = decoded['data'] as Map<String, dynamic>? ?? {};

      print('VoiceSessionCubit: WS event received: $eventType');

      if (isClosed) return;

      switch (eventType) {
        case 'session_connected':
          break;
        case 'show_user_search':
          if (_room != null) {
            final users = (eventData['users'] as List?)
                    ?.map((u) => Map<String, dynamic>.from(u as Map))
                    .toList() ??
                [];
            // Keep the candidates so selectUser() can resolve the chosen
            // user's name / avatar for the HUD. If we are searching again
            // after a prior failure, reset the stale result fields.
            _lastSearchCandidates = users;
            if (_transferContext.status == VoiceTransferStatus.failed ||
                _transferContext.status == VoiceTransferStatus.cancelled) {
              _updateTransferContext(VoiceTransferContext.idle);
            }

            // Single match auto-resolved by the agent (e.g. "send 500 to obinna"
            // when there's exactly one Obinna). The backend already stored the
            // recipient, so we DON'T show a picker — we render the recipient widget
            // PRE-SELECTED so the user visually sees Obinna selected and the flow
            // continues straight to amount/summary.
            final autoSelected = eventData['auto_selected'] == true;
            if (autoSelected && users.isNotEmpty) {
              _setVisualFeedbackActive(false);
              final u = users.first;
              final uname = (u['username'] ?? '').toString();
              final name = _candidateName(u);
              _updateTransferContext(VoiceTransferContext(
                status: VoiceTransferStatus.recipientSelected,
                recipientName: name.isEmpty ? uname : name,
                recipientUsername: uname.isEmpty ? null : uname,
                recipientAvatarUrl: _candidateAvatar(u),
              ));
              break;
            }

            _setVisualFeedbackActive(true);
            emit(VoiceSessionUserSearchRequired(
              _room!,
              users,
              eventData['query'] as String? ?? '',
            ));
          }
          break;
        case 'show_transfer_summary':
          if (_room != null) {
            _setVisualFeedbackActive(true);
            _applyTransferSummary(eventData);
            emit(VoiceSessionTransferConfirmation(_room!, eventData));
          }
          break;
        case 'request_pin_entry':
          if (_room != null) {
            _setVisualFeedbackActive(true);
            // A PIN request implies a confirmed amount even if the summary
            // event was skipped — backfill the money fields from the payload.
            _applyPinPayload(eventData);
            emit(VoiceSessionPinRequired(_room!, eventData));
          }
          break;
        case 'voice_pin_spoken':
          // Spoken-PIN mode (voice_txpin_entry_mode == "voice"): the worker captured
          // the digits the user SAID and sent them here. Verify them through the SAME
          // TransactionPinService the on-screen sheet uses, then round-trip the
          // single-use token via submitPinVerification. On any failure fall back to
          // the on-screen sheet so the user is never stuck.
          if (_room != null) {
            _applyPinPayload(eventData);
            unawaited(_handleSpokenPin(eventData));
          }
          break;
        case 'voice_pin_skipped':
          // The user's txPIN policy allows this move WITHOUT a PIN, and
          // auth-service already minted the verification token. Resume through
          // submitPinVerification — the SAME path a typed PIN takes — so there
          // is no second contract that only runs for skipped PINs.
          if (_room != null) {
            _applyPinPayload(eventData);
            final token = eventData['verification_token'] as String?;
            final intent = eventData['callback_intent'] as String?;
            if (token != null &&
                token.isNotEmpty &&
                intent != null &&
                intent.isNotEmpty) {
              unawaited(submitPinVerification(
                verificationToken: token,
                callbackIntent: intent,
                callbackArgs: (eventData['callback_args'] as Map?)
                    ?.cast<String, dynamic>(),
              ));
            } else {
              // Token or intent missing: fall back to asking rather than
              // silently dropping a money move the user is waiting on.
              emit(VoiceSessionPinRequired(_room!, eventData));
            }
          }
          break;
        case 'transaction_result':
          if (_room != null) {
            _setVisualFeedbackActive(false);
            _applyTransactionResult(eventData);
            emit(VoiceSessionTransactionSuccess(_room!, eventData));
          }
          break;
        case 'voice_status':
          if (_room != null) {
            final status = eventData['status'] as String? ?? '';
            final message = eventData['message'] as String?;
            if (status == 'processing') {
              // The user's turn just ended and the agent is now thinking. If a
              // `user_caption_final` already arrived it cleared the interim; but
              // if the turn closed WITHOUT a usable final (VAD cut, empty
              // result), drop the rough live partial here so inaccurate
              // partial text never persists on screen (req: final wins, rough
              // partials never linger). The committed history bubble — if the
              // final landed — is untouched.
              if (_currentUserCaption != null) {
                _currentUserCaption = null;
                _emitCaptionUpdate();
              }
              // Only emit processing if no dialog is active
              if (!_isVisualFeedbackActive) {
                emit(VoiceSessionAgentProcessing(_room!));
              }
            } else if (status == 'listening') {
              // Back to listening for a fresh utterance — clear any stale rough
              // interim from a prior turn that never finalized.
              if (_currentUserCaption != null) {
                _currentUserCaption = null;
                _emitCaptionUpdate();
              }
              _setVisualFeedbackActive(false);
              emit(VoiceSessionConnected(_room!));
            } else if (status == 'error') {
              // Voice verification failed or other error
              _setVisualFeedbackActive(false);
              // If a transfer was mid-flight, mark the HUD failed with the
              // reason rather than leaving it stuck on review/PIN.
              if (_transferContext.isActive && !_transferContext.isTerminal) {
                _updateTransferContext(_transferContext.copyWith(
                  status: VoiceTransferStatus.failed,
                  failureReason:
                      message ?? 'Voice verification failed. Please try again.',
                ));
              }
              emit(VoiceSessionVerificationFailed(
                message ?? 'Voice verification failed. Please try again.',
              ));
            } else if (status == 'language_switched' ||
                status == 'voice_switched') {
              // The agent already SPOKE the switch confirmation (audio) in the new
              // language/voice; just clear any feedback gate and return to listening
              // so the UI reflects that the change took effect.
              _setVisualFeedbackActive(false);
              emit(VoiceSessionConnected(_room!));
            } else if (status == 'disconnected') {
              // Agent signaled session end
              _setVisualFeedbackActive(false);
              _disconnectWebSocket();
              _emitSessionDeath(VoiceSessionDisconnected());
            }
          }
          break;
        case 'custom_voice_state':
          // The agent pushes this on ANY clone state change (created, processing
          // progress tick, ready, failed, enable/disable toggle). We expose it on
          // [customVoiceLive] so the voice settings custom-voice card re-renders
          // live. It does NOT touch the call's session state — voice cloning is a
          // side channel that must never disturb the active conversation UI.
          try {
            customVoiceLive.value = CustomVoiceLiveState.fromJson(eventData);
            // A clone that just finished IS usable — adopt it now rather than
            // waiting for the user to find a button. No-ops if they have
            // already chosen a voice themselves.
            if (customVoiceLive.value?.status == 'ready') {
              unawaited(adoptClonedVoiceIfReady(cloneReady: true));
            }
            print('VoiceSessionCubit: custom_voice_state '
                'status=${eventData['status']} enabled=${eventData['enabled']} '
                'progress=${eventData['progress']} score=${eventData['score']}');
          } catch (e) {
            print('VoiceSessionCubit: bad custom_voice_state payload: $e');
          }
          break;
        case 'voice_verification':
          if (_room != null) {
            final verificationStatus = eventData['status'] as String? ?? '';
            final verificationMsg = eventData['message'] as String? ?? '';
            if (verificationStatus == 'low_confidence') {
              emit(VoiceSessionLowConfidenceWarning(_room!, verificationMsg));
              // Auto-dismiss after 5s and return to connected state
              Future.delayed(const Duration(seconds: 5), () {
                if (!isClosed &&
                    _room != null &&
                    _room!.connectionState == ConnectionState.connected) {
                  emit(VoiceSessionConnected(_room!));
                }
              });
            } else if (verificationStatus == 'verified') {
              // Voice biometrics CONFIRMED the speaker — surface a brief success
              // confirmation (mirrors the failure/unable nudge). The UI auto-
              // dismisses it after 3s; an OK button can dismiss it sooner.
              emit(VoiceSessionVerificationSuccess(
                _room!,
                verificationMsg.isNotEmpty
                    ? verificationMsg
                    : "Voice verified — it's really you.",
              ));
              Future.delayed(const Duration(seconds: 3), () {
                if (!isClosed &&
                    state is VoiceSessionVerificationSuccess &&
                    _room != null &&
                    _room!.connectionState == ConnectionState.connected) {
                  emit(VoiceSessionConnected(_room!));
                }
              });
            }
          }
          break;
        case 'transfer_rejected':
        case 'insufficient_funds':
        case 'daily_limit_exceeded':
        case 'invalid_beneficiary':
          if (_room != null) {
            _setVisualFeedbackActive(false);
            final errorMsg =
                eventData['message'] as String? ?? 'Transaction failed';
            // Reflect the rejection on the HUD (failed + reason) so it stays
            // in sync instead of stalling on the review/PIN step.
            if (_transferContext.isActive) {
              _updateTransferContext(_transferContext.copyWith(
                status: VoiceTransferStatus.failed,
                failureReason: _rejectReason(eventType, errorMsg),
              ));
            }
            emit(VoiceSessionTransactionError(
                _room!, errorMsg, eventType ?? 'error'));
          }
          break;
        // ── Caption events for real-time transcription ──
        case 'user_caption_interim':
          // In on-device mode the client renders user captions locally from the
          // on-device recognizer and commits the final turn itself; the backend
          // still echoes the final text (handle_client_text), so ignore inbound
          // user captions here to avoid a double bubble / double history entry.
          if (_onDeviceMode) break;
          // Partial transcription — a transient LIVE PREVIEW only. This is the
          // rough, inaccurate text from gpt-4o-transcribe partials; it is NEVER
          // committed to VoiceChatHistoryCubit. It is shown as a faded
          // "speaking…" bubble and is REPLACED by the accurate
          // `user_caption_final` (or cleared if the turn ends without one).
          //
          // Accuracy-first flicker guard: ignore very-early/very-short partials
          // (a stray character or two) so the preview doesn't flash garbage
          // before there's enough signal. We only START showing once the
          // partial has a few characters; once a preview is already showing we
          // keep updating it (including shrinking) so corrections still render.
          // The final always overwrites whatever the preview last held.
          if (_room != null) {
            final text = eventData['text'] as String?;
            if (text != null && text.isNotEmpty) {
              // Validate and sanitize
              final sanitized = _sanitizeCaptionText(text);
              const minInterimChars = 3;
              final hasPreview = _currentUserCaption != null &&
                  _currentUserCaption!.isNotEmpty;
              if (sanitized.length >= minInterimChars || hasPreview) {
                _currentUserCaption =
                    sanitized.isNotEmpty ? sanitized : _currentUserCaption;
                _emitCaptionUpdate();
              }
            }
          }
          break;
        case 'user_caption_final':
          // Ignored in on-device mode (committed locally — see user_caption_interim).
          if (_onDeviceMode) break;
          // Final transcription — the user's turn is complete. Commit it to
          // the persistent transcript (so it stays in the scrollable history)
          // and clear the live interim bubble so the finalized history bubble
          // takes over WITHOUT a gap. We do NOT time-clear the interim caption
          // any more (the old 5s YouTube-style timer wiped the user's words
          // mid-conversation — user complaint #1/#2). Clearing only on finalize
          // means there's no flicker: the persisted bubble is appended in the
          // same frame the interim bubble is dropped.
          if (_room != null) {
            final text = eventData['text'] as String?;
            // `replace` = this turn continues/merges the previous one (an interrupted
            // input), so it should REPLACE the last user bubble rather than add a new
            // one — keeping "send 500 … actually 600" as a single message.
            final replace = eventData['replace'] == true;
            if (text != null && text.isNotEmpty) {
              // Validate and sanitize
              final sanitized = _sanitizeCaptionText(text);
              if (sanitized.isNotEmpty) {
                // Commit the finalized turn to the persistent transcript first,
                // then drop the interim live bubble so the history bubble is
                // already present when the live one disappears (no flicker).
                if (_currentSessionId != null) {
                  if (replace) {
                    _chatHistoryCubit.replaceLastUserMessage(
                        _currentSessionId!, sanitized);
                  } else {
                    _chatHistoryCubit.addUserMessage(
                        _currentSessionId!, sanitized);
                  }
                }
                _currentUserCaption = null;
                _emitCaptionUpdate();
              }
            } else {
              // Empty final (e.g. VAD closed the utterance) — just drop the
              // interim bubble; nothing to persist.
              _currentUserCaption = null;
              _emitCaptionUpdate();
            }
          }
          break;
        case 'agent_caption_start':
          // AI agent started its turn. Clear any lingering interim USER caption
          // (their turn is over) and begin streaming the agent's text live. We
          // do NOT persist here — the full agent text is only known once
          // streaming completes, so we commit to history on agent_caption_end
          // (committing the partial start text would store a truncated turn).
          if (_room != null) {
            _currentUserCaption = null;
            // On-device mode: the agent is now speaking.
            if (_onDeviceMode) {
              _agentSpeaking = true;
              _awaitingAgentReply = true;
              _bargedInThisTurn = false;
              // Pause the on-device recognizer (it has no AEC, would hear the TTS).
              unawaited(stopLocalListening());
              if (_hybridAecBargeIn) {
                // AGENT phase: hand the mic to LiveKit WITH echo cancellation so the
                // server's interruption detector can hear the user talk over the
                // agent on clean audio and stop it (true barge-in, no feedback).
                unawaited(_setAecMicPublished(true));
              } else if (_bargeInEnabled) {
                // (Legacy) open-mic acoustic barge-in — off by default (no AEC).
                Future.delayed(const Duration(milliseconds: 700), () {
                  if (_agentSpeaking && _listeningPermitted())
                    startLocalListening();
                });
              }
            }
            final text = eventData['text'] as String?;
            // `replace` = this answer supersedes/merges a prior reply whose bubble
            // is still showing — commit it as a REPLACE on agent_caption_end so the
            // user sees ONE answer, not a half reply followed by a second one.
            _pendingAgentReplace = eventData['replace'] == true;
            final sanitized = text != null ? _sanitizeCaptionText(text) : '';
            _currentAgentCaption = sanitized.isNotEmpty ? sanitized : null;
            _echoGuard.noteAgentUtterance(sanitized);
            _isAgentSpeaking = true;
            _emitCaptionUpdate();
          }
          break;
        case 'agent_caption_text':
          // Streaming chunk of text as the AI speaks (grows the live bubble so
          // it reads as the agent "typing" in realtime).
          if (_room != null) {
            final text = eventData['text'] as String?;
            if (text != null && text.isNotEmpty) {
              final sanitized = _sanitizeCaptionText(text);
              if (sanitized.isNotEmpty) {
                _currentAgentCaption = sanitized;
                _echoGuard.noteAgentUtterance(sanitized);
                _isAgentSpeaking = true;
                _emitCaptionUpdate();
              }
            }
          }
          break;
        case 'agent_caption_end':
          // AI agent finished its turn. Commit the final streamed text to the
          // persistent transcript (so the agent's reply stays in the scrollable
          // history), then drop the live bubble so the history bubble takes
          // over with no gap. Prefer the explicit end-text if provided, else
          // the last streamed caption.
          if (_room != null) {
            final endText = eventData['text'] as String?;
            final finalText = (endText != null && endText.trim().isNotEmpty)
                ? _sanitizeCaptionText(endText)
                : (_currentAgentCaption ?? '');
            if (finalText.isNotEmpty && _currentSessionId != null) {
              if (_pendingAgentReplace) {
                _chatHistoryCubit.replaceLastAgentMessage(
                    _currentSessionId!, finalText);
              } else {
                _chatHistoryCubit.addAgentMessage(
                    _currentSessionId!, finalText);
              }
            }
            _pendingAgentReplace = false;
            _isAgentSpeaking = false;
            _currentAgentCaption = null;
            _emitCaptionUpdate();
            // On-device mode: the agent finished (or was interrupted) — end the
            // AGENT phase. Drop the LiveKit AEC mic so the on-device recognizer can
            // own it again, then re-arm to capture the user's turn (hands-free,
            // natural multi-turn). On a server barge-in this fires right after the
            // interruption, so the user's continuing speech is transcribed.
            if (_onDeviceMode && !isClosed && !_teardownRequested) {
              _agentSpeaking = false;
              // The recognizer re-arms immediately below, but the loudspeaker
              // is still emptying its buffer — this is the exact window the
              // agent's own sentence came back through and was rendered as the
              // user's turn. Start the tail window before re-arming.
              _echoGuard.noteAgentStoppedSpeaking(DateTime.now());
              _awaitingAgentReply = false;
              if (_hybridAecBargeIn) {
                _setAecMicPublished(false).whenComplete(_reArmListeningSoon);
              } else {
                _reArmListeningSoon();
              }
            }
          }
          break;
        case 'language_changed':
          // Agent detected mid-conversation language switch — update UI
          final newLang = eventData['language'] as String?;
          final newLocale = eventData['locale'] as String?;
          if (newLang != null && newLang.isNotEmpty) {
            _selectedLanguageCode = newLang;
            print(
                'VoiceSessionCubit: Language switched to $newLang ($newLocale)');
            if (_room != null) {
              emit(VoiceSessionLanguageChanged(
                  _room!, newLang, newLocale ?? newLang));
            }
          }
          break;
        case 'voice_clone_degraded':
          // The user's custom cloned voice failed over to a standard voice mid-call.
          // Audio keeps working seamlessly — surface a brief notice so the user knows
          // WHY the voice changed, then auto-revert to the connected state.
          if (_room != null) {
            final msg = eventData['message'] as String? ??
                'Voice cloning is temporarily unavailable — using a standard voice.';
            emit(VoiceSessionCloneDegraded(_room!, msg));
            Future.delayed(const Duration(seconds: 4), () {
              if (!isClosed &&
                  state is VoiceSessionCloneDegraded &&
                  _room != null &&
                  _room!.connectionState == ConnectionState.connected) {
                emit(VoiceSessionConnected(_room!));
              }
            });
          }
          break;
        case 'voice_session_ended':
          // The AGENT ended the call (user said "end the call"/"goodbye", idle
          // timeout, etc.). Make this IDENTICAL to the user ending the call
          // manually: run the SAME full teardown (WS + LiveKit room disposal via
          // endSession → _disposeRoomResources) and surface the call-ended /
          // rating screen (VoiceSessionEnded), instead of silently popping the
          // sheet. The mini-bubble also auto-hides on VoiceSessionEnded.
          final reason = eventData['reason'] as String? ?? 'ended';
          print(
              'VoiceSessionCubit: agent ended session (reason=$reason) — ending like a manual end (show rating)');
          _setVisualFeedbackActive(false);
          _clearCaptions();
          // Fire-and-forget to avoid reentrancy on the active WS-message stack;
          // endSession disposes the LiveKit room (closes all connections for this
          // session) and emits VoiceSessionEnded.
          unawaited(endSession(endReason: reason));
          break;
        case 'voice_quota_exceeded':
          // The SERVER declined to start this session: the user is out of
          // monthly voice minutes. Not an error — a decision, with a way
          // forward. Recorded BEFORE the teardown so the RoomDisconnectedEvent
          // the agent is about to cause cannot replace this state.
          final quota = VoiceQuotaInfo.fromEvent(eventData);
          print('VoiceSessionCubit: voice quota exceeded '
              '(used=${quota.usedMinutes}/${quota.freeMinutes}, '
              'payg=${quota.needsPaygOptIn}, reason=${quota.reason})');
          _quotaRefusal = quota;
          _setVisualFeedbackActive(false);
          _clearCaptions();
          emit(VoiceSessionQuotaExceeded(quota));
          // Tear the room down so we are not holding a LiveKit connection the
          // agent has already left. Fire-and-forget to avoid reentrancy on the
          // active WS-message stack; _emitSessionDeath keeps the teardown from
          // emitting over the state just set.
          unawaited(endSession(endReason: 'quota_exceeded'));
          break;
        case 'error':
          _setVisualFeedbackActive(false);
          print('VoiceSessionCubit: WS error event: ${eventData['message']}');
          if (_room != null) {
            final errorMsg =
                eventData['message'] as String? ?? 'An error occurred';
            emit(VoiceSessionError(errorMsg));
          }
          break;
      }
    } catch (e) {
      print('VoiceSessionCubit: Error decoding WS message: $e');
      if (isClosed) return;
      emit(VoiceSessionError('Error processing voice event: $e'));
    }
  }

  void _disconnectWebSocket() {
    _wsReconnectTimer?.cancel();
    _wsReconnectTimer = null;
    _wsSubscription?.cancel();
    _wsSubscription = null;
    _wsChannel?.sink.close();
    _wsChannel = null;
    _wsReconnectAttempts = 0;
    // Clear caption state when WebSocket disconnects
    _clearCaptions();
  }

  // ── Caption helper methods ──

  /// Monotonic counter that forces a distinct emit for every caption tick.
  /// Without it, re-emitting the current (Equatable) state is a no-op and the
  /// live transcript would not grow as the user/agent speaks.
  int _captionSeq = 0;

  /// Emits a caption-only state change so the UI rebuilds and reads the latest
  /// caption getters (`currentUserCaption` / `currentAgentCaption` /
  /// `isAgentSpeaking`). The active session states carry a [seq] nonce; we bump
  /// it here so each interim word/chunk produces a NON-equal state and bloc
  /// doesn't drop the emit (which would freeze the live "typing as you speak"
  /// bubble). For non-active states we fall back to a plain re-emit.
  void _emitCaptionUpdate() {
    if (isClosed) return;
    final s = state;
    final next = ++_captionSeq;
    if (s is VoiceSessionConnected) {
      emit(VoiceSessionConnected(s.room, seq: next));
    } else if (s is VoiceSessionLocalUserSpeaking) {
      emit(VoiceSessionLocalUserSpeaking(s.room, seq: next));
    } else if (s is VoiceSessionAgentProcessing) {
      emit(VoiceSessionAgentProcessing(s.room, seq: next));
    } else {
      // Other states (e.g. transfer-confirmation, PIN) already change on their
      // own events; a plain re-emit is enough for the rare caption tick there.
      emit(s);
    }
  }

  /// Clears all caption state and timers
  void _clearCaptions() {
    _currentUserCaption = null;
    _currentAgentCaption = null;
    _isAgentSpeaking = false;
    _baseStateBeforeCaption = null;
  }

  // ── Transfer HUD context helpers ──

  /// Replace the accumulated transfer context. Does NOT emit on its own — the
  /// caller emits a session state right after, which rebuilds the HUD (the UI
  /// reads [transferContext] via the getter, same pattern as captions).
  void _updateTransferContext(VoiceTransferContext next) {
    _transferContext = next;
  }

  /// Reset the HUD back to idle (cancel / end / new session / disconnect).
  void _resetTransferContext() {
    _transferContext = VoiceTransferContext.idle;
    _lastSearchCandidates = const [];
  }

  /// Pull a usable display name out of a user-search candidate map.
  String _candidateName(Map<String, dynamic> u) {
    final full = (u['full_name'] ?? u['fullName'] ?? '').toString().trim();
    if (full.isNotEmpty) return full;
    final user = (u['username'] ?? '').toString().trim();
    return user;
  }

  /// Pull a profile-picture URL out of a candidate map, tolerating the several
  /// key shapes the backend may use. Returns null when none is present (HUD
  /// then renders initials).
  String? _candidateAvatar(Map<String, dynamic> u) {
    for (final key in const [
      'profile_picture',
      'profile_pic',
      'profile_image_url',
      'profile_picture_url',
      'avatar_url',
      'avatarUrl',
      'profilePicture',
      'photo_url',
    ]) {
      final v = u[key];
      if (v is String && v.trim().isNotEmpty) return v.trim();
    }
    return null;
  }

  /// Map a backend `transfer_type` to a short HUD label.
  String _transferTypeLabel(String type) {
    switch (type) {
      case 'internal':
        return 'Lazervault';
      case 'domestic':
        return 'Bank Transfer';
      case 'international':
        return 'International';
      case 'phone':
        return 'Phone';
      default:
        return type.isEmpty ? 'Transfer' : type;
    }
  }

  /// Tolerantly parse a Naira (major-unit) amount from a dynamic JSON value.
  double? _parseNaira(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    final s = v.toString().replaceAll(',', '').trim();
    if (s.isEmpty) return null;
    return double.tryParse(s);
  }

  /// Fold a `show_transfer_summary` payload into the HUD context → reviewing.
  /// Amounts are NAIRA (major units) — do NOT divide.
  void _applyTransferSummary(Map<String, dynamic> d) {
    final amount = _parseNaira(d['amount']);
    final fee = _parseNaira(d['fee']);
    final total = _parseNaira(d['total']) ??
        ((amount ?? 0) + (fee ?? 0) > 0 ? (amount ?? 0) + (fee ?? 0) : null);
    final currency = (d['currency'] ?? 'NGN').toString();
    final recipient = (d['recipient'] ?? '').toString().trim();
    final username = (d['username'] ?? '').toString().trim();
    final bank =
        (d['beneficiary_bank'] ?? d['bank_name'] ?? '').toString().trim();
    final account = (d['account_number'] ?? d['recipient_account_number'] ?? '')
        .toString()
        .trim();
    final type = (d['transfer_type'] ?? 'internal').toString();

    _updateTransferContext(_transferContext.copyWith(
      status: VoiceTransferStatus.reviewing,
      recipientName: recipient.isEmpty ? null : recipient,
      recipientUsername: username.isEmpty ? null : username,
      amountNaira: amount,
      feeNaira: fee,
      totalNaira: total,
      currency: currency.isEmpty ? 'NGN' : currency,
      bankName: bank.isEmpty ? null : bank,
      accountDetail: account.isEmpty ? null : account,
      transferTypeLabel: _transferTypeLabel(type),
    ));
  }

  /// Backfill money fields from a `request_pin_entry` payload (in case the
  /// summary event was skipped) and flip the HUD to awaitingPin.
  void _applyPinPayload(Map<String, dynamic> d) {
    final amount = _parseNaira(d['amount']);
    final fee = _parseNaira(d['fee']);
    final total = _parseNaira(d['total_amount']) ?? _parseNaira(d['total']);
    final currency = (d['currency'] ?? '').toString();
    final summary = (d['recipient_summary'] ?? '').toString().trim();

    _updateTransferContext(_transferContext.copyWith(
      status: VoiceTransferStatus.awaitingPin,
      amountNaira: amount,
      feeNaira: fee,
      totalNaira: total,
      currency: currency.isEmpty ? null : currency,
      // Only adopt the summary as a name if we never resolved a recipient.
      recipientName:
          _transferContext.recipientName == null && summary.isNotEmpty
              ? summary
              : null,
    ));
  }

  /// Fold a `transaction_result` payload into the HUD context. Backend marks
  /// success/failure inline (`success: false` + `error`).
  void _applyTransactionResult(Map<String, dynamic> d) {
    final success = d['success'] as bool? ?? true;
    if (success) {
      final ref = (d['reference'] ?? d['transaction_reference'] ?? '')
          .toString()
          .trim();
      final balance =
          (d['new_balance'] ?? d['balance'] ?? '').toString().trim();
      _updateTransferContext(_transferContext.copyWith(
        status: VoiceTransferStatus.success,
        reference: ref.isEmpty ? null : ref,
        newBalance: balance.isEmpty ? null : balance,
      ));
    } else {
      final reason =
          (d['error'] ?? d['message'] ?? 'Transfer failed').toString();
      _updateTransferContext(_transferContext.copyWith(
        status: VoiceTransferStatus.failed,
        failureReason: reason,
      ));
    }
  }

  /// Human-friendly reason for a transfer-rejection event family.
  String _rejectReason(String? eventType, String fallback) {
    switch (eventType) {
      case 'insufficient_funds':
        return 'Insufficient funds';
      case 'daily_limit_exceeded':
        return 'Daily limit exceeded';
      case 'invalid_beneficiary':
        return 'Invalid beneficiary';
      default:
        return fallback;
    }
  }

  // ── Send events to voice agent via WebSocket ──

  /// Send a structured event to the voice agent through the WebSocket service.
  Future<void> sendToVoiceAgent(
      String eventType, Map<String, dynamic> data) async {
    if (_wsChannel == null) return;
    final payload = jsonEncode({'event': eventType, 'data': data});
    try {
      _wsChannel!.sink.add(payload);
      print('VoiceSessionCubit: Sent $eventType to voice agent via WS');
    } catch (e) {
      print('VoiceSessionCubit: Failed to send $eventType: $e');
    }
  }

  /// User selected a recipient from the search results dialog.
  Future<void> selectUser(String userId, String username) async {
    _setVisualFeedbackActive(false);

    // Resolve the chosen candidate (name / avatar / initials) from the last
    // search results and fold it into the HUD context → recipientSelected.
    Map<String, dynamic>? chosen;
    for (final u in _lastSearchCandidates) {
      final uid = (u['user_id'] ?? u['userId'] ?? '').toString();
      final uname = (u['username'] ?? '').toString();
      if ((userId.isNotEmpty && uid == userId) ||
          (username.isNotEmpty && uname == username)) {
        chosen = u;
        break;
      }
    }
    final name = chosen != null ? _candidateName(chosen) : username;
    final avatar = chosen != null ? _candidateAvatar(chosen) : null;
    // Fresh recipient selection resets any prior result fields (e.g. retry
    // after a failure) while keeping the new recipient details.
    _updateTransferContext(VoiceTransferContext(
      status: VoiceTransferStatus.recipientSelected,
      recipientName: name.isEmpty ? username : name,
      recipientUsername: username.isEmpty ? null : username,
      recipientAvatarUrl: avatar,
    ));

    await sendToVoiceAgent('user_selected', {
      'user_id': userId,
      'username': username,
    });
    if (_room != null && !isClosed) {
      // Emit processing — agent will process the selection and send next event
      emit(VoiceSessionAgentProcessing(_room!));
    }
  }

  /// User confirmed the transfer summary.
  Future<void> confirmTransfer() async {
    _setVisualFeedbackActive(false);
    await sendToVoiceAgent('transfer_confirmed', {});
    if (_room != null && !isClosed) {
      emit(VoiceSessionAgentProcessing(_room!));
    }
  }

  /// User cancelled the current voice action.
  Future<void> cancelVoiceAction() async {
    _setVisualFeedbackActive(false);
    // Fully reset the transfer context on cancel so the NEXT transfer starts
    // clean (no stale recipient/amount flashing on the HUD). The HUD simply
    // disappears on abort, which is the correct behaviour for a cancellation.
    _resetTransferContext();
    await sendToVoiceAgent('transfer_cancelled', {});
    if (_room != null && !isClosed) {
      emit(VoiceSessionConnected(_room!));
    }
  }

  /// PIN entry completed — notify voice agent of the result.
  Future<void> notifyPinCompleted(
    bool success, {
    String? reference,
    String? error,
    bool isLocked = false,
    int? remainingAttempts,
  }) async {
    _setVisualFeedbackActive(false);
    await sendToVoiceAgent('pin_completed', {
      'success': success,
      if (reference != null) 'reference': reference,
      if (error != null) 'error': error,
      // Real failure detail so the agent speaks the CORRECT outcome (locked vs cancel
      // vs exhausted) instead of always offering a retry that a locked account rejects.
      'is_locked': isLocked,
      if (remainingAttempts != null) 'remaining_attempts': remainingAttempts,
    });
    if (_room != null && !isClosed) {
      emit(VoiceSessionAgentProcessing(_room!));
    }
  }

  /// Single-use PIN verification round-trip — matches the chat path's
  /// `submitPinVerification` shape so voice and chat share the same
  /// agent-resume contract.
  ///
  /// Caller (VoicePinSheetLauncher) passes the verification_token from
  /// TransactionPinMixin AND the callback_intent + callback_args that
  /// were attached to the agent's PinPromptIntent. The bridge then
  /// re-calls the same tool with the token in entities, the saga
  /// spends the token (atomic single-use), and a ReceiptCard comes
  /// back to the user.
  Future<void> submitPinVerification({
    required String verificationToken,
    required String callbackIntent,
    Map<String, dynamic>? callbackArgs,
  }) async {
    _setVisualFeedbackActive(false);
    await sendToVoiceAgent('pin_verified', {
      'verification_token': verificationToken,
      'callback_intent': callbackIntent,
      if (callbackArgs != null && callbackArgs.isNotEmpty)
        'callback_args': callbackArgs,
    });
    if (_room != null && !isClosed) {
      emit(VoiceSessionAgentProcessing(_room!));
    }
  }

  /// Verify a SPOKEN transaction PIN (voice_txpin_entry_mode == "voice").
  ///
  /// The voice worker captured the digits the user said and sent them via the
  /// `voice_pin_spoken` event. We verify them headlessly through the SAME
  /// [ITransactionPinService.verifyPin] the on-screen sheet uses, then resume the
  /// agent's saga via [submitPinVerification] with the single-use token — reusing
  /// the exact verify-then-resume contract of the sheet path (no parallel money
  /// code). On a wrong/locked PIN, or any error, we fall back to opening the
  /// on-screen PIN sheet so the user can retry manually and see attempts remaining.
  Future<void> _handleSpokenPin(Map<String, dynamic> payload) async {
    final pin = (payload['pin'] ?? '').toString().trim();
    final transactionId = (payload['transaction_id'] ?? '').toString();
    final transactionType =
        (payload['transaction_type'] ?? 'transfer').toString();
    final currency = (payload['currency'] ?? 'NGN').toString();
    final amount = _parseNaira(payload['amount']) ?? 0.0;
    final callbackIntent = (payload['callback_intent'] ?? '').toString();
    final callbackArgs = payload['callback_args'] is Map
        ? Map<String, dynamic>.from(payload['callback_args'] as Map)
        : <String, dynamic>{};

    // Never keep the raw PIN in the payload we might re-emit to the sheet.
    final sheetPayload = Map<String, dynamic>.from(payload)..remove('pin');

    void fallbackToSheet() {
      if (_room == null || isClosed) return;
      _setVisualFeedbackActive(true);
      emit(VoiceSessionPinRequired(_room!, sheetPayload));
    }

    if (pin.length < 4 || pin.length > 6) {
      fallbackToSheet();
      return;
    }

    try {
      final result = await serviceLocator<ITransactionPinService>().verifyPin(
        pin: pin,
        transactionId: transactionId,
        transactionType: transactionType,
        amount: amount,
        currency: currency,
      );
      if (result.success && (result.verificationToken?.isNotEmpty ?? false)) {
        final token = result.verificationToken!;
        if (callbackIntent.isNotEmpty) {
          await submitPinVerification(
            verificationToken: token,
            callbackIntent: callbackIntent,
            callbackArgs: callbackArgs,
          );
        } else {
          await notifyPinCompleted(true, reference: token);
        }
        return;
      }
      // Wrong / locked / no-PIN-set: let the user retry on the on-screen sheet,
      // which surfaces the exact attempts-remaining / lockout messaging.
      fallbackToSheet();
    } catch (_) {
      fallbackToSheet();
    }
  }

  /// User flipped the custom-voice toggle in voice settings DURING a live call.
  /// Notify the agent so it swaps its TTS live (clone when enabled+ready, default
  /// otherwise) and the NEXT reply uses the new voice. When there is NO active
  /// session (`_wsChannel == null`, the toggle was flipped outside a call),
  /// sendToVoiceAgent returns silently and the next session picks up the new flag
  /// at start. Does not emit/transition session state — voice swap is silent.
  Future<void> notifyCustomVoiceChanged(bool enabled) async {
    await sendToVoiceAgent('custom_voice_changed', {'enabled': enabled});
  }

  /// User picked a different PRESET voice during a live call. Tell the agent to
  /// swap its TTS live so the next reply uses it — a LIVE swap, NOT a session
  /// restart (restarting mid-call raced the backend's concurrent-session limit
  /// and left a room with no agent, which is what broke voice output). No-ops
  /// when there is no active session; the next session start picks up the saved
  /// voice from metadata. Does not transition session state.
  Future<void> notifyVoiceChanged(String voiceId) async {
    if (voiceId.isEmpty) return;
    await sendToVoiceAgent('voice_changed', {'voice_preference': voiceId});
  }

  /// The user opened the voice-cloning setup flow while a voice call is live.
  /// Tell the agent to PAUSE (stop listening / talking) so the mic isn't fought
  /// over while the user records their cloning sample. No-op when there is no
  /// active session (`sendToVoiceAgent` returns early). Does not change session
  /// state — the call stays connected, just muted on the agent side.
  Future<void> notifyCustomVoiceSetupStarted() async {
    await sendToVoiceAgent('custom_voice_setup_started', {});
  }

  /// The user finished, cancelled or left the voice-cloning/enrollment setup
  /// flow. Tell the agent to RESUME the paused call. Safe to call unconditionally
  /// — it pairs with [notifyCustomVoiceSetupStarted] and no-ops when no session
  /// is active.
  ///
  /// [succeeded] tells the agent whether the setup actually produced/updated a
  /// voice (true) or was cancelled/failed (false). On false the agent resumes
  /// with a neutral line instead of falsely announcing "I'm using your voice
  /// now". Defaults to true to preserve the existing voice-cloning callers.
  Future<void> notifyCustomVoiceSetupFinished({bool succeeded = true}) async {
    await sendToVoiceAgent(
      'custom_voice_setup_finished',
      {'succeeded': succeeded},
    );
  }

  Future<void> disconnectFromLiveKitRoom({bool fullCleanup = false}) async {
    print(
        'VoiceSessionCubit: disconnectFromLiveKitRoom called, fullCleanup=$fullCleanup');
    _teardownRequested =
        true; // cancel any in-flight connect (mid-connection dismissal)
    _disconnectWebSocket();
    _setVisualFeedbackActive(false);
    _clearCaptions();
    _resetTransferContext();
    await _disposeRoomResources();
    if (isClosed) return;
    emit(VoiceSessionDisconnected());

    // Clear session data on full cleanup
    if (fullCleanup) {
      // Close the conversation record FIRST — clearing _currentSessionId below throws
      // the id away, after which nothing can ever close it.
      //
      // A full cleanup means this session is over for good, so leaving the record open
      // is simply wrong: the conversation sat in history with no end time, and every
      // caller of this method (the sheet's close button, a swipe-dismiss, logout) left
      // one behind. endSession() on the history cubit is idempotent — it re-stamps
      // endedAt — so callers that also go through endSession() below are unaffected.
      if (_currentSessionId != null && _currentSessionId!.isNotEmpty) {
        _chatHistoryCubit.endSession(_currentSessionId!);
      }
      _currentSessionId = null;
      _currentAccessToken = null;
      _isMuted = false;
    }
  }

  /// End the session and transition to the rating/thank-you screen.
  /// [endReason] optionally describes why the call ended (e.g. voice verification failure).
  Future<void> endSession({String? endReason}) async {
    final sessionId = _currentSessionId ?? '';
    print('VoiceSessionCubit: endSession called, sessionId=$sessionId');
    _teardownRequested =
        true; // cancel any in-flight connect (mid-connection end)
    _disconnectWebSocket();
    _setVisualFeedbackActive(false);
    _clearCaptions();
    _resetTransferContext();

    // End chat history tracking
    if (sessionId.isNotEmpty) {
      _chatHistoryCubit.endSession(sessionId);
    }

    await _disposeRoomResources();
    _isMuted = false;
    if (isClosed) return;
    // Suppressed on a quota refusal: VoiceSessionEnded shows the call-ended /
    // rating screen, and asking someone to rate a call that was never allowed
    // to start is absurd.
    _emitSessionDeath(
        VoiceSessionEnded(sessionId: sessionId, endReason: endReason));
  }

  /// This user's voice allowance and the current price terms.
  ///
  /// Returns null when it cannot be read — callers must treat that as "unknown",
  /// never as "no allowance left" or "already opted in".
  Future<Map<String, dynamic>?> fetchVoiceBillingStatus(
      {String? accessToken}) async {
    final token = accessToken ?? _currentAccessToken ?? '';
    if (token.isEmpty) return null;
    try {
      final response = await http.get(
        Uri.parse('$_voiceAgentGatewayUrl/voice/billing/status'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        print('VoiceSessionCubit: billing status HTTP ${response.statusCode}');
        return null;
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print('VoiceSessionCubit: billing status error: $e');
      return null;
    }
  }

  /// Accept or withdraw pay-as-you-go consent. Returns true when saved.
  ///
  /// The terms version is read from the server IN THIS CALL rather than taken
  /// from the caller, and the server checks it again before recording. Two
  /// reads of the same thing on purpose: the app must not be the one asserting
  /// what price the user agreed to, and the second check closes the window
  /// where a rate changes between the sheet rendering and the tap.
  ///
  /// Throws on transport failure so the sheet can distinguish "server not
  /// reachable" from a deliberate refusal, which return false.
  Future<bool> setVoicePaygOptIn(bool optedIn, {String? accessToken}) async {
    final token = accessToken ?? _currentAccessToken ?? '';
    if (token.isEmpty) {
      print('VoiceSessionCubit: cannot set payg opt-in — no token');
      return false;
    }

    String? termsVersion;
    if (optedIn) {
      // Required to opt IN. Withdrawing needs no version — nobody should be
      // held in a paid mode because the rates moved while they cancelled.
      final status = await fetchVoiceBillingStatus(accessToken: token);
      termsVersion =
          (status?['terms'] as Map<String, dynamic>?)?['version'] as String?;
      if (termsVersion == null || termsVersion.isEmpty) {
        print('VoiceSessionCubit: payg opt-in aborted — no terms version');
        return false;
      }
    }

    final response = await http
        .post(
          Uri.parse('$_voiceAgentGatewayUrl/voice/billing/payg'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'opted_in': optedIn,
            if (termsVersion != null) 'terms_version': termsVersion,
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      if (optedIn) {
        // The refusal is spent: the next start is allowed to run.
        _quotaRefusal = null;
      }
      return true;
    }
    print('VoiceSessionCubit: payg opt-in HTTP ${response.statusCode}: '
        '${response.body}');
    return false;
  }

  /// Submit a session rating to the backend.
  /// Returns true on success, false on failure.
  Future<bool> submitRating({
    required int rating,
    String? feedback,
  }) async {
    final sessionId = _currentSessionId ?? '';
    final token = _currentAccessToken ?? '';
    if (sessionId.isEmpty || token.isEmpty) {
      print('VoiceSessionCubit: Cannot submit rating — no session/token');
      return false;
    }

    try {
      final url = '$_voiceAgentGatewayUrl/voice/session/rate';
      print('VoiceSessionCubit: POST $url (rating=$rating)');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'session_id': sessionId,
          'rating': rating,
          if (feedback != null && feedback.isNotEmpty) 'feedback': feedback,
        }),
      );
      print('VoiceSessionCubit: Rating response status=${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('VoiceSessionCubit: Rating submission error: $e');
      return false;
    }
  }

  /// Start a fresh session (used from the "Call Again" button on the ended screen).
  Future<void> startNewSession({required String accessToken}) async {
    // Ensure old session is fully cleaned up before starting new one
    // Cleared FIRST: a retry after opting into pay-as-you-go must not be
    // silenced by the previous attempt's refusal.
    _quotaRefusal = null;
    _disconnectWebSocket();
    await _disposeRoomResources();
    _currentSessionId = null;
    _currentAccessToken = null;
    _isMuted = false;
    _setVisualFeedbackActive(false);
    _resetTransferContext();
    if (!isClosed) emit(VoiceSessionInitial());
    // Small delay to let UI rebuild, then start
    await Future.delayed(const Duration(milliseconds: 100));
    startVoiceSession(accessToken: accessToken);
  }

  Future<void> _disposeRoomResources() {
    // Concurrent callers (widget dispose + _closeSheet + agent-ended) share the
    // SAME in-flight disposal instead of racing on _room.
    final existing = _disposingRoom;
    if (existing != null) return existing;
    final future = _doDisposeRoomResources();
    _disposingRoom = future;
    return future.whenComplete(() => _disposingRoom = null);
  }

  Future<void> _doDisposeRoomResources() async {
    final listener = _roomEventsListener;
    final room = _room;
    // Null the refs first so a late connect / re-entrant call sees a clean slate.
    _roomEventsListener = null;
    _room = null;
    // Release the on-device recognizer + biometric recorder so the next session
    // (or another mic consumer) gets a clean audio session. Reset per-session
    // turn-taking flags so a restart re-arms correctly.
    _awaitingAgentReply = false;
    _agentSpeaking = false;
    // New session must never begin inside a stale tail window.
    _echoGuard.reset();
    _bargedInThisTurn = false;
    _isLocalListening = false;
    // Or the mic indicator stays green after the session ends: LiveKit sends no
    // final "stopped speaking" event when the room goes away.
    _localUserSpeaking = false;
    // Release the recorder and drop any clip still on disk. A recorder left open
    // holds the audio session, which is what makes the NEXT session's mic dead —
    // and an abandoned temp file is a voice note nobody asked to keep.
    final capture = _noteCapture;
    _noteCapture = null;
    if (capture != null) unawaited(capture.dispose());
    _bioAttemptedThisSession = false;
    _bioInProgress = false;
    _bioCancelled =
        true; // bail any in-flight capture; a new capture re-arms it
    _bioPending = false;
    _turnDispatched = false;
    _lastPartialText = '';
    _turnAccumulator = '';
    _turnSilenceTimer?.cancel();
    _turnSilenceTimer = null;
    _endOfTurnTimer?.cancel();
    _endOfTurnTimer = null;
    // ORDER MATTERS, and this order is the fix for "End / X doesn't close the
    // call". The room disconnect used to run LAST, behind three unbounded
    // awaits on platform audio plugins. `_speech.cancel()` and
    // `_bioRecorder.stop()` both cross a platform channel into the OS audio
    // session, which is exactly the thing that wedges when a call is torn down
    // mid-utterance — and a wedge there meant teardown never reached
    // `room.disconnect()`. The user got a dismissed sheet on top of a LiveKit
    // room that was still connected, still publishing their mic, and still
    // billing, until the server swept it.
    //
    // So: close the CONNECTION first, then release local audio. Every step is
    // independently bounded — one stuck plugin can no longer hold the others
    // hostage, and none of them can hold the disconnect hostage.
    Future<void> step(String what, Future<void> Function() body,
        [int seconds = 3]) async {
      try {
        await body().timeout(Duration(seconds: seconds));
      } catch (e) {
        // Teardown is best-effort by definition: the refs are already nulled,
        // so a failure here must never propagate and strand the caller.
        print('VoiceSessionCubit: $what failed/timed out (ignored): $e');
      }
    }

    // 1. The connection itself — first, and never skipped.
    //    5s is well past a healthy WebRTC close.
    await step('room disconnect', () async => room?.disconnect(), 5);

    // 2. Stop listening for events on a room that is already gone.
    await step('room listener dispose', () async => listener?.dispose(), 2);

    // 3. Local audio resources, so the next session (or another mic consumer)
    //    gets a clean audio session. Safe to be last now: if either of these
    //    wedges, the call is already closed.
    await step('speech recognizer cancel', () async {
      if (_speech.isListening) await _speech.cancel();
    });
    await step('biometric recorder stop', () async {
      if (await _bioRecorder.isRecording()) await _bioRecorder.stop();
    });
  }

  /// Reset the session state (for reconnection scenarios)
  Future<void> resetSessionState() async {
    print('VoiceSessionCubit: resetSessionState called');
    _disconnectWebSocket();
    await _disposeRoomResources();
    _setVisualFeedbackActive(false);
    _isMuted = false;
    _clearCaptions();
    _resetTransferContext();
    if (!isClosed) {
      emit(VoiceSessionInitial());
    }
  }

  /// Keep the process-global "voice session live" flag in sync with the session
  /// state so the InactivityWatcher suppresses auto-logout for the WHOLE session —
  /// including while the sheet is minimized to the floating bubble (cubit out of the
  /// watcher's context). Terminal states (Initial / Ended / Error / CredentialsError /
  /// MicPermissionDenied) clear it; every engaged state (connecting, connected,
  /// speaking, processing, PIN, transfer, and transient disconnect/reconnect) keeps it
  /// set so a reconnect blip never re-arms logout mid-call.
  @override
  void onChange(Change<VoiceSessionState> change) {
    super.onChange(change);
    final s = change.nextState;
    final active = s is! VoiceSessionInitial &&
        s is! VoiceSessionEnded &&
        s is! VoiceSessionError &&
        s is! VoiceSessionCredentialsError &&
        s is! VoiceSessionMicPermissionDenied;
    VoiceSessionActivity.setActive(active);
  }

  @override
  Future<void> close() async {
    // Definitive teardown — always release the auto-logout suppression.
    VoiceSessionActivity.setActive(false);
    _visualFeedbackTimer?.cancel();
    _visualFeedbackTimer = null;
    _modalOwnsScreenTimer?.cancel();
    _modalOwnsScreenTimer = null;
    _disconnectWebSocket();
    // Guard against a double-dispose (a screen may already be tearing down and
    // racing this close()); listeners on the other side guard removeListener.
    try {
      customVoiceLive.dispose();
    } catch (_) {}
    try {
      await _bioRecorder.dispose();
    } catch (_) {}
    await _disposeRoomResources();
    return super.close();
  }

  /// Sanitize caption text to handle edge cases.
  /// - Removes null characters and invalid Unicode
  /// - Tr excessively long text
  /// - Handles empty/whitespace-only strings
  String _sanitizeCaptionText(String text) {
    if (text.isEmpty) return '';

    // Trim whitespace
    final trimmed = text.trim();
    if (trimmed.isEmpty) return '';

    // Remove control characters (except common whitespace)
    final sanitized =
        trimmed.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]'), '');

    // Truncate if too long (max 500 chars to prevent memory issues)
    const maxLength = 500;
    if (sanitized.length > maxLength) {
      return '${sanitized.substring(0, maxLength - 3)}...';
    }

    return sanitized;
  }
}
