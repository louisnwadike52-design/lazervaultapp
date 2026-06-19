import 'package:grpc/grpc.dart';

/// Turn any thrown error from the lock-funds (PiggyVault) flow into a short,
/// user-friendly message — NEVER the raw gRPC dump (code/trailers/cloudflare
/// headers) that leaked onto the failure screen. Prefers the server's human
/// message (e.g. "Year Lock does not support auto-renewal"); otherwise maps the
/// status code to plain language. Used by the repository AND the cubits so every
/// lock-funds screen surfaces a clean error.
String friendlyLockError(Object e) {
  if (e is GrpcError) {
    final msg = e.message?.trim() ?? '';
    if (msg.isNotEmpty) return msg;
    switch (e.code) {
      case StatusCode.invalidArgument:
        return 'Some of the details are invalid. Please review and try again.';
      case StatusCode.failedPrecondition:
        return "This can't be completed right now. Please try again later.";
      case StatusCode.notFound:
        return 'We could not find that lock. Please refresh and try again.';
      case StatusCode.alreadyExists:
        return 'That lock already exists.';
      case StatusCode.permissionDenied:
        return "You don't have permission to do this.";
      case StatusCode.unauthenticated:
        return 'Your session expired. Please log in again.';
      case StatusCode.resourceExhausted:
        return "You've reached a limit. Please try again later.";
      case StatusCode.unavailable:
        return 'Service is temporarily unavailable. Please try again.';
      case StatusCode.deadlineExceeded:
        return 'The request timed out. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
  // Unwrap a plain Exception('...') and reject anything that still looks like a
  // raw gRPC/transport dump.
  var s = e.toString();
  if (s.startsWith('Exception: ')) s = s.substring('Exception: '.length).trim();
  if (s.isEmpty ||
      s.contains('gRPC Error') ||
      s.contains('trailers:') ||
      s.contains('rawResponse')) {
    return 'Something went wrong. Please try again.';
  }
  return s;
}
