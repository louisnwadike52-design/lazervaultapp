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
