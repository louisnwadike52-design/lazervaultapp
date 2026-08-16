import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Wire shape from `services/commerce-gateway/websocket/qr_websocket.go`.
/// Keep keys in sync with the Go `QRUpdateEvent`.
class QrPayStatusEvent {
  final String qrCode;
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

  QrPayStatusEvent({
    required this.qrCode,
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

  factory QrPayStatusEvent.fromJson(Map<String, dynamic> json) {
    return QrPayStatusEvent(
      qrCode: (json['qr_code'] as String?) ?? '',
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
      'QrPayStatusEvent(qr=$qrCode status=$status eventType=$eventType payer=$payerName)';
}

enum QrPayWebSocketConnectionState { disconnected, connected, error }

/// Realtime channel for QR-pay completion notifications.
///
/// Flow:
///   1. Generator phone creates a QR via gRPC, displays it.
///   2. QR display screen connects this WS service — subscribes under the
///      generator's user id.
///   3. Payer scans + pays via gRPC; qr-pay-service POSTs
///      /ws/qr/notify on commerce-gateway.
///   4. The gateway's QRHub fans the event to the generator's WS, which
///      flips the display to "Paid by …".
///
/// Polling stays as a Flutter-side fallback. If the WS errors or no
/// `connected` arrives within a cubit timeout, the screen reverts to
/// `getQRDetails` polling so the flow still completes.
class QrPayWebSocketService {
  WebSocketChannel? _channel;
  final _eventController = StreamController<QrPayStatusEvent>.broadcast();
  final _connectionController =
      StreamController<QrPayWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;

  Stream<QrPayStatusEvent> get updates => _eventController.stream;
  Stream<QrPayWebSocketConnectionState> get connectionState =>
      _connectionController.stream;
  bool get isConnected => _isConnected;

  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    if (_isConnected) return;
    // commerce-gateway HTTP defaults to 8080; tunnel route on 443 flips
    // the scheme automatically.
    final ep = endpointRegistry.resolveServiceHostPort(
      overrideHost:
          dotenv.env['QR_WS_HOST'] ?? dotenv.env['COMMERCE_WS_HOST'],
      overridePort: int.tryParse(
          dotenv.env['QR_WS_PORT'] ?? dotenv.env['COMMERCE_WS_PORT'] ?? ''),
      devPort: 8080,
    );
    final wsHost = ep.host;
    final port = ep.port;
    final tlsTunnel = port == 443;
    final uri = Uri(
      scheme: tlsTunnel ? 'wss' : 'ws',
      host: wsHost,
      port: tlsTunnel ? null : port,
      path: '/ws/qr',
      queryParameters: {
        'user_id': userId,
        'access_token': accessToken,
      },
    );
    print('QrPayWebSocketService: connecting to $uri');
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
    _connectionController.add(QrPayWebSocketConnectionState.connected);
    _startPingTimer();
    print('QrPayWebSocketService: connected');
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
      if (type == 'qr_status') {
        final payload = decoded['payload'];
        if (payload is Map<String, dynamic>) {
          _eventController.add(QrPayStatusEvent.fromJson(payload));
        }
      }
    } catch (e) {
      print('QrPayWebSocketService: handle error: $e');
    }
  }

  void _handleError(Object error) {
    print('QrPayWebSocketService: stream error: $error');
    _connectionController.add(QrPayWebSocketConnectionState.error);
    _isConnected = false;
  }

  void _handleDone() {
    print('QrPayWebSocketService: stream closed');
    _connectionController.add(QrPayWebSocketConnectionState.disconnected);
    _isConnected = false;
    _pingTimer?.cancel();
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _connectionController.add(QrPayWebSocketConnectionState.disconnected);
  }

  void dispose() {
    disconnect();
    _eventController.close();
    _connectionController.close();
  }
}
