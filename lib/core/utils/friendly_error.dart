import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:grpc/grpc.dart';

/// The single, canonical message shown for any connectivity / transport-level
/// failure. Use this everywhere so the wording is consistent across the app and
/// never exposes raw HTTP/gRPC text (e.g. "expected 200, got 503").
const String networkErrorMessage =
    'Network error. Please check your connection and try again.';

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
/// unavailable(14). HTTP: 500/502/503/504.
bool isNetworkStatusCode(dynamic statusCode) {
  if (statusCode is int) {
    const grpcNetworkCodes = {2, 4, 10, 13, 14};
    const httpNetworkCodes = {500, 502, 503, 504};
    return grpcNetworkCodes.contains(statusCode) ||
        httpNetworkCodes.contains(statusCode);
  }
  return false;
}

/// True when a candidate message is unsafe to show to a user because it looks
/// like raw transport/exception text rather than a human sentence. Use this to
/// gate any "pass the server's own message through" branch.
bool looksTechnical(String? msg) {
  if (msg == null || msg.isEmpty) return true;
  final m = msg.toLowerCase();
  if (m.contains('exception') ||
      m.contains('error:') ||
      m.contains('stacktrace') ||
      m.contains('statuscode') ||
      m.contains('grpcerror') ||
      m.contains('dioexception')) {
    return true;
  }
  return _messageLooksLikeNetwork(m);
}

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
