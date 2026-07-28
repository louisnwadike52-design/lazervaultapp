import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import 'support_models.dart';

/// Thrown when the user is already at the maximum number of open tickets and
/// tries to create another (support-service returns HTTP 409). Carries the cap
/// and the user's current open count so the UI can explain the block.
class SupportTicketLimitException implements Exception {
  final int limit;
  final int openCount;
  final String message;
  const SupportTicketLimitException(this.limit, this.openCount, this.message);

  @override
  String toString() => message;
}

/// REST client for the support user surface. Routes through core-gateway on 443
/// (`/api/v1/support/*`) — the app never talks to the support microservice port
/// directly, matching the platform's "frontend always goes through a gateway"
/// rule. Local dev can override with SUPPORT_HOST/SUPPORT_PORT to hit :8030.
class SupportApi {
  final SecureStorageService _storage;
  SupportApi(this._storage);

  /// Every request is time-bounded so an unreachable support-service surfaces a
  /// friendly error instead of hanging the screen on an endless spinner (the
  /// p2p-chat client does the same). Without this the chat screen never leaves
  /// its loading state when :8030 isn't reachable.
  static const _timeout = Duration(seconds: 20);

  /// Runs [req] with a timeout, mapping a stall into a readable message.
  Future<http.Response> _send(Future<http.Response> Function() req) async {
    try {
      return await req().timeout(_timeout);
    } on TimeoutException {
      throw Exception(
          "Support isn't responding. Check your connection and try again.");
    }
  }

  Uri _uri(String path) {
    // Local dev can point straight at the microservice
    // (SUPPORT_HOST=10.0.2.2, SUPPORT_PORT=8030). Every normal build routes
    // through core-gateway on 443 instead.
    final overrideHost = dotenv.env['SUPPORT_HOST'];
    if (overrideHost != null && overrideHost.isNotEmpty) {
      final port = int.tryParse(dotenv.env['SUPPORT_PORT'] ?? '8030') ?? 8030;
      return Uri(
        scheme: port == 443 ? 'https' : 'http',
        host: overrideHost,
        port: port,
        path: path,
      );
    }
    // core-gateway base ends with `/api/v1`; our paths already carry that
    // prefix, so proxy through the gateway origin.
    final core = endpointRegistry.httpCore; // e.g. https://dev.lazervault.app/api/v1
    const suffix = '/api/v1';
    final origin = core.endsWith(suffix)
        ? core.substring(0, core.length - suffix.length)
        : core;
    return Uri.parse('$origin$path');
  }

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  /// Returns (or creates) the user's live-chat thread.
  Future<SupportTicket> getOrCreateChat() async {
    final res = await _send(() async =>
        http.post(_uri('/api/v1/support/chat'), headers: await _headers()));
    _ensureOk(res);
    return SupportTicket.fromJson(jsonDecode(res.body)['ticket']);
  }

  /// Opens a brand-new ticket (always a new ticket ID). Subject + message are
  /// required. Throws [SupportTicketLimitException] when the user is at the
  /// 5-open-ticket cap.
  Future<SupportTicket> createTicket({
    required String subject,
    required String message,
    String category = 'general',
  }) async {
    final res = await _send(() async => http.post(
          _uri('/api/v1/support/tickets'),
          headers: await _headers(),
          body: jsonEncode({
            'category': category,
            'subject': subject,
            'message': message,
          }),
        ));
    if (res.statusCode == 409) {
      Map<String, dynamic> b = const {};
      try {
        final decoded = jsonDecode(res.body);
        if (decoded is Map<String, dynamic>) b = decoded;
      } catch (_) {}
      if (b['code'] == 'TICKET_LIMIT_REACHED') {
        throw SupportTicketLimitException(
          (b['limit'] as num?)?.toInt() ?? 5,
          (b['open_count'] as num?)?.toInt() ?? 0,
          (b['error'] as String?) ??
              "You've reached the maximum number of open tickets.",
        );
      }
    }
    _ensureOk(res);
    return SupportTicket.fromJson(jsonDecode(res.body)['ticket']);
  }

  Future<List<SupportTicket>> listTickets() async {
    final res = await _send(() async =>
        http.get(_uri('/api/v1/support/tickets'), headers: await _headers()));
    _ensureOk(res);
    final list = (jsonDecode(res.body)['tickets'] as List?) ?? [];
    return list.map((e) => SupportTicket.fromJson(e)).toList();
  }

  Future<List<SupportMessage>> getMessages(String ticketId) async {
    final res = await _send(() async => http.get(
        _uri('/api/v1/support/tickets/$ticketId'),
        headers: await _headers()));
    _ensureOk(res);
    final list = (jsonDecode(res.body)['messages'] as List?) ?? [];
    return list.map((e) => SupportMessage.fromJson(e)).toList();
  }

  Future<SupportMessage> postMessage(String ticketId, String body) async {
    final res = await _send(() async => http.post(
          _uri('/api/v1/support/tickets/$ticketId/messages'),
          headers: await _headers(),
          body: jsonEncode({'body': body}),
        ));
    _ensureOk(res);
    return SupportMessage.fromJson(jsonDecode(res.body)['message']);
  }

  Future<void> markRead(String ticketId) async {
    // Fire-and-forget from the UI; never let a stall bubble up as an unhandled
    // async error.
    try {
      await _send(() async => http.post(
          _uri('/api/v1/support/tickets/$ticketId/read'),
          headers: await _headers()));
    } catch (_) {/* best-effort */}
  }

  void _ensureOk(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      String msg = 'Support request failed (${res.statusCode})';
      try {
        final b = jsonDecode(res.body);
        if (b is Map && b['error'] is String) msg = b['error'] as String;
      } catch (_) {}
      throw Exception(msg);
    }
  }
}
