import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

/// Maps any caught exception (gRPC error, generic Exception, raw string)
/// to a user-friendly message. Never returns the raw server error text —
/// that's the whole point. The raw error is preserved via `debugPrint` so
/// devs can still diagnose from the console / logcat.
///
/// `context` is an optional short hint about what the user was trying to
/// do (e.g. "loading wallets", "creating address"). When provided it's
/// folded into the friendly message for clarity.
///
/// Usage:
///   try { … } catch (e) {
///     emit(CryptoError(message: friendlyCryptoError(e, context: 'loading holdings')));
///   }
String friendlyCryptoError(Object error, {String? context}) {
  // Always log the raw thing so engineers can diagnose.
  debugPrint('[crypto] error${context != null ? ' ($context)' : ''}: $error');

  // gRPC categorised errors → category-specific copy.
  if (error is GrpcError) {
    switch (error.code) {
      case StatusCode.unavailable:
      case StatusCode.deadlineExceeded:
        return "We couldn't reach the crypto service. Please check your connection and try again.";
      case StatusCode.unauthenticated:
        return 'Your session has expired. Please sign in again.';
      case StatusCode.permissionDenied:
        return "You don't have permission to do that.";
      case StatusCode.notFound:
        return _withContext(context, fallback: "We couldn't find that asset. Pull to refresh and try again.");
      case StatusCode.failedPrecondition:
        // The crypto-service handler is the source of truth for what
        // string the user sees: "Insufficient balance" (HoldFunds at
        // ConfirmSwap), "Could not hold funds: account frozen", the
        // sub-account-not-yet-provisioned message, etc. All are
        // user-safe by design. Surface verbatim when present; fall
        // back to a generic message if the server gave us nothing.
        final fpMsg = error.message?.trim() ?? '';
        if (fpMsg.isNotEmpty) return fpMsg;
        return _withContext(context, fallback: "We're still getting your account ready. Please try again in a moment.");
      case StatusCode.invalidArgument:
        // PR-bridge: bridge_per_trade_cap_exceeded returns a user-safe
        // message ("bridged trades are capped at ₦50,000 NGN…") that
        // we surface verbatim. Any other InvalidArgument the server
        // sends already shaped a user-readable message; fall back to a
        // generic prompt only when the message is empty.
        final iaMsg = error.message?.trim() ?? '';
        if (iaMsg.isNotEmpty) return iaMsg;
        return 'The amount or details you entered are invalid. Please review and try again.';
      case StatusCode.resourceExhausted:
        // PR-bridge: bridge_daily_volume_cap_reached surfaces a polite
        // "try again later" message that already names what's blocked.
        final reMsg = error.message?.trim() ?? '';
        if (reMsg.isNotEmpty) return reMsg;
        return 'Too many requests. Please wait a few seconds and try again.';
      case StatusCode.aborted:
        // PR12: includes rate_drift_too_large ("Price moved X.XX% since
        // you viewed the quote. Please re-quote.") and quote_expired.
        // PR-bridge: includes bridge_leg2_failed ("Trade is being
        // unwound. Your funds will be refunded.") so the user sees a
        // clear "trade rolling back" message while the compensation
        // worker recovers the NGN in the background. The server is the
        // canonical source of user-facing copy.
        final abMsg = error.message?.trim() ?? '';
        if (abMsg.isNotEmpty) return abMsg;
        return _withContext(context, fallback: 'Quote expired. Please refresh and try again.');
      case StatusCode.internal:
      case StatusCode.unknown:
      default:
        return _withContext(context, fallback: 'Something went wrong. Please try again.');
    }
  }

  // Anything else (network-layer failure, parse error, etc.) → generic.
  return _withContext(context, fallback: 'Something went wrong. Please try again.');
}

String _withContext(String? context, {required String fallback}) {
  if (context == null || context.trim().isEmpty) {
    return fallback;
  }
  // Capitalise context only if it doesn't already start with an uppercase
  // letter; helper text reads "We couldn't finish loading holdings".
  return "We couldn't finish ${context.trim()}. $fallback";
}
