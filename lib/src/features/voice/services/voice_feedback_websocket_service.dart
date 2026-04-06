import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart';
import '../cubit/voice_transaction_cubit.dart';

// ==============================================================================
// Voice Feedback WebSocket Service
// ==============================================================================

/// Service for connecting to voice-agent-gateway via WebSocket
/// Receives real-time updates for voice action states
class VoiceFeedbackWebSocketService {
  VoiceFeedbackWebSocketService({
    required this.baseUrl,
    this.reconnectDelay = const Duration(seconds: 3),
    this.pingInterval = const Duration(seconds: 30),
    this.connectionTimeout = const Duration(seconds: 10),
  });

  final String baseUrl;
  final Duration reconnectDelay;
  final Duration pingInterval;
  final Duration connectionTimeout;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _pingTimer;
  Timer? _reconnectTimer;

  bool _isConnected = false;
  bool _isIntentionallyClosed = false;
  String? _sessionId;
  String? _userId;

  // Exponential backoff reconnection
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _initialReconnectDelay = Duration(seconds: 1);
  static const Duration _maxReconnectDelay = Duration(seconds: 30);

  // Event callbacks
  final _stateControllers = <String, StreamController<VoiceTransactionEvent>>{};
  final _globalListeners = <void Function(VoiceTransactionEvent)>[];

  // Connection state callbacks
  final _onConnectCallbacks = <void Function()>[];
  final _onDisconnectCallbacks = <void Function(String reason)>[];
  final _onErrorCallbacks = <void Function(dynamic error)>[];

  bool get isConnected => _isConnected;
  String? get sessionId => _sessionId;

  // ==============================================================================
  // Connection Management
  // ==============================================================================

  /// Connect to the voice feedback WebSocket server
  Future<bool> connect({
    required String userId,
    required String sessionId,
    String? actionId,
  }) async {
    if (_isConnected) {
      debugPrint('[VoiceFeedback] Already connected');
      return true;
    }

    _userId = userId;
    _sessionId = sessionId;
    _isIntentionallyClosed = false;

    try {
      final wsUrl = _buildWsUrl(userId: userId, sessionId: sessionId);
      debugPrint('[VoiceFeedback] Connecting to: $wsUrl');

      final channel = WebSocketChannel.connect(
        Uri.parse(wsUrl),
      );

      _channel = channel;

      // Wait for connection with timeout
      final readyFuture = channel.ready.timeout(connectionTimeout);
      await readyFuture;

      _isConnected = true;
      _reconnectAttempts = 0; // Reset reconnection counter on successful connection
      debugPrint('[VoiceFeedback] Connected successfully');

      // Subscribe to action-specific events if actionId provided
      if (actionId != null) {
        _sendSubscribe(actionId);
      }

      // Listen to incoming messages
      _subscription = channel.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );

      // Start ping timer
      _startPingTimer();

      // Notify connection callbacks
      for (final callback in _onConnectCallbacks) {
        try {
          callback();
        } catch (e) {
          debugPrint('[VoiceFeedback] Connect callback error: $e');
        }
      }

      return true;
    } on TimeoutException {
      debugPrint('[VoiceFeedback] Connection timeout');
      _handleConnectionError('Connection timeout');
      return false;
    } catch (e) {
      debugPrint('[VoiceFeedback] Connection error: $e');
      _handleConnectionError(e.toString());
      return false;
    }
  }

  /// Disconnect from the WebSocket server
  Future<void> disconnect({String reason = 'client_disconnect'}) async {
    _isIntentionallyClosed = true;

    _pingTimer?.cancel();
    _reconnectTimer?.cancel();

    try {
      await _channel?.sink.close(1000, reason);
    } catch (e) {
      debugPrint('[VoiceFeedback] Error closing connection: $e');
    }

    await _subscription?.cancel();
    _subscription = null;
    _channel = null;

    _isConnected = false;

    debugPrint('[VoiceFeedback] Disconnected: $reason');

    // Notify disconnect callbacks
    for (final callback in _onDisconnectCallbacks) {
      try {
        callback(reason);
      } catch (e) {
        debugPrint('[VoiceFeedback] Disconnect callback error: $e');
      }
    }
  }

  /// Reconnect to the WebSocket server
  Future<bool> reconnect() async {
    if (_userId == null || _sessionId == null) {
      debugPrint('[VoiceFeedback] Cannot reconnect: missing credentials');
      return false;
    }

    await disconnect(reason: 'reconnecting');

    // Wait before reconnecting
    await Future.delayed(reconnectDelay);

    return connect(
      userId: _userId!,
      sessionId: _sessionId!,
    );
  }

  // ==============================================================================
  // Subscription Management
  // ==============================================================================

  /// Subscribe to events for a specific action
  void subscribeToAction(String actionId) {
    if (!_isConnected) {
      debugPrint('[VoiceFeedback] Cannot subscribe: not connected');
      return;
    }

    _sendSubscribe(actionId);
  }

  /// Unsubscribe from events for a specific action
  void unsubscribeFromAction(String actionId) {
    if (!_isConnected) {
      return;
    }

    _send({
      'type': 'unsubscribe',
      'action_id': actionId,
    });
  }

  void _sendSubscribe(String actionId) {
    _send({
      'type': 'subscribe',
      'action_id': actionId,
    });
  }

  // ==============================================================================
  // Event Handling
  // ==============================================================================

  /// Listen to all voice transaction events
  Stream<VoiceTransactionEvent> eventStream() {
    final controller = StreamController<VoiceTransactionEvent>.broadcast();
    _globalListeners.add((event) {
      if (!controller.isClosed) {
        controller.add(event);
      }
    });
    return controller.stream;
  }

  /// Listen to events for a specific action
  Stream<VoiceTransactionEvent> actionEventStream(String actionId) {
    return _stateControllers.putIfAbsent(
      actionId,
      () => StreamController<VoiceTransactionEvent>.broadcast(),
    ).stream;
  }

  /// Add a callback for all events
  void addEventListener(void Function(VoiceTransactionEvent) listener) {
    _globalListeners.add(listener);
  }

  /// Remove an event listener callback
  void removeEventListener(void Function(VoiceTransactionEvent) listener) {
    _globalListeners.remove(listener);
  }

  void _onMessage(dynamic message) {
    if (message == null) return;

    try {
      final data = message is String ? jsonDecode(message) : message;
      final eventType = data['event_type'] as String?;

      if (eventType == null) {
        debugPrint('[VoiceFeedback] Received message without event_type');
        return;
      }

      debugPrint('[VoiceFeedback] Received event: $eventType');

      final event = _parseEvent(data);
      if (event != null) {
        _dispatchEvent(event, actionId: data['action_id'] as String?);
      }
    } catch (e) {
      debugPrint('[VoiceFeedback] Error parsing message: $e');
    }
  }

  VoiceTransactionEvent? _parseEvent(Map<String, dynamic> data) {
    final eventType = data['event_type'];

    switch (eventType) {
      case 'connected':
        return null; // Handled internally

      case 'state_update':
        final contextData = data['data']?['context'] as Map<String, dynamic>?;
        if (contextData != null) {
          final context = VoiceActionContext.fromJson(contextData);
          return VoiceTransactionStateChanged(
            newState: context.state,
            data: contextData,
          );
        }
        return null;

      case 'transcript':
        return VoiceTranscriptReceived(
          transcript: data['data']?['transcript'] as String? ?? '',
          isFinal: data['data']?['is_final'] as bool? ?? false,
        );

      case 'voice_verification':
        return VoiceVerificationCompleted(
          verified: data['data']?['verified'] as bool? ?? false,
          confidence: (data['data']?['confidence'] as num?)?.toDouble() ?? 0.0,
          requiresPin: data['data']?['requires_pin'] as bool? ?? false,
        );

      case 'pin_required':
        return VoicePinRequired(
          reason: data['data']?['reason'] as String? ?? 'security',
          attemptsRemaining: data['data']?['attempts_remaining'] as int? ?? 3,
        );

      case 'confirmation_required':
        return VoiceConfirmationRequested(
          title: data['data']?['title'] as String? ?? 'Confirm Transaction',
          message: data['data']?['message'] as String? ?? '',
          details: data['data']?['details'] as Map<String, dynamic>? ?? {},
          timeoutSeconds: data['data']?['timeout_seconds'] as int? ?? 30,
        );

      case 'success':
        final resultData = data['data'] as Map<String, dynamic>?;
        if (resultData != null) {
          return VoiceTransactionCompleted(
            result: VoiceActionResult.fromJson(resultData),
          );
        }
        return null;

      case 'error':
        return VoiceTransactionError(
          errorCode: data['data']?['error_code'] as String? ?? 'UNKNOWN',
          errorMessage: data['data']?['error_message'] as String? ?? 'An error occurred',
          severity: _parseSeverity(data['data']?['severity']),
          recoverable: data['data']?['recoverable'] as bool? ?? true,
        );

      case 'audio_level':
        final level = (data['data']?['level'] as num?)?.toDouble() ?? 0.0;
        return VoiceAudioLevelUpdated(level: level);

      default:
        debugPrint('[VoiceFeedback] Unknown event type: $eventType');
        return null;
    }
  }

  ErrorSeverity _parseSeverity(String? severity) {
    switch (severity) {
      case 'low':
        return ErrorSeverity.low;
      case 'medium':
        return ErrorSeverity.medium;
      case 'high':
        return ErrorSeverity.high;
      case 'critical':
        return ErrorSeverity.critical;
      default:
        return ErrorSeverity.medium;
    }
  }

  void _dispatchEvent(VoiceTransactionEvent event, {String? actionId}) {
    // Notify global listeners
    for (final listener in _globalListeners) {
      try {
        listener(event);
      } catch (e) {
        debugPrint('[VoiceFeedback] Error in global listener: $e');
      }
    }

    // Notify action-specific listeners
    if (actionId != null) {
      final controller = _stateControllers[actionId];
      if (controller != null && !controller.isClosed) {
        controller.add(event);
      }
    }
  }

  // ==============================================================================
  // Connection State Callbacks
  // ==============================================================================

  void onConnect(void Function() callback) {
    _onConnectCallbacks.add(callback);
  }

  void onDisconnect(void Function(String reason) callback) {
    _onDisconnectCallbacks.add(callback);
  }

  void onError(void Function(dynamic error) callback) {
    _onErrorCallbacks.add(callback);
  }

  // ==============================================================================
  // Internal Methods
  // ==============================================================================

  String _buildWsUrl({required String userId, required String sessionId}) {
    final uri = Uri.parse(baseUrl);
    final scheme = uri.scheme == 'https' ? 'wss' : 'ws';
    final host = uri.host;
    final port = uri.port;
    final path = '/ws/voice-feedback';

    return '$scheme://$host:$port$path?user_id=$userId&session_id=$sessionId';
  }

  void _send(Map<String, dynamic> data) {
    if (_channel == null) {
      debugPrint('[VoiceFeedback] Cannot send: not connected');
      return;
    }

    try {
      _channel!.sink.add(jsonEncode(data));
    } catch (e) {
      debugPrint('[VoiceFeedback] Error sending message: $e');
    }
  }

  void _onError(dynamic error) {
    debugPrint('[VoiceFeedback] WebSocket error: $error');

    for (final callback in _onErrorCallbacks) {
      try {
        callback(error);
      } catch (e) {
        debugPrint('[VoiceFeedback] Error callback error: $e');
      }
    }

    _handleConnectionError('WebSocket error: $error');
  }

  void _onDone() {
    debugPrint('[VoiceFeedback] WebSocket connection closed');

    final wasConnected = _isConnected;
    _isConnected = false;
    _pingTimer?.cancel();

    if (wasConnected && !_isIntentionallyClosed) {
      // Unexpected disconnection, attempt reconnect
      debugPrint('[VoiceFeedback] Unexpected disconnect, reconnecting...');
      _scheduleReconnect();
    }

    for (final callback in _onDisconnectCallbacks) {
      try {
        callback('connection_closed');
      } catch (e) {
        debugPrint('[VoiceFeedback] Disconnect callback error: $e');
      }
    }
  }

  void _handleConnectionError(String error) {
    _isConnected = false;
    _pingTimer?.cancel();

    if (!_isIntentionallyClosed) {
      debugPrint('[VoiceFeedback] Connection error: $error');
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint('[VoiceFeedback] Max reconnect attempts ($_maxReconnectAttempts) reached. Giving up.');
      // Notify callbacks about permanent failure
      for (final callback in _onErrorCallbacks) {
        try {
          callback('Max reconnection attempts reached. Please check your connection.');
        } catch (e) {
          debugPrint('[VoiceFeedback] Error callback error: $e');
        }
      }
      return;
    }

    _reconnectTimer?.cancel();

    // Calculate exponential backoff delay: 2^n seconds, max 30 seconds
    final delay = _calculateReconnectDelay(_reconnectAttempts);
    debugPrint('[VoiceFeedback] Scheduling reconnect attempt ${_reconnectAttempts + 1}/$_maxReconnectAttempts in ${delay.inSeconds}s');

    _reconnectTimer = Timer(delay, () async {
      if (_isIntentionallyClosed) return;

      debugPrint('[VoiceFeedback] Attempting to reconnect (attempt ${_reconnectAttempts + 1}/$_maxReconnectAttempts)...');
      _reconnectAttempts++;

      final success = await reconnect();

      if (success) {
        // Reset counter on successful reconnection
        _reconnectAttempts = 0;
        debugPrint('[VoiceFeedback] Reconnection successful');
      } else if (!_isIntentionallyClosed) {
        // Retry again with exponential backoff
        _scheduleReconnect();
      }
    });
  }

  /// Calculate exponential backoff delay: 2^attempt seconds, clamped to max 30 seconds
  Duration _calculateReconnectDelay(int attempt) {
    final seconds = (1 << attempt).toDouble(); // 2^attempt
    final clamped = seconds.clamp(1.0, _maxReconnectDelay.inSeconds.toDouble());
    return Duration(seconds: clamped.toInt());
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(pingInterval, (_) {
      if (_isConnected) {
        _send({'type': 'ping'});
      }
    });
  }

  // ==============================================================================
  // Dispose
  // ==============================================================================

  Future<void> dispose() async {
    await disconnect(reason: 'service_disposed');

    // Close all stream controllers
    for (final controller in _stateControllers.values) {
      await controller.close();
    }
    _stateControllers.clear();
    _globalListeners.clear();
    _onConnectCallbacks.clear();
    _onDisconnectCallbacks.clear();
    _onErrorCallbacks.clear();
  }
}

// ==============================================================================
// Provider/Service Locator Integration
// ==============================================================================

class VoiceFeedbackService {
  static VoiceFeedbackWebSocketService? _instance;

  static VoiceFeedbackWebSocketService getInstance({
    required String baseUrl,
  }) {
    _instance ??= VoiceFeedbackWebSocketService(baseUrl: baseUrl);
    return _instance!;
  }

  static void reset() {
    _instance = null;
  }
}
