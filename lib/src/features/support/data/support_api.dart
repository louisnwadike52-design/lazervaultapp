import 'dart:async';
import 'package:lazervault/core/services/access_token_shape.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import 'support_models.dart';

/// Thrown when the user is already at the maximum number of open tickets and
/// tries to create another (support-service returns HTTP 409). Carries the cap
/// and the user's current open count so the UI can explain the block.
/// Raised when a locked-out customer already has a support request open.
///
/// NOT AN ERROR TO APOLOGISE FOR: the right answer is "we already have this,
/// somebody will reply", which is reassuring rather than a failure.
class SupportPreAuthOpenException implements Exception {
  const SupportPreAuthOpenException(this.message);
  final String message;
  @override
  String toString() => message;
}

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
/// The operator-tunable support settings, as the app sees them.
///
/// Both fields are null when unset or unreachable, and every consumer must
/// render correctly without them — see [SupportApi.supportSettings].
class SupportSettings {
  const SupportSettings({this.responseSlaText, this.contactEmail});

  /// The reply-time promise shown on support surfaces.
  final String? responseSlaText;

  /// The PUBLIC address customers are told to write to, e.g. on a KYC failure
  /// where the in-app ticket is not enough. NEVER hardcoded in the app: it is
  /// a commitment that somebody reads that inbox, and the support team changes
  /// it without waiting on an app-store review.
  final String? contactEmail;
}

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
    final core =
        endpointRegistry.httpCore; // e.g. https://dev.lazervault.app/api/v1
    const suffix = '/api/v1';
    final origin = core.endsWith(suffix)
        ? core.substring(0, core.length - suffix.length)
        : core;
    return Uri.parse('$origin$path');
  }

  // ── Raw verbs, for the support DESK ──────────────────────────────────────
  //
  // The desk calls support-service's ADMIN ticket routes. Those share this
  // client's origin resolution, timeout and auth header exactly; what differs
  // is only the path. Exposing the verbs is how the desk reuses all of that
  // without a second copy of _uri() — and a second copy is how a dev-port
  // override comes to apply to one support surface and not the other.
  //
  // Deliberately thin: no status interpretation here, because the desk's
  // reaction to a 403 ("you are no longer support") is not the customer
  // surface's reaction to one.
  Future<http.Response> rawGet(String path,
          {Map<String, String>? query}) async =>
      _send(() async => http.get(
            query == null || query.isEmpty
                ? _uri(path)
                : _uri(path).replace(queryParameters: query),
            headers: await _headers(),
          ));

  Future<http.Response> rawPost(String path, String body) async =>
      _send(() async => http.post(_uri(path),
          headers: await _headers(), body: body.isEmpty ? null : body));

  Future<http.Response> rawPatch(String path, String body) async =>
      _send(() async => http.patch(_uri(path),
          headers: await _headers(), body: body.isEmpty ? null : body));

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) ...authHeader(token),
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

  /// Raises a support request for somebody who CANNOT SIGN IN.
  ///
  /// The one support call that carries no token, because the customer it
  /// exists for has none: stuck at the passcode screen, on an email they
  /// cannot verify, in a resumption state that will not resume. Every other
  /// route here would answer 401 — the platform refusing to hear from exactly
  /// the person it has locked out.
  ///
  /// IT IS NOT A LOGIN, AND IT PROVES NOTHING. The address is simply what the
  /// device had cached; support files these on a separate, visibly unverified
  /// channel and still verifies identity before touching an account.
  ///
  /// Throws [SupportPreAuthOpenException] when this address already has a
  /// request open — which is not a failure, and the caller should say so.
  Future<String> createPreAuthTicket({
    required String email,
    required String message,
    String subject = '',
    String context = '',
  }) async {
    final res = await _send(() async => http.post(
          _uri('/api/v1/support/pre-auth/tickets'),
          // NO AUTH HEADER, deliberately — not even an expired one. _headers()
          // would attach whatever stale token is lying in storage, and a
          // rejected token on an unauthenticated route is a confusing 401
          // instead of a filed ticket.
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'subject': subject,
            'message': message,
            'context': context,
          }),
        ));
    if (res.statusCode == 409) {
      String msg = 'You already have a support request open about this.';
      try {
        final b = jsonDecode(res.body);
        if (b is Map && b['error'] is String) msg = b['error'] as String;
      } catch (_) {}
      throw SupportPreAuthOpenException(msg);
    }
    _ensureOk(res);
    final body = jsonDecode(res.body);
    return (body is Map && body['ticket_number'] is String)
        ? body['ticket_number'] as String
        : '';
  }

  /// The reply-time promise shown on every support surface.
  ///
  /// Served by support-service from the same row the admin console writes,
  /// so the wording the team commits to is exactly the wording the customer
  /// reads. Deliberately NOT a constant in the app: it is a promise the
  /// support team has to keep, and they must be able to change it over a
  /// holiday or during an incident without waiting on an app-store review.
  ///
  /// Returns null on any failure — the notice is reassurance, not content,
  /// and a support screen must never fail to open because a banner could
  /// not be fetched.
  Future<String?> responseSlaText() async =>
      (await supportSettings()).responseSlaText;

  /// The operator-tunable support settings the app renders.
  ///
  /// ONE CALL FOR BOTH VALUES. responseSlaText() used to fetch this payload and
  /// throw away everything except one field, so adding the contact address
  /// would have meant a second request to the same endpoint on the same screen.
  ///
  /// Never throws, and every field is nullable: these are reassurance and a
  /// fallback route, not content. A support surface must open even when the
  /// settings call fails — a customer who cannot reach support is exactly who
  /// this screen exists for.
  Future<SupportSettings> supportSettings() async {
    try {
      final res = await _send(() async => http.get(
          _uri('/api/v1/support/settings'),
          headers: await _headers()));
      if (res.statusCode != 200) return const SupportSettings();
      final body = jsonDecode(res.body);
      if (body is! Map) return const SupportSettings();
      String? pick(String key) {
        final v = body[key];
        return (v is String && v.trim().isNotEmpty) ? v.trim() : null;
      }

      return SupportSettings(
        responseSlaText: pick('response_sla_text'),
        // "" from the server is MEANINGFUL: no public address is configured,
        // and the app must then omit the line rather than invent one. pick()
        // turns it into null, which every caller already treats as "hide".
        contactEmail: pick('contact_email'),
      );
    } catch (_) {
      return const SupportSettings();
    }
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

  /// Post a message, optionally with an image.
  ///
  /// [mediaUrl] must be a URL the chat-media upload pipeline issued — the
  /// server rejects anything else, because a support message's attachment is
  /// rendered in the admin dashboard and an arbitrary URL there is a tracking
  /// pixel that fires when an agent opens the ticket.
  Future<SupportMessage> postMessage(
    String ticketId,
    String body, {
    String mediaUrl = '',
  }) async {
    final res = await _send(() async => http.post(
          _uri('/api/v1/support/tickets/$ticketId/messages'),
          headers: await _headers(),
          body: jsonEncode({
            'body': body,
            if (mediaUrl.trim().isNotEmpty) 'media_url': mediaUrl.trim(),
          }),
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

/// The app-rating prompt's calls.
///
/// On SupportApi rather than a client of its own: the endpoints live on
/// support-service, share its base-URL resolution, its auth header and its
/// timeout, and a second client would be three copies of that for four calls.
extension SupportApiAppRating on SupportApi {
  /// Asks the SERVER whether to show the prompt.
  ///
  /// The schedule is entirely server-side — a device-side interval is defeated
  /// by clearing app storage or reinstalling. The app's only input is how old
  /// the account is, which the server cannot see from support-service; a client
  /// that lies about it can at worst be offered a prompt, and cannot touch the
  /// interval, the snooze or the post-rating quiet.
  ///
  /// NEVER THROWS. A rating prompt is the least important thing on the
  /// dashboard: if this fails for any reason the answer is "do not ask".
  Future<bool> shouldAskForRating({required int accountAgeDays}) async {
    try {
      final headers = await _headers();
      final res = await _send(() => http.get(
            _uri('/api/v1/support/app-rating/should-ask'
                '?account_age_days=$accountAgeDays'),
            headers: headers,
          ));
      if (res.statusCode != 200) return false;
      final body = jsonDecode(res.body);
      return body is Map && body['ask'] == true;
    } catch (_) {
      return false;
    }
  }

  /// Records a rating. Returns whether it was stored.
  Future<bool> submitRating({
    required int stars,
    String comment = '',
    String platform = '',
    String appVersion = '',
    bool sentToStore = false,
  }) async {
    try {
      final headers = await _headers();
      final res = await _send(() => http.post(
            _uri('/api/v1/support/app-rating'),
            headers: headers,
            body: jsonEncode({
              'stars': stars,
              'comment': comment,
              'platform': platform,
              'app_version': appVersion,
              'sent_to_store': sentToStore,
            }),
          ));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Records a "not now". Best-effort: if it fails the server's interval still
  /// applies, so the worst case is being asked again at the normal cadence
  /// rather than immediately.
  Future<void> snoozeRating() async {
    try {
      final headers = await _headers();
      await _send(() => http.post(
            _uri('/api/v1/support/app-rating/snooze'),
            headers: headers,
          ));
    } catch (_) {
      // Deliberately silent — see above.
    }
  }
}
