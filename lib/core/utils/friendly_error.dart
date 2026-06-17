import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:grpc/grpc.dart';

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

  // --- connectivity / timeouts (safe + actionable to surface) ---------------
  if (error is SocketException ||
      (error is DioException &&
          error.type == DioExceptionType.connectionError)) {
    return 'No internet connection. Check your network and try again.';
  }
  if (error is TimeoutException ||
      (error is DioException &&
          (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.sendTimeout ||
              error.type == DioExceptionType.receiveTimeout))) {
    return 'This is taking longer than usual. Please try again.';
  }

  // --- gRPC: map by status code, never the raw message ----------------------
  if (error is GrpcError) {
    switch (error.code) {
      case StatusCode.unauthenticated:
        return 'Your session has expired. Please sign in again.';
      case StatusCode.permissionDenied:
        return 'You don’t have permission to do that.';
      case StatusCode.unavailable:
      case StatusCode.deadlineExceeded:
        return 'The service is busy right now. Please try again in a moment.';
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
    if (status >= 500) {
      return 'The service is busy right now. Please try again in a moment.';
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
