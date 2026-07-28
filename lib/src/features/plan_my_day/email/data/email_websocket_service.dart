import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// One realtime email event pushed from the backend
/// (`{type, data}` on the `/ws/planning/email` socket). Types:
/// `email.received`, `email.reply_pending`, `email.reply_sent`, `plan.updated`.
class EmailWsEvent {
  final String type;
  final Map<String, dynamic> data;
  const EmailWsEvent(this.type, this.data);
}

/// Connects to the lifestyle-gateway Plan My Day email WebSocket and surfaces
/// realtime events so the inbox/drafts refresh without polling. Mirrors the
/// P2P chat WS service (Bearer on mobile, token subprotocol on web, backoff
/// reconnect). Best-effort: failures never break the UI (it falls back to the
/// manual Sync / refresh actions).
class EmailWebSocketService {
  final FlutterSecureStorage _storage;
  EmailWebSocketService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  WebSocketChannel? _channel;
  final _events = StreamController<EmailWsEvent>.broadcast();
  Timer? _reconnectTimer;
  bool _manualDisconnect = false;
  bool _connected = false;
  int _attempts = 0;
  static const int _maxAttempts = 8;

  Stream<EmailWsEvent> get events => _events.stream;
  bool get isConnected => _connected;

  Future<void> connect() async {
    if (_connected || _channel != null) return;
    _manualDisconnect = false;

    String? token;
    try {
      token = await _storage.read(key: 'access_token');
    } catch (_) {
      token = null;
    }
    if (token == null || token.isEmpty) return;

    final base = dotenv.env['LIFESTYLE_GATEWAY_URL'] ?? '';
    if (base.isEmpty) return;
    Uri httpUri;
    try {
      httpUri = Uri.parse(base);
    } catch (_) {
      return;
    }
    final wsScheme = httpUri.scheme == 'https' ? 'wss' : 'ws';
    final wsUri = Uri(
      scheme: wsScheme,
      host: httpUri.host,
      port: httpUri.hasPort ? httpUri.port : null,
      path: '/ws/planning/email',
    );

    try {
      if (kIsWeb) {
        _channel = WebSocketChannel.connect(wsUri, protocols: ['token', token]);
      } else {
        _channel = IOWebSocketChannel.connect(
          wsUri,
          headers: {'Authorization': 'Bearer $token'},
        );
      }
      _channel!.stream.listen(_onMessage, onError: (_) => _onDone(), onDone: _onDone, cancelOnError: false);
      _connected = true;
      _attempts = 0;
    } catch (_) {
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic message) {
    try {
      final decoded = jsonDecode(message as String);
      if (decoded is Map<String, dynamic>) {
        final type = decoded['type'] as String? ?? '';
        if (type.isEmpty || type == 'connected' || type == 'pong') return;
        final data = (decoded['data'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
        _events.add(EmailWsEvent(type, data));
      }
    } catch (_) {/* ignore malformed frames */}
  }

  void _onDone() {
    _connected = false;
    _channel = null;
    if (!_manualDisconnect) _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_manualDisconnect || _attempts >= _maxAttempts) return;
    _attempts++;
    final delay = Duration(seconds: (2 * _attempts).clamp(2, 30));
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, connect);
  }

  Future<void> disconnect() async {
    _manualDisconnect = true;
    _reconnectTimer?.cancel();
    _connected = false;
    try {
      await _channel?.sink.close();
    } catch (_) {}
    _channel = null;
  }

  void dispose() {
    disconnect();
    _events.close();
  }
}
