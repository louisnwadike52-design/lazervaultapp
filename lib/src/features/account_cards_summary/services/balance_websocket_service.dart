import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/utils/api_headers.dart';
part 'balance_websocket_service_widgets.dart';


/// WebSocket service for real-time balance updates
/// Supports both WebSocket and SSE (Server-Sent Events) for broad compatibility
class BalanceWebSocketService {
  WebSocketChannel? _channel;
  http.Client? _httpClient;
  StreamSubscription? _sseSubscription;
  final _eventController = StreamController<BalanceUpdateEvent>.broadcast();
  final _lockFundEventController =
      StreamController<LockFundLifecycleEvent>.broadcast();
  // Dedicated insurance streams. Cubits subscribe here instead of
  // filtering balance updates by event_type prefix; keeps the call
  // sites tidy and the wire format isolated from consumers.
  final _insurancePurchaseEventController =
      StreamController<InsurancePurchaseEvent>.broadcast();
  final _insuranceClaimEventController =
      StreamController<InsuranceClaimEvent>.broadcast();
  final _connectionController = StreamController<WebSocketConnectionState>.broadcast();
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _useSSE = false; // Flag to track if using SSE instead of WebSocket
  final SecureStorageService _secureStorage;
  final AccountManager? _accountManager;

  BalanceWebSocketService({
    required SecureStorageService secureStorage,
    AccountManager? accountManager,
  })  : _secureStorage = secureStorage,
        _accountManager = accountManager;

  /// Stream of balance update events
  Stream<BalanceUpdateEvent> get balanceUpdates => _eventController.stream;

  /// Stream of PiggyVault lock-fund lifecycle events
  /// (created / matured / renewed / renewal_skipped).
  Stream<LockFundLifecycleEvent> get lockFundEvents =>
      _lockFundEventController.stream;

  /// Stream of insurance purchase / renewal lifecycle events. Consumed
  /// by `InsuranceCubit` to refresh the policy list when a purchase
  /// completes or a renewal lands without waiting for a pull-to-refresh.
  Stream<InsurancePurchaseEvent> get insurancePurchaseEvents =>
      _insurancePurchaseEventController.stream;

  /// Stream of insurance claim status events. Consumed by
  /// `MyClaimsCubit` to refresh the claims list when the reconciler
  /// advances a claim to a terminal state on MyCover's side.
  Stream<InsuranceClaimEvent> get insuranceClaimEvents =>
      _insuranceClaimEventController.stream;

  /// Stream of connection state changes
  Stream<WebSocketConnectionState> get connectionState => _connectionController.stream;

  /// Check if currently connected
  bool get isConnected => _isConnected;

  /// Build WebSocket headers with auth and metadata
  Future<Map<String, String>> _buildHeaders(String accessToken) async {
    final headers = await ApiHeaders.buildWebSocketHeaders(
      secureStorage: _secureStorage,
      accountManager: _accountManager,
    );
    // Override with explicit access token
    headers['Authorization'] = 'Bearer $accessToken';
    return headers;
  }

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
  /// Resolves the balance WS URL the cubit will dial. Precedence:
  ///   1. `WS_BALANCE_HOST` / `WS_BALANCE_PORT` dotenv overrides (legacy
  ///      local-dev workflow).
  ///   2. `EndpointRegistry.wsBalance` — the admin-managed
  ///      `wss://api.lazervault.app/ws/balance` URL the cubit cached on
  ///      first launch.
  ///   3. Hard-coded fallback (`wss://api.lazervault.app/ws/balance/ws/balance`).
  ///
  /// [scheme] = 'ws' for WebSocket, 'http' for SSE fallback. The
  /// registry URL's scheme (`wss://` for production) is mapped to its
  /// http(s) sibling when [scheme] is 'http'.
  Uri _resolveBalanceWsUri(String countryCode, {required String scheme}) {
    final overrideHost = dotenv.env['WS_BALANCE_HOST'];
    final overridePort = dotenv.env['WS_BALANCE_PORT'];
    if (overrideHost != null && overrideHost.isNotEmpty) {
      final port = int.tryParse(overridePort ?? '8095') ?? 8095;
      // Cloudflare's edge speaks TLS on 443 — `ws://host:443` returns HTTP
      // 400 ("not upgraded to websocket"). Promote to the secure scheme
      // when the override port is 443.
      final effective = port == 443
          ? (scheme == 'ws' ? 'wss' : 'https')
          : scheme;
      return Uri(
        scheme: effective,
        host: overrideHost,
        port: port == 443 ? null : port, // omit default port for tidy URL
        path: '/ws/balance',
        queryParameters: {'country_code': countryCode},
      );
    }
    final registryUrl = endpointRegistry.wsBalance;
    final parsed = Uri.parse(registryUrl);
    final effectiveScheme = scheme == 'ws'
        ? (parsed.scheme == 'wss' ? 'wss' : 'ws')
        : (parsed.scheme == 'wss' ? 'https' : 'http');
    return Uri(
      scheme: effectiveScheme,
      host: parsed.host,
      port: parsed.hasPort ? parsed.port : null,
      path: parsed.path.isEmpty ? '/ws/balance' : parsed.path,
      queryParameters: {'country_code': countryCode},
    );
  }

  Future<void> _connectWebSocket(String userId, String countryCode, String accessToken) async {
    // The balance WS URL now comes from the EndpointRegistry (cached on
    // first launch, refreshed in the background on every launch). dotenv
    // overrides still win when set so local dev pointing at
    // wss://api.lazervault.app/ws/balance/ws/balance keeps working without rewiring.
    final wsUrl = _resolveBalanceWsUri(countryCode, scheme: 'ws');

    print('BalanceWebSocketService: Connecting via WebSocket to $wsUrl');

    // Build headers with all required metadata
    final headers = await _buildHeaders(accessToken);

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
        headers: headers,
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
    // SSE shares the WS endpoint host; only the scheme differs (http vs ws/wss).
    // The EndpointRegistry's wsBalance URL is converted to its http(s) sibling
    // by [_resolveBalanceWsUri] so a single source of truth covers both
    // transports.
    final sseUrl = _resolveBalanceWsUri(countryCode, scheme: 'http').replace(
      queryParameters: {
        'country_code': countryCode,
        // SECURITY: Token moved to Authorization header (not logged in URLs)
      },
    );

    print('BalanceWebSocketService: Connecting via SSE to $sseUrl');

    _httpClient = http.Client();
    _useSSE = true;

    // Build headers with all required metadata
    final headers = await _buildHeaders(accessToken);

    // Make streaming HTTP request for SSE with Authorization header
    final request = http.Request('GET', sseUrl);
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cache-Control'] = 'no-cache';
    request.headers.addAll(headers);

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
          // Fan out to the insurance-specific streams when the wire
          // event_type matches. Cubits subscribe to those rather than
          // filtering balance updates by prefix.
          _maybeRouteInsuranceEvent(event);
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

      // Handle PiggyVault lock-fund lifecycle events. Pushed by
      // accounts-service from CreateLockFunds and the auto-renew
      // worker; consumed by LockFundsCubit to refresh the list.
      if (messageType == 'lock_fund_lifecycle') {
        final payload = data['payload'] as Map<String, dynamic>?;
        if (payload != null) {
          final event = LockFundLifecycleEvent.fromJson(payload);
          print('BalanceWebSocketService: Lock-fund lifecycle - $event');
          _lockFundEventController.add(event);
        }
        return;
      }

      // Legacy format support: direct event_type in message
      final eventType = data['event_type'] as String?;
      if (eventType == 'transfer' ||
          eventType == 'transfer_in' ||
          eventType == 'transfer_out' ||
          eventType == 'deposit' ||
          eventType == 'withdrawal' ||
          eventType == 'tagpay_tag_paid' ||
          eventType == 'tagpay_tag_received' ||
          eventType == 'tagpay_send' ||
          eventType == 'tagpay_request_accepted' ||
          eventType == 'exchange_out' ||
          eventType == 'exchange_in' ||
          eventType == 'giftcard_purchase' ||
          eventType == 'giftcard_redeem' ||
          eventType == 'giftcard_refund' ||
          eventType == 'giftcard_sell') {
        final event = BalanceUpdateEvent.fromJson(data);
        print('BalanceWebSocketService: Received balance update (legacy) - $event');
        _eventController.add(event);
      }
    } catch (e) {
      print('BalanceWebSocketService: Error parsing message - $e');
    }
  }

  /// Test-only hook: inject a wire-shaped payload as if it had arrived
  /// over the socket. Used by `test/features/insurance/insurance_cubit_ws_test.dart`
  /// to exercise the cubit subscriptions without standing up a real
  /// ws-balance-service. Mirrors the routing inside [_handleMessage] but
  /// skips the JSON decode + envelope check.
  void testInjectBalanceEvent(Map<String, dynamic> payload) {
    final event = BalanceUpdateEvent.fromJson(payload);
    _eventController.add(event);
    _maybeRouteInsuranceEvent(event);
  }

  /// Fan a parsed `BalanceUpdateEvent` out to the insurance-specific
  /// streams when the wire `event_type` matches. Safe to call for any
  /// event — the routing is keyed off the string prefix and unknown
  /// types are simply ignored.
  void _maybeRouteInsuranceEvent(BalanceUpdateEvent event) {
    final t = event.eventType;
    if (t.startsWith('insurance_purchase_') ||
        t == 'insurance_policy_renewed') {
      _insurancePurchaseEventController
          .add(InsurancePurchaseEvent.fromBalanceEvent(event));
    } else if (t == 'insurance_claim_status_changed') {
      _insuranceClaimEventController
          .add(InsuranceClaimEvent.fromBalanceEvent(event));
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
    _lockFundEventController.close();
    _insurancePurchaseEventController.close();
    _insuranceClaimEventController.close();
    _connectionController.close();
  }

  /// Check if using SSE connection
  bool get isUsingSSE => _useSSE;
}
