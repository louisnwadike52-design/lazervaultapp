/// What the server tells us when a phone-change code goes out.
///
/// WHY THIS TYPE EXISTS. `RequestPhoneChangeResponse` has carried `expires_in`
/// and `resend_after_seconds` since the RPC was written, and the repository
/// returned only `msg` — so the app threw away both numbers and then had to
/// invent replacements. The change-phone screen had no countdown at all and no
/// resend control, which is why a customer whose code did not arrive had
/// exactly one option: leave.
///
/// The same class of bug has bitten this codebase repeatedly — a screen showing
/// a window the server did not agree to. Carrying the server's own figures
/// means the cooldown the button honours is the cooldown the server will
/// enforce, rather than a constant that drifts from it.
class PhoneChangeRequestResult {
  const PhoneChangeRequestResult({
    required this.message,
    required this.expiresInSeconds,
    required this.resendAfterSeconds,
  });

  /// Operator-facing confirmation, already worded by the server.
  final String message;

  /// Seconds until the code dies. 0 when the server did not say — the caller
  /// must then show no countdown rather than guess one.
  final int expiresInSeconds;

  /// Seconds before another code may be requested. The server refuses earlier
  /// requests outright, so the button must not offer one.
  final int resendAfterSeconds;
}
