/// WHERE A FLOW GOES WHEN IT REACHES THE PHONE-VERIFICATION STEP.
///
/// THE BUG THIS FIXES. `signup_steps.dart` takes the phone-OTP step OUT of the
/// journey when no provider can deliver a code, and `signup_resume.dart` and
/// `post_login_navigator.dart` both honour that. But the phone-verification
/// screen is also pushed DIRECTLY from four other places, and not one of them
/// asked:
///
///   * `main.dart` `_getRouteForSignupStep`, resuming step `phone_verify`
///   * `email_verification_screen.dart`, chaining on from email verification
///   * `sign_up.dart`, after creating a phone-primary account
///
/// The sibling map in the same file, `_getRouteForPhoneSignupStep`, DID get the
/// guard. So the phone-flow resume was safe and the email-flow resume was not,
/// which is why this surfaced as "the OTP screen still appears on login": a
/// customer resuming at `phone_verify` landed on a screen that requests a code
/// on load, the request was refused by the server's SMS gate, and they were
/// left on a dead end being told the code could not be sent.
///
/// SO THE DECISION LIVES HERE, ONCE. A caller says it has reached the phone
/// step; this says where that actually goes. Adding a fifth navigation site
/// means calling this, not re-deriving the rule — which is the same reasoning
/// `signup_steps.dart` records for the progress bar, and the same drift that
/// produced this bug.

/// Whether the phone-OTP screen may be shown at all.
///
/// One getter, delegating to [SmsPolicy], so this module cannot disagree with
/// the signup progress bar about whether the step exists.
library;

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';

bool get phoneOtpStepAvailable => SmsPolicy.showSignupOtpStep;

/// The route for the phone-verification step, with the arguments to pass it.
///
/// Returns the ONWARD step when a code cannot be delivered — email
/// verification when there is an address to use, passcode setup otherwise.
/// That is not a new rule: it is exactly what the phone-verification screen's
/// own `_navigateToNextScreen` does when the user taps "Skip for now", so a
/// flow that never shows the screen lands where a flow that skipped it would.
///
/// [secondaryEmail] is the address to fall back to, when the caller has one.
/// Both signup hops already carry it for precisely this chaining.
({String name, Map<String, dynamic>? args}) phoneVerificationStepRoute({
  String? phoneNumber,
  String? secondaryEmail,
  bool isRequired = false,
  bool codeSent = false,
  int expiresInSeconds = 600,
}) {
  final hasPhone = phoneNumber != null && phoneNumber.isNotEmpty;
  if (hasPhone && phoneOtpStepAvailable) {
    return (
      name: AppRoutes.phoneVerification,
      args: <String, dynamic>{
        'phoneNumber': phoneNumber,
        'codeSent': codeSent,
        'expiresIn': expiresInSeconds,
        'isRequired': isRequired,
        'secondaryEmail': secondaryEmail,
      },
    );
  }
  return onwardFromPhoneVerification(secondaryEmail: secondaryEmail);
}

/// The step AFTER phone verification — the shared destination for skipping it,
/// completing it, and never showing it.
///
/// Email verification is preferred when an address exists because email is the
/// channel that works whatever the SMS provider is doing (see
/// `signup_steps.dart`), so the account still ends up with ONE verified
/// contact rather than none.
({String name, Map<String, dynamic>? args}) onwardFromPhoneVerification({
  String? secondaryEmail,
}) {
  if (secondaryEmail != null && secondaryEmail.isNotEmpty) {
    return (
      name: AppRoutes.emailVerification,
      args: <String, dynamic>{
        'email': secondaryEmail,
        'codeSent': false,
        // Skippable: this is a FALLBACK for a step we could not run, so it
        // must not be harder to get past than the step it replaced.
        'isRequired': false,
        'secondaryPhone': null,
      },
    );
  }
  // Reached only from flows with an INCOMPLETE signup, which by definition
  // have no passcode yet (see main.dart's call sites), so passcode setup is
  // the genuine next step and not a screen the user has already finished.
  return (name: AppRoutes.passcodeSetup, args: null);
}
