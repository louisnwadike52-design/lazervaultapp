/// IS THIS VALUE SAFE TO PUT IN AN AUTHORIZATION HEADER?
///
/// One question, asked in one place, by every transport — gRPC call options
/// and the HTTP interceptor both call this. Two copies of the rule is how the
/// two ends start disagreeing about what a token is.
///
/// WHY THE QUESTION EXISTS. "Non-empty" is not "usable". During login and
/// step-up an OPAQUE token is briefly in play (auth_repository's
/// twoFactorToken), and secure storage can also hold a stray "null" or a
/// half-written value. Sending one of those is WORSE than sending nothing:
///
///   * no header      -> an ordinary unauthenticated call, which the app
///                       already handles quietly;
///   * a bad header   -> the server PARSES it, fails with "token contains an
///                       invalid number of segments", and rejects the call as
///                       malformed.
///
/// On 2026-10-20 that difference put a raw parse error on the dashboard during
/// login, where a silent retry had been before.
library;

import 'dart:convert';

/// Whether [token] is shaped like a JWT we can actually send.
///
/// Three dot-separated, non-empty segments. Deliberately a SHAPE check and
/// nothing more: a client cannot verify a signature and must not pretend to.
/// Its only job is to keep a non-token out of the authorization header.
bool isUsableJwt(String? token) {
  if (token == null) return false;
  final t = token.trim();
  if (t.isEmpty) return false;
  final parts = t.split('.');
  if (parts.length != 3) return false;
  // "a..b" has three segments and is still not a token.
  return parts.every((p) => p.isNotEmpty);
}

/// The authorization entry for a headers or metadata map — or NOTHING.
///
/// Spread it into a map literal:
///
///   headers: {
///     ...authHeader(token),
///     'Content-Type': 'application/json',
///   }
///
/// This exists because a map literal cannot conditionally omit a key, and the
/// alternative people reach for is `'Bearer $token'` with no check at all —
/// which sends the literal text "Bearer null" when the token has not been
/// written yet. An ABSENT header is an ordinary unauthenticated call; a
/// malformed one is rejected as a bad credential and surfaces to the user.
///
/// [key] defaults to the HTTP spelling. gRPC metadata keys must be lowercase,
/// so those call sites pass `key: 'authorization'`.
Map<String, String> authHeader(String? token, {String key = 'Authorization'}) =>
    isUsableJwt(token) ? {key: 'Bearer ${token!.trim()}'} : const {};

/// The `exp` claim of a JWT, or null when it cannot be read.
///
/// WHY THIS EXISTS SEPARATELY FROM [isUsableJwt]. That function checks SHAPE
/// only — three non-empty segments — which is the right test for "would the
/// server reject this as malformed". It says nothing about whether the token is
/// still valid, so an EXPIRED token passes it and is sent anyway. The gateway
/// then answers `invalid token: ... token is expired`, which the app treats
/// exactly like any other failure: on 2026-11-08 that meant a dashboard card
/// stuck on its loading state with no error and no retry.
///
/// Deliberately tolerant: a token whose payload will not decode returns null
/// and is treated as "expiry unknown", because refusing to send a token we
/// merely failed to parse would be worse than letting the server judge it.
DateTime? jwtExpiry(String? token) {
  if (!isUsableJwt(token)) return null;
  try {
    final payload = token!.trim().split('.')[1];
    // base64url without padding is what JWTs use; normalise before decoding.
    final normalised = base64Url.normalize(payload);
    final map = jsonDecode(utf8.decode(base64Url.decode(normalised)));
    if (map is! Map) return null;
    final exp = map['exp'];
    if (exp is! num) return null;
    return DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000, isUtc: true);
  } catch (_) {
    return null;
  }
}

/// Whether [token] is expired, or so close to it that sending it is pointless.
///
/// [leeway] guards the race where a token is valid when checked and expired by
/// the time the server sees it — a real outcome on a slow first call after a
/// cold start. An unreadable or absent expiry is reported as NOT expired: see
/// [jwtExpiry].
bool isJwtExpired(String? token,
    {Duration leeway = const Duration(seconds: 30)}) {
  final exp = jwtExpiry(token);
  if (exp == null) return false;
  return DateTime.now().toUtc().add(leeway).isAfter(exp);
}
