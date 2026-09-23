import 'package:google_sign_in/google_sign_in.dart';

/// Turning a Google sign-in failure into something the user can act on.
///
/// WHY THIS EXISTS
/// ---------------
/// Connecting Google from Plan My Day dropped the user on Google's own page:
///
///   Access blocked: Lazervault has not completed the Google verification process
///   Error 403: access_denied
///
/// That is not a bug in this app and nothing in it can be retried into working. The
/// OAuth consent screen is in TESTING, so only accounts listed as test users may
/// consent — and the Gmail scopes this feature needs (gmail.readonly, gmail.send) are
/// RESTRICTED, which requires Google verification before any non-test user can be
/// allowed at all.
///
/// The app's job is to say so plainly instead of leaving a raw provider error as the
/// last thing the user saw. "Try again" is actively wrong here: it will fail every time
/// until someone changes the Cloud Console.
class GoogleConnectError {
  const GoogleConnectError._();

  /// True when Google refused because this app is not yet verified for the account.
  ///
  /// The signal arrives inconsistently — sometimes as an exception code, sometimes only
  /// as `access_denied` inside the description — so the text is what is examined.
  ///
  /// The explicit markers are matched on their own; a bare status code is not. This
  /// message tells the user to contact support, and support can do nothing about an
  /// unrelated failure that merely happens to mention 403, so the cost of a false
  /// positive is a wasted support conversation rather than a slightly vague error.
  static bool isNotApprovedForThisAccount(Object error) {
    final text = error.toString().toLowerCase();

    // The unambiguous signals first.
    if (text.contains('access_denied') ||
        text.contains('has not completed the google verification') ||
        text.contains('developer-approved testers')) {
      return true;
    }

    // A bare "403" is NOT enough on its own — it appears in unrelated failures, and
    // mislabelling one of those as "we are not approved yet" sends the user to support
    // for something support cannot fix. Only treat it as this case when it arrives
    // alongside language that actually means refusal.
    return text.contains('403') &&
        (text.contains('denied') ||
            text.contains('blocked') ||
            text.contains('not completed') ||
            text.contains('verification'));
  }

  /// True when the user simply backed out. Not a failure, and must not read as one.
  static bool isCancelled(Object error) =>
      error is GoogleSignInException &&
      error.code == GoogleSignInExceptionCode.canceled;

  /// A message describing what actually happened and who can fix it.
  ///
  /// [feature] names what the user was connecting ("Gmail", "Google Calendar") so the
  /// sentence reads naturally wherever it is shown.
  static String message(Object error, {required String feature}) {
    if (isCancelled(error)) return 'Sign-in was cancelled';

    if (isNotApprovedForThisAccount(error)) {
      // Deliberately does NOT say "try again". It cannot succeed until the account is
      // added as a tester or the app completes Google's review, and inviting a retry
      // would send the user round the same loop.
      return "Google hasn't approved this app for $feature yet, so it can only be "
          "connected by accounts our team has added for testing. Ask support to add "
          "your Google account, or check back once verification is complete.";
    }

    if (error is GoogleSignInException) {
      final detail = error.description ?? error.code.name;
      return 'Could not connect $feature: $detail';
    }
    return 'Could not connect $feature. Please try again.';
  }
}
