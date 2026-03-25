import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Real-time event from a spray session room
class SprayRoomEvent {
  final String type;
  final String sessionId;
  final String senderId;
  final String senderName;
  final Map<String, dynamic> data;
  final int timestamp;

  const SprayRoomEvent({
    required this.type,
    required this.sessionId,
    this.senderId = '',
    this.senderName = '',
    this.data = const {},
    required this.timestamp,
  });

  factory SprayRoomEvent.fromJson(Map<String, dynamic> json) {
    return SprayRoomEvent(
      type: json['type'] as String? ?? '',
      sessionId: json['session_id'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
      senderName: json['sender_name'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>? ?? {},
      timestamp: (json['timestamp'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch,
    );
  }
}

enum SprayWebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// WebSocket service for real-time spray room events.
/// Connects to the lifestyle-gateway SprayMe WebSocket endpoint.
class SprayMeWebSocketService {
  WebSocketChannel? _channel;
  StreamSubscription? _channelSubscription;
  final _eventController = StreamController<SprayRoomEvent>.broadcast();
  final _connectionController = StreamController<SprayWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  bool _isDisposed = false;
  bool _intentionalDisconnect = false;
  String? _currentSessionId;
  String? _currentAccessToken;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;

  /// Stream of spray room events
  Stream<SprayRoomEvent> get events => _eventController.stream;

  /// Stream of connection state changes
  Stream<SprayWebSocketConnectionState> get connectionState => _connectionController.stream;

  bool get isConnected => _isConnected;
  String? get currentSessionId => _currentSessionId;

  bool _isConnecting = false;

  /// Connect to a spray session room
  Future<void> connect({
    required String sessionId,
    required String accessToken,
  }) async {
    if (_isConnected && _currentSessionId == sessionId) return;
    if (_isConnecting) return; // Prevent duplicate connect calls
    _isConnecting = true;

    // Disconnect from any existing session (without triggering reconnect)
    _intentionalDisconnect = true;
    disconnect();
    _intentionalDisconnect = false;
    _isDisposed = false;
    _reconnectAttempts = 0;
    _currentAccessToken = accessToken;

    final host = dotenv.env['LIFESTYLE_GATEWAY_HOST'] ?? dotenv.env['PAYMENT_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.tryParse(dotenv.env['LIFESTYLE_GATEWAY_PORT'] ?? '8088') ?? 8088;

    final wsUrl = Uri(
      scheme: 'ws',
      host: host,
      port: port,
      path: '/ws/sprayme',
      queryParameters: {
        'session_id': sessionId,
        'token': accessToken,
      },
    );

    if (kIsWeb) {
      _channel = WebSocketChannel.connect(wsUrl);
    } else {
      _channel = IOWebSocketChannel.connect(
        wsUrl,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
    }

    _currentSessionId = sessionId;

    // Cancel previous stream subscription to prevent duplicate listeners
    await _channelSubscription?.cancel();
    _channelSubscription = _channel!.stream.listen(
      _handleMessage,
      onError: _handleError,
      onDone: _handleDone,
      cancelOnError: false,
    );

    _isConnected = true;
    _isConnecting = false;
    _connectionController.add(SprayWebSocketConnectionState.connected);
    _startPingTimer();
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _pingTimer?.cancel();
    _pingTimer = null;
    _channelSubscription?.cancel();
    _channelSubscription = null;
    _channel?.sink.close();
    _channel = null;
    final wasConnected = _isConnected;
    _isConnected = false;
    _isConnecting = false;
    _currentSessionId = null;
    _currentAccessToken = null;
    if (wasConnected && !_isDisposed) {
      _connectionController.add(SprayWebSocketConnectionState.disconnected);
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_isConnected && _channel != null) {
        try {
          _channel!.sink.add(jsonEncode({'type': 'ping'}));
        } catch (_) {}
      }
    });
  }

  void _handleMessage(dynamic message) {
    if (_isDisposed) return;
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final msgType = data['type'] as String?;

      if (msgType == 'connected' || msgType == 'pong' || msgType == 'shutdown') return;

      // Parse as spray room event
      final event = SprayRoomEvent.fromJson(data);
      if (event.type.isNotEmpty && !_eventController.isClosed) {
        _eventController.add(event);
      }
    } catch (_) {}
  }

  void _handleError(dynamic error) {
    if (_isDisposed) return;
    final sessionId = _currentSessionId;
    final token = _currentAccessToken;
    _isConnected = false;
    _pingTimer?.cancel();
    _channelSubscription?.cancel();
    _channelSubscription = null;
    _channel = null;
    if (!_connectionController.isClosed) {
      _connectionController.add(SprayWebSocketConnectionState.error);
    }
    _scheduleReconnect(sessionId, token);
  }

  void _handleDone() {
    if (_isDisposed) return;
    final sessionId = _currentSessionId;
    final token = _currentAccessToken;
    _isConnected = false;
    _pingTimer?.cancel();
    _channelSubscription?.cancel();
    _channelSubscription = null;
    _channel = null;
    if (!_connectionController.isClosed) {
      _connectionController.add(SprayWebSocketConnectionState.disconnected);
    }
    _scheduleReconnect(sessionId, token);
  }

  void _scheduleReconnect(String? sessionId, String? token) {
    if (_intentionalDisconnect || _isDisposed) return;
    if (sessionId == null || token == null) return;
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      // Max attempts reached — notify listeners so UI can show "connection lost"
      if (!_connectionController.isClosed) {
        _connectionController.add(SprayWebSocketConnectionState.error);
      }
      return;
    }

    _reconnectAttempts++;

    // Exponential backoff: 1s, 2s, 4s, 8s, 16s
    final delay = Duration(seconds: 1 << (_reconnectAttempts - 1));
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (!_isDisposed && !_isConnected) {
        connect(sessionId: sessionId, accessToken: token);
      }
    });
  }

  void dispose() {
    _isDisposed = true;
    _intentionalDisconnect = true;
    disconnect();
    _eventController.close();
    _connectionController.close();
  }
}
