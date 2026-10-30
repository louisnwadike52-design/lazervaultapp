/// Two decisions from the phone+passcode signup flow, kept pure so they can be
/// tested and so the client and the server cannot drift apart silently.
///
/// WHY THIS FILE EXISTS. On 30 October 2026 users on the email step were shown
/// "Couldn't use that email" above the line "invalid phone number format", and
/// retried a perfectly good address seven times in six minutes. Two separate
/// defects produced that one banner:
///
///   1. Continue on the email step submits the WHOLE signup — phone, passcode,
///      name and email — so a PHONE rejection arrives on the email screen. The
///      banner title was chosen from the screen's phase alone, so every
///      failure there was announced as an email problem.
///   2. The client sent whatever phone it held without checking it, leaving the
///      server as the only judge. A resumed flow starts with an empty phone
///      (the draft load is async), so an empty string reached SignupWithPhone,
///      which rejected it before touching the database.
///
/// Both are decisions about text and shape, not about state, so they live here
/// rather than inside a cubit or a widget.
library;

/// Whether [phone] is in the E.164 shape the backend requires.
///
/// Mirrors `isValidE164` in
/// `auth-service/internal/service/auth_username.go` EXACTLY — same bounds, same
/// "+" requirement, same digits-only rule. If that function changes, change
/// this one: the point of the pair is that the client refuses locally whatever
/// the server would refuse remotely, instead of spending a round trip to be
/// told so in words the user cannot act on.
///
/// Note this checks SHAPE, not reachability. `canonicalizeE164` on the server
/// does the country-aware normalising; by the time a number is submitted it is
/// already canonical, so shape is the right local test.
bool isValidSignupE164(String phone) {
  if (phone.length < 9 || phone.length > 16) return false;
  if (!phone.startsWith('+')) return false;
  for (final unit in phone.substring(1).codeUnits) {
    if (unit < 0x30 || unit > 0x39) return false; // '0'..'9'
  }
  return true;
}

/// Title for an error banner on the email/verify step.
///
/// Derived from the MESSAGE rather than from which phase the screen is in,
/// because the screen's phase says nothing about what the server rejected. A
/// title that contradicts the line underneath it is worse than a general one.
///
/// [onCodeStep] only breaks the tie when the message itself names nothing
/// specific.
String signupFailureTitle(String message, {required bool onCodeStep}) {
  final m = message.toLowerCase();
  if (m.contains('phone')) return 'Phone number problem';
  if (m.contains('passcode')) return 'Passcode problem';
  if (onCodeStep) return 'Invalid code';
  return "Couldn't use that email";
}
