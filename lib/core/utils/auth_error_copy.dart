/// Turns a backend auth failure into something a person can act on.
///
/// Reported 2026-10-26: a user resuming login saw a red banner reading
/// "Login Failed — email_not_verified: please verify your email to continue",
/// on top of the Verify Your Email screen they had just been routed to.
///
/// Three things were wrong with that, and they are separate problems:
///
///  1. The raw backend CODE reached the user. The house rule is that people
///     see something plain while the detail goes to the logs.
///  2. "Login Failed" was not true. The passcode was correct and the account is
///     fine; one step remains. Calling that a failure makes people think they
///     mistyped and retry the thing that already worked.
///  3. It was shown AT ALL on a screen that already explains the next step, so
///     the banner covered the instruction it was duplicating.
///
/// [authErrorCopy] fixes the first two. The third is handled by the caller,
/// which now suppresses the banner when it has already routed somewhere that
/// says the same thing better.
library;

/// A user-facing title and message for an auth failure.
class AuthErrorCopy {
  const AuthErrorCopy(this.title, this.message, {this.suppressBanner = false});

  final String title;
  final String message;

  /// True when the screen the user is being sent to already explains this, so
  /// a banner would just cover that explanation.
  final bool suppressBanner;
}

/// Map a raw failure message to copy. Unknown shapes get a generic line — never
/// the raw text, which is where codes and stack fragments leak from.
AuthErrorCopy authErrorCopy(String? raw) {
  final s = (raw ?? '').toLowerCase();

  if (s.contains('email_not_verified')) {
    return const AuthErrorCopy(
      'One more step',
      'Verify your email to finish signing in. We have sent you a code.',
      // The app routes to the verification screen, which states this and shows
      // the code field. A banner on top of it adds nothing and hides the form.
      suppressBanner: true,
    );
  }
  if (s.contains('phone_not_verified')) {
    return const AuthErrorCopy(
      'One more step',
      'Verify your phone number to finish signing in.',
      suppressBanner: true,
    );
  }
  if (s.contains('invalid_credentials') ||
      s.contains('invalid passcode') ||
      s.contains('incorrect passcode')) {
    // Deliberately does not say WHICH part was wrong — that tells an attacker
    // whether an identifier exists.
    return const AuthErrorCopy(
        'Incorrect passcode', 'That passcode did not match. Please try again.');
  }
  if (s.contains('account_locked') || s.contains('too many attempts')) {
    return const AuthErrorCopy('Account locked',
        'Too many attempts. Please wait a moment and try again.');
  }
  if (s.contains('account_frozen') || s.contains('fraud')) {
    return const AuthErrorCopy('Account on hold',
        'Your account is temporarily on hold. Please contact support.');
  }
  if (s.contains('network') ||
      s.contains('timeout') ||
      s.contains('socket') ||
      s.contains('unreachable') ||
      s.contains('connection')) {
    return const AuthErrorCopy('No connection',
        'We could not reach Lazervault. Check your connection and try again.');
  }
  if (s.contains('unavailable') || s.contains('503') || s.contains('502')) {
    return const AuthErrorCopy(
        'Try again shortly', 'We are having a brief problem on our side.');
  }

  return const AuthErrorCopy(
      'Could not sign in', 'Something went wrong. Please try again.');
}
