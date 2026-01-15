import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Balance update event received from WebSocket
class BalanceUpdateEvent {
  final String userId;
  final String accountId;
  final String countryCode;
  final double newBalance;
  final double availableBalance;
  final String currency;
  final String eventType;
  final String? transactionId;
  final int timestamp;

  BalanceUpdateEvent({
    required this.userId,
    required this.accountId,
    required this.countryCode,
    required this.newBalance,
    required this.availableBalance,
    required this.currency,
    required this.eventType,
    this.transactionId,
    required this.timestamp,
  });

  factory BalanceUpdateEvent.fromJson(Map<String, dynamic> json) {
    return BalanceUpdateEvent(
      userId: json['user_id'] as String,
      accountId: json['account_id'] as String,
      countryCode: json['country_code'] as String,
      newBalance: (json['new_balance'] as num).toDouble(),
      availableBalance: (json['available_balance'] as num).toDouble(),
      currency: json['currency'] as String,
      eventType: json['event_type'] as String,
      transactionId: json['transaction_id'] as String?,
      timestamp: json['timestamp'] as int,
    );
  }

  @override
  String toString() {
    return 'BalanceUpdateEvent(userId: $userId, accountId: $accountId, newBalance: $newBalance, eventType: $eventType)';
  }
}

/// Connection states for WebSocket
enum WebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// WebSocket service for real-time balance updates
class BalanceWebSocketService {
  WebSocketChannel? _channel;
  final _eventController = StreamController<BalanceUpdateEvent>.broadcast();
  final _connectionController = StreamController<WebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;

  /// Stream of balance update events
  Stream<BalanceUpdateEvent> get balanceUpdates => _eventController.stream;

  /// Stream of connection state changes
  Stream<WebSocketConnectionState> get connectionState => _connectionController.stream;

  /// Check if currently connected
  bool get isConnected => _isConnected;

  /// Connect to the WebSocket server
  Future<void> connect({
    required String userId,
    required String countryCode,
    required String accessToken,
  }) async {
    if (_isConnected) {
      print('BalanceWebSocketService: Already connected');
      return;
    }

    try {
      // Get financial gateway host and port from environment
      final financialGatewayHost = dotenv.env['PAYMENT_GRPC_HOST'] ?? '10.0.2.2';
      final financialGatewayPort = int.tryParse(dotenv.env['PAYMENT_GRPC_PORT'] ?? '8080') ?? 8080;

      // Build WebSocket URL
      final wsUrl = Uri(
        scheme: 'ws',
        host: financialGatewayHost,
        port: financialGatewayPort,
        path: '/ws/balance',
        queryParameters: {
          'user_id': userId,
          'country_code': countryCode,
          'access_token': accessToken,
        },
      );

      print('BalanceWebSocketService: Connecting to $wsUrl');

      // Create WebSocket channel
      _channel = WebSocketChannel.connect(wsUrl);

      // Listen for incoming messages
      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
        cancelOnError: false,
      );

      _isConnected = true;
      _connectionController.add(WebSocketConnectionState.connected);

      // Start ping timer to keep connection alive
      _startPingTimer();

      print('BalanceWebSocketService: Connected successfully');
    } catch (e) {
      print('BalanceWebSocketService: Connection error - $e');
      _isConnected = false;
      _connectionController.add(WebSocketConnectionState.error);
      rethrow;
    }
  }

  /// Disconnect from the WebSocket server
  void disconnect() {
    if (!_isConnected) {
      return;
    }

    print('BalanceWebSocketService: Disconnecting');

    _pingTimer?.cancel();
    _pingTimer = null;

    _channel?.sink.close();
    _channel = null;

    _isConnected = false;
    _connectionController.add(WebSocketConnectionState.disconnected);

    print('BalanceWebSocketService: Disconnected');
  }

  /// Send a ping message
  void _sendPing() {
    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(jsonEncode({'type': 'ping'}));
      } catch (e) {
        print('BalanceWebSocketService: Error sending ping - $e');
      }
    }
  }

  /// Start the ping timer
  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _sendPing();
    });
  }

  /// Handle incoming WebSocket message
  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;

      // Handle different message types
      final eventType = data['event_type'] as String?;

      if (eventType == 'connected') {
        print('BalanceWebSocketService: Connection confirmed by server');
        return;
      }

      // Handle balance update events
      if (eventType == 'transfer' ||
          eventType == 'deposit' ||
          eventType == 'withdrawal') {
        final event = BalanceUpdateEvent.fromJson(data);
        print('BalanceWebSocketService: Received balance update - $event');
        _eventController.add(event);
      }
    } catch (e) {
      print('BalanceWebSocketService: Error parsing message - $e');
    }
  }

  /// Handle WebSocket error
  void _handleError(error) {
    print('BalanceWebSocketService: WebSocket error - $error');
    _isConnected = false;
    _connectionController.add(WebSocketConnectionState.error);
  }

  /// Handle WebSocket connection closed
  void _handleDone() {
    print('BalanceWebSocketService: Connection closed');
    _isConnected = false;
    _connectionController.add(WebSocketConnectionState.disconnected);
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _eventController.close();
    _connectionController.close();
  }
}
