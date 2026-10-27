import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';

/// THE post-login destination. Every successful-auth surface routes through it.
///
/// ## The state decides, not the step label
///
/// Every screen this can land on exists to CHANGE one fact about the account:
/// the email is verified, the phone is verified, a passcode exists, a PIN
/// exists, identity is verified. So the only question worth asking before
/// showing one is whether that fact is already true — and every login
/// response carries the answer: `email_verified`, `phone_verified`,
/// `has_passcode`, `has_transaction_pin`, `kyc_tier` / `kyc_status`.
///
/// An earlier version routed from `users.current_signup_step` first and asked
/// those questions second. The step column is written by a tracker that, until
/// today, moved a FINISHED account back to a step whenever it verified
/// something later — a phone verified from Settings a month after signup put
/// `current_signup_step = identity_verify` on a Tier-3 holder, and
/// `passcode_setup` on someone who had typed their passcode that morning. The
/// router believed the label over the facts, so the next login opened on
/// "Set Up Passcode" for a passcode that existed, and on a verification screen
/// that greeted the holder with "You're Verified".
///
/// The backend no longer regresses the column, and heals rows it already did
/// (see auth-service `ReconcileSignupStatus`). But a label is still only a
/// hint: here it is consulted for exactly one thing — whether an unfinished
/// signup is parked at email verification when the admin does not otherwise
/// require it. Everything else reads the fact.
///
/// ## Order, and why
///
///   1. forgot-passcode reset — the user is here to set a passcode, nothing else
///   2. email, when it is unverified and either required or the signup is
///      parked on it
///   3. passcode — the credential everything else assumes. NO skip, for any
///      account: a social (Google/Apple) sign-in with no passcode resumes
///      INTO this step like any other unfinished onboarding step
///   4. phone, when the account has a number it has not verified. Shown whether
///      or not the admin requires it; the admin setting decides only whether
///      the screen offers "Skip for now"
///   5. transaction PIN
///   6. identity verification, when the platform requires it
///   7. dashboard
///
/// KYC is LAST because it is the heaviest step and the one most likely to be
/// abandoned halfway. Asking for it before the PIN would mean a user who gives
/// up on verification has no working transaction PIN either, and comes back to
/// two unfinished things instead of one.
///
/// ## Chaining
///
/// A verification screen that finishes (or is skipped) does not get to guess
/// where to go next. It is handed `nextRoute` + `nextRouteArgs`, computed HERE
/// by re-running this resolver with that one fact flipped to done — so the
/// phone screen hands over to the PIN gate, the KYC gate or the dashboard by
/// the same rule every login uses, and never to "passcode setup" for someone
/// who has one.
({String name, Map<String, dynamic>? args}) resolvePostLoginRoute({
  required String? step,
  required String? status,
  required String email,
  String? phone,
  required bool hasPasscode,
  required bool hasTransactionPin,
  bool fromForgotPasscode = false,

  /// Identity verification state + whether the platform requires it.
  ///
  /// REQUIRED, and one value rather than two optionals, so a surface cannot
  /// supply half of it and silently lose the gate. Pass [KycLoginGate.none] to
  /// mean "not gating on this here".
  required KycLoginGate kyc,

  /// Admin toggle: whether phone verification may be skipped. This does NOT
  /// decide whether the phone screen is shown — an unverified number is shown
  /// either way — only whether it carries "Skip for now".
  bool phoneVerificationRequired = false,
  bool phoneVerified = true,

  /// Admin toggle for email, same shape. Email is ALSO gated server-side at
  /// login when required, so by the time this runs a required-and-unverified
  /// email is rare; the gate here is belt-and-braces plus the signup-parked
  /// case.
  bool emailVerificationRequired = false,
  bool isEmailVerified = true,
}) {
  if (fromForgotPasscode) {
    return (
      name: AppRoutes.passcodeSetup,
      args: <String, dynamic>{
        'fromLoginFlow': true,
        'hasTransactionPin': hasTransactionPin,
        'fromForgotPasscode': true,
      },
    );
  }

  // Everything after a verification step is "this resolver, with that fact
  // now true, and the signup label out of the picture" — the label has done
  // its one job by then.
  ({String name, Map<String, dynamic>? args}) after({
    bool? emailDone,
    bool? phoneDone,
  }) =>
      resolvePostLoginRoute(
        step: null,
        status: null,
        email: email,
        phone: phone,
        hasPasscode: hasPasscode,
        hasTransactionPin: hasTransactionPin,
        kyc: kyc,
        phoneVerificationRequired: phoneVerificationRequired,
        phoneVerified: phoneDone ?? phoneVerified,
        emailVerificationRequired: emailVerificationRequired,
        isEmailVerified: emailDone ?? isEmailVerified,
      );

  // 2. Email.
  if (email.isNotEmpty &&
      !isEmailVerified &&
      (emailVerificationRequired ||
          _signupParkedAtEmail(step: step, status: status))) {
    final next = after(emailDone: true);
    return (
      name: AppRoutes.emailVerification,
      args: <String, dynamic>{
        'email': email,
        'codeSent': false,
        'isRequired': emailVerificationRequired,
        'secondaryPhone': phone,
        'nextRoute': next.name,
        'nextRouteArgs': next.args,
      },
    );
  }

  // 3. Passcode. `fromLoginFlow` is what hides the skip: a passcode is the
  // credential the lock screen, biometrics and every quick login assume, and
  // someone who is already signed in has no onboarding to be hurried through.
  //
  // That includes a PROVIDER-LINKED account. A Google or Apple holder signs
  // in through the provider, but the passcode is what the app lock, the
  // biometric unlock and every quick login use once they are inside — so a
  // social sign-in without one resumes into this step too, and there is
  // nothing to skip to. Setting it needs nothing external: six digits,
  // twice, with no code, no document and no provider in the way.
  if (!hasPasscode) {
    return (
      name: AppRoutes.passcodeSetup,
      args: <String, dynamic>{
        'fromLoginFlow': true,
        'hasTransactionPin': hasTransactionPin,
      },
    );
  }

  // 4. Phone. Only when there is a number to send a code to — with none,
  // blocking would strand the user with no way forward.
  if ((phone?.isNotEmpty ?? false) && !phoneVerified) {
    final next = after(phoneDone: true);
    return (
      name: AppRoutes.phoneVerification,
      args: <String, dynamic>{
        'phoneNumber': phone,
        'codeSent': false,
        'isRequired': phoneVerificationRequired,
        'expiresIn': 600,
        'nextRoute': next.name,
        'nextRouteArgs': next.args,
      },
    );
  }

  // 5. Transaction PIN.
  if (!hasTransactionPin) {
    return (
      name: AppRoutes.transactionPinSetup,
      args: <String, dynamic>{'fromLoginFlow': true},
    );
  }

  // 6. Identity verification.
  //
  // With the admin setting ON, an unverified account resumes INTO verification
  // on every login, exactly like any other unfinished onboarding step, and
  // there is no skip. With it OFF this never fires and the dashboard shows the
  // dismissible prompt instead — one setting, two coherent products, and the
  // two cannot disagree because both read the same gate.
  //
  // A verified holder never lands here whatever `current_signup_step` says:
  // the gate reads `kyc_tier` / `kyc_status`, which is the fact. `inReview`
  // does not land here either — that holder has done their part and would
  // otherwise be walked back into a form they already submitted.
  if (kyc.blocksDashboard) {
    return (
      name: AppRoutes.kycBVNVerification,
      // No args. The verification screen does not read `isRequired` or
      // `nextRoute` — it reads its own Prove status and enforces a stricter
      // rule than this flag asks for: compulsory below Tier 2, everywhere it
      // appears, with no skip until a BVN is inserted.
      args: null,
    );
  }

  return (name: AppRoutes.dashboard, args: null);
}

/// The one thing the backend's signup label is still consulted for.
///
/// An unfinished signup whose recorded step is email verification (or
/// account creation, which precedes it) is resumed there even when the admin
/// does not require email verification — that is where the person left off,
/// and the screen offers "Skip for now" in exactly that configuration. Once
/// the backend marks the signup complete, the label is ignored for good.
bool _signupParkedAtEmail({required String? step, required String? status}) {
  if (status == null || status.isEmpty || status == 'complete') return false;
  return step == 'email_verify' || step == 'account_created';
}
