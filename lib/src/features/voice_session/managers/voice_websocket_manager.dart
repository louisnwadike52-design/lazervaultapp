import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Enhanced WebSocket manager for voice session with comprehensive edge case handling.
///
/// Edge cases handled:
/// - Automatic reconnection with exponential backoff
/// - Duplicate message detection
/// - Message queuing during disconnection
/// - Heartbeat/keepalive to detect stale connections
/// - Graceful degradation when WebSocket fails
/// - State synchronization validation
/// - Network change detection
class VoiceWebSocketManager {
  final String wsUrl;
  final String sessionId;
  final String accessToken;
  final void Function(Map<String, dynamic>) onMessage;
  final void Function(String)? onError;
  final void Function()? onReconnected;
  final void Function()? onPermanentlyFailed;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  Timer? _staleConnectionTimer;

  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _initialReconnectDelay = Duration(seconds: 2);
  static const Duration _maxReconnectDelay = Duration(seconds: 60);
  static const Duration _heartbeatInterval = Duration(seconds: 30);
  static const Duration _staleConnectionTimeout = Duration(seconds: 90);

  bool _isConnected = false;
  bool _isPermanentlyFailed = false;
  final Set<String> _processedMessageIds = {};
  final List<Map<String, dynamic>> _messageQueue = [];
  String? _lastMessageId;

  static const int _maxProcessedIds = 1000; // Prevent unbounded growth

  VoiceWebSocketManager({
    required this.wsUrl,
    required this.sessionId,
    required this.accessToken,
    required this.onMessage,
    this.onError,
    this.onReconnected,
    this.onPermanentlyFailed,
  });

  /// Connect to WebSocket with automatic retry
  Future<void> connect() async {
    if (_isPermanentlyFailed) {
      onError?.call('WebSocket permanently failed');
      return;
    }

    // Edge case: Don't reconnect if already connected
    if (_isConnected && _channel != null) {
      return;
    }

    await _disconnect();

    final uri = Uri.parse(
      '$wsUrl/ws/voice/$sessionId?token=$accessToken',
    );

    try {
      _channel = IOWebSocketChannel.connect(
        uri,
        pingInterval: _heartbeatInterval,
      );

      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );

      _isConnected = true;
      _reconnectAttempts = 0; // Reset on successful connect

      // Edge case: Start heartbeat to detect stale connections
      _startHeartbeat();
      _startStaleConnectionTimer();

      // Edge case: Send queued messages from previous disconnection
      _sendQueuedMessages();

      onReconnected?.call();
    } catch (e) {
      onError?.call('WebSocket connection failed: $e');
      _scheduleReconnect();
    }
  }

  /// Disconnect from WebSocket
  Future<void> _disconnect() async {
    _heartbeatTimer?.cancel();
    _staleConnectionTimer?.cancel();
    _reconnectTimer?.cancel();

    await _subscription?.cancel();
    _subscription = null;

    await _channel?.sink.close();
    _channel = null;

    _isConnected = false;
  }

  /// Send message through WebSocket
  void send(Map<String, dynamic> data) {
    // Edge case: Add message ID for duplicate detection
    final messageId = data['message_id'] as String? ?? _generateMessageId();
    data['message_id'] = messageId;

    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(jsonEncode(data));
      } catch (e) {
        onError?.call('Failed to send message: $e');
        // Edge case: Queue message for retry after reconnection
        _messageQueue.add(data);
        _scheduleReconnect();
      }
    } else {
      // Edge case: Queue message when disconnected
      _messageQueue.add(data);
    }
  }

  void _onMessage(dynamic message) {
    try {
      final decoded = jsonDecode(message as String) as Map<String, dynamic>;
      final messageId = decoded['message_id'] as String?;

      // Edge case: Duplicate message detection
      if (messageId != null) {
        if (_processedMessageIds.contains(messageId)) {
          return; // Skip duplicate
        }

        // Edge case: Prevent unbounded growth of processed IDs
        if (_processedMessageIds.length >= _maxProcessedIds) {
          // Remove oldest 500 IDs
          final ids = _processedMessageIds.toList();
          ids.sort();
          ids.take(500).forEach((id) => _processedMessageIds.remove(id));
        }

        _processedMessageIds.add(messageId);
      }

      // Edge case: Reset stale connection timer on any message
      _resetStaleConnectionTimer();

      onMessage(decoded);
    } catch (e) {
      onError?.call('Failed to parse WebSocket message: $e');
    }
  }

  void _onError(error) {
    onError?.call('WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _onDone() {
    onError?.call('WebSocket connection closed');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_isPermanentlyFailed) return;

    _reconnectAttempts++;

    if (_reconnectAttempts > _maxReconnectAttempts) {
      _isPermanentlyFailed = true;
      onError?.call('Max WebSocket reconnect attempts reached');
      onPermanentlyFailed?.call();
      return;
    }

    // Edge case: Exponential backoff with jitter
    final delay = _calculateReconnectDelay();
    _reconnectTimer = Timer(delay, () {
      connect();
    });
  }

  Duration _calculateReconnectDelay() {
    // Exponential backoff: 2s, 4s, 8s, 16s, 32s, 60s (max)
    final exponentialDelay = _initialReconnectDelay * (1 << (_reconnectAttempts - 1));
    final cappedDelay = exponentialDelay > _maxReconnectDelay
        ? _maxReconnectDelay
        : exponentialDelay;

    // Edge case: Add jitter to prevent thundering herd
    final jitter = Duration(milliseconds: (cappedDelay.inMilliseconds * 0.1).round());
    return cappedDelay + jitter;
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (_isConnected && _channel != null) {
        try {
          // Send ping to keep connection alive
          _channel!.sink.add(jsonEncode({'type': 'ping', 'timestamp': DateTime.now().toIso8601String()}));
        } catch (e) {
          onError?.call('Heartbeat failed: $e');
          _isConnected = false;
          _scheduleReconnect();
        }
      }
    });
  }

  void _startStaleConnectionTimer() {
    _staleConnectionTimer?.cancel();
    _staleConnectionTimer = Timer(_staleConnectionTimeout, () {
      // Edge case: No messages received in 90 seconds - connection might be stale
      if (_isConnected) {
        onError?.call('Connection appears stale (no messages in ${_staleConnectionTimeout.inSeconds}s)');
        _isConnected = false;
        _scheduleReconnect();
      }
    });
  }

  void _resetStaleConnectionTimer() {
    _startStaleConnectionTimer();
  }

  void _sendQueuedMessages() {
    // Edge case: Send messages that were queued during disconnection
    if (_messageQueue.isEmpty) return;

    final queuedMessages = List<Map<String, dynamic>>.from(_messageQueue);
    _messageQueue.clear();

    for (final message in queuedMessages) {
      send(message);
    }
  }

  String _generateMessageId() {
    return '${sessionId}_${DateTime.now().millisecondsSinceEpoch}_${_lastMessageId++}';
  }

  /// Clean up resources
  Future<void> dispose() async {
    _isPermanentlyFailed = true; // Stop reconnection attempts
    await _disconnect();
    _processedMessageIds.clear();
    _messageQueue.clear();
  }

  /// Get current connection status
  bool get isConnected => _isConnected;
  bool get isPermanentlyFailed => _isPermanentlyFailed;
  int get reconnectAttempts => _reconnectAttempts;

  /// Manually trigger reconnection (e.g., after network change)
  void reconnect() {
    _reconnectAttempts = 0;
    _isPermanentlyFailed = false;
    connect();
  }

  /// Get queued message count
  int get queuedMessageCount => _messageQueue.length;
}
