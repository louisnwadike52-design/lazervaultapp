import 'package:shared_preferences/shared_preferences.dart';

/// Stops the email-verification screen auto-sending a code that replaces one
/// already sitting in the user's inbox.
///
/// WHY
///
/// EmailVerificationScreen auto-sends on mount whenever it is entered with
/// `codeSent: false` — which is how four of the nine navigation sites enter it
/// (authentication_cubit x2, phone_verification_step, signup_resume). That send
/// goes through the RESEND endpoint, and on the server
/// CreateEmailVerification DELETES the user's existing verification row before
/// inserting the new one. So a re-mount does not merely send a second email: it
/// INVALIDATES the code the user is, at that moment, switching apps to go and
/// read.
///
/// Measured on prod 2026-11-05: one user received eleven codes in minutes, and
/// every verification failure that day was the row-not-found branch rather than
/// the expiry branch — the codes were not timing out, they were being deleted
/// out from under the user.
///
/// A re-mount is easy to cause and invisible to the user: anything that
/// replaces the subtree (the startup gate returning ForcedUpdateScreen), a
/// resumed-signup navigation, or the OS reclaiming and cold-starting the app
/// while they are in their mail client.
///
/// WHAT THIS DOES
///
/// Records when a code was last sent for an address, and refuses an automatic
/// send inside that window. It gates ONLY the automatic on-mount send — the
/// "Resend Code" button is the user explicitly asking for a new code, and must
/// always work, because replacing the code is exactly what they want then.
class EmailOtpSendGuard {
  const EmailOtpSendGuard._();

  static const String _keyPrefix = 'email_otp_last_sent_';

  /// Matches the server's own 60-second resend throttle
  /// (auth_verify.go: `time.Since(lastVerification.CreatedAt) < 60*time.Second`)
  /// plus headroom for the round trip, so the client stops asking for sends the
  /// server would refuse anyway — and, more importantly, stops asking for ones
  /// it would ACCEPT and thereby kill a live code.
  ///
  /// Deliberately shorter than the code's own lifetime: a user who genuinely
  /// never received the first email should not be held off for the full window,
  /// and past this they can also use the Resend button, which is never gated.
  static const Duration window = Duration(seconds: 90);

  /// Overridable for tests.
  static Future<SharedPreferences> Function() prefs =
      SharedPreferences.getInstance;

  static String _key(String email) =>
      '$_keyPrefix${email.trim().toLowerCase()}';

  /// Whether an AUTOMATIC send is allowed for [email] right now.
  ///
  /// Fails OPEN: if the timestamp cannot be read we send, because never
  /// sending would strand a user who has no code at all — a worse failure than
  /// an extra email.
  static Future<bool> mayAutoSend(String email) async {
    if (email.trim().isEmpty) return false;
    try {
      final p = await prefs();
      final at = p.getInt(_key(email));
      if (at == null) return true;
      final since = DateTime.now().millisecondsSinceEpoch - at;
      if (since < 0) return true; // clock moved backwards; do not trust it
      return since >= window.inMilliseconds;
    } catch (_) {
      return true;
    }
  }

  /// Records that a code was just sent for [email].
  static Future<void> markSent(String email) async {
    if (email.trim().isEmpty) return;
    try {
      final p = await prefs();
      await p.setInt(_key(email), DateTime.now().millisecondsSinceEpoch);
    } catch (_) {
      // A failed write only costs us the guard on the next mount, which is the
      // pre-existing behaviour.
    }
  }

  /// Forgets the marker — used once the email is verified, so a later signup or
  /// a re-verification on the same address is not held off by a stale stamp.
  static Future<void> clear(String email) async {
    if (email.trim().isEmpty) return;
    try {
      final p = await prefs();
      await p.remove(_key(email));
    } catch (_) {}
  }
}
