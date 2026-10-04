import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/user_switch_purge.dart';

/// One row in the admin's searchable user directory.
@immutable
class ImpersonationCandidate {
  const ImpersonationCandidate({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.highestRole,
    required this.selectable,
    this.username,
    this.phone = '',
    this.accountStatus = 'active',
    this.kycTier = 0,
    this.lastLoginAt,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? username;
  final String phone;
  final String accountStatus;
  final int kycTier;

  /// The target's own highest role, so the UI can say WHY a row is disabled.
  final String highestRole;

  /// Computed server-side with exactly the rule the mint refuses on: not
  /// yourself, and strictly below your own tier. Trusting the server here
  /// rather than re-deriving it on the client means the list can never offer a
  /// row the mint would then reject.
  final bool selectable;

  final DateTime? lastLoginAt;

  String get displayName {
    final n = '$firstName $lastName'.trim();
    if (n.isNotEmpty) return n;
    if (username != null && username!.isNotEmpty) return '@${username!}';
    return email.isNotEmpty ? email : id;
  }

  /// Why this row cannot be opened. Empty when it can.
  String get blockedReason {
    if (selectable) return '';
    if (highestRole.isNotEmpty && highestRole != 'user') {
      return 'You cannot view an account with equal or higher privileges';
    }
    return 'This is your own account';
  }

  factory ImpersonationCandidate.fromJson(Map<String, dynamic> j) {
    DateTime? last;
    final raw = j['last_login_at'];
    if (raw is String && raw.isNotEmpty) last = DateTime.tryParse(raw);
    return ImpersonationCandidate(
      id: (j['id'] ?? '').toString(),
      email: (j['email'] ?? '').toString(),
      firstName: (j['first_name'] ?? '').toString(),
      lastName: (j['last_name'] ?? '').toString(),
      username: (j['username'] as String?)?.trim().isEmpty ?? true
          ? null
          : (j['username'] as String).trim(),
      phone: (j['phone'] ?? '').toString(),
      accountStatus: (j['account_status'] ?? 'active').toString(),
      kycTier: (j['kyc_tier'] is num) ? (j['kyc_tier'] as num).toInt() : 0,
      highestRole: (j['highest_role'] ?? '').toString(),
      selectable: j['selectable'] == true,
      lastLoginAt: last,
    );
  }
}

/// Raised with a message meant to be shown to the admin as-is.
///
/// The server's refusals are written for a person to read ("cannot impersonate
/// an account with equal or higher privileges", "the view-as-user privilege has
/// been revoked for your account"), so they are carried through rather than
/// replaced with a generic failure that throws away the only useful part.
class ImpersonationException implements Exception {
  const ImpersonationException(this.message, {this.code});
  final String message;
  final String? code;
  @override
  String toString() => message;
}

/// Talks to admin-gateway's /api/v1/admin/impersonation/* routes.
class ImpersonationService {
  ImpersonationService(this._storage, {http.Client? client})
      : _client = client ?? http.Client();

  final SecureStorageService _storage;
  final http.Client _client;

  String get _base => endpointRegistry.httpAdmin;

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getAccessToken();
    return {
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  /// Never let a server error reach the UI raw.
  ///
  /// The platform rule is that infrastructure failures read as "server not
  /// reachable" rather than leaking an allow-list or SQL error. But a
  /// DELIBERATE refusal carries a sentence written for the admin, and that one
  /// is shown verbatim — the two are told apart by status code, not by
  /// inspecting the text.
  Never _fail(int status, String body) {
    String message = 'Something went wrong. Please try again.';
    String? code;
    if (status == 403 || status == 400 || status == 404 || status == 409) {
      try {
        final decoded = jsonDecode(body);
        if (decoded is Map) {
          final e = decoded['error'] ?? decoded['message'];
          if (e is String && e.trim().isNotEmpty) message = e.trim();
          final c = decoded['code'];
          if (c is String && c.trim().isNotEmpty) code = c.trim();
        }
      } catch (_) {
        // A non-JSON body on a 4xx is not something to show a person.
      }
    } else if (status == 401) {
      message = 'Your session has expired. Please sign in again.';
    } else if (status >= 500 || status == 502 || status == 503) {
      message = 'Server not reachable. Please try again shortly.';
    }
    throw ImpersonationException(message, code: code);
  }

  /// Whether the signed-in user holds a role that may start a session.
  ///
  /// Read from the ACCESS TOKEN's own `roles`/`role` claims, which is the only
  /// place the app has them. This decides whether to RENDER the entry point —
  /// it is not a security check. Both endpoints enforce the role server-side
  /// and auth-service enforces it again at the mint, so a user who forces
  /// their way to the screen gets a 403 and an empty list.
  ///
  /// The `imp` check matters: while impersonating, the ACTIVE token carries the
  /// TARGET's roles. Without this, viewing an ordinary user would hide the
  /// entry point (correct) but viewing another admin would offer a nested
  /// session, which is a confusing spiral and not something the server intends.
  Future<bool> currentUserCanImpersonate() async {
    final token = await _storage.getAccessToken();
    if (token == null || token.isEmpty) return false;
    final claims = _decodeClaims(token);
    if (claims == null) return false;
    if (claims['imp'] == true) return false;

    final roles = <String>{};
    final rawList = claims['roles'];
    if (rawList is List) {
      for (final r in rawList) {
        final s = r?.toString().trim().toLowerCase();
        if (s != null && s.isNotEmpty) roles.add(s);
      }
    }
    final single = claims['role']?.toString().trim().toLowerCase();
    if (single != null && single.isNotEmpty) roles.add(single);

    // Mirrors auth-service's floor: admin, pro_admin and super_admin.
    return roles.contains('admin') ||
        roles.contains('pro_admin') ||
        roles.contains('super_admin');
  }

  /// Decode a JWT payload. Never throws — a malformed token is simply "no
  /// roles", which hides the entry point rather than crashing a settings list.
  Map<String, dynamic>? _decodeClaims(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return null;
      var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      // base64url without padding is normal in JWTs.
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded = utf8.decode(base64.decode(payload));
      final map = jsonDecode(decoded);
      return map is Map<String, dynamic> ? map : null;
    } catch (_) {
      return null;
    }
  }

  /// Search the directory. An empty [query] lists recent sign-ins.
  Future<List<ImpersonationCandidate>> search({
    String query = '',
    int limit = 25,
  }) async {
    final uri = Uri.parse('$_base/impersonation/users').replace(
      queryParameters: {
        if (query.trim().isNotEmpty) 'q': query.trim(),
        'limit': '$limit',
      },
    );
    late http.Response res;
    try {
      res = await _client
          .get(uri, headers: await _headers())
          .timeout(const Duration(seconds: 15));
    } catch (e) {
      debugPrint('[impersonation] search failed: $e');
      throw const ImpersonationException(
          'Server not reachable. Please try again shortly.');
    }
    if (res.statusCode != 200) _fail(res.statusCode, res.body);

    final decoded = jsonDecode(res.body);
    final rows = (decoded is Map ? decoded['users'] : null);
    if (rows is! List) return const [];
    return rows
        .whereType<Map>()
        .map((m) => ImpersonationCandidate.fromJson(
            Map<String, dynamic>.from(m)))
        .where((c) => c.id.isNotEmpty)
        .toList(growable: false);
  }

  /// Start a read-only session and make it the active one.
  ///
  /// On success the app is signed in AS [candidate] and the admin's own tokens
  /// are stashed. The caller must then send the user to a fresh dashboard —
  /// every screen already on the stack was built from the admin's data.
  Future<ImpersonationStartResult> start(
    ImpersonationCandidate candidate, {
    String reason = '',
  }) async {
    late http.Response res;
    try {
      res = await _client
          .post(
            Uri.parse('$_base/impersonation/start'),
            headers: await _headers(),
            body: jsonEncode({
              'target_user_id': candidate.id,
              if (reason.trim().isNotEmpty) 'reason': reason.trim(),
            }),
          )
          .timeout(const Duration(seconds: 20));
    } catch (e) {
      debugPrint('[impersonation] start failed: $e');
      throw const ImpersonationException(
          'Server not reachable. Please try again shortly.');
    }
    if (res.statusCode != 200) _fail(res.statusCode, res.body);

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final token = (body['access_token'] ?? '').toString();
    final sessionId = (body['session_id'] ?? '').toString();
    final expiresAt = (body['expires_at'] ?? '').toString();
    if (token.isEmpty) {
      throw const ImpersonationException(
          'The server did not return a session. Please try again.');
    }
    if (sessionId.isEmpty) {
      // Without a session id, Exit cannot revoke server-side — it could only
      // wait out the token. Refusing to start is better than opening a session
      // that cannot be ended.
      throw const ImpersonationException(
          'The server returned a session that cannot be ended early. '
          'Not starting it.');
    }

    await _storage.beginImpersonation(
      impersonationToken: token,
      sessionId: sessionId,
      targetLabel: candidate.displayName,
      expiresAtIso: expiresAt,
    );

    // Entering someone else's account is a USER SWITCH, and the app caches
    // per-user state that must not cross it. Without this the admin is shown
    // their OWN cached profile, accounts, limits and balances while
    // authenticated as the target — which defeats the point of a feature whose
    // purpose is to see what the user sees, and sends support off to answer
    // the wrong question. AccountManager's active account id would also still
    // be the admin's, scoping reads to an account the authenticated user does
    // not own.
    //
    // The CACHE-only purge, not purgeStaleUserCache: that one also deletes the
    // admin's remembered login (stored_email, user_passcode, login_method) and
    // their biometric session, which they need intact to come back to.
    await purgeUserScopedCaches();

    return ImpersonationStartResult(
      sessionId: sessionId,
      targetLabel: candidate.displayName,
      expiresAt: DateTime.tryParse(expiresAt)?.toUtc(),
    );
  }

  /// End the active session: revoke it server-side, then restore the admin.
  ///
  /// The admin's session is restored EVEN IF the revoke call fails. Leaving
  /// them stuck inside someone else's account because the server was briefly
  /// unreachable would be the worse outcome, and the token expires on its own
  /// regardless. The failure is returned so the caller can say so.
  Future<ImpersonationExitResult> exit({String reason = ''}) async {
    final sessionId = await _storage.getImpersonationSessionId();

    String? revokeError;
    if (sessionId != null && sessionId.isNotEmpty) {
      // Revoke FIRST, while the admin's token is still stashed and reachable —
      // the call is authenticated as the ADMIN, and after endImpersonation()
      // the active token has already been swapped back, which is also fine,
      // but doing it in this order keeps one less thing in flight.
      final adminHeaders = await _adminHeadersForRevoke();
      try {
        final res = await _client
            .post(
              Uri.parse('$_base/impersonation/exit'),
              headers: adminHeaders,
              body: jsonEncode({
                'session_id': sessionId,
                if (reason.trim().isNotEmpty) 'reason': reason.trim(),
              }),
            )
            .timeout(const Duration(seconds: 15));
        if (res.statusCode != 200) {
          revokeError = 'The session could not be ended on the server; '
              'it will expire on its own.';
          debugPrint('[impersonation] exit revoke HTTP ${res.statusCode}: '
              '${res.body}');
        }
      } catch (e) {
        revokeError = 'The session could not be ended on the server; '
            'it will expire on its own.';
        debugPrint('[impersonation] exit revoke failed: $e');
      }
    }

    await _storage.endImpersonation();
    // Symmetry matters as much as the entry purge: without it the TARGET's
    // cached balances and active account persist into the admin's own session
    // after they exit.
    await purgeUserScopedCaches();
    return ImpersonationExitResult(
      revoked: revokeError == null,
      warning: revokeError,
    );
  }

  /// Headers for the revoke call, authenticated as the ADMIN.
  ///
  /// The active token right now is the TARGET's, and an impersonated token is
  /// refused by the admin routes (it holds the target's roles, which is the
  /// whole point). So the stashed admin token is used explicitly.
  Future<Map<String, String>> _adminHeadersForRevoke() async {
    final adminToken = await _storage.getStashedAdminAccessToken();
    return {
      if (adminToken != null && adminToken.isNotEmpty)
        'Authorization': 'Bearer $adminToken',
      'Content-Type': 'application/json',
    };
  }
}

@immutable
class ImpersonationStartResult {
  const ImpersonationStartResult({
    required this.sessionId,
    required this.targetLabel,
    this.expiresAt,
  });
  final String sessionId;
  final String targetLabel;
  final DateTime? expiresAt;
}

@immutable
class ImpersonationExitResult {
  const ImpersonationExitResult({required this.revoked, this.warning});

  /// False when the server could not be told. The admin IS out either way.
  final bool revoked;
  final String? warning;
}
