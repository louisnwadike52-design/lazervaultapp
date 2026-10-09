import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:grpc/grpc.dart';

/// Shown when the DEVICE cannot reach the network: a socket error, a DNS
/// failure, a connection timeout. The user can often fix this, so it is the only
/// one of the three that asks them to.
const String networkErrorMessage =
    'Network error. Please check your connection and try again.';

/// Shown when OUR side is at fault: a 5xx from the gateway or the Cloudflare
/// edge, a service that panicked, a route that is not deployed.
///
/// This exists because every one of those used to produce [networkErrorMessage].
/// A user whose signup failed on our 503 was told to check their connection —
/// so they restarted their router, switched to mobile data, and tried again into
/// the same outage, while the app implied the fault was theirs. Telling someone
/// their connection is broken when it is not is worse than saying nothing.
const String serverErrorMessage =
    'Our servers are having a problem right now. This is not your connection — '
    'please try again in a moment.';

/// Shown when the failure genuinely could be either, and the app has no evidence
/// to choose — a gRPC `unavailable`, a deadline exceeded. Naming both is honest;
/// picking one and being wrong is what the other two constants exist to avoid.
const String unreachableErrorMessage =
    'We could not reach Lazervault. Check your connection, or try again in a '
    'moment.';

/// Shown when a PAYMENT PROVIDER refuses us — an IP allowlist, a revoked
/// resource entitlement, expired credentials, a merchant-account block.
///
/// These are failures of OUR arrangement with a partner. The user cannot act
/// on them and must never be shown the provider's own words: "You are not
/// whitelisted to access this resource" and "Your Request Seems to be coming
/// from an unknown source" are meaningless to the person sending money, and
/// they describe our infrastructure to someone who should never see it.
///
/// Deliberately does not blame the user's connection — the same reasoning as
/// [serverErrorMessage]. Telling someone to check their wifi when our IP fell
/// off a provider's allowlist sends them to restart a router that was never
/// the problem.
const String providerUnavailableMessage =
    'We couldn’t reach our payment partner right now. This is not your '
    'connection — please try again shortly.';

/// The single, canonical message shown when a money-moving flow is refused
/// because the source account is frozen/suspended. accounts-service is the
/// single source of truth for balances and blocks EVERY debit/hold/transfer on
/// a frozen source, so mapping this one error covers every transfer-related
/// service (send, FX/international, withdrawals, bills, crypto, move-money, …).
const String frozenAccountMessage =
    'This account is frozen, so this transaction can’t go through. '
    'Unfreeze it in Account settings to continue.';

/// True when [error] (a GrpcError, a raw string, or anything with a message) is
/// the accounts-service frozen/suspended-account rejection
/// (e.g. `account <uuid> is frozen`).
bool isFrozenAccountError(Object? error) {
  if (error == null) return false;
  final raw = error is GrpcError
      ? (error.message ?? '')
      : error is String
          ? error
          : error.toString();
  return _messageLooksFrozen(raw);
}

/// True when [error] is the behavioural-fraud enforce-block rejection — a
/// transfer refused because it was unusually large and the account was just
/// frozen for review. core-payments returns this as FailedPrecondition with the
/// guidance text; callers use this to launch the tx-PIN self-unfreeze modal
/// instead of only showing the message.
bool isFraudBlockError(Object? error) {
  if (error == null) return false;
  final raw = error is GrpcError
      ? (error.message ?? '')
      : error is String
          ? error
          : error.toString();
  return raw.toLowerCase().contains('blocked for your security');
}

/// True when [error] carries a provider's refusal of our integration (an IP
/// allowlist, a revoked resource, bad merchant credentials) rather than
/// anything the user did.
bool isProviderRefusalError(Object? error) {
  if (error == null) return false;
  final raw = error is GrpcError
      ? (error.message ?? '')
      : error is String
          ? error
          : error.toString();
  return messageLooksLikeProviderRefusal(raw);
}

/// Shared substring detector for the frozen/suspended-account server error.
bool _messageLooksFrozen(String raw) {
  if (raw.isEmpty) return false;
  final m = raw.toLowerCase();
  return m.contains('is frozen') ||
      m.contains('account frozen') ||
      m.contains('is suspended') ||
      m.contains('account suspended');
}

/// True when [error] is a connectivity / transport-level failure (no internet,
/// server unreachable, gateway 5xx, timeout, dropped connection).
///
/// Detects by BOTH error type AND message text, so it still classifies the
/// failure correctly regardless of which gRPC [StatusCode] the transport
/// happened to assign (a non-200 HTTP response can surface as `unknown`,
/// `internal`, or `unavailable`, with the raw text only in the message).
bool isNetworkError(Object? error) {
  if (error == null) return false;

  if (error is SocketException || error is TimeoutException) return true;

  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return true;
      default:
        break;
    }
    if (isNetworkStatusCode(error.response?.statusCode)) return true;
  }

  if (error is GrpcError) {
    if (error.code == StatusCode.unavailable ||
        error.code == StatusCode.unknown ||
        error.code == StatusCode.internal ||
        error.code == StatusCode.deadlineExceeded ||
        error.code == StatusCode.aborted) {
      return true;
    }
  }

  return _messageLooksLikeNetwork(
      error is GrpcError ? (error.message ?? '') : error.toString());
}

/// True when the failure is demonstrably OURS: something on our side answered,
/// or failed to be deployed at all.
///
/// Deliberately narrower than [isNetworkError], and deliberately separate from
/// it: [isNetworkError] drives retry and offline behaviour at 49 call sites and
/// its meaning ("transport-class, retryable, never show raw text") is correct.
/// What was wrong was using that one bucket to choose the user-facing WORDS.
bool isServerError(Object? error) {
  if (error == null) return false;

  if (error is DioException) {
    final status = error.response?.statusCode;
    if (status != null && status >= 500 && status <= 599) return true;
  }

  if (error is GrpcError) {
    // internal: a service panicked or returned a malformed response. Ours.
    if (error.code == StatusCode.internal) return true;
    // unimplemented / "unknown service": the method is not registered, which
    // means the service is not deployed or the gateway route is missing. A
    // deployment gap, never the user's network.
    if (error.code == StatusCode.unimplemented) return true;
    if ((error.message ?? '').toLowerCase().contains('unknown service')) {
      return true;
    }
  }

  return _messageLooksLikeServerFailure(
      error is GrpcError ? (error.message ?? '') : error.toString());
}

/// True when the device itself could not get onto the network. Distinct from
/// [isServerError]: this is the case where "check your connection" is real
/// advice rather than a misdirection.
bool isDeviceTransportError(Object? error) {
  if (error == null) return false;
  if (error is SocketException) return true;

  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return true;
      default:
        break;
    }
  }

  return _messageLooksLikeTransportFailure(
      error is GrpcError ? (error.message ?? '') : error.toString());
}

/// The right wording for a transport-class failure, given what is actually
/// known about it. Every "return networkErrorMessage" site now calls this.
String transportFailureMessage(Object? error) {
  // Server evidence wins: a 5xx is proof, a socket timeout is not.
  if (isServerError(error)) return serverErrorMessage;
  if (isDeviceTransportError(error)) return networkErrorMessage;
  return unreachableErrorMessage;
}

/// True when [statusCode] (gRPC int code or HTTP status) denotes a
/// transport/server-class failure that should be surfaced as a network error.
///
/// gRPC: unknown(2), deadlineExceeded(4), aborted(10), internal(13),
/// unavailable(14). HTTP: any 5xx — including the Cloudflare edge codes
/// (520-527 origin errors, 530 origin unreachable) our tunnel returns when a
/// service is down.
bool isNetworkStatusCode(dynamic statusCode) {
  if (statusCode is int) {
    const grpcNetworkCodes = {2, 4, 10, 13, 14};
    // Whole 5xx range, not a hand-listed subset: a Cloudflare 530 (origin
    // unreachable) is exactly as much a "service is down" as a 502, and
    // listing only 500/502/503/504 let it fall through as a raw code.
    // gRPC codes are 0-16, so they can never collide with this range.
    if (statusCode >= 500 && statusCode <= 599) return true;
    return grpcNetworkCodes.contains(statusCode);
  }
  return false;
}

/// True when a candidate message is unsafe to show to a user because it looks
/// like raw transport/exception text rather than a human sentence. Use this to
/// gate any "pass the server's own message through" branch.
/// True when a message names one of our payment/exchange providers alongside a
/// status or vendor code — the signature of a raw upstream failure that has
/// been string-joined into our own error and must never reach a customer.
///
/// Named providers only. A generic three-digit number is far too common in
/// legitimate copy ("minimum send is 100 USDT") to treat as technical on its
/// own.
bool _namesAProviderWithACode(String lower) {
  const providers = <String>[
    'quidax', 'flutterwave', 'nomba', 'fincra', 'klasha', 'vtpass',
    'epins', 'prestmit', 'reloadly', 'mono', 'vtuafrica', 'paystack',
  ];
  var named = false;
  for (final p in providers) {
    if (lower.contains(p)) {
      named = true;
      break;
    }
  }
  if (!named) return false;
  // A status code, a parenthesised vendor code, or an explicit code= field.
  return RegExp(r'\b\d{3}\b').hasMatch(lower) ||
      RegExp(r'\(\s*\d+\s*\)').hasMatch(lower) ||
      lower.contains('code=') ||
      lower.contains('code:');
}

bool looksTechnical(String? msg) {
  if (msg == null || msg.isEmpty) return true;
  final trimmed = msg.trim();
  final m = msg.toLowerCase();
  if (m.contains('exception') ||
      m.contains('error:') ||
      m.contains('stacktrace') ||
      m.contains('statuscode') ||
      m.contains('grpcerror') ||
      m.contains('dioexception') ||
      m.contains('rpc error') || // raw gRPC status string
      // A provider/JSON blob leaked to the client (e.g. Klasha's
      // {"message":"…","error":"com.…Exception"}). Never show raw JSON.
      trimmed.startsWith('{') ||
      trimmed.startsWith('[') ||
      m.contains('{"') ||
      m.contains('":"')) {
    return true;
  }
  // A PROVIDER's own API error, leaked verbatim. Measured 2026-10-08 on the
  // crypto send flow, shown to a customer in a red snackbar:
  //
  //   "create withdrawal: quidax api error 400 (110112):
  //    Insufficient account balance"
  //
  // Every filter above let it through — no "exception", no "error:" (it reads
  // "api error 400"), no JSON. And the sentence is not merely technical, it is
  // actively MISLEADING: that balance is OUR float at the provider, not the
  // customer's. They had the funds; the message told them they did not.
  //
  // So the rule is the shape, not the vendor: anything that reads as a
  // provider API failure is ours to fix and never the user's to action.
  if (m.contains('api error') ||
      m.contains('provider error') ||
      m.contains('upstream error') ||
      _namesAProviderWithACode(m)) {
    return true;
  }
  // Dart runtime type failures. "type 'Null' is not a subtype of type 'String'"
  // carries no "exception", no "error:" and no JSON, so every filter above let
  // it through — it only stayed hidden because the sole caller unwrapped just
  // GrpcError and DioException, and anything else became a generic line before
  // reaching here. Now that a WRAPPED message is judged on its merits, the gap
  // is reachable, and a null-safety bug would be shown to a customer verbatim.
  if (m.contains('is not a subtype of') ||
      m.contains('noSuchMethodError'.toLowerCase()) ||
      m.contains('rangeerror') ||
      m.contains('formatexception') ||
      m.contains('_typeerror') ||
      m.contains('unhandled ')) {
    return true;
  }
  return _messageLooksLikeNetwork(m);
}

/// True when the text is a PROVIDER refusing our integration rather than
/// anything about this user's request.
///
/// Motivating case: Nomba's IP allowlist stopped matching this host, so every
/// authenticated call returned
/// `403 "Your Request Seems to be coming from an unknown source"`. Our own Go
/// clients format failures as
/// `nomba transfer failed: http 403 code=403 desc=<provider text>`, and that
/// string clears every other filter here — it has no "exception", no JSON, and
/// the 5xx pattern does not match a 403. It would have been shown verbatim.
///
/// Matches the refusal VOCABULARY rather than provider names: a message that
/// legitimately names a provider ("payouts are paused") is fine to show, while
/// "not whitelisted" is not, whoever said it.
bool messageLooksLikeProviderRefusal(String? raw) {
  if (raw == null || raw.isEmpty) return false;
  final m = raw.toLowerCase();

  const refusalPhrases = <String>[
    'not whitelisted',
    'whitelist',
    'allowlist',
    'allow list',
    'unknown source',
    'access denied',
    'not authorized to access',
    'not authorised to access',
    'forbidden error',
    'request forbidden',
    'ip address is not',
    'invalid api key',
    'invalid credentials for',
    'merchant not',
    'service not authorized',
  ];
  for (final phrase in refusalPhrases) {
    if (m.contains(phrase)) return true;
  }

  // Our own client formatting: "... http 403 code=403 desc=...". A 401/403
  // surfaced from a PROVIDER call is never something the user can fix; the
  // app's own auth failures arrive as a gRPC status, not as this text shape.
  if (m.contains('desc=') && (m.contains('403') || m.contains('401'))) {
    return true;
  }
  return false;
}

/// Matches raw "HTTP 5xx" transport text (any 5xx, so Cloudflare's 520-527 and
/// 530 are covered alongside 500/502/503/504).
final RegExp _httpServerStatusPattern = RegExp(r'http[^0-9a-z]{0,3}5\d\d');

/// Raw text that identifies a failure ON OUR SIDE — a 5xx in any of the shapes
/// the gateway, the tunnel and the gRPC layer write it.
bool _messageLooksLikeServerFailure(String raw) {
  if (raw.isEmpty) return false;
  final m = raw.toLowerCase();
  return m.contains('expected 200') ||
      m.contains('non-200') ||
      m.contains('got 50') || // got 500/502/503/504
      m.contains('502') ||
      m.contains('503') ||
      m.contains('504') ||
      // Raw edge/transport text like "HTTP 530" or "http 522". Anchored on the
      // "http" prefix on purpose: a bare '530' also appears in ordinary money
      // copy (e.g. "NGN 530"), which must NOT read as a network failure.
      _httpServerStatusPattern.hasMatch(m) ||
      // An HTML body where JSON was expected is a gateway or edge error page.
      m.contains('<html');
}

/// Raw text that identifies a failure on the DEVICE's side of the wire.
bool _messageLooksLikeTransportFailure(String raw) {
  if (raw.isEmpty) return false;
  final m = raw.toLowerCase();
  return m.contains('connection') ||
      m.contains('socket') ||
      m.contains('failed host lookup') ||
      m.contains('host lookup') ||
      m.contains('network is unreachable') ||
      m.contains('unreachable') ||
      m.contains('handshake') ||
      m.contains('xmlhttprequest');
}

/// Shared substring detector for raw transport text, either direction. Kept as
/// the union of the two above so [looksTechnical] and [isNetworkError] behave
/// exactly as before — only the WORDING split, not the classification that 49
/// call sites depend on.
bool _messageLooksLikeNetwork(String raw) {
  if (raw.isEmpty) return false;
  final m = raw.toLowerCase();
  return _messageLooksLikeServerFailure(m) ||
      _messageLooksLikeTransportFailure(m) ||
      m.contains('status code');
}

/// Converts ANY thrown error into a short, user-friendly message.
///
/// The platform must never show raw gRPC/HTTP/exception text to users — it makes
/// the app feel broken and leaks internals. Call sites pass whatever they caught
/// and get back something safe to display. The default for anything unrecognised
/// is the generic "Something went wrong" line.
///
///   try { ... } catch (e) {
///     showError(friendlyError(e));   // never the raw e.toString()
///   }
///
/// Pass [context] (e.g. "transfer", "load budgets") to tailor the generic line
/// without exposing internals: "We couldn't complete your transfer. Please try
/// again."
String friendlyError(Object? error, {String? context}) {
  const generic = 'Something went wrong. Please try again.';
  String contextual() => context == null || context.isEmpty
      ? generic
      : 'We couldn’t $context right now. Please try again.';

  // --- provider refused OUR integration -------------------------------------
  // FIRST, ahead of even the connectivity check. A provider 403 can surface as
  // Internal, Unavailable, FailedPrecondition or Unknown depending on which
  // service wrapped it, and gRPC Unavailable would otherwise be read as a
  // transport failure and reported as "our servers are having a problem".
  // That is safe but wrong: nothing is down, a partner is refusing us, and
  // saying so is both more accurate and more useful to whoever reads the
  // support ticket.
  if (isProviderRefusalError(error)) {
    return providerUnavailableMessage;
  }

  // --- connectivity / transport-level failures (network error) --------------
  // Caught first so a no-internet / unreachable-server / 5xx situation always
  // reads as a network error, never as raw transport text or a wrong-credential
  // style message.
  if (isNetworkError(error)) {
    return transportFailureMessage(error);
  }

  // --- frozen/suspended source account — clean, actionable, code-agnostic ----
  if (isFrozenAccountError(error)) {
    return frozenAccountMessage;
  }

  // --- gRPC: map by status code, never the raw message ----------------------
  if (error is GrpcError) {
    switch (error.code) {
      case StatusCode.unauthenticated:
        return 'Your session has expired. Please sign in again.';
      case StatusCode.permissionDenied:
        return 'You don’t have permission to do that.';
      case StatusCode.notFound:
        return contextual();
      case StatusCode.resourceExhausted:
        return 'Too many attempts. Please wait a moment and try again.';
      case StatusCode.failedPrecondition:
      case StatusCode.invalidArgument:
        // Services return clean, user-facing text for known business cases
        // (quote expired, insufficient balance, payout unavailable, …). Pass
        // it through the sanitizer so a genuine sentence shows while any raw
        // rpc/JSON blob still collapses to the generic line. Never e.toString()
        // — that carries the gRPC status + cloudflare trailers.
        return sanitizeUserFacingError(error.message);
      default:
        return contextual();
    }
  }

  // --- HTTP (Dio) responses: map by status, never the body ------------------
  if (error is DioException) {
    final status = error.response?.statusCode ?? 0;
    if (status == 401 || status == 403) {
      return 'Your session has expired. Please sign in again.';
    }
    if (status == 429) {
      return 'Too many attempts. Please wait a moment and try again.';
    }
    return contextual();
  }

  // --- a WRAPPED business error still carries a sentence meant for the user --
  //
  // A service's precise, actionable refusal reached this point and was thrown
  // away. Only GrpcError and DioException were unwrapped above, so by the time
  // a repository had turned the gRPC status into a Failure/Exception, the
  // message was invisible here and everything collapsed to "We couldn't …
  // right now. Please try again."
  //
  // Measured 2026-10-02 on send-funds. core-payments returned:
  //
  //   InvalidArgument: "the minimum for a bank transfer is 100.00 NGN
  //                     (you entered 10.00) — payout providers reject
  //                     smaller amounts"     retryable=false
  //
  // and the user was shown "Something went wrong … Please try again" after
  // entering their PIN. Telling someone to retry a NON-RETRYABLE refusal is
  // worse than saying nothing: every retry fails identically, and it reads as
  // the app being broken rather than the amount being too small. Three days of
  // "all transfers are failing" came from exactly this.
  //
  // sanitizeUserFacingError is the existing arbiter of "is this fit to show":
  // genuine sentences pass, raw transport/technical text collapses. Running the
  // wrapped text through it recovers the real reason without loosening what may
  // be displayed — anything it rejects still falls to the contextual line.
  final wrapped = sanitizeUserFacingError(_unwrappedMessage(error));
  if (wrapped.isNotEmpty && wrapped != generic) return wrapped;

  return contextual();
}

/// Best-effort user-facing text out of an arbitrary thrown object.
///
/// Strips the wrapper noise Dart prepends — "Exception: ", "StateError: " and
/// the like — so the sentence underneath is judged on its own merits rather
/// than being rejected as technical because of its envelope.
String _unwrappedMessage(Object? error) {
  if (error == null) return '';
  String text;
  try {
    // Most Failure/exception types in this codebase expose `.message`; fall
    // back to toString() for the rest.
    final dynamic d = error;
    final dynamic m = d.message;
    text = m is String ? m : error.toString();
  } catch (_) {
    text = error.toString();
  }
  text = text.trim();
  // A gRPC error that was CAUGHT AND RETHROWN loses its type but keeps its
  // sentence inside an envelope:
  //
  //   rpc error: code = FailedPrecondition desc = <the message for the user>
  //
  // The typed branch above only fires for a live GrpcError. Once a repository
  // wraps it — `Exception(e.toString())`, which is ordinary — that branch is
  // skipped and the envelope reaches the sanitizer, which correctly rejects
  // "rpc error: code = ..." as technical. The service's own actionable
  // sentence is then thrown away and replaced with the generic line.
  //
  // Measured on a real failure: utility-payments returned
  // "The family pool has ₦80.00 left, which doesn't cover this payment.
  // Anyone in the family can add money to the pool." and the user was shown
  // "We couldn't complete your transfer right now. Please try again." — a
  // precise, fixable refusal reported as an unexplained fault, which is how
  // it was reported to us as a broken airtime purchase.
  //
  // ONLY for the codes that carry text written FOR the user, exactly as the
  // typed GrpcError branch above does. This gate is load-bearing: without it,
  // unwrapping also frees internal text from codes that never carry a user
  // message — `code = Internal desc = pq: duplicate key value violates unique
  // constraint` reached the user in testing — which is the leak the sanitizer
  // was catching only because the envelope made the whole string look
  // technical. Mirroring the typed branch keeps one rule in both places.
  //
  // Take the LAST `desc =`, because a message nested through two services
  // carries two envelopes and the innermost one is the real sentence.
  final lower = text.toLowerCase();
  final descIndex = text.lastIndexOf('desc = ');
  final carriesUserText = lower.contains('code = failedprecondition') ||
      lower.contains('code = invalidargument');
  if (descIndex >= 0 && lower.contains('rpc error') && carriesUserText) {
    final inner = text.substring(descIndex + 'desc = '.length).trim();
    if (inner.isNotEmpty) text = inner;
  }
  // "Exception: foo", "_TypeError: foo", "SomeFailure: foo"
  final match = RegExp(r'^[A-Za-z_][A-Za-z0-9_]*(Exception|Error|Failure)?\s*:\s*(.+)$',
          dotAll: true)
      .firstMatch(text);
  if (match != null && (match.group(2) ?? '').trim().isNotEmpty) {
    text = match.group(2)!.trim();
  }
  return text;
}

/// Sanitize an ALREADY-EXTRACTED message string for display. Use at the sink
/// (Failure construction, snackbars, error widgets) where only the string —
/// not the original error object — is available. Raw transport text (e.g.
/// "HTTP connection completed with 502 instead of 200") becomes the friendly
/// network message; other clearly-technical text becomes a generic line;
/// genuine human/business messages ("Insufficient balance") pass through
/// unchanged, so downstream logic that reads business messages is unaffected.
String sanitizeUserFacingError(String? message) {
  final msg = message?.trim() ?? '';
  if (msg.isEmpty) return 'Something went wrong. Please try again.';
  final lower = msg.toLowerCase();
  // A provider refusing OUR integration comes first: its text can contain
  // words the transport matchers also claim ("unreachable", a 5xx), and
  // "our servers are having a problem" would be a wrong diagnosis when
  // nothing of ours is down.
  if (messageLooksLikeProviderRefusal(msg)) return providerUnavailableMessage;
  if (_messageLooksLikeServerFailure(lower)) return serverErrorMessage;
  if (_messageLooksLikeTransportFailure(lower)) return networkErrorMessage;
  if (lower.contains('status code')) return unreachableErrorMessage;
  // Map the raw frozen/suspended-account error (carries a UUID) to a clean line.
  if (_messageLooksFrozen(msg)) return frozenAccountMessage;
  if (looksTechnical(msg)) return 'Something went wrong. Please try again.';
  return msg;
}

/// True when the error means the user's auth/session is no longer valid, so the
/// caller can route to re-login instead of just showing a message.
bool isAuthError(Object? error) {
  if (error is GrpcError) {
    return error.code == StatusCode.unauthenticated;
  }
  if (error is DioException) {
    final s = error.response?.statusCode;
    return s == 401 || s == 403;
  }
  return false;
}

/// The message a USER sees when starting a voice session fails.
///
/// Exists because the app used to render the transport layer verbatim:
/// `Failed to get voice session credentials: 500 {"error":"Failed to create
/// voice session. Please try again."}` — a status code and a raw JSON body in
/// a red banner. It names our internals to someone who cannot act on them,
/// and it reads like the user broke something.
///
/// Pure and status/body driven so it can be tested without a cubit: the
/// property that matters is that NOTHING technical survives into the result.
/// The real status and body go to the ops log sink instead.
String voiceSessionStartMessage(int statusCode, String body) {
  final b = body.toLowerCase();
  // A shut-down executor in the gateway. Genuinely transient — a recycle
  // clears it — so "try again shortly" is true here, where it would be a lie
  // for a hard 500.
  if (b.contains('voice_service_restarting')) {
    return 'Voice is restarting. Please try again in a moment.';
  }
  // An admin turned voice off. Retrying will never help, so don't imply it
  // might; point at the thing that does work.
  if (b.contains('voice_recognition_disabled') ||
      b.contains('voice_service_disabled')) {
    return 'Voice is currently turned off. You can use chat instead.';
  }
  if (statusCode == 401 || statusCode == 403) {
    return 'Your session expired. Please sign in again to use voice.';
  }
  if (statusCode == 429) {
    return 'Too many voice requests just now. Please wait a moment and try again.';
  }
  if (statusCode >= 500) return serverErrorMessage;
  return 'We could not start voice just now. Please try again.';
}
