import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

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
  final String? reference;
  final double? amount;
  final String? narration;
  final String status; // "pending", "processing", "completed", "failed"
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
    this.reference,
    this.amount,
    this.narration,
    required this.status,
    required this.timestamp,
  });

  factory BalanceUpdateEvent.fromJson(Map<String, dynamic> json) {
    return BalanceUpdateEvent(
      userId: json['user_id'] as String,
      accountId: json['account_id'] as String,
      countryCode: json['country_code'] as String? ?? '',
      newBalance: (json['new_balance'] as num).toDouble(),
      availableBalance: (json['available_balance'] as num).toDouble(),
      currency: json['currency'] as String,
      eventType: json['event_type'] as String,
      transactionId: json['transaction_id'] as String?,
      reference: json['reference'] as String?,
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      narration: json['narration'] as String?,
      status: json['status'] as String? ?? 'completed',
      timestamp: json['timestamp'] as int,
    );
  }

  @override
  String toString() {
    return 'BalanceUpdateEvent(userId: $userId, accountId: $accountId, newBalance: $newBalance, eventType: $eventType, status: $status)';
  }
}

/// Connection states for WebSocket
enum WebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// WebSocket service for real-time balance updates
/// Supports both WebSocket and SSE (Server-Sent Events) for broad compatibility
class BalanceWebSocketService {
  WebSocketChannel? _channel;
  http.Client? _httpClient;
  StreamSubscription? _sseSubscription;
  final _eventController = StreamController<BalanceUpdateEvent>.broadcast();
  final _connectionController = StreamController<WebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _useSSE = false; // Flag to track if using SSE instead of WebSocket

  /// Stream of balance update events
  Stream<BalanceUpdateEvent> get balanceUpdates => _eventController.stream;

  /// Stream of connection state changes
  Stream<WebSocketConnectionState> get connectionState => _connectionController.stream;

  /// Check if currently connected
  bool get isConnected => _isConnected;

  /// Connect to the real-time updates server
  /// Attempts WebSocket first, falls back to SSE if WebSocket fails
  Future<void> connect({
    required String userId,
    required String countryCode,
    required String accessToken,
  }) async {
    if (_isConnected) {
      print('BalanceWebSocketService: Already connected');
      return;
    }

    // Try WebSocket first, fall back to SSE
    try {
      await _connectWebSocket(userId, countryCode, accessToken);
    } catch (e) {
      print('BalanceWebSocketService: WebSocket failed, trying SSE - $e');
      try {
        await _connectSSE(userId, countryCode, accessToken);
      } catch (sseError) {
        print('BalanceWebSocketService: SSE also failed - $sseError');
        _connectionController.add(WebSocketConnectionState.error);
        rethrow;
      }
    }
  }

  /// Connect using WebSocket protocol
  /// Token is passed via Authorization header on mobile/desktop, query param on web
  Future<void> _connectWebSocket(String userId, String countryCode, String accessToken) async {
    // Get WebSocket balance service host and port from environment
    // Falls back to financial gateway if WS_BALANCE_HOST is not set
    final wsBalanceHost = dotenv.env['WS_BALANCE_HOST'] ?? dotenv.env['PAYMENT_GRPC_HOST'] ?? '10.0.2.2';
    final wsBalancePort = int.tryParse(dotenv.env['WS_BALANCE_PORT'] ?? '8095') ?? 8095;

    // Build WebSocket URL - only include country_code in query string
    final wsUrl = Uri(
      scheme: 'ws',
      host: wsBalanceHost,
      port: wsBalancePort,
      path: '/ws/balance',
      queryParameters: {
        'country_code': countryCode,
      },
    );

    print('BalanceWebSocketService: Connecting via WebSocket to $wsUrl');

    // Create WebSocket channel with proper auth
    if (kIsWeb) {
      // Web: Use Sec-WebSocket-Protocol to pass token (browsers don't allow custom headers)
      // Format: "token, <actual-token>" - server parses this
      _channel = WebSocketChannel.connect(
        wsUrl,
        protocols: ['token', accessToken],
      );
    } else {
      // Mobile/Desktop: Use IOWebSocketChannel with Authorization header (secure)
      _channel = IOWebSocketChannel.connect(
        wsUrl,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
    }
    _useSSE = false;

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

    print('BalanceWebSocketService: WebSocket connected successfully');
  }

  /// Connect using Server-Sent Events (SSE) - fallback for when WebSocket is not available
  /// SECURITY: Token is passed in Authorization header, not query string
  Future<void> _connectSSE(String userId, String countryCode, String accessToken) async {
    // Get WebSocket balance service host and port from environment
    final wsBalanceHost = dotenv.env['WS_BALANCE_HOST'] ?? dotenv.env['PAYMENT_GRPC_HOST'] ?? '10.0.2.2';
    final wsBalancePort = int.tryParse(dotenv.env['WS_BALANCE_PORT'] ?? '8095') ?? 8095;

    // Build SSE URL - only non-sensitive params in query string
    final sseUrl = Uri(
      scheme: 'http',
      host: wsBalanceHost,
      port: wsBalancePort,
      path: '/ws/balance',
      queryParameters: {
        'country_code': countryCode,
        // SECURITY: Token moved to Authorization header (not logged in URLs)
      },
    );

    print('BalanceWebSocketService: Connecting via SSE to $sseUrl');

    _httpClient = http.Client();
    _useSSE = true;

    // Make streaming HTTP request for SSE with Authorization header
    final request = http.Request('GET', sseUrl);
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cache-Control'] = 'no-cache';
    // SECURITY: Pass token in Authorization header instead of URL
    request.headers['Authorization'] = 'Bearer $accessToken';

    final response = await _httpClient!.send(request);

    if (response.statusCode != 200) {
      throw Exception('SSE connection failed with status ${response.statusCode}');
    }

    _isConnected = true;
    _connectionController.add(WebSocketConnectionState.connected);

    // Listen to the stream
    _sseSubscription = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
      _handleSSELine,
      onError: _handleError,
      onDone: _handleDone,
      cancelOnError: false,
    );

    print('BalanceWebSocketService: SSE connected successfully');
  }

  /// Handle a line from SSE stream
  void _handleSSELine(String line) {
    // SSE format: "event: <event_type>\ndata: <json_data>\n\n"
    if (line.startsWith('data: ')) {
      final jsonStr = line.substring(6);
      _handleMessage(jsonStr);
    }
  }

  /// Disconnect from the server (handles both WebSocket and SSE)
  void disconnect() {
    if (!_isConnected) {
      return;
    }

    print('BalanceWebSocketService: Disconnecting');

    _pingTimer?.cancel();
    _pingTimer = null;

    // Close WebSocket if used
    _channel?.sink.close();
    _channel = null;

    // Close SSE if used
    _sseSubscription?.cancel();
    _sseSubscription = null;
    _httpClient?.close();
    _httpClient = null;

    _isConnected = false;
    _useSSE = false;
    _connectionController.add(WebSocketConnectionState.disconnected);

    print('BalanceWebSocketService: Disconnected');
  }

  /// Send a ping message (only for WebSocket connections)
  void _sendPing() {
    // Only send ping for WebSocket connections, not SSE
    if (_isConnected && _channel != null && !_useSSE) {
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

  /// Handle incoming message (works for both WebSocket and SSE)
  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;

      // Handle different message types
      final messageType = data['type'] as String?;

      // Handle connection confirmation
      if (messageType == 'connected') {
        print('BalanceWebSocketService: Connection confirmed by server');
        return;
      }

      // Handle pong response
      if (messageType == 'pong') {
        print('BalanceWebSocketService: Pong received');
        return;
      }

      // Handle shutdown notification
      if (messageType == 'shutdown') {
        print('BalanceWebSocketService: Server shutting down');
        disconnect();
        return;
      }

      // Handle balance update events
      if (messageType == 'balance_update') {
        final payload = data['payload'] as Map<String, dynamic>?;
        if (payload != null) {
          final event = BalanceUpdateEvent.fromJson(payload);
          print('BalanceWebSocketService: Received balance update - $event');
          _eventController.add(event);
        }
        return;
      }

      // Handle transaction status updates
      if (messageType == 'transaction_status') {
        final payload = data['payload'] as Map<String, dynamic>?;
        if (payload != null) {
          print('BalanceWebSocketService: Transaction status update - ${payload['transaction_id']}: ${payload['new_status']}');
          // Could add a separate stream for transaction status updates if needed
        }
        return;
      }

      // Legacy format support: direct event_type in message
      final eventType = data['event_type'] as String?;
      if (eventType == 'transfer' ||
          eventType == 'transfer_in' ||
          eventType == 'transfer_out' ||
          eventType == 'deposit' ||
          eventType == 'withdrawal') {
        final event = BalanceUpdateEvent.fromJson(data);
        print('BalanceWebSocketService: Received balance update (legacy) - $event');
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

  /// Check if using SSE connection
  bool get isUsingSSE => _useSSE;
}
