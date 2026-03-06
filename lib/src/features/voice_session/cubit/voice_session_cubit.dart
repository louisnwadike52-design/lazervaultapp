import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VoiceSessionCubit extends Cubit<VoiceSessionState> {
  // --- Configuration ---
  final String _livekitWsUrl = dotenv.env['LIVEKIT_URL'] ?? 'wss://lazervault-sgb9bwog.livekit.cloud';
  final String _goBackendBaseApiUrl = dotenv.env['HTTP_API_HOST'] ?? (throw Exception('HTTP_API_HOST environment variable is not set.'));
  final String _voiceWsUrl = dotenv.env['VOICE_WS_URL'] ?? 'ws://localhost:3012';
  final String _voiceLanguageApiUrl = dotenv.env['VOICE_LANGUAGE_API_URL'] ?? 'http://localhost:3013';

  static const String _prefKeyLanguage = 'voice_selected_language';
  static const String _prefKeyVoice = 'voice_selected_voice_id';

  Room? _room;
  EventsListener<RoomEvent>? _roomEventsListener;
  WebSocketChannel? _wsChannel;
  StreamSubscription? _wsSubscription;
  String? _currentSessionId;
  String? _currentAccessToken;

  // Language & voice selection
  String? _selectedLanguageCode;
  String? _selectedVoiceId;
  List<VoiceLanguage> _availableLanguages = [];

  /// Whether a visual feedback dialog is currently showing (user search, transfer summary, PIN).
  /// When true, SpeakingChangedEvent should NOT overwrite the state.
  bool _isVisualFeedbackActive = false;

  VoiceSessionCubit() : super(VoiceSessionInitial());

  /// Currently selected language code (e.g., "en", "yo", "ig").
  String? get selectedLanguageCode => _selectedLanguageCode;

  /// Currently selected voice ID.
  String? get selectedVoiceId => _selectedVoiceId;

  /// Check if currently connected to LiveKit room
  bool get isConnected => _room?.connectionState == ConnectionState.connected;

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
        requestBody['voice_preference'] = _selectedVoiceId;
      }

      final response = await http.post(
        Uri.parse('$_goBackendBaseApiUrl/v1/voice/session/start'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> &&
            data.containsKey('roomName') && data['roomName'] is String &&
            data.containsKey('livekitToken') && data['livekitToken'] is String) {
          final roomName = data['roomName'] as String;
          final livekitToken = data['livekitToken'] as String;
          _currentSessionId = data['sessionId'] as String? ?? roomName;

          if (roomName.isNotEmpty && livekitToken.isNotEmpty) {
            if (isClosed) return;
            emit(VoiceSessionCredentialsLoaded(
              roomName: roomName,
              livekitToken: livekitToken,
              livekitUrl: _livekitWsUrl,
            ));
          } else {
            if (isClosed) return;
            emit(const VoiceSessionCredentialsError('Received empty credentials from backend.'));
          }
        } else {
          if (isClosed) return;
          emit(VoiceSessionCredentialsError('Invalid credential data received from backend: ${response.body}'));
        }
      } else {
        if (isClosed) return;
        emit(VoiceSessionCredentialsError('Failed to get voice session credentials: ${response.statusCode} ${response.body}'));
      }
    } catch (e) {
      if (isClosed) return;
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
      await _room!.connect(url, token);
      await _room!.localParticipant?.setMicrophoneEnabled(true);

      // Connect to voice WebSocket service for visual feedback events
      _connectWebSocket();

      if (isClosed) return;
      emit(VoiceSessionConnected(_room!));
    } catch (e) {
      if (isClosed) return;
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

      print('VoiceSessionCubit: WebSocket connected to $_voiceWsUrl');
    } catch (e) {
      print('VoiceSessionCubit: WebSocket connection failed: $e');
    }
  }

  void _scheduleWebSocketReconnect() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed && _room?.connectionState == ConnectionState.connected) {
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
            }
          }
          break;
        case 'error':
          print('VoiceSessionCubit: WS error event: ${eventData['message']}');
          break;
      }
    } catch (e) {
      print('VoiceSessionCubit: Error decoding WS message: $e');
      if (isClosed) return;
      emit(VoiceSessionError('Error processing voice event: $e'));
    }
  }

  void _disconnectWebSocket() {
    _wsSubscription?.cancel();
    _wsSubscription = null;
    _wsChannel?.sink.close();
    _wsChannel = null;
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
    await _disposeRoomResources();
    if (isClosed) return;
    emit(VoiceSessionDisconnected());

    // Clear session data on full cleanup
    if (fullCleanup) {
      _currentSessionId = null;
      _currentAccessToken = null;
    }
  }

  Future<void> _disposeRoomResources() async {
    await _roomEventsListener?.dispose();
    _roomEventsListener = null;
    await _room?.disconnect();
    _room = null;
  }

  /// Reset the session state (for reconnection scenarios)
  void resetSessionState() {
    print('VoiceSessionCubit: resetSessionState called');
    _disconnectWebSocket();
    _disposeRoomResources();
    if (!isClosed) {
      emit(VoiceSessionInitial());
    }
  }

  @override
  Future<void> close() {
    _disconnectWebSocket();
    _disposeRoomResources();
    return super.close();
  }
}
