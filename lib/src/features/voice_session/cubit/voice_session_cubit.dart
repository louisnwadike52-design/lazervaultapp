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
import 'package:lazervault/src/features/voice_session/cubit/voice_chat_history_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VoiceSessionCubit extends Cubit<VoiceSessionState> {
  // --- Configuration ---
  final String _livekitWsUrl = dotenv.env['LIVEKIT_URL'] ?? (throw Exception('LIVEKIT_URL environment variable is not set.'));
  final String _goBackendBaseApiUrl = dotenv.env['HTTP_API_HOST'] ?? (throw Exception('HTTP_API_HOST environment variable is not set.'));
  final String _voiceWsUrl = dotenv.env['VOICE_WS_URL'] ?? 'ws://localhost:3012';
  final String _voiceLanguageApiUrl = dotenv.env['VOICE_LANGUAGE_API_URL'] ?? 'http://localhost:3013';
  final String _voiceAgentGatewayUrl = dotenv.env['VOICE_AGENT_GATEWAY_URL'] ?? 'http://localhost:3010';

  static const String _prefKeyLanguage = 'voice_selected_language';
  static const String _prefKeyVoice = 'voice_selected_voice_id';

  Room? _room;
  EventsListener<RoomEvent>? _roomEventsListener;
  WebSocketChannel? _wsChannel;
  StreamSubscription? _wsSubscription;
  String? _currentSessionId;
  String? _currentAccessToken;

  /// Get the current session ID
  String? get currentSessionId => _currentSessionId;

  // Language & voice selection
  String? _selectedLanguageCode;
  String? _selectedVoiceId;
  List<VoiceLanguage> _availableLanguages = [];

  /// Whether a visual feedback dialog is currently showing (user search, transfer summary, PIN).
  /// When true, SpeakingChangedEvent should NOT overwrite the state.
  bool _isVisualFeedbackActive = false;

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

  VoiceSessionCubit() : super(VoiceSessionInitial());

  /// Chat history cubit for tracking conversation messages
  late final VoiceChatHistoryCubit _chatHistoryCubit = get_pkg.Get.find<VoiceChatHistoryCubit>();

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
    final prefs = await SharedPreferences.getInstance();
    _selectedLanguageCode = prefs.getString(_prefKeyLanguage);
    _selectedVoiceId = prefs.getString(_prefKeyVoice);

    // Fetch available languages from voice gateway API
    _availableLanguages = await _fetchSupportedLanguages(countryCode);

    // If no persisted language, or it's not available for this country, show picker
    if (_selectedLanguageCode == null ||
        !_availableLanguages.any((l) => l.code == _selectedLanguageCode)) {
      _selectedLanguageCode = null;
    }
  }

  /// Set the voice language for the session.
  Future<void> setLanguage(String languageCode) async {
    _selectedLanguageCode = languageCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyLanguage, languageCode);

    // If no voice preference exists or the current voice is not available for the new language,
    // set the default voice for the new language
    final lang = _availableLanguages.where((l) => l.code == languageCode).firstOrNull;
    if (lang != null) {
      final hasValidVoice = _selectedVoiceId != null &&
          lang.availableVoices.any((v) => v.id == _selectedVoiceId);
      if (!hasValidVoice && lang.defaultVoice.isNotEmpty) {
        _selectedVoiceId = lang.defaultVoice;
        await prefs.setString(_prefKeyVoice, lang.defaultVoice);
      }
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

  Future<void> startVoiceSession({required String? accessToken, String? serviceName}) async {
    if (isClosed) return;
    emit(VoiceSessionLoadingCredentials());

    if (accessToken == null || accessToken.isEmpty) {
      if (isClosed) return;
      emit(const VoiceSessionCredentialsError('Authentication token is invalid or user not logged in.'));
      return;
    }

    _currentAccessToken = accessToken;

    try {
      final requestBody = <String, dynamic>{};
      if (serviceName != null && serviceName.isNotEmpty) {
        requestBody['serviceName'] = serviceName;
      }
      // Include language and voice preference in room metadata
      if (_selectedLanguageCode != null) {
        requestBody['language'] = _selectedLanguageCode;
      }
      if (_selectedVoiceId != null) {
        requestBody['voicePreference'] = _selectedVoiceId;
      }

      final url = '$_goBackendBaseApiUrl/api/v1/voice/session/start';
      print('VoiceSessionCubit: POST $url');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      );
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
      if (isClosed) return;
      print('VoiceSessionCubit: Exception: $e');
      emit(VoiceSessionCredentialsError('Error processing voice session credentials: $e'));
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
      await _room!.connect(url, token);
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
            _isVisualFeedbackActive = true;
            final users = (eventData['users'] as List?)
                ?.map((u) => Map<String, dynamic>.from(u as Map))
                .toList() ?? [];
            emit(VoiceSessionUserSearchRequired(
              _room!,
              users,
              eventData['query'] as String? ?? '',
            ));
          }
          break;
        case 'show_transfer_summary':
          if (_room != null) {
            _isVisualFeedbackActive = true;
            emit(VoiceSessionTransferConfirmation(_room!, eventData));
          }
          break;
        case 'request_pin_entry':
          if (_room != null) {
            _isVisualFeedbackActive = true;
            emit(VoiceSessionPinRequired(_room!, eventData));
          }
          break;
        case 'transaction_result':
          if (_room != null) {
            _isVisualFeedbackActive = false;
            emit(VoiceSessionTransactionSuccess(_room!, eventData));
          }
          break;
        case 'voice_status':
          if (_room != null) {
            final status = eventData['status'] as String? ?? '';
            final message = eventData['message'] as String?;
            if (status == 'processing') {
              // Only emit processing if no dialog is active
              if (!_isVisualFeedbackActive) {
                emit(VoiceSessionAgentProcessing(_room!));
              }
            } else if (status == 'listening') {
              _isVisualFeedbackActive = false;
              emit(VoiceSessionConnected(_room!));
            } else if (status == 'error') {
              // Voice verification failed or other error
              _isVisualFeedbackActive = false;
              emit(VoiceSessionVerificationFailed(
                message ?? 'Voice verification failed. Please try again.',
              ));
            } else if (status == 'disconnected') {
              // Agent signaled session end
              _isVisualFeedbackActive = false;
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
            _isVisualFeedbackActive = false;
            final errorMsg = eventData['message'] as String? ?? 'Transaction failed';
            emit(VoiceSessionTransactionError(_room!, errorMsg, eventType ?? 'error'));
          }
          break;
        // ── Caption events for real-time transcription ──
        case 'user_caption_interim':
          // Partial transcription - update while user is speaking
          if (_room != null) {
            final text = eventData['text'] as String?;
            if (text != null && text.isNotEmpty) {
              // Validate and sanitize
              final sanitized = _sanitizeCaptionText(text);
              if (sanitized.isNotEmpty) {
                _currentUserCaption = sanitized;
                _emitCaptionUpdate();
              }
            }
          }
          break;
        case 'user_caption_final':
          // Final transcription - complete sentence/phrase
          if (_room != null) {
            final text = eventData['text'] as String?;
            if (text != null && text.isNotEmpty) {
              // Validate and sanitize
              final sanitized = _sanitizeCaptionText(text);
              if (sanitized.isNotEmpty) {
                _currentUserCaption = sanitized;
                _emitCaptionUpdate();
                // Add to chat history
                if (_currentSessionId != null) {
                  _chatHistoryCubit.addUserMessage(_currentSessionId!, sanitized);
                }
                // Auto-clear user caption after 5 seconds (YouTube-style)
                Future.delayed(const Duration(seconds: 5), () {
                  if (!isClosed && _currentUserCaption != null) {
                    _currentUserCaption = null;
                    _emitCaptionUpdate();
                  }
                });
              }
            }
          }
          break;
        case 'agent_caption_start':
          // AI agent started speaking - show what will be said
          if (_room != null) {
            final text = eventData['text'] as String?;
            if (text != null && text.isNotEmpty) {
              // Validate and sanitize
              final sanitized = _sanitizeCaptionText(text);
              if (sanitized.isNotEmpty) {
                _currentAgentCaption = sanitized;
                _isAgentSpeaking = true;
                _emitCaptionUpdate();
                // Add to chat history when we have the full text
                if (_currentSessionId != null) {
                  _chatHistoryCubit.addAgentMessage(_currentSessionId!, sanitized);
                }
              }
            }
          }
          break;
        case 'agent_caption_text':
          // Streaming chunk of text as AI speaks (for word-by-word effect)
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
          // AI agent finished speaking - clear caption
          if (_room != null) {
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
          _isVisualFeedbackActive = false;
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

  /// Emits a caption-only state change.
  /// The UI reads caption data separately via getters, so this just triggers a rebuild.
  void _emitCaptionUpdate() {
    if (isClosed) return;
    // Emit current state again to trigger UI rebuild with new caption data
    // The UI will read _currentUserCaption, _currentAgentCaption, _isAgentSpeaking via getters
    emit(state);
  }

  /// Clears all caption state and timers
  void _clearCaptions() {
    _currentUserCaption = null;
    _currentAgentCaption = null;
    _isAgentSpeaking = false;
    _baseStateBeforeCaption = null;
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
    _isVisualFeedbackActive = false;
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
    _isVisualFeedbackActive = false;
    await sendToVoiceAgent('transfer_confirmed', {});
    if (_room != null && !isClosed) {
      emit(VoiceSessionAgentProcessing(_room!));
    }
  }

  /// User cancelled the current voice action.
  Future<void> cancelVoiceAction() async {
    _isVisualFeedbackActive = false;
    await sendToVoiceAgent('transfer_cancelled', {});
    if (_room != null && !isClosed) {
      emit(VoiceSessionConnected(_room!));
    }
  }

  /// PIN entry completed — notify voice agent of the result.
  Future<void> notifyPinCompleted(bool success, {String? reference, String? error}) async {
    _isVisualFeedbackActive = false;
    await sendToVoiceAgent('pin_completed', {
      'success': success,
      if (reference != null) 'reference': reference,
      if (error != null) 'error': error,
    });
    if (_room != null && !isClosed) {
      emit(VoiceSessionAgentProcessing(_room!));
    }
  }

  Future<void> disconnectFromLiveKitRoom({bool fullCleanup = false}) async {
    print('VoiceSessionCubit: disconnectFromLiveKitRoom called, fullCleanup=$fullCleanup');
    _disconnectWebSocket();
    _isVisualFeedbackActive = false;
    _clearCaptions();
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
  Future<void> endSession() async {
    final sessionId = _currentSessionId ?? '';
    print('VoiceSessionCubit: endSession called, sessionId=$sessionId');
    _disconnectWebSocket();
    _isVisualFeedbackActive = false;
    _clearCaptions();

    // End chat history tracking
    if (sessionId.isNotEmpty) {
      _chatHistoryCubit.endSession(sessionId);
    }

    await _disposeRoomResources();
    _isMuted = false;
    if (isClosed) return;
    emit(VoiceSessionEnded(sessionId: sessionId));
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
    _isVisualFeedbackActive = false;
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
    _isVisualFeedbackActive = false;
    _isMuted = false;
    _clearCaptions();
    if (!isClosed) {
      emit(VoiceSessionInitial());
    }
  }

  @override
  Future<void> close() async {
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
