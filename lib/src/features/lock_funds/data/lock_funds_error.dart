import 'package:grpc/grpc.dart';

/// Turn any thrown error from the lock-funds (PiggyVault) flow into a short,
/// user-friendly message — NEVER the raw gRPC dump (code/trailers/cloudflare
/// headers) NOR an internal/technical error string (e.g. "GetLockTransactions
/// not implemented", "distlock acquisition failed", nil-pointer panics).
///
/// Rule: only surface the server's own message for *validation-class* status
/// codes (invalidArgument / failedPrecondition / alreadyExists / resourceExhausted
/// / outOfRange), where the backend deliberately sends human, user-actionable
/// text like "minimum amount is 5000" or "Year Lock does not support auto-renewal"
/// — and only when that text doesn't look technical. For every other code
/// (internal, unimplemented, unknown, unavailable, timeouts, transport dumps) we
/// show plain "Something went wrong" language and keep the raw error out of the UI.
/// Used by the repository AND the cubits so every lock-funds screen is clean.
String friendlyLockError(Object e) {
  if (e is GrpcError) {
    final server = _userFacing(e.message);
    switch (e.code) {
      // Validation-class codes: prefer the server's human message.
      case StatusCode.invalidArgument:
        return server ?? 'Some of the details are invalid. Please review and try again.';
      case StatusCode.failedPrecondition:
        return server ?? "This can't be completed right now. Please try again later.";
      case StatusCode.alreadyExists:
        return server ?? 'That already exists.';
      case StatusCode.resourceExhausted:
        return server ?? "You've reached a limit. Please try again later.";
      case StatusCode.outOfRange:
        return server ?? 'Some of the details are out of range. Please review and try again.';
      // Everything else: fixed, friendly copy — never the raw server text.
      case StatusCode.notFound:
        return 'We could not find that. Please refresh and try again.';
      case StatusCode.permissionDenied:
        return "You don't have permission to do this.";
      case StatusCode.unauthenticated:
        return 'Your session expired. Please log in again.';
      case StatusCode.unavailable:
        return 'Service is temporarily unavailable. Please try again.';
      case StatusCode.deadlineExceeded:
        return 'The request timed out. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
  // Non-gRPC error. Unwrap a plain Exception('...') and only surface it if it
  // still reads as a clean, user-facing sentence; otherwise go generic.
  var s = e.toString();
  if (s.startsWith('Exception: ')) s = s.substring('Exception: '.length).trim();
  return _userFacing(s) ?? 'Something went wrong. Please try again.';
}

/// Returns [msg] only if it's a non-empty, human-readable message safe to show a
/// user — else null. Rejects empty strings, raw gRPC/transport dumps, and text
/// that carries internal/technical markers (stack/impl/DB/network jargon).
String? _userFacing(String? msg) {
  final s = (msg ?? '').trim();
  if (s.isEmpty) return null;
  // Over-long strings are almost always dumps, not a crafted user message.
  if (s.length > 160) return null;
  final lower = s.toLowerCase();
  const technical = [
    'not implemented',
    'unimplemented',
    'distlock',
    'panic',
    'runtime error',
    'nil pointer',
    'invalid memory',
    'goroutine',
    'sql',
    'pq:',
    'rpc error',
    'grpc',
    'trailers:',
    'rawresponse',
    'connection refused',
    'connection reset',
    'context deadline',
    'context canceled',
    'eof',
    'no such host',
    'dial tcp',
    'i/o timeout',
    'failed to',
    'unexpected',
    'internal error',
    'quotation failed',
    '%!',
    '0x',
    'null',
    'exception',
  ];
  for (final t in technical) {
    if (lower.contains(t)) return null;
  }
  return s;
}
