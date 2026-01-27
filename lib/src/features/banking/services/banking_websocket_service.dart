import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Banking status event received from WebSocket
class BankingStatusEvent {
  final String transferId;
  final String userId;
  final String accountId;
  final String status;
  final String? errorMessage;
  final String eventType;
  final int? amount;
  final String? currency;
  final String? reference;
  final int timestamp;

  BankingStatusEvent({
    required this.transferId,
    required this.userId,
    required this.accountId,
    required this.status,
    this.errorMessage,
    required this.eventType,
    this.amount,
    this.currency,
    this.reference,
    required this.timestamp,
  });

  factory BankingStatusEvent.fromJson(Map<String, dynamic> json) {
    return BankingStatusEvent(
      transferId: json['transfer_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      accountId: json['account_id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      errorMessage: json['error_message'] as String?,
      eventType: json['event_type'] as String? ?? '',
      amount: json['amount'] as int?,
      currency: json['currency'] as String?,
      reference: json['reference'] as String?,
      timestamp: json['timestamp'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    return 'BankingStatusEvent(transferId: $transferId, userId: $userId, accountId: $accountId, status: $status, eventType: $eventType, reference: $reference)';
  }
}

/// Connection states for WebSocket
enum BankingWebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// WebSocket service for real-time banking status updates
/// Supports both WebSocket and SSE (Server-Sent Events) for broad compatibility
class BankingWebSocketService {
  WebSocketChannel? _channel;
  http.Client? _httpClient;
  StreamSubscription? _sseSubscription;
  final _eventController = StreamController<BankingStatusEvent>.broadcast();
  final _connectionController = StreamController<BankingWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _useSSE = false;

  /// Stream of banking status events
  Stream<BankingStatusEvent> get bankingUpdates => _eventController.stream;

  /// Stream of connection state changes
  Stream<BankingWebSocketConnectionState> get connectionState => _connectionController.stream;

  /// Check if currently connected
  bool get isConnected => _isConnected;

  /// Connect to the real-time updates server
  /// Attempts WebSocket first, falls back to SSE if WebSocket fails
  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    if (_isConnected) {
      print('BankingWebSocketService: Already connected');
      return;
    }

    try {
      await _connectWebSocket(userId, accessToken);
    } catch (e) {
      print('BankingWebSocketService: WebSocket failed, trying SSE - $e');
      try {
        await _connectSSE(userId, accessToken);
      } catch (sseError) {
        print('BankingWebSocketService: SSE also failed - $sseError');
        _connectionController.add(BankingWebSocketConnectionState.error);
        rethrow;
      }
    }
  }

  /// Connect using WebSocket protocol
  Future<void> _connectWebSocket(String userId, String accessToken) async {
    final wsHost = dotenv.env['BANKING_WS_HOST'] ?? dotenv.env['BANKING_GATEWAY_GRPC_HOST'] ?? '10.0.2.2';
    final wsPort = int.tryParse(dotenv.env['BANKING_WS_PORT'] ?? '8082') ?? 8082;

    final wsUrl = Uri(
      scheme: 'ws',
      host: wsHost,
      port: wsPort,
      path: '/ws/banking',
      queryParameters: {
        'user_id': userId,
        'access_token': accessToken,
      },
    );

    print('BankingWebSocketService: Connecting via WebSocket to $wsUrl');

    if (kIsWeb) {
      _channel = WebSocketChannel.connect(
        wsUrl,
        protocols: ['token', accessToken],
      );
    } else {
      _channel = IOWebSocketChannel.connect(
        wsUrl,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
    }
    _useSSE = false;

    _channel!.stream.listen(
      _handleMessage,
      onError: _handleError,
      onDone: _handleDone,
      cancelOnError: false,
    );

    _isConnected = true;
    _connectionController.add(BankingWebSocketConnectionState.connected);
    _startPingTimer();

    print('BankingWebSocketService: WebSocket connected successfully');
  }

  /// Connect using Server-Sent Events (SSE) - fallback
  Future<void> _connectSSE(String userId, String accessToken) async {
    final wsHost = dotenv.env['BANKING_WS_HOST'] ?? dotenv.env['BANKING_GATEWAY_GRPC_HOST'] ?? '10.0.2.2';
    final wsPort = int.tryParse(dotenv.env['BANKING_WS_PORT'] ?? '8082') ?? 8082;

    final sseUrl = Uri(
      scheme: 'http',
      host: wsHost,
      port: wsPort,
      path: '/ws/banking',
      queryParameters: {
        'user_id': userId,
      },
    );

    print('BankingWebSocketService: Connecting via SSE to $sseUrl');

    _httpClient = http.Client();
    _useSSE = true;

    final request = http.Request('GET', sseUrl);
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cache-Control'] = 'no-cache';
    request.headers['Authorization'] = 'Bearer $accessToken';

    final response = await _httpClient!.send(request);

    if (response.statusCode != 200) {
      throw Exception('SSE connection failed with status ${response.statusCode}');
    }

    _isConnected = true;
    _connectionController.add(BankingWebSocketConnectionState.connected);

    _sseSubscription = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
      _handleSSELine,
      onError: _handleError,
      onDone: _handleDone,
      cancelOnError: false,
    );

    print('BankingWebSocketService: SSE connected successfully');
  }

  /// Handle a line from SSE stream
  void _handleSSELine(String line) {
    if (line.startsWith('data: ')) {
      final jsonStr = line.substring(6);
      _handleMessage(jsonStr);
    }
  }

  /// Disconnect from the server
  void disconnect() {
    if (!_isConnected) return;

    print('BankingWebSocketService: Disconnecting');

    _pingTimer?.cancel();
    _pingTimer = null;

    _channel?.sink.close();
    _channel = null;

    _sseSubscription?.cancel();
    _sseSubscription = null;
    _httpClient?.close();
    _httpClient = null;

    _isConnected = false;
    _useSSE = false;
    _connectionController.add(BankingWebSocketConnectionState.disconnected);

    print('BankingWebSocketService: Disconnected');
  }

  /// Send a ping message (only for WebSocket connections)
  void _sendPing() {
    if (_isConnected && _channel != null && !_useSSE) {
      try {
        _channel!.sink.add(jsonEncode({'type': 'ping'}));
      } catch (e) {
        print('BankingWebSocketService: Error sending ping - $e');
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

  /// Handle incoming message
  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final messageType = data['type'] as String?;

      if (messageType == 'connected') {
        print('BankingWebSocketService: Connection confirmed by server');
        return;
      }

      if (messageType == 'pong') {
        print('BankingWebSocketService: Pong received');
        return;
      }

      if (messageType == 'shutdown') {
        print('BankingWebSocketService: Server shutting down');
        disconnect();
        return;
      }

      if (messageType == 'banking_status') {
        final payload = data['payload'] as Map<String, dynamic>?;
        if (payload != null) {
          final event = BankingStatusEvent.fromJson(payload);
          print('BankingWebSocketService: Received banking update - $event');
          _eventController.add(event);
        }
        return;
      }

      // Legacy format support
      final eventType = data['event_type'] as String?;
      if (eventType != null) {
        final event = BankingStatusEvent.fromJson(data);
        print('BankingWebSocketService: Received banking update (legacy) - $event');
        _eventController.add(event);
      }
    } catch (e) {
      print('BankingWebSocketService: Error parsing message - $e');
    }
  }

  /// Handle WebSocket error
  void _handleError(error) {
    print('BankingWebSocketService: WebSocket error - $error');
    _isConnected = false;
    _connectionController.add(BankingWebSocketConnectionState.error);
  }

  /// Handle WebSocket connection closed
  void _handleDone() {
    print('BankingWebSocketService: Connection closed');
    _isConnected = false;
    _connectionController.add(BankingWebSocketConnectionState.disconnected);
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _eventController.close();
    _connectionController.close();
  }

  /// Check if using SSE connection
  bool get isUsingSSE => _useSSE;

  /// Filter banking updates by deposit reference
  Stream<BankingStatusEvent> filterByReference(String reference) {
    return bankingUpdates.where(
      (event) => event.reference == reference || event.transferId == reference,
    );
  }
}
