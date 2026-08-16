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
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/voice_session_activity.dart';
import 'package:lazervault/core/config/feature_flags.dart';
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

class VoiceSessionCubit extends Cubit<VoiceSessionState> {
  // --- Configuration ---
  // LiveKit Cloud's URL stays dotenv-only — LiveKit lives outside the
  // Cloudflare tunnel (it has its own SFU edge). The voice-ws, voice-
  // agent and voice-language URLs all come from the EndpointRegistry so
  // an admin URL rotation propagates without an app rebuild; dotenv
  // overrides are still honoured for local-dev (10.0.2.2 dialling).
  final String _livekitWsUrl = dotenv.env['LIVEKIT_URL'] ?? (throw Exception('LIVEKIT_URL environment variable is not set.'));
  final String _voiceWsUrl = (dotenv.env['VOICE_WS_URL']?.isNotEmpty == true)
      ? dotenv.env['VOICE_WS_URL']!
      : endpointRegistry.wsVoice;
  final String _voiceLanguageApiUrl = (dotenv.env['VOICE_LANGUAGE_API_URL']?.isNotEmpty == true)
      ? dotenv.env['VOICE_LANGUAGE_API_URL']!
      : endpointRegistry.httpVoiceLang;
  final String _voiceAgentGatewayUrl = (dotenv.env['VOICE_AGENT_GATEWAY_URL']?.isNotEmpty == true)
      ? dotenv.env['VOICE_AGENT_GATEWAY_URL']!
      : endpointRegistry.httpVoiceAgent;

  static const String _prefKeyLanguage = 'voice_selected_language';
  static const String _prefKeyVoice = 'voice_selected_voice_id';
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

  /// How the user talks to the agent (UX preference; on-device mode only):
  ///   'continuous'  — always-listening VAD (default; auto re-arms hands-free);
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

  /// Guards a single barge-in per agent turn (so we interrupt once, not per word).
  bool _bargedInThisTurn = false;

  /// Master switch for OPEN-MIC acoustic barge-in (interrupt the agent by talking
  /// over it) in on_device mode.
  ///
  /// OFF by default: on a loudspeaker there is NO acoustic echo cancellation on
  /// the raw `speech_to_text` mic (unlike LiveKit mode, which has hardware AEC), so
  /// keeping the recognizer open while the agent speaks makes it transcribe the
  /// agent's OWN TTS and fire a false barge-in that cuts the audio — the user then
  /// hears nothing. So we PAUSE the recognizer while the agent speaks and re-arm on
  /// agent_caption_end (clean hands-free turn-taking). Barge-in stays fully working
  /// in LiveKit mode (native interruption + AEC). Re-enable here only once on-device
  /// AEC / headset-gating is in place.
  static const bool _bargeInEnabled = false;

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
  String _bioMismatchAction = 'warn'; // 'warn' (continue) | 'exit' (end session)
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
  static final Duration _turnSilenceWindow =
      Duration(milliseconds: _isIOS ? 3200 : 2500);

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
  static final Duration _endOfTurnGraceWindow =
      Duration(milliseconds: _isIOS ? 2200 : 1400);

  // ── Adaptive (semantic) endpointing — stop splitting speeches ──
  // A big cause of "split speeches" on BOTH platforms is a fixed timeout firing
  // while the user is mid-thought (e.g. they say "send five thousand to…" then
  // pause to recall the name). When the utterance ENDS in a continuation word
  // (conjunction/preposition/article/filler), the user almost certainly isn't
  // done, so we wait noticeably longer before finalising. Short, complete
  // commands ("yes", "check balance") don't end in these, so they stay snappy —
  // this only ever EXTENDS the wait, never shortens it, so it can't cut anyone off.
  static const Set<String> _incompleteTrailers = {
    'and', 'or', 'but', 'so', 'because', 'if', 'then', 'to', 'too', 'for',
    'with', 'of', 'the', 'a', 'an', 'my', 'your', 'our', 'their', 'his', 'her',
    'at', 'on', 'in', 'into', 'from', 'by', 'as', 'plus', 'minus', 'about',
    'um', 'uh', 'er', 'erm', 'hmm', 'like', 'send', 'pay', 'transfer',
  };
  static const Duration _incompleteExtraWait = Duration(milliseconds: 1600);
  static final Duration _endOfTurnGraceWindowLong =
      _endOfTurnGraceWindow + _incompleteExtraWait;
  static final Duration _turnSilenceWindowLong =
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
  late final VoiceChatHistoryCubit _chatHistoryCubit = serviceLocator<VoiceChatHistoryCubit>();

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
      final conversation = _chatHistoryCubit.getConversation(_currentSessionId!);
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
        : 'NG';  // Default to Nigeria

    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedLanguageCode = prefs.getString(_prefKeyLanguage);
      _selectedVoiceId = prefs.getString(_prefKeyVoice);
      _africanPermittedCached = prefs.getBool(_prefKeyAfricanPermitted) ?? false;

      // Fetch available languages from voice gateway API
      _availableLanguages = await _fetchSupportedLanguages(effectiveCountry);

      // Edge case: Handle empty available languages list
      if (_availableLanguages.isEmpty) {
        print('VoiceSessionCubit: No languages available from API, using hardcoded defaults');
        _availableLanguages = VoiceLanguageDefaults.forCountry(effectiveCountry);
      }

      // If no persisted language, or it's not available for this country, auto-select default
      final hasPersistedLanguage = _selectedLanguageCode != null &&
          _availableLanguages.any((l) => l.code == _selectedLanguageCode);

      if (!hasPersistedLanguage) {
        // Auto-select English for Nigerian users (Domestic English with en-NG locale)
        if (effectiveCountry == 'NG' && _availableLanguages.any((l) => l.code == 'en')) {
          _selectedLanguageCode = 'en';

          // Pre-select default voice for English
          final english = _availableLanguages.where((l) => l.code == 'en').firstOrNull;
          if (english != null) {
            // Edge case: Use defaultVoiceOption with fallback to first available voice
            final defaultVoiceOption = english.defaultVoiceOption;
            if (defaultVoiceOption != null) {
              _selectedVoiceId = defaultVoiceOption.id;
            } else if (english.availableVoices.isNotEmpty) {
              // Edge case: No default voice set, use first available voice
              _selectedVoiceId = english.availableVoices.first.id;
              print('VoiceSessionCubit: No default voice for English, using first available: $_selectedVoiceId');
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
      final lang = _availableLanguages.where((l) => l.code == languageCode).firstOrNull;
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
            print('VoiceSessionCubit: No default voice for $languageCode, using first available: $_selectedVoiceId');
          } else {
            // Edge case: No voices available for this language
            print('VoiceSessionCubit: No voices available for language $languageCode');
            _selectedVoiceId = null;
          }
        }
      } else {
        // Edge case: Language not found in available list
        AppLogger.error('setLanguage: Language $languageCode not found in available languages');
      }

      // Send language change to backend via WebSocket if session is active
      if (_wsChannel != null && isConnected) {
        final localeManager = serviceLocator<LocaleManager>();
        final currentCountry = localeManager.currentCountry;
        final locale = currentCountry.isNotEmpty ? '$languageCode-$currentCountry' : languageCode;

        await sendToVoiceAgent('language_changed', {
          'language': languageCode,
          'locale': locale,
          // Carry the (auto-selected) voice for the new language so the agent
          // re-resolves TTS with a voice that's VALID for it — without this the
          // backend kept the old language's voice and audio could break.
          if (_selectedVoiceId != null && _selectedVoiceId!.isNotEmpty)
            'voice_preference': _selectedVoiceId,
        });
        print('VoiceSessionCubit: Sent language change to backend: $languageCode ($locale) voice=$_selectedVoiceId');
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
  Future<List<VoiceLanguage>> _fetchSupportedLanguages(String countryCode) async {
    try {
      // Send the bearer so the gateway can read the email claim and return African
      // languages ONLY when this user is on the admin per-email allowlist — the picker
      // then never offers a language the session would silently coerce back to English.
      final headers = <String, String>{};
      try {
        final token = await serviceLocator<SecureStorageService>().getAccessToken();
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {
        // No token (picker opened pre-login) — server returns the English-safe set.
      }

      final response = await http.get(
        Uri.parse('$_voiceLanguageApiUrl/api/v1/voice/languages?country=$countryCode'),
        headers: headers,
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final languages = (data['languages'] as List<dynamic>?)
            ?.map((l) => VoiceLanguage.fromJson(l as Map<String, dynamic>))
            .toList();
        if (languages != null && languages.isNotEmpty) {
          // The server already applied THIS user's per-email African grant. Remember
          // whether it granted African languages so the offline fallback matches.
          final hasAfrican = languages.any((l) =>
              _africanLangCodes.contains(l.code.toLowerCase().split('-').first));
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
          .where((l) => !_africanLangCodes.contains(l.code.toLowerCase().split('-').first))
          .toList();
      return filtered.isEmpty ? langs : filtered;
    }
    // Online server result already reflects THIS user's per-email grant — trust it.
    if (serverAuthoritative) return langs;
    // Offline fallback: only surface African if this user was previously granted them
    // (so a non-allowlisted user never sees African chips when the server is down).
    if (_africanPermittedCached) return langs;
    final filtered = langs
        .where((l) => !_africanLangCodes.contains(l.code.toLowerCase().split('-').first))
        .toList();
    return filtered.isEmpty ? langs : filtered;
  }

  // ── Session Start ──

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

    // Re-entrancy guard: a single user action can dispatch startVoiceSession()
    // more than once (sheet-open path + language-selected + enrollment-proceed).
    // Refuse a second start while one is already in flight so exactly one
    // LiveKit room/agent is created. The legitimate restart path (startNewSession)
    // tears the old room down and awaits before reaching here, so it is not
    // blocked. Cleared in the finally below.
    if (_isStartingSession) {
      print('VoiceSessionCubit: startVoiceSession ignored — a start is already in flight');
      return;
    }
    _isStartingSession = true;

    emit(VoiceSessionLoadingCredentials());

    if (accessToken == null || accessToken.isEmpty) {
      _isStartingSession = false;
      if (isClosed) return;
      emit(const VoiceSessionCredentialsError('Authentication token is invalid or user not logged in.'));
      return;
    }

    _currentAccessToken = accessToken;

    // Clean restart: if a session is already live (e.g. the user changed the
    // language or voice mid-call from the picker), tear down the existing
    // LiveKit room + WS first so the new STT/TTS choice takes effect
    // deterministically instead of leaking a second room.
    if (_room != null) {
      print('VoiceSessionCubit: restarting — disposing existing room before new session');
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
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 30));
      print('VoiceSessionCubit: Response status=${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> &&
            data.containsKey('roomName') && data['roomName'] is String &&
            data.containsKey('livekitToken') && data['livekitToken'] is String) {
          final roomName = data['roomName'] as String;
          final livekitToken = data['livekitToken'] as String;
          _currentSessionId = data['sessionId'] as String? ?? roomName;
          // Admin speech-capture mode (default on_device). on_device → run the
          // on-device recognizer + suppress the LiveKit mic; livekit → legacy
          // server-side STT. Read once per session from the start response.
          _onDeviceMode = (data['inputMode'] as String?) != 'livekit';
          print('VoiceSessionCubit: inputMode=${data['inputMode'] ?? 'on_device(default)'} -> onDeviceMode=$_onDeviceMode');
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
            print('VoiceSessionCubit: biometrics policy enabled=$_bioEnabled action=$_bioMismatchAction failOpen=$_bioFailOpen');
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
                emit(VoiceSessionLanguageCoerced(coercedFrom, effectiveLanguage));
              }
            }
            print('VoiceSessionCubit: Credentials loaded, room=$roomName, url=$_livekitWsUrl');
            emit(VoiceSessionCredentialsLoaded(
              roomName: roomName,
              livekitToken: livekitToken,
              livekitUrl: _livekitWsUrl,
            ));
          } else {
            if (isClosed) return;
            print('VoiceSessionCubit: Empty credentials received');
            emit(const VoiceSessionCredentialsError('Received empty credentials from backend.'));
          }
        } else {
          if (isClosed) return;
          print('VoiceSessionCubit: Invalid response data: ${response.body}');
          emit(VoiceSessionCredentialsError('Invalid credential data received from backend: ${response.body}'));
        }
      } else {
        if (isClosed) return;
        print('VoiceSessionCubit: HTTP error ${response.statusCode}: ${response.body}');
        emit(VoiceSessionCredentialsError('Failed to get voice session credentials: ${response.statusCode} ${response.body}'));
      }
    } catch (e) {
      if (isClosed) {
        _isStartingSession = false;
        return;
      }
      print('VoiceSessionCubit: Exception: $e');
      emit(VoiceSessionCredentialsError('Error processing voice session credentials: $e'));
    } finally {
      // Release the re-entrancy guard. Credentials are loaded (or failed) by
      // now; the LiveKit connect itself runs in connectToLiveKitRoom().
      _isStartingSession = false;
    }
  }

  Future<void> connectToLiveKitRoom(String roomName, String token, String url) async {
    if (isClosed) return;
    _teardownRequested = false; // fresh connect — clear any stale teardown request
    emit(VoiceSessionConnectingToRoom());

    final micPermissionStatus = await Permission.microphone.request();
    if (micPermissionStatus.isDenied || micPermissionStatus.isPermanentlyDenied) {
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
        ),
      ),
    );

    // Setup LiveKit listeners
    _roomEventsListener = _room!.createListener()
      ..on<RoomDisconnectedEvent>((event) {
        if (isClosed) return;
        _disconnectWebSocket();
        emit(VoiceSessionDisconnected());
      })
      ..on<SpeakingChangedEvent>((event) {
        if (event.participant == _room?.localParticipant) {
          // Don't overwrite visual feedback states (dialogs are showing)
          if (_isVisualFeedbackActive) return;

          if (event.participant.isSpeaking) {
            if (_room != null && !isClosed) emit(VoiceSessionLocalUserSpeaking(_room!));
          } else {
            if (_room != null && _room!.connectionState == ConnectionState.connected) {
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
        print('VoiceSessionCubit: teardown requested during connect — disconnecting immediately');
        await _disposeRoomResources();
        if (!isClosed) emit(VoiceSessionDisconnected());
        return;
      }

      if (_onDeviceMode) {
        // On-device mode: the app owns the mic for speech_to_text, so DON'T publish
        // it to LiveKit (avoids iOS audio-session contention). LiveKit stays
        // connected for the agent's TTS downlink + the user-text data channel.
        await _room!.localParticipant?.setMicrophoneEnabled(false);
      } else {
        // Legacy server-STT path: publish the mic so the gateway can transcribe.
        await _room!.localParticipant?.setMicrophoneEnabled(true);
      }

      // Connect to voice WebSocket service for visual feedback events
      _connectWebSocket();

      if (isClosed) return;
      emit(VoiceSessionConnected(_room!));

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
        print('VoiceSessionCubit: greeting-end not observed — starting on-device listening (fallback)');
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
          print('VoiceSessionCubit: speech_to_text error: ${err.errorMsg} (permanent=${err.permanent})');
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
      print('VoiceSessionCubit: speech_to_text initialized available=$_sttAvailable');
    } catch (e) {
      _sttAvailable = false;
      _sttInitialized = true;
      print('VoiceSessionCubit: speech_to_text init failed: $e');
    }
  }

  /// Start a listening window. speech_to_text auto-finalises the turn after
  /// [pauseFor] of trailing silence (automatic end-of-turn detection) and streams
  /// partial results meanwhile for live captions.
  /// Whether the recognizer should be open right now.
  /// - while the agent speaks → only if barge-in is enabled (interrupt window);
  /// - while waiting for the agent to START replying → no;
  /// - otherwise (user's turn) → yes.
  bool _listeningPermitted() {
    if (!_onDeviceMode || isClosed || _teardownRequested || _isMuted || !_sttAvailable) {
      return false;
    }
    if (_bioInProgress) return false; // verification capture owns the mic
    // Push-to-talk: the mic opens ONLY inside a gesture-held capture window. This
    // single gate turns every auto-listen path (greeting, re-arm, agent-end,
    // barge-in) into a no-op unless the user is actively pressing/holding to talk.
    if (isPushToTalk && !_pttActive) return false;
    if (_agentSpeaking) return _bargeInEnabled;
    return !_awaitingAgentReply;
  }

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
    _interactionMode = next;
    if (isPushToTalk) {
      // Entering PTT: close the mic; it reopens only on a gesture.
      _pttActive = false;
      unawaited(stopLocalListening());
    } else if (wasPtt) {
      // Back to continuous: resume hands-free listening if it's the user's turn.
      _pttActive = false;
      _reArmListeningSoon();
    }
  }

  /// Begin a push-to-talk capture window (hold-down / tap-to-start / double-tap).
  /// Opens the recognizer; the turn is sent when [pttEnd] is called.
  Future<void> pttBegin() async {
    if (!isPushToTalk) return;
    _pttActive = true;
    _awaitingAgentReply = false; // a fresh user turn overrides any pending wait
    await startLocalListening();
  }

  /// End a push-to-talk capture window (release / tap-to-stop). Force-finalises the
  /// accumulated turn immediately (PTT never waits for trailing silence), then
  /// closes the mic until the next gesture.
  Future<void> pttEnd() async {
    if (!isPushToTalk) return;
    _pttActive = false;
    // Dispatch whatever we have NOW (accumulated finals + the live partial), the
    // same join the silence-timer/native-final paths use. _dispatchUserTurn dedups
    // and drops an empty turn, so a no-speech press is a clean no-op.
    _dispatchUserTurn(_joinTurn(_turnAccumulator, _lastPartialText));
    await stopLocalListening();
  }

  Future<void> startLocalListening() async {
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
          pauseFor: Duration(milliseconds: _isIOS ? 3200 : 2500),
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
  Future<void> _setAecMicPublished(bool enabled) async {
    if (!_onDeviceMode || !_hybridAecBargeIn) return;
    final lp = _room?.localParticipant;
    if (lp == null) return;
    try {
      await lp.setMicrophoneEnabled(
        enabled,
        audioCaptureOptions: enabled
            ? const AudioCaptureOptions(
                echoCancellation: true,
                noiseSuppression: true,
                autoGainControl: true,
              )
            : null,
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

    // ── BARGE-IN WINDOW: recognizer is open while the agent is speaking ──
    if (_agentSpeaking && !_bargedInThisTurn) {
      if (!_bargeInEnabled) return;
      // Ignore the agent's own TTS bleeding into the mic (speaker echo): the
      // recognized text would BE the agent's words, so it matches the caption.
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
    final hasPreview = _currentUserCaption != null && _currentUserCaption!.isNotEmpty;
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
    // Same adaptive rule for the pure-silence path: an unfinished-sounding turn
    // gets the longer window so a natural pause doesn't finalise it early.
    final silenceWindow = _looksIncomplete(display)
        ? _turnSilenceWindowLong
        : _turnSilenceWindow;
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

  /// Send the final recognized text to the agent over the LiveKit data channel.
  void _publishUserText(String text) {
    final room = _room;
    if (room == null) return;
    try {
      final payload = utf8.encode(jsonEncode({'type': 'user_text', 'text': text}));
      unawaited(room.localParticipant?.publishData(
            payload,
            reliable: true,
            topic: _userTextTopic,
          ) ??
          Future.value());
      print('VoiceSessionCubit: published on-device user text (${text.length} chars)');
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
    final lang = (_selectedLanguageCode ?? 'en').split(RegExp('[-_]')).first.toLowerCase();
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
      path = '${tmp.path}/voice_verify_${DateTime.now().millisecondsSinceEpoch}.wav';
      _bioCancelled = false;
      _bioInProgress = true; // recorder owns the mic
      await _bioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.wav, sampleRate: 16000, numChannels: 1),
        path: path,
      );
      // Gate on REAL speech: wait until the mic actually hears the user before we
      // accept the sample. If they stay silent, skip (fail-open) — we never verify
      // against silence or the agent's own audio.
      final heardUser = await _waitForUserSpeech();
      if (_bioCancelled || isClosed || !heardUser) {
        print('VoiceSessionCubit: no user speech for verification — skipping (fail-open)');
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
      print('VoiceSessionCubit: on-device voice verification → verified=${result.verified} (${result.status})');
      // _applyBiometricVerdict may end the session on a mismatch+exit; don't then
      // re-arm listening into a torn-down room.
      reArm = !(result.verified == false && _bioMismatchAction == 'exit');
      _applyBiometricVerdict(verified: result.verified, message: result.message);
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
    const speechDbThreshold = -35.0; // dBFS; quiet room floor is well below this
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
        (message != null && message.isNotEmpty) ? message : "Voice verified — it's really you.",
      ));
      // Auto-dismiss back to the live session after ~3s.
      Future.delayed(const Duration(seconds: 3), () {
        if (!isClosed && state is VoiceSessionVerificationSuccess && _room != null &&
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
        if (!isClosed && state is VoiceSessionLowConfidenceWarning && _room != null &&
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

    final wsUri = Uri.parse(
      '$_voiceWsUrl/ws/voice/$_currentSessionId'
      '?token=$_currentAccessToken'
    );

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
                .toList() ?? [];
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
              emit(VoiceSessionDisconnected());
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
                if (!isClosed && _room != null &&
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
            final errorMsg = eventData['message'] as String? ?? 'Transaction failed';
            // Reflect the rejection on the HUD (failed + reason) so it stays
            // in sync instead of stalling on the review/PIN step.
            if (_transferContext.isActive) {
              _updateTransferContext(_transferContext.copyWith(
                status: VoiceTransferStatus.failed,
                failureReason: _rejectReason(eventType, errorMsg),
              ));
            }
            emit(VoiceSessionTransactionError(_room!, errorMsg, eventType ?? 'error'));
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
                    _chatHistoryCubit.addUserMessage(_currentSessionId!, sanitized);
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
                  if (_agentSpeaking && _listeningPermitted()) startLocalListening();
                });
              }
            }
            final text = eventData['text'] as String?;
            // `replace` = this answer supersedes/merges a prior reply whose bubble
            // is still showing — commit it as a REPLACE on agent_caption_end so the
            // user sees ONE answer, not a half reply followed by a second one.
            _pendingAgentReplace = eventData['replace'] == true;
            final sanitized =
                text != null ? _sanitizeCaptionText(text) : '';
            _currentAgentCaption = sanitized.isNotEmpty ? sanitized : null;
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
                _chatHistoryCubit.replaceLastAgentMessage(_currentSessionId!, finalText);
              } else {
                _chatHistoryCubit.addAgentMessage(_currentSessionId!, finalText);
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
            print('VoiceSessionCubit: Language switched to $newLang ($newLocale)');
            if (_room != null) {
              emit(VoiceSessionLanguageChanged(_room!, newLang, newLocale ?? newLang));
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
          print('VoiceSessionCubit: agent ended session (reason=$reason) — ending like a manual end (show rating)');
          _setVisualFeedbackActive(false);
          _clearCaptions();
          // Fire-and-forget to avoid reentrancy on the active WS-message stack;
          // endSession disposes the LiveKit room (closes all connections for this
          // session) and emits VoiceSessionEnded.
          unawaited(endSession(endReason: reason));
          break;
        case 'error':
          _setVisualFeedbackActive(false);
          print('VoiceSessionCubit: WS error event: ${eventData['message']}');
          if (_room != null) {
            final errorMsg = eventData['message'] as String? ?? 'An error occurred';
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
    final bank = (d['beneficiary_bank'] ?? d['bank_name'] ?? '').toString().trim();
    final account =
        (d['account_number'] ?? d['recipient_account_number'] ?? '')
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
      recipientName: _transferContext.recipientName == null && summary.isNotEmpty
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
      final balance = (d['new_balance'] ?? d['balance'] ?? '').toString().trim();
      _updateTransferContext(_transferContext.copyWith(
        status: VoiceTransferStatus.success,
        reference: ref.isEmpty ? null : ref,
        newBalance: balance.isEmpty ? null : balance,
      ));
    } else {
      final reason = (d['error'] ?? d['message'] ?? 'Transfer failed').toString();
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
  Future<void> sendToVoiceAgent(String eventType, Map<String, dynamic> data) async {
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
      if (result.success &&
          (result.verificationToken?.isNotEmpty ?? false)) {
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
    print('VoiceSessionCubit: disconnectFromLiveKitRoom called, fullCleanup=$fullCleanup');
    _teardownRequested = true; // cancel any in-flight connect (mid-connection dismissal)
    _disconnectWebSocket();
    _setVisualFeedbackActive(false);
    _clearCaptions();
    _resetTransferContext();
    await _disposeRoomResources();
    if (isClosed) return;
    emit(VoiceSessionDisconnected());

    // Clear session data on full cleanup
    if (fullCleanup) {
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
    _teardownRequested = true; // cancel any in-flight connect (mid-connection end)
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
    emit(VoiceSessionEnded(sessionId: sessionId, endReason: endReason));
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
    _bargedInThisTurn = false;
    _isLocalListening = false;
    _bioAttemptedThisSession = false;
    _bioInProgress = false;
    _bioCancelled = true; // bail any in-flight capture; a new capture re-arms it
    _bioPending = false;
    _turnDispatched = false;
    _lastPartialText = '';
    _turnAccumulator = '';
    _turnSilenceTimer?.cancel();
    _turnSilenceTimer = null;
    _endOfTurnTimer?.cancel();
    _endOfTurnTimer = null;
    try {
      if (_speech.isListening) await _speech.cancel();
    } catch (_) {}
    try {
      if (await _bioRecorder.isRecording()) await _bioRecorder.stop();
    } catch (_) {}
    try {
      await listener?.dispose();
    } catch (e) {
      print('VoiceSessionCubit: room listener dispose error (ignored): $e');
    }
    try {
      // Bound the disconnect — a stuck WebRTC teardown must never hang cleanup or
      // the user is trapped on a dead session. 5s is well past a healthy close.
      await room?.disconnect().timeout(const Duration(seconds: 5));
    } catch (e) {
      print('VoiceSessionCubit: room disconnect error/timeout (ignored): $e');
    }
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
    final sanitized = trimmed.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]'), '');

    // Truncate if too long (max 500 chars to prevent memory issues)
    const maxLength = 500;
    if (sanitized.length > maxLength) {
      return '${sanitized.substring(0, maxLength - 3)}...';
    }

    return sanitized;
  }
}
