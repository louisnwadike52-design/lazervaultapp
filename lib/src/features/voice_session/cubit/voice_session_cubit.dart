import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_pkg;
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';
import 'package:lazervault/src/features/voice_session/models/voice_conversation.dart';
import 'package:lazervault/src/features/voice_session/models/voice_transfer_context.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_chat_history_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
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

  /// Get the current session ID
  String? get currentSessionId => _currentSessionId;

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
  Timer? _visualFeedbackTimer;
  static const Duration _visualFeedbackTimeout = Duration(seconds: 90);

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

  // ── Caption state for real-time transcription display ──

  /// Current user caption (what the user is saying)
  String? _currentUserCaption;

  /// Current agent caption (what the AI is responding with)
  String? _currentAgentCaption;

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
      await _room?.localParticipant?.setMicrophoneEnabled(!_isMuted);
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
        });
        print('VoiceSessionCubit: Sent language change to backend: $languageCode ($locale)');
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
      final response = await http.get(
        Uri.parse('$_voiceLanguageApiUrl/api/v1/voice/languages?country=$countryCode'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final languages = (data['languages'] as List<dynamic>?)
            ?.map((l) => VoiceLanguage.fromJson(l as Map<String, dynamic>))
            .toList();
        if (languages != null && languages.isNotEmpty) {
          return languages;
        }
      }
    } catch (e) {
      // Fall through to hardcoded defaults
    }
    return VoiceLanguageDefaults.forCountry(countryCode);
  }

  // ── Session Start ──

  Future<void> startVoiceSession({
    required String? accessToken,
    String? serviceName,
    String? accountId,
    String? currency,
  }) async {
    if (isClosed) return;

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

    _room = Room();

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
      await _room!.localParticipant?.setMicrophoneEnabled(true);

      // Connect to voice WebSocket service for visual feedback events
      _connectWebSocket();

      if (isClosed) return;
      emit(VoiceSessionConnected(_room!));
    } catch (e) {
      if (isClosed) return;
      print('VoiceSessionCubit: LiveKit connect error: $e');
      emit(VoiceSessionError('Failed to connect to LiveKit room: $e'));
      await _disposeRoomResources();
    }
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
            _setVisualFeedbackActive(true);
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
            } else if (status == 'disconnected') {
              // Agent signaled session end
              _setVisualFeedbackActive(false);
              _disconnectWebSocket();
              emit(VoiceSessionDisconnected());
            }
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
            if (text != null && text.isNotEmpty) {
              // Validate and sanitize
              final sanitized = _sanitizeCaptionText(text);
              if (sanitized.isNotEmpty) {
                // Commit the finalized turn to the persistent transcript first,
                // then drop the interim live bubble so the history bubble is
                // already present when the live one disappears (no flicker).
                if (_currentSessionId != null) {
                  _chatHistoryCubit.addUserMessage(_currentSessionId!, sanitized);
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
            final text = eventData['text'] as String?;
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
              _chatHistoryCubit.addAgentMessage(_currentSessionId!, finalText);
            }
            _isAgentSpeaking = false;
            _currentAgentCaption = null;
            _emitCaptionUpdate();
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
        return 'LazerVault';
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
  Future<void> notifyPinCompleted(bool success, {String? reference, String? error}) async {
    _setVisualFeedbackActive(false);
    await sendToVoiceAgent('pin_completed', {
      'success': success,
      if (reference != null) 'reference': reference,
      if (error != null) 'error': error,
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

  Future<void> disconnectFromLiveKitRoom({bool fullCleanup = false}) async {
    print('VoiceSessionCubit: disconnectFromLiveKitRoom called, fullCleanup=$fullCleanup');
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

  Future<void> _disposeRoomResources() async {
    await _roomEventsListener?.dispose();
    _roomEventsListener = null;
    await _room?.disconnect();
    _room = null;
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

  @override
  Future<void> close() async {
    _visualFeedbackTimer?.cancel();
    _visualFeedbackTimer = null;
    _disconnectWebSocket();
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
