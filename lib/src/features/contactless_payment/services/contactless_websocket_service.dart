import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Wire shape from `services/contactless-payment-gateway/websocket/contactless_websocket.go`.
/// Keep keys in sync with `ContactlessUpdateEvent`.
class ContactlessStatusEvent {
  final String sessionId;
  final String userId;
  final String status;
  final String eventType;
  final String? reference;
  final int? amount;
  final String? currency;
  final String? payerName;
  final String? payerUserId;
  final String? errorMessage;
  final int timestamp;

  ContactlessStatusEvent({
    required this.sessionId,
    required this.userId,
    required this.status,
    required this.eventType,
    this.reference,
    this.amount,
    this.currency,
    this.payerName,
    this.payerUserId,
    this.errorMessage,
    required this.timestamp,
  });

  factory ContactlessStatusEvent.fromJson(Map<String, dynamic> json) {
    return ContactlessStatusEvent(
      sessionId: (json['session_id'] as String?) ?? '',
      userId: (json['user_id'] as String?) ?? '',
      status: (json['status'] as String?) ?? '',
      eventType: (json['event_type'] as String?) ?? '',
      reference: json['reference'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      payerName: json['payer_name'] as String?,
      payerUserId: json['payer_user_id'] as String?,
      errorMessage: json['error_message'] as String?,
      timestamp: ((json['timestamp'] as num?) ?? 0).toInt(),
    );
  }

  @override
  String toString() =>
      'ContactlessStatusEvent(session=$sessionId status=$status eventType=$eventType payer=$payerName)';
}

enum ContactlessWebSocketConnectionState { disconnected, connected, error }

/// Realtime channel for tap-to-pay completion notifications.
///
/// Flow:
///   1. Receiver phone creates a session via gRPC, writes the NFC tag.
///   2. Cubit connects this WS service immediately after — subscribes
///      under the receiver's user id.
///   3. Payer phone reads the NFC tag, runs `processContactlessPayment`.
///   4. contactless-payment-service POSTs /ws/contactless/notify on the
///      gateway, which fans the event back to the receiver's WS.
///   5. Receiver UI flips to the receipt without the 2s polling lag.
///
/// Polling continues as a Flutter-side fallback (see
/// `contactless_payment_cubit.dart`). If [connect] throws or never
/// emits `connected` within the cubit's WS timeout, the cubit reverts
/// to polling `checkSessionStatus` so the flow still completes.
class ContactlessWebSocketService {
  WebSocketChannel? _channel;
  final _eventController = StreamController<ContactlessStatusEvent>.broadcast();
  final _connectionController =
      StreamController<ContactlessWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;

  Stream<ContactlessStatusEvent> get updates => _eventController.stream;
  Stream<ContactlessWebSocketConnectionState> get connectionState =>
      _connectionController.stream;
  bool get isConnected => _isConnected;

  /// Connect to /ws/contactless on the contactless-payment-gateway. Host
  /// + port come from `.env` (CONTACTLESS_WS_HOST / CONTACTLESS_WS_PORT)
  /// with sensible fallbacks. Port 443 implies cloudflared TLS termination
  /// → `wss://`. Loopback dev ports stay `ws://`.
  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    if (_isConnected) return;
    final wsHost = dotenv.env['CONTACTLESS_WS_HOST'] ??
        dotenv.env['CONTACTLESS_GRPC_HOST'] ??
        '10.0.2.2';
    final portStr = dotenv.env['CONTACTLESS_WS_PORT'] ?? '8086';
    final port = int.tryParse(portStr) ?? 8086;
    final tlsTunnel = port == 443;
    final uri = Uri(
      scheme: tlsTunnel ? 'wss' : 'ws',
      host: wsHost,
      port: tlsTunnel ? null : port,
      path: '/ws/contactless',
      queryParameters: {
        'user_id': userId,
        'access_token': accessToken,
      },
    );
    print('ContactlessWebSocketService: connecting to $uri');
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    if (kIsWeb) {
      _channel =
          WebSocketChannel.connect(uri, protocols: ['token', accessToken]);
    } else {
      _channel = IOWebSocketChannel.connect(uri, headers: headers);
    }
    _channel!.stream.listen(
      _handleMessage,
      onError: _handleError,
      onDone: _handleDone,
      cancelOnError: false,
    );
    _isConnected = true;
    _connectionController.add(ContactlessWebSocketConnectionState.connected);
    _startPingTimer();
    print('ContactlessWebSocketService: connected');
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_channel != null) {
        _channel!.sink.add(jsonEncode({'type': 'ping'}));
      }
    });
  }

  void _handleMessage(dynamic raw) {
    try {
      final decoded =
          raw is String ? jsonDecode(raw) : raw as Map<String, dynamic>;
      if (decoded is! Map<String, dynamic>) return;
      final type = decoded['type'] as String?;
      if (type == 'connected') return;
      if (type == 'pong') return;
      if (type == 'contactless_status') {
        final payload = decoded['payload'];
        if (payload is Map<String, dynamic>) {
          _eventController.add(ContactlessStatusEvent.fromJson(payload));
        }
      }
    } catch (e) {
      print('ContactlessWebSocketService: handle error: $e');
    }
  }

  void _handleError(Object error) {
    print('ContactlessWebSocketService: stream error: $error');
    _connectionController.add(ContactlessWebSocketConnectionState.error);
    _isConnected = false;
  }

  void _handleDone() {
    print('ContactlessWebSocketService: stream closed');
    _connectionController
        .add(ContactlessWebSocketConnectionState.disconnected);
    _isConnected = false;
    _pingTimer?.cancel();
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _connectionController
        .add(ContactlessWebSocketConnectionState.disconnected);
  }

  void dispose() {
    disconnect();
    _eventController.close();
    _connectionController.close();
  }
}
