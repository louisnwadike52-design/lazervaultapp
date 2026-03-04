import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lazervault/src/features/p2p_chat/data/models/p2p_message_model.dart';

/// Typing event from another user
class P2PTypingEvent {
  final String conversationId;
  final String userId;
  final bool isTyping;

  const P2PTypingEvent({
    required this.conversationId,
    required this.userId,
    required this.isTyping,
  });
}

/// Read receipt from another user
class P2PReadReceiptEvent {
  final String conversationId;
  final String userId;
  final String messageId;

  const P2PReadReceiptEvent({
    required this.conversationId,
    required this.userId,
    required this.messageId,
  });
}

/// Delivery status update for a sent message
class P2PDeliveryUpdate {
  final String messageId;
  final String status;

  const P2PDeliveryUpdate({required this.messageId, required this.status});
}

/// Message sent confirmation from the server
class P2PMessageSentConfirmation {
  final String messageId;
  final String clientMessageId;
  final String conversationId;
  final String createdAt;

  const P2PMessageSentConfirmation({
    required this.messageId,
    required this.clientMessageId,
    required this.conversationId,
    required this.createdAt,
  });
}

/// Connection state for P2P chat WebSocket
enum P2PChatConnectionState { disconnected, connected, reconnecting, error }

/// WebSocket service for real-time P2P chat messaging.
class P2PChatWebSocketService {
  WebSocketChannel? _channel;
  final _messageStream = StreamController<P2PMessageModel>.broadcast();
  final _typingStream = StreamController<P2PTypingEvent>.broadcast();
  final _readReceiptStream = StreamController<P2PReadReceiptEvent>.broadcast();
  final _deliveryStream = StreamController<P2PDeliveryUpdate>.broadcast();
  final _messageSentStream =
      StreamController<P2PMessageSentConfirmation>.broadcast();
  final _connectionStream =
      StreamController<P2PChatConnectionState>.broadcast();
  final _connectionAcceptedStream =
      StreamController<Map<String, dynamic>>.broadcast();
  final _serverErrorStream =
      StreamController<Map<String, dynamic>>.broadcast();

  Timer? _pingTimer;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  bool _isConnecting = false;
  bool _manualDisconnect = false;
  bool _disposed = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;

  // Stored for reconnection
  String? _accessToken;

  /// Stream of new messages received via WebSocket.
  Stream<P2PMessageModel> get messageStream => _messageStream.stream;

  /// Stream of typing indicators.
  Stream<P2PTypingEvent> get typingStream => _typingStream.stream;

  /// Stream of read receipts.
  Stream<P2PReadReceiptEvent> get readReceiptStream =>
      _readReceiptStream.stream;

  /// Stream of delivery status updates.
  Stream<P2PDeliveryUpdate> get deliveryStream => _deliveryStream.stream;

  /// Stream of message sent confirmations.
  Stream<P2PMessageSentConfirmation> get messageSentStream =>
      _messageSentStream.stream;

  /// Stream of connection state changes.
  Stream<P2PChatConnectionState> get connectionState =>
      _connectionStream.stream;

  /// Stream of connection_accepted events (financial connections auto-accepted).
  Stream<Map<String, dynamic>> get connectionAcceptedStream =>
      _connectionAcceptedStream.stream;

  /// Stream of server-side errors (e.g., CONNECTION_PENDING).
  Stream<Map<String, dynamic>> get serverErrorStream =>
      _serverErrorStream.stream;

  bool get isConnected => _isConnected;

  /// Connect to the P2P chat WebSocket server.
  Future<void> connect(String accessToken) async {
    if (_isConnected || _isConnecting || _disposed) return;
    _isConnecting = true;
    _manualDisconnect = false;
    _accessToken = accessToken;

    final host = dotenv.env['P2P_CHAT_HOST'] ?? '10.0.2.2';
    final port = int.tryParse(dotenv.env['P2P_CHAT_PORT'] ?? '8018') ?? 8018;

    final wsUrl = Uri(
      scheme: 'ws',
      host: host,
      port: port,
      path: '/ws/chat',
    );

    try {
      if (kIsWeb) {
        _channel = WebSocketChannel.connect(
          wsUrl,
          protocols: ['token', accessToken],
        );
      } else {
        _channel = IOWebSocketChannel.connect(
          wsUrl,
          headers: {'Authorization': 'Bearer $accessToken'},
        );
      }

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
        cancelOnError: false,
      );

      _isConnected = true;
      _isConnecting = false;
      _reconnectAttempts = 0;
      _addToStream(_connectionStream, P2PChatConnectionState.connected);
      _startPingTimer();
    } catch (e) {
      _isConnecting = false;
      _addToStream(_connectionStream, P2PChatConnectionState.error);
      _scheduleReconnect();
    }
  }

  /// Send a text message via WebSocket.
  void sendMessage(
      String conversationId, String content, String clientMessageId) {
    _send({
      'type': 'message',
      'payload': {
        'conversation_id': conversationId,
        'content': content,
        'client_message_id': clientMessageId,
      },
    });
  }

  /// Send a typing indicator.
  void sendTyping(String conversationId, bool isTyping) {
    _send({
      'type': 'typing',
      'payload': {
        'conversation_id': conversationId,
        'is_typing': isTyping,
      },
    });
  }

  /// Mark messages as read.
  void markRead(String conversationId, String messageId) {
    _send({
      'type': 'mark_read',
      'payload': {
        'conversation_id': conversationId,
        'message_id': messageId,
      },
    });
  }

  /// Disconnect from the WebSocket server.
  void disconnect() {
    _manualDisconnect = true;
    _pingTimer?.cancel();
    _pingTimer = null;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _isConnecting = false;
    _addToStream(_connectionStream, P2PChatConnectionState.disconnected);
  }

  void _send(Map<String, dynamic> data) {
    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(jsonEncode(data));
      } catch (e) {
        // Ignore send errors on closed connections
      }
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _send({'type': 'ping'});
    });
  }

  void _handleMessage(dynamic message) {
    if (_disposed) return;
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final type = data['type'] as String?;

      switch (type) {
        case 'connected':
          // Server confirmed connection
          break;
        case 'pong':
          // Pong response - connection alive
          break;
        case 'shutdown':
          _manualDisconnect = true; // Don't reconnect on server shutdown
          disconnect();
          break;
        case 'new_message':
          final payload = data['payload'] as Map<String, dynamic>?;
          if (payload != null) {
            _addToStream(_messageStream, P2PMessageModel.fromJson(payload));
          }
          break;
        case 'message_sent':
          final payload = data['payload'] as Map<String, dynamic>?;
          if (payload != null) {
            _addToStream(
                _messageSentStream,
                P2PMessageSentConfirmation(
                  messageId: payload['message_id'] as String? ?? '',
                  clientMessageId:
                      payload['client_message_id'] as String? ?? '',
                  conversationId:
                      payload['conversation_id'] as String? ?? '',
                  createdAt: payload['created_at'] as String? ?? '',
                ));
          }
          break;
        case 'typing':
          final payload = data['payload'] as Map<String, dynamic>?;
          if (payload != null) {
            _addToStream(
                _typingStream,
                P2PTypingEvent(
                  conversationId: payload['conversation_id'] as String? ?? '',
                  userId: payload['user_id'] as String? ?? '',
                  isTyping: payload['is_typing'] as bool? ?? false,
                ));
          }
          break;
        case 'read_receipt':
          final payload = data['payload'] as Map<String, dynamic>?;
          if (payload != null) {
            _addToStream(
                _readReceiptStream,
                P2PReadReceiptEvent(
                  conversationId: payload['conversation_id'] as String? ?? '',
                  userId: payload['user_id'] as String? ?? '',
                  messageId: payload['message_id'] as String? ?? '',
                ));
          }
          break;
        case 'delivery_update':
          final payload = data['payload'] as Map<String, dynamic>?;
          if (payload != null) {
            _addToStream(
                _deliveryStream,
                P2PDeliveryUpdate(
                  messageId: payload['message_id'] as String? ?? '',
                  status: payload['status'] as String? ?? '',
                ));
          }
          break;
        case 'connection_accepted':
          final payload = data['payload'] as Map<String, dynamic>?;
          if (payload != null) {
            _addToStream(_connectionAcceptedStream, payload);
          }
          break;
        case 'error':
          _addToStream(_serverErrorStream, data);
          break;
      }
    } catch (e) {
      // Ignore parse errors for malformed messages
    }
  }

  /// Safely add to a stream controller, checking for closed state.
  void _addToStream<T>(StreamController<T> controller, T event) {
    if (!controller.isClosed && !_disposed) {
      controller.add(event);
    }
  }

  void _handleError(dynamic error) {
    _isConnected = false;
    _isConnecting = false;
    _addToStream(_connectionStream, P2PChatConnectionState.error);
    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  void _handleDone() {
    _isConnected = false;
    _isConnecting = false;
    _addToStream(_connectionStream, P2PChatConnectionState.disconnected);
    // Only reconnect if disconnect wasn't intentional
    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Optional callback to refresh the access token before reconnecting.
  /// Set this from the cubit to provide fresh tokens on reconnect.
  Future<String?> Function()? onTokenRefresh;

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts ||
        _accessToken == null ||
        _disposed ||
        _manualDisconnect) {
      return;
    }

    _reconnectTimer?.cancel();
    // Exponential backoff: 2, 4, 8, 16, 30, 30...
    final delaySecs = (1 << (_reconnectAttempts + 1)).clamp(2, 30);
    final delay = Duration(seconds: delaySecs);
    _reconnectAttempts++;
    _addToStream(_connectionStream, P2PChatConnectionState.reconnecting);

    _reconnectTimer = Timer(delay, () async {
      if (_disposed || _manualDisconnect) return;
      // Try to get a fresh token before reconnecting
      if (onTokenRefresh != null) {
        final freshToken = await onTokenRefresh!();
        if (freshToken != null && freshToken.isNotEmpty) {
          _accessToken = freshToken;
        }
      }
      if (_accessToken != null && !_disposed && !_manualDisconnect) {
        connect(_accessToken!);
      }
    });
  }

  /// Dispose all resources.
  void dispose() {
    _disposed = true;
    disconnect();
    _messageStream.close();
    _typingStream.close();
    _readReceiptStream.close();
    _deliveryStream.close();
    _messageSentStream.close();
    _connectionStream.close();
    _connectionAcceptedStream.close();
    _serverErrorStream.close();
  }
}
