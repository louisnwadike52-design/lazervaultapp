import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/utils/api_headers.dart';

/// True when a transfer status can no longer change.
///
/// Shared so the socket event and the receipt card cannot disagree about
/// when to stop tracking — they did, and each was missing a different
/// terminal state.
bool isTerminalTransferStatus(String status) {
  switch (status.toLowerCase().trim()) {
    case 'completed':
    case 'success':
    case 'successful':
    case 'paid':
    case 'settled':
    case 'failed':
    case 'declined':
    case 'rejected':
    case 'reversed':
    case 'refunded':
    case 'rollback_completed':
    case 'cancelled':
    case 'canceled':
      return true;
    default:
      // pending / processing / scheduled / queued / anything unrecognised.
      // Unknown is treated as NON-terminal on purpose: keep watching rather
      // than freeze a card on a status nobody has taught us about yet.
      return false;
  }
}

/// True when a receipt card's transaction type has a status that
/// `GetTransferStatus(reference)` can actually resolve.
///
/// The first cut tested `transaction_type.contains('transfer')`, which quietly
/// excluded every TagPay and split-bill receipt: those emit `tagpay_pay`,
/// `tagpay_send`, `tagpay_accept` and `split_bill_pay`. Their saga status is
/// NOT always terminal — commerce_agent resolves it from the payment/txn row
/// and it can come back `pending`, `processing` or `manual_review` — so those
/// cards could sit on a stale status forever.
///
/// They resolve fine: core-payments' GetTransferStatus handler falls back to
/// `payments WHERE reference = ?`, and TagPay writes a payments row keyed on
/// its own `TPTAG-…` reference (the handler's own comment notes split-bill
/// payouts land there too).
///
/// An allowlist rather than a substring test, because the types NOT here —
/// crypto, insurance, exchange — carry references this endpoint cannot
/// resolve, and polling them would be 20 guaranteed misses per card.
bool isTrackableReceiptType(String transactionType) {
  final t = transactionType.toLowerCase().trim();
  if (t.isEmpty) return true; // unlabelled: let the reference decide
  if (t.contains('transfer')) return true; // transfer, batch_transfer, …
  return t.startsWith('tagpay') || t == 'split_bill_pay';
}

/// Transfer status event received from WebSocket.
///
/// [reference] is the field that makes this feed usable to anything that has
/// already drawn the transfer: it is the platform-canonical id chat and voice
/// receipt cards are keyed by, so it is how an update finds the card on
/// screen. The gateway did not send it (and could not — its Kafka consumer
/// failed to decode the publisher's payload at all), which is why nothing ever
/// subscribed and the receipt SCREEN polls instead.
class TransferStatusEvent {
  final String transferId;
  final String reference;
  final String userId;
  final String status;
  final double? amount;
  final String? currency;
  final String? recipient;
  final String? errorMessage;
  final String eventType;
  final int timestamp;

  TransferStatusEvent({
    required this.transferId,
    this.reference = '',
    required this.userId,
    required this.status,
    this.amount,
    this.currency,
    this.recipient,
    this.errorMessage,
    required this.eventType,
    required this.timestamp,
  });

  /// Tolerant by design. Every field here used to be a hard cast, so one
  /// absent key threw and took the whole stream's error handler with it —
  /// unacceptable for a feed whose only job is to make a card more accurate.
  /// A malformed event should degrade to "no update", never to a crash.
  factory TransferStatusEvent.fromJson(Map<String, dynamic> json) {
    String str(String k) {
      final v = json[k];
      return v == null ? '' : v.toString();
    }

    final rawAmount = json['amount'];
    return TransferStatusEvent(
      // The gateway sends both; payment_id is the authoritative id and
      // transfer_id mirrors it.
      transferId: str('transfer_id').isNotEmpty
          ? str('transfer_id')
          : str('payment_id'),
      reference: str('reference'),
      userId: str('user_id'),
      status: str('status'),
      amount: rawAmount is num ? rawAmount.toDouble() : null,
      currency: str('currency').isEmpty ? null : str('currency'),
      recipient: str('recipient').isEmpty ? null : str('recipient'),
      errorMessage: str('error_message').isEmpty ? null : str('error_message'),
      eventType: str('event_type'),
      timestamp: json['timestamp'] is int ? json['timestamp'] as int : 0,
    );
  }

  /// True once the transfer can no longer change — the point at which a
  /// subscriber can stop listening for this reference.
  ///
  /// The list mirrors what core-payments actually PUBLISHES, not a guess:
  /// internal/models/payment.go declares pending / processing / completed /
  /// failed / reversed / scheduled, and the two rollback paths publish
  /// `refunded` (transfer_rollback_refund.go) and `rollback_completed`
  /// (admin_service.go). Those last two were the ones missing — a refunded
  /// transfer kept a card listening for a change that could never come.
  /// `scheduled` is deliberately NOT terminal: it has not run yet.
  bool get isTerminal => isTerminalTransferStatus(status);

  @override
  String toString() {
    return 'TransferStatusEvent(transferId: $transferId, reference: $reference, '
        'userId: $userId, status: $status, eventType: $eventType)';
  }
}

/// Connection states for WebSocket
enum TransferWebSocketConnectionState {
  disconnected,
  connected,
  error,
}

/// WebSocket service for real-time transfer status updates
/// Supports both WebSocket and SSE (Server-Sent Events) for broad compatibility
class TransferWebSocketService {
  WebSocketChannel? _channel;
  http.Client? _httpClient;
  StreamSubscription? _sseSubscription;
  final _eventController = StreamController<TransferStatusEvent>.broadcast();

  // --- Reconnect / identity lifecycle -------------------------------------
  //
  // This service was never registered in DI, so none of this was exercised:
  // a dropped socket stayed dropped for the rest of the session, and a
  // pending receipt card waiting on it simply never heard back. Same shape as
  // BalanceWebSocketService — capped exponential backoff with jitter, and a
  // reconnect signal so subscribers can re-sync the state they missed while
  // the socket was down (events are NOT replayed).
  Future<void>? _connecting;
  String? _lastUserId;
  String? _lastAccessToken;
  bool _shouldReconnect = false;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 12;
  static const Duration _maxReconnectDelay = Duration(seconds: 30);

  final _reconnectedController = StreamController<void>.broadcast();

  /// Fires after a successful reconnect. A subscriber that cares about state
  /// rather than events should refetch here: anything that happened while the
  /// socket was down was missed, not queued.
  Stream<void> get onReconnected => _reconnectedController.stream;
  final _connectionController =
      StreamController<TransferWebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _useSSE = false;
  final SecureStorageService _secureStorage;

  TransferWebSocketService({
    required SecureStorageService secureStorage,
  }) : _secureStorage = secureStorage;

  /// Stream of transfer status events
  Stream<TransferStatusEvent> get transferUpdates => _eventController.stream;

  /// Stream of connection state changes
  Stream<TransferWebSocketConnectionState> get connectionState =>
      _connectionController.stream;

  /// Check if currently connected
  bool get isConnected => _isConnected;

  /// Build WebSocket headers with auth and metadata
  Future<Map<String, String>> _buildHeaders(String accessToken) async {
    final headers = await ApiHeaders.buildWebSocketHeaders(
      secureStorage: _secureStorage,
    );
    // Override with explicit access token
    headers['Authorization'] = 'Bearer $accessToken';
    return headers;
  }

  /// Connect to the real-time updates server
  /// Attempts WebSocket first, falls back to SSE if WebSocket fails
  /// Single-flight connect.
  ///
  /// Two receipt cards mounting in the same frame both saw `_isConnected ==
  /// false` and both opened a socket; one leaked, pinging forever. The
  /// in-flight future collapses concurrent callers onto one attempt, and the
  /// identity check below means a user switch re-authenticates instead of
  /// quietly serving the previous user's feed.
  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    if (_isConnected && _lastUserId == userId) return;

    // A different user on the same process must not inherit the open socket.
    if (_isConnected && _lastUserId != userId) {
      print('TransferWebSocketService: user changed, reconnecting');
      _shouldReconnect = false;
      disconnect();
    }

    final inFlight = _connecting;
    if (inFlight != null) return inFlight;

    final completer = Completer<void>();
    _connecting = completer.future;
    _lastUserId = userId;
    _lastAccessToken = accessToken;
    _shouldReconnect = true;
    try {
      await _doConnect(userId, accessToken);
      _reconnectAttempts = 0;
    } finally {
      _connecting = null;
      if (!completer.isCompleted) completer.complete();
    }
  }

  Future<void> _doConnect(String userId, String accessToken) async {
    try {
      await _connectWebSocket(userId, accessToken);
    } catch (e) {
      print('TransferWebSocketService: WebSocket failed, trying SSE - $e');
      try {
        await _connectSSE(userId, accessToken);
      } catch (sseError) {
        print('TransferWebSocketService: SSE also failed - $sseError');
        _connectionController.add(TransferWebSocketConnectionState.error);
        rethrow;
      }
    }
  }

  /// Connect using WebSocket protocol
  /// Uses transfer-gateway **HTTP** port (default 8084), not gRPC 50076 — see PORTS_CONFIG.json / service-discovery.sh.
  Future<void> _connectWebSocket(String userId, String accessToken) async {
    final ep = endpointRegistry.resolveServiceHostPort(
      overrideHost:
          dotenv.env['TRANSFER_WS_HOST'] ?? dotenv.env['TRANSFER_GRPC_HOST'],
      overridePort: int.tryParse(dotenv.env['TRANSFER_WS_PORT'] ?? ''),
      devPort: 8084,
    );
    final wsHost = ep.host;
    final wsPort = ep.port;
    // Tunnel termination is TLS — when the env points at the public host
    // (port 443) we must speak wss, not plain ws. On the loopback dev
    // setup the gateway HTTP port stays clear-text ws as before.
    final tlsTunnel = wsPort == 443;

    final wsUrl = Uri(
      scheme: tlsTunnel ? 'wss' : 'ws',
      host: wsHost,
      port: tlsTunnel ? null : wsPort,
      path: '/ws/transfer',
      queryParameters: {
        'user_id': userId,
        'access_token': accessToken,
      },
    );

    print('TransferWebSocketService: Connecting via WebSocket to $wsUrl');

    if (kIsWeb) {
      _channel = WebSocketChannel.connect(
        wsUrl,
        protocols: ['token', accessToken],
      );
    } else {
      final headers = await _buildHeaders(accessToken);
      _channel = IOWebSocketChannel.connect(
        wsUrl,
        headers: headers,
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
    _connectionController.add(TransferWebSocketConnectionState.connected);
    _startPingTimer();

    print('TransferWebSocketService: WebSocket connected successfully');
  }

  /// Connect using Server-Sent Events (SSE) - fallback (same host/port as WebSocket: transfer-gateway HTTP).
  Future<void> _connectSSE(String userId, String accessToken) async {
    final ep = endpointRegistry.resolveServiceHostPort(
      overrideHost:
          dotenv.env['TRANSFER_WS_HOST'] ?? dotenv.env['TRANSFER_GRPC_HOST'],
      overridePort: int.tryParse(dotenv.env['TRANSFER_WS_PORT'] ?? ''),
      devPort: 8084,
    );
    final wsHost = ep.host;
    final wsPort = ep.port;
    final tlsTunnel = wsPort == 443;

    final sseUrl = Uri(
      scheme: tlsTunnel ? 'https' : 'http',
      host: wsHost,
      port: tlsTunnel ? null : wsPort,
      path: '/ws/transfer',
      queryParameters: {
        'user_id': userId,
      },
    );

    print('TransferWebSocketService: Connecting via SSE to $sseUrl');

    _httpClient = http.Client();
    _useSSE = true;

    final request = http.Request('GET', sseUrl);
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cache-Control'] = 'no-cache';

    final headers = await _buildHeaders(accessToken);
    request.headers.addAll(headers);

    final response = await _httpClient!.send(request);

    if (response.statusCode != 200) {
      throw Exception(
          'SSE connection failed with status ${response.statusCode}');
    }

    _isConnected = true;
    _connectionController.add(TransferWebSocketConnectionState.connected);

    _sseSubscription = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          _handleSSELine,
          onError: _handleError,
          onDone: _handleDone,
          cancelOnError: false,
        );

    print('TransferWebSocketService: SSE connected successfully');
  }

  /// Handle a line from SSE stream
  void _handleSSELine(String line) {
    if (line.startsWith('data: ')) {
      final jsonStr = line.substring(6);
      _handleMessage(jsonStr);
    }
  }

  /// Disconnect from the server.
  ///
  /// Call on sign-out: the socket is authenticated, and leaving it open means
  /// the next user's process still holds the previous user's feed.
  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;
    if (!_isConnected) return;

    print('TransferWebSocketService: Disconnecting');

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
    _connectionController.add(TransferWebSocketConnectionState.disconnected);

    print('TransferWebSocketService: Disconnected');
  }

  /// Send a ping message (only for WebSocket connections)
  void _sendPing() {
    if (_isConnected && _channel != null && !_useSSE) {
      try {
        _channel!.sink.add(jsonEncode({'type': 'ping'}));
      } catch (e) {
        print('TransferWebSocketService: Error sending ping - $e');
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
        print('TransferWebSocketService: Connection confirmed by server');
        return;
      }

      if (messageType == 'pong') {
        print('TransferWebSocketService: Pong received');
        return;
      }

      if (messageType == 'shutdown') {
        print('TransferWebSocketService: Server shutting down');
        disconnect();
        return;
      }

      if (messageType == 'transfer_status') {
        final payload = data['payload'] as Map<String, dynamic>?;
        if (payload != null) {
          final event = TransferStatusEvent.fromJson(payload);
          print('TransferWebSocketService: Received transfer update - $event');
          _eventController.add(event);
        }
        return;
      }

      // Legacy format support
      final eventType = data['event_type'] as String?;
      if (eventType != null) {
        final event = TransferStatusEvent.fromJson(data);
        print(
            'TransferWebSocketService: Received transfer update (legacy) - $event');
        _eventController.add(event);
      }
    } catch (e) {
      print('TransferWebSocketService: Error parsing message - $e');
    }
  }

  /// Handle WebSocket error
  void _handleError(error) {
    print('TransferWebSocketService: WebSocket error - $error');
    _isConnected = false;
    _connectionController.add(TransferWebSocketConnectionState.error);
    _scheduleReconnect();
  }

  /// Handle WebSocket connection closed
  void _handleDone() {
    print('TransferWebSocketService: Connection closed');
    _isConnected = false;
    _connectionController.add(TransferWebSocketConnectionState.disconnected);
    _scheduleReconnect();
  }

  /// Capped exponential backoff with jitter, so an outage does not produce a
  /// reconnect stampede. Only runs while a deliberate disconnect has not been
  /// requested and we still hold credentials.
  void _scheduleReconnect() {
    if (!_shouldReconnect || _lastUserId == null || _lastAccessToken == null) {
      return;
    }
    if (_reconnectTimer != null || _connecting != null || _isConnected) return;
    _reconnectAttempts++;
    final capped = _reconnectAttempts > _maxReconnectAttempts
        ? _maxReconnectAttempts
        : _reconnectAttempts;
    var seconds = 1 << (capped - 1);
    if (seconds > _maxReconnectDelay.inSeconds) {
      seconds = _maxReconnectDelay.inSeconds;
    }
    final jitterMs = (seconds * 1000 * 0.2).round();
    final delayMs = (seconds * 1000) +
        (DateTime.now().microsecond % (jitterMs == 0 ? 1 : (jitterMs * 2))) -
        jitterMs;
    _reconnectTimer =
        Timer(Duration(milliseconds: delayMs.clamp(500, 60000)), () async {
      _reconnectTimer = null;
      if (!_shouldReconnect || _isConnected) return;
      final uid = _lastUserId, tok = _lastAccessToken;
      if (uid == null || tok == null) return;
      try {
        await _doConnect(uid, tok);
        if (_isConnected) {
          _reconnectAttempts = 0;
          if (!_reconnectedController.isClosed) {
            _reconnectedController.add(null);
          }
        }
      } catch (_) {
        _scheduleReconnect();
      }
    });
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _eventController.close();
    _connectionController.close();
    _reconnectedController.close();
  }

  /// Check if using SSE connection
  bool get isUsingSSE => _useSSE;
}
