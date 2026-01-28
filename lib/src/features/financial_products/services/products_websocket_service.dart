import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Products status event received from WebSocket
class ProductsStatusEvent {
  final String productId;
  final String productType;
  final String userId;
  final String status;
  final String? errorMessage;
  final String eventType;
  final int timestamp;

  ProductsStatusEvent({
    required this.productId,
    required this.productType,
    required this.userId,
    required this.status,
    this.errorMessage,
    required this.eventType,
    required this.timestamp,
  });

  factory ProductsStatusEvent.fromJson(Map<String, dynamic> json) {
    return ProductsStatusEvent(
      productId: json['product_id'] as String,
      productType: json['product_type'] as String,
      userId: json['user_id'] as String,
      status: json['status'] as String,
      errorMessage: json['error_message'] as String?,
      eventType: json['event_type'] as String,
      timestamp: json['timestamp'] as int,
    );
  }

  @override
  String toString() {
    return 'ProductsStatusEvent(productId: $productId, productType: $productType, userId: $userId, status: $status, eventType: $eventType)';
  }
}

/// Connection states for WebSocket
enum ProductsWebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// WebSocket service for real-time financial products status updates
/// Supports both WebSocket and SSE (Server-Sent Events) for broad compatibility
class ProductsWebSocketService {
  WebSocketChannel? _channel;
  http.Client? _httpClient;
  StreamSubscription? _sseSubscription;
  final _eventController = StreamController<ProductsStatusEvent>.broadcast();
  final _connectionController = StreamController<ProductsWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _useSSE = false;

  /// Stream of products status events
  Stream<ProductsStatusEvent> get productsUpdates => _eventController.stream;

  /// Stream of connection state changes
  Stream<ProductsWebSocketConnectionState> get connectionState => _connectionController.stream;

  /// Check if currently connected
  bool get isConnected => _isConnected;

  /// Connect to the real-time updates server
  /// Attempts WebSocket first, falls back to SSE if WebSocket fails
  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    if (_isConnected) {
      print('ProductsWebSocketService: Already connected');
      return;
    }

    try {
      await _connectWebSocket(userId, accessToken);
    } catch (e) {
      print('ProductsWebSocketService: WebSocket failed, trying SSE - $e');
      try {
        await _connectSSE(userId, accessToken);
      } catch (sseError) {
        print('ProductsWebSocketService: SSE also failed - $sseError');
        _connectionController.add(ProductsWebSocketConnectionState.error);
        rethrow;
      }
    }
  }

  /// Connect using WebSocket protocol
  Future<void> _connectWebSocket(String userId, String accessToken) async {
    final wsHost = dotenv.env['PRODUCTS_WS_HOST'] ?? dotenv.env['PRODUCTS_GRPC_HOST'] ?? '10.0.2.2';
    final wsPort = int.tryParse(dotenv.env['PRODUCTS_WS_PORT'] ?? '8083') ?? 8083;

    final wsUrl = Uri(
      scheme: 'ws',
      host: wsHost,
      port: wsPort,
      path: '/ws/products',
      queryParameters: {
        'user_id': userId,
        'access_token': accessToken,
      },
    );

    print('ProductsWebSocketService: Connecting via WebSocket to $wsUrl');

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
    _connectionController.add(ProductsWebSocketConnectionState.connected);
    _startPingTimer();

    print('ProductsWebSocketService: WebSocket connected successfully');
  }

  /// Connect using Server-Sent Events (SSE) - fallback
  Future<void> _connectSSE(String userId, String accessToken) async {
    final wsHost = dotenv.env['PRODUCTS_WS_HOST'] ?? dotenv.env['PRODUCTS_GRPC_HOST'] ?? '10.0.2.2';
    final wsPort = int.tryParse(dotenv.env['PRODUCTS_WS_PORT'] ?? '8083') ?? 8083;

    final sseUrl = Uri(
      scheme: 'http',
      host: wsHost,
      port: wsPort,
      path: '/ws/products',
      queryParameters: {
        'user_id': userId,
      },
    );

    print('ProductsWebSocketService: Connecting via SSE to $sseUrl');

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
    _connectionController.add(ProductsWebSocketConnectionState.connected);

    _sseSubscription = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
      _handleSSELine,
      onError: _handleError,
      onDone: _handleDone,
      cancelOnError: false,
    );

    print('ProductsWebSocketService: SSE connected successfully');
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

    print('ProductsWebSocketService: Disconnecting');

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
    _connectionController.add(ProductsWebSocketConnectionState.disconnected);

    print('ProductsWebSocketService: Disconnected');
  }

  /// Send a ping message (only for WebSocket connections)
  void _sendPing() {
    if (_isConnected && _channel != null && !_useSSE) {
      try {
        _channel!.sink.add(jsonEncode({'type': 'ping'}));
      } catch (e) {
        print('ProductsWebSocketService: Error sending ping - $e');
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
        print('ProductsWebSocketService: Connection confirmed by server');
        return;
      }

      if (messageType == 'pong') {
        print('ProductsWebSocketService: Pong received');
        return;
      }

      if (messageType == 'shutdown') {
        print('ProductsWebSocketService: Server shutting down');
        disconnect();
        return;
      }

      if (messageType == 'products_status') {
        final payload = data['payload'] as Map<String, dynamic>?;
        if (payload != null) {
          final event = ProductsStatusEvent.fromJson(payload);
          print('ProductsWebSocketService: Received products update - $event');
          _eventController.add(event);
        }
        return;
      }

      // Legacy format support
      final eventType = data['event_type'] as String?;
      if (eventType != null) {
        final event = ProductsStatusEvent.fromJson(data);
        print('ProductsWebSocketService: Received products update (legacy) - $event');
        _eventController.add(event);
      }
    } catch (e) {
      print('ProductsWebSocketService: Error parsing message - $e');
    }
  }

  /// Handle WebSocket error
  void _handleError(error) {
    print('ProductsWebSocketService: WebSocket error - $error');
    _isConnected = false;
    _connectionController.add(ProductsWebSocketConnectionState.error);
  }

  /// Handle WebSocket connection closed
  void _handleDone() {
    print('ProductsWebSocketService: Connection closed');
    _isConnected = false;
    _connectionController.add(ProductsWebSocketConnectionState.disconnected);
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
