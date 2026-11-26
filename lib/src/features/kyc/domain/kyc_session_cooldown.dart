/// A new Prove session is needed but cannot be minted yet.
///
/// Every `initiate` bills a session charge, so an in-flight session is reused
/// for a window the operator configures (`kyc.mono.session_reuse_seconds`). A
/// repeat with the SAME details is handed the session already paid for and the
/// customer sees nothing. A repeat with CHANGED details cannot be: the stored
/// session carries the old name and would fail at Mono exactly as before — so
/// the customer is asked to wait out the remainder instead of being handed a
/// session that is already known to be wrong.
///
/// [retryAfter] is the server's own figure, not a countdown from a window
/// length hardcoded here. The two would drift the moment an operator changed
/// the setting, and the screen would either re-offer the attempt too early (to
/// the same refusal) or make the customer wait longer than necessary.
class KycSessionCooldownException implements Exception {
  final Duration retryAfter;
  final String message;

  const KycSessionCooldownException({
    required this.retryAfter,
    this.message = '',
  });

  /// Whole minutes remaining, rounded UP, for the modal's headline.
  ///
  /// Rounded up because "try again in 1 minute" with 61 seconds left sends the
  /// customer back a second early, to the same refusal — which reads as the
  /// app being broken rather than as a wait.
  int get minutesRemaining {
    final secs = retryAfter.inSeconds;
    if (secs <= 0) return 0;
    return (secs + 59) ~/ 60;
  }

  /// True once the wait has elapsed and the attempt is worth re-offering.
  bool get elapsed => retryAfter.inSeconds <= 0;

  @override
  String toString() => message.isEmpty
      ? 'A new verification session is needed. Please try again shortly.'
      : message;
}
