import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:grpc/grpc.dart';

/// The single, canonical message shown for any connectivity / transport-level
/// failure. Use this everywhere so the wording is consistent across the app and
/// never exposes raw HTTP/gRPC text (e.g. "expected 200, got 503").
const String networkErrorMessage =
    'Network error. Please check your connection and try again.';

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

  return _messageLooksLikeNetwork(error is GrpcError
      ? (error.message ?? '')
      : error.toString());
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
  return _messageLooksLikeNetwork(m);
}

/// Matches raw "HTTP 5xx" transport text (any 5xx, so Cloudflare's 520-527 and
/// 530 are covered alongside 500/502/503/504).
final RegExp _httpServerStatusPattern = RegExp(r'http[^0-9a-z]{0,3}5\d\d');

/// Shared substring detector for raw transport text.
bool _messageLooksLikeNetwork(String raw) {
  if (raw.isEmpty) return false;
  final m = raw.toLowerCase();
  return m.contains('expected 200') ||
      m.contains('non-200') ||
      m.contains('got 50') || // got 500/502/503/504
      m.contains('status code') ||
      m.contains('502') ||
      m.contains('503') ||
      m.contains('504') ||
      // Raw edge/transport text like "HTTP 530" or "http 522". Anchored on the
      // "http" prefix on purpose: a bare '530' also appears in ordinary money
      // copy (e.g. "NGN 530"), which must NOT read as a network failure.
      _httpServerStatusPattern.hasMatch(m) ||
      m.contains('connection') ||
      m.contains('socket') ||
      m.contains('failed host lookup') ||
      m.contains('host lookup') ||
      m.contains('network is unreachable') ||
      m.contains('unreachable') ||
      m.contains('handshake') ||
      m.contains('<html') ||
      m.contains('xmlhttprequest') ||
      m.contains('connection refused') ||
      m.contains('connection reset') ||
      m.contains('connection closed') ||
      m.contains('connection terminated');
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

  // --- connectivity / transport-level failures (network error) --------------
  // Caught first so a no-internet / unreachable-server / 5xx situation always
  // reads as a network error, never as raw transport text or a wrong-credential
  // style message.
  if (isNetworkError(error)) {
    return networkErrorMessage;
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

  // --- everything else ------------------------------------------------------
  return contextual();
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
  if (_messageLooksLikeNetwork(msg.toLowerCase())) return networkErrorMessage;
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
