import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// A single terminal-or-intermediate event pushed by the financial-gateway
/// exchange WebSocket. Mirrors the Go ExchangeEvent struct in
/// services/financial-gateway/websocket/exchange_websocket.go.
class ExchangeWsEvent {
  final String eventType;
  final String transactionId;
  final String userId;
  final String reference;
  final String fromCurrency;
  final String toCurrency;
  final double amountFrom;
  final double amountTo;
  final String status;
  final int timestamp;

  ExchangeWsEvent({
    required this.eventType,
    required this.transactionId,
    required this.userId,
    required this.reference,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amountFrom,
    required this.amountTo,
    required this.status,
    required this.timestamp,
  });

  /// Backend-authoritative terminal check — matches the Go
  /// ExchangeEvent.Terminal() method.
  bool get terminal =>
      status == 'completed' ||
      status == 'failed' ||
      status == 'refunded' ||
      status == 'cancelled';

  factory ExchangeWsEvent.fromJson(Map<String, dynamic> json) {
    return ExchangeWsEvent(
      eventType: json['event_type'] as String? ?? '',
      transactionId: json['transaction_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      reference: json['reference'] as String? ?? '',
      fromCurrency: json['from_currency'] as String? ?? '',
      toCurrency: json['to_currency'] as String? ?? '',
      amountFrom: (json['amount_from'] as num?)?.toDouble() ?? 0,
      amountTo: (json['amount_to'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? '',
      timestamp: json['timestamp'] as int? ?? 0,
    );
  }

}

/// WebSocket client for exchange transaction events. Maintains a single
/// shared socket and broadcasts every event to every subscriber — the
/// cubit filters by transaction id. Reconnects with bounded exponential
/// backoff on disconnect; the backoff is NOT business polling, it's
/// standard socket-recovery practice.
class ExchangeWebSocketService {
  final _eventController = StreamController<ExchangeWsEvent>.broadcast();
  WebSocketChannel? _channel;
  StreamSubscription? _channelSub;
  bool _connecting = false;
  bool _manuallyClosed = false;
  int _reconnectAttempt = 0;
  Timer? _reconnectTimer;
  String? _userId;

  /// Stream of every exchange event the server broadcasts for this
  /// user. Cubits filter by transaction id. Broadcast so multiple
  /// cubits (e.g., home + processing screen mounted concurrently) can
  /// share the single socket.
  Stream<ExchangeWsEvent> get events => _eventController.stream;

  /// Reach for a connection if we don't already have one. Idempotent —
  /// safe to call from every initState. Pulls user id + bearer token
  /// from secure storage so the cubit doesn't need to.
  Future<void> ensureConnected() async {
    if (_channel != null || _connecting) return;
    _connecting = true;
    _manuallyClosed = false;
    try {
      await _connect();
    } finally {
      _connecting = false;
    }
  }

  /// Close the socket. Call from app logout / account switch — NOT from
  /// the processing screen's dispose (other subscribers may still need
  /// the stream).
  Future<void> disconnect() async {
    _manuallyClosed = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _channelSub?.cancel();
    _channelSub = null;
    _channel?.sink.close();
    _channel = null;
  }

  Future<void> _connect() async {
    final storage = serviceLocator<SecureStorageService>();
    final token = await storage.getAccessToken();
    final userId = await storage.getUserId();
    if (token == null || token.isEmpty || userId == null || userId.isEmpty) {
      // Not signed in — can't subscribe. Silent no-op; cubit doesn't
      // error, it just falls back to RPC-via-pull-to-refresh.
      return;
    }
    _userId = userId;

    // Android emulator uses 10.0.2.2 to reach the host's
    // financial-gateway :8016. Web/desktop override to 127.0.0.1.
    final host = kIsWeb ? '127.0.0.1' : '10.0.2.2';
    final uri = Uri.parse(
      'ws://$host:8016/ws/exchange'
      '?user_id=${Uri.encodeComponent(userId)}'
      '&access_token=${Uri.encodeComponent(token)}',
    );

    try {
      _channel = kIsWeb
          ? WebSocketChannel.connect(uri)
          : IOWebSocketChannel.connect(uri.toString());
      _reconnectAttempt = 0;
      _channelSub = _channel!.stream.listen(
        _onMessage,
        onError: (_) => _scheduleReconnect(),
        onDone: _scheduleReconnect,
        cancelOnError: false,
      );
    } catch (_) {
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic raw) {
    try {
      final decoded = raw is String ? jsonDecode(raw) : raw;
      if (decoded is! Map<String, dynamic>) return;
      final event = ExchangeWsEvent.fromJson(decoded);
      // "connected" welcome event — skip, not relevant to cubits.
      if (event.eventType == 'connected') return;
      _eventController.add(event);
    } catch (_) {
      // Malformed event — ignore, don't tear the socket down.
    }
  }

  void _scheduleReconnect() {
    _channel = null;
    _channelSub = null;
    if (_manuallyClosed || _userId == null) return;
    _reconnectAttempt = (_reconnectAttempt + 1).clamp(1, 5);
    // Bounded exponential backoff: 1s, 2s, 4s, 8s, 16s cap. This is NOT
    // application-level polling — it's the defensive reconnect policy
    // every long-lived socket needs. Without it, a down gateway would
    // spin the client into a tight reconnect loop.
    final delay = Duration(seconds: 1 << (_reconnectAttempt - 1));
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      _connecting = false;
      _connect();
    });
  }
}
