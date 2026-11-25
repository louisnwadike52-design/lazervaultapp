/// THE LOGIN GATES THAT ARE NOT FAILURES.
///
/// `email_not_verified` and `phone_not_verified` mean the passcode was RIGHT
/// and one step remains. Every login surface has to do the same two things
/// with them — say so plainly, and route to the screen that finishes it — and
/// until now only one of the four did.
///
/// Reported 2026-11-24 with a screenshot: a customer on the phone+passcode
/// screen saw a red banner reading
///
///   Login failed
///   email_not_verified: please verify your email to continue
///
/// Three faults in one toast: the backend CODE reached a person, it was
/// called a failure when nothing had failed, and it named a next step while
/// offering no way to take it. She re-entered her passcode and got the same
/// banner, for ever.
///
/// auth_error_copy.dart already fixes the wording. This fixes the routing, in
/// one place, so a fifth login surface cannot be added without it.
library;

import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';

/// True when a refusal is the email-verification gate rather than a failure.
bool isEmailVerificationGate(String? raw) =>
    (raw ?? '').toLowerCase().contains('email_not_verified');

/// The address auth-service attached to an email-verification gate.
///
/// The gate fires on a phone+passcode login, where the client has never seen
/// the customer's email — so the verification screen opened with a blank line
/// under "Enter the 6-digit code sent to" and a Resend button with nothing to
/// send to (reported 2026-11-25, with a screenshot of the empty line).
/// auth-service now appends `[verify_email=...]`, which this reads out.
///
/// Returns null when the tail is absent, which is the case for every older
/// build of the backend — the screen then falls back to the stored signup
/// address exactly as it did before.
String? emailFromVerificationGate(String? raw) {
  final m = RegExp(r'\[verify_email=([^\]]+)\]').firstMatch(raw ?? '');
  final value = m?.group(1)?.trim();
  return (value == null || value.isEmpty) ? null : value;
}

/// Remove the machine-readable tails before a refusal is shown to anyone.
///
/// `authErrorCopy` already replaces the whole message for the gates it knows,
/// but a raw message reaches a snackbar on a few screens, and an address in
/// square brackets is not something to print at a customer.
String stripGateTokens(String? raw) =>
    (raw ?? '').replaceAll(RegExp(r'\s*\[verify_email=[^\]]*\]'), '').trim();

/// True when a refusal is the phone-verification gate.
bool isPhoneVerificationGate(String? raw) =>
    (raw ?? '').toLowerCase().contains('phone_not_verified');

/// Send the customer to the screen that finishes the step, and bring them
/// back to [returnTo] so the flow resumes instead of dead-ending.
///
/// `codeSent: true` is correct and not an assumption: `verificationGateError`
/// in auth-service best-effort re-sends a fresh code BEFORE it returns this
/// error, precisely so the client can go straight to the code field. Telling
/// the screen to send another would mail a second code and invalidate the one
/// already in their inbox.
///
/// [onReturn] re-arms the caller's "same error twice" de-duplication. Without
/// it the second attempt is byte-identical to the first, the guard swallows
/// it, and the screen does nothing at all — the exact trap reported on
/// 2026-11-19 on the other passcode screen.
void routeToVerificationGate(
  String? raw, {
  required String returnTo,
  void Function()? onReturn,
}) {
  if (isEmailVerificationGate(raw)) {
    final email = emailFromVerificationGate(raw);
    Get.toNamed(AppRoutes.emailVerification, arguments: {
      'isRequired': true,
      'codeSent': true,
      'nextRoute': returnTo,
      // Absent on an older backend; the screen's stored-email fallback then
      // applies. Never send an empty string — the route treats that as an
      // address and the screen stops looking for a better one.
      if (email != null) 'email': email,
    })?.whenComplete(() => onReturn?.call());
    return;
  }
  if (isPhoneVerificationGate(raw)) {
    // Phone is not hard-gated at login by the server (its verification
    // endpoints need a session, so blocking would strand the customer), but
    // if a surface ever surfaces it, send them somewhere that finishes it
    // rather than showing a code.
    Get.toNamed(AppRoutes.phoneVerification, arguments: {
      'isRequired': true,
      'nextRoute': returnTo,
    })?.whenComplete(() => onReturn?.call());
  }
}

/// True when [raw] is a gate this helper can route.
bool isVerificationGate(String? raw) =>
    isEmailVerificationGate(raw) || isPhoneVerificationGate(raw);
