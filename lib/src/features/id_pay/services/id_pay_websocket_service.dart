import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Wire shape from `services/commerce-gateway/websocket/id_pay_websocket.go`.
/// Keep keys in sync with the Go `IDPayUpdateEvent`.
class IDPayStatusEvent {
  final String payId;
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

  IDPayStatusEvent({
    required this.payId,
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

  factory IDPayStatusEvent.fromJson(Map<String, dynamic> json) {
    return IDPayStatusEvent(
      payId: (json['pay_id'] as String?) ?? '',
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
      'IDPayStatusEvent(pay=$payId status=$status eventType=$eventType payer=$payerName)';
}

enum IDPayWebSocketConnectionState { disconnected, connected, error }

/// Realtime channel for IDPay completion notifications.
///
/// Flow mirrors the QR-pay flow:
///   1. Creator creates an IDPay via gRPC, displays the PAY-code.
///   2. The IDPay display screen connects this WS service — subscribes
///      under the creator's user id.
///   3. Payer looks up + pays via gRPC; id-pay-service POSTs
///      /ws/id-pay/notify on commerce-gateway.
///   4. The gateway's IDPayHub fans the event to the creator's WS,
///      which flips the display to "Paid by …".
///
/// Polling stays as a Flutter-side fallback. If the WS errors or no
/// `connected` arrives within a cubit timeout, the screen reverts to
/// LookupIDPay polling so the flow still completes.
class IDPayWebSocketService {
  WebSocketChannel? _channel;
  final _eventController = StreamController<IDPayStatusEvent>.broadcast();
  final _connectionController =
      StreamController<IDPayWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;

  Stream<IDPayStatusEvent> get updates => _eventController.stream;
  Stream<IDPayWebSocketConnectionState> get connectionState =>
      _connectionController.stream;
  bool get isConnected => _isConnected;

  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    if (_isConnected) return;
    // commerce-gateway HTTP defaults to 8080; tunnel route on 443 flips
    // the scheme automatically.
    final wsHost = dotenv.env['ID_PAY_WS_HOST'] ??
        dotenv.env['COMMERCE_WS_HOST'] ??
        endpointRegistry.grpcHost;
    final portStr = dotenv.env['ID_PAY_WS_PORT'] ??
        dotenv.env['COMMERCE_WS_PORT'] ??
        '8080';
    final port = int.tryParse(portStr) ?? 8080;
    final tlsTunnel = port == 443;
    final uri = Uri(
      scheme: tlsTunnel ? 'wss' : 'ws',
      host: wsHost,
      port: tlsTunnel ? null : port,
      path: '/ws/id-pay',
      queryParameters: {
        'user_id': userId,
        'access_token': accessToken,
      },
    );
    print('IDPayWebSocketService: connecting to $uri');
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
    _connectionController.add(IDPayWebSocketConnectionState.connected);
    _startPingTimer();
    print('IDPayWebSocketService: connected');
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
      if (type == 'connected' || type == 'pong') return;
      if (type == 'id_pay_status') {
        final payload = decoded['payload'];
        if (payload is Map<String, dynamic>) {
          _eventController.add(IDPayStatusEvent.fromJson(payload));
        }
      }
    } catch (e) {
      print('IDPayWebSocketService: handle error: $e');
    }
  }

  void _handleError(Object error) {
    print('IDPayWebSocketService: stream error: $error');
    _connectionController.add(IDPayWebSocketConnectionState.error);
    _isConnected = false;
  }

  void _handleDone() {
    print('IDPayWebSocketService: stream closed');
    _connectionController.add(IDPayWebSocketConnectionState.disconnected);
    _isConnected = false;
    _pingTimer?.cancel();
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _connectionController.add(IDPayWebSocketConnectionState.disconnected);
  }

  void dispose() {
    disconnect();
    _eventController.close();
    _connectionController.close();
  }
}
