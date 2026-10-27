import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';

/// Backend-authoritative onboarding resume routing.
///
/// Given the backend's `users.current_signup_step` + `users.signup_status`
/// (both returned in the login response), resolve the route a returning,
/// freshly-authenticated user should land on so they pick up exactly where they
/// left off — even if they quit at an unexpected point or reinstalled (local
/// signup-draft state is NOT consulted; the backend is the source of truth).
///
/// Returns `null` when signup is complete (or for legacy users predating the
/// tracking table), so the caller falls through to its normal
/// dashboard-or-passcode-setup branch.
///
/// Used by BOTH login surfaces — the email/password sign-in and the passcode
/// lock screen — so resumption is identical regardless of how the user logs in.
({String name, Map<String, dynamic> args})? signupResumeRoute(
  String? step,
  String? status, {
  required String email,
  String? phone,
  bool hasPasscode = false,
  bool hasTransactionPin = false,
}) {
  // Backend treats "complete" as the terminal status; anything else is either
  // explicit-incomplete or null (legacy users predating the tracking table —
  // fall through to default routing).
  if (status == null || status.isEmpty) return null;
  if (status == 'complete') return null;
  if (step == null || step.isEmpty) return null;

  return _stepRoute(step,
      email: email,
      phone: phone,
      hasPasscode: hasPasscode,
      hasTransactionPin: hasTransactionPin);
}

/// The destination AFTER a resume-verify step (phone/email) completes, honoring
/// what the user has ALREADY done so they're never re-asked for it: dashboard
/// when passcode+PIN both exist, transaction-PIN setup when only the passcode
/// exists, and passcode setup only when genuinely none. Mirrors the tail of
/// [resolvePostLoginRoute]. This is the fix for the "verify phone → re-asked to
/// set a passcode I already have" bug.
String _postVerifyRoute({
  required bool hasPasscode,
  required bool hasTransactionPin,
}) {
  if (!hasPasscode) return AppRoutes.passcodeSetup;
  if (!hasTransactionPin) return AppRoutes.transactionPinSetup;
  return AppRoutes.dashboard;
}

({String name, Map<String, dynamic> args})? _stepRoute(
  String step, {
  required String email,
  String? phone,
  bool hasPasscode = false,
  bool hasTransactionPin = false,
}) {
  // Where a verify step should hand off once done — never back to passcode
  // setup if the user already has a passcode.
  final nextAfterVerify = _postVerifyRoute(
      hasPasscode: hasPasscode, hasTransactionPin: hasTransactionPin);
  switch (step) {
    case 'email_verify':
      return (
        name: AppRoutes.emailVerification,
        args: <String, dynamic>{
          'email': email,
          'codeSent': false,
          'isRequired': true,
          'secondaryPhone': phone,
          // Carry the user's real next step so email-verify doesn't dead-end
          // into a re-ask for something already set.
          'nextRoute': nextAfterVerify,
        },
      );
    case 'phone_verify':
      if (phone == null || phone.isEmpty) {
        // No phone on file but backend expects phone verify — route to the
        // user's REAL next step (not blindly passcode setup); user can add a
        // phone in Settings.
        return (
          name: nextAfterVerify,
          args: <String, dynamic>{
            'fromLoginFlow': true,
            'hasTransactionPin': hasTransactionPin,
          },
        );
      }
      return (
        name: AppRoutes.phoneVerification,
        args: <String, dynamic>{
          'phoneNumber': phone,
          'codeSent': false,
          'isRequired': false,
          'expiresIn': 600,
          // The phone screen routes here after verify/skip instead of its
          // hardcoded passcodeSetup default — so a user who already set a
          // passcode isn't asked to set one again.
          'nextRoute': nextAfterVerify,
        },
      );
    case 'identity_verify':
      // BVN/NIN flow — KYC entry point.
      return (
        name: AppRoutes.kycBVNVerification,
        args: <String, dynamic>{'fromSignup': true},
      );
    case 'passcode_setup':
    case 'account_created': // user signed up but bailed before any verify
      return (
        name: AppRoutes.passcodeSetup,
        args: <String, dynamic>{
          'fromLoginFlow': true,
          'hasTransactionPin': hasTransactionPin,
        },
      );
  }
  return null;
}

/// THE post-login destination. Every successful-auth surface routes through it.
///
/// "Every" is now literally true and was not before. There were SIX surfaces
/// that could end in an authenticated session — email/password sign-in, the
/// passcode lock screen, email+passcode, phone+passcode, the 2FA verification
/// screen and the step-up OTP screen — and they routed three different ways:
///
///   * 2FA called this function;
///   * email sign-in and the lock screen each had their OWN hand-written tail,
///     which had already drifted (only the lock screen re-gated phone
///     verification; only email sign-in handled forgot-passcode);
///   * email+passcode, phone+passcode and the step-up OTP screen called
///     `Get.offAllNamed(dashboard)` unconditionally, skipping resumption
///     ENTIRELY — so logging in through a step-up OTP, or on a phone+passcode
///     account, walked past an unverified email, an unfinished signup and a
///     never-set transaction PIN straight onto the dashboard.
///
/// Three copies of a routing rule is three places for a gate to be missing
/// from, which is exactly what had happened. One function now, and a gate
/// added here is a gate on every way into the app.
///
/// ## Order, and why
///
///   1. forgot-passcode reset — the user is here to set a passcode, nothing else
///   2. backend-authoritative signup resume (`users.current_signup_step`)
///   3. no passcode → set one; it is the credential everything else assumes
///   4. phone re-verification, when an admin has turned it on
///   5. no transaction PIN → set one
///   6. identity verification, when the platform requires it
///   7. dashboard
///
/// KYC is LAST because it is the heaviest step and the one most likely to be
/// abandoned halfway. Asking for it before the PIN would mean a user who gives
/// up on verification has no working transaction PIN either, and comes back to
/// two unfinished things instead of one.
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
  /// Phone re-verification, for an account that onboarded while the admin
  /// setting was off and comes back after it was turned on. Previously this
  /// lived only in the passcode lock screen's private tail, so the same user
  /// logging in by email was never asked.
  bool phoneVerificationRequired = false,
  bool phoneVerified = true,
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

  final resume = signupResumeRoute(step, status,
      email: email,
      phone: phone,
      hasPasscode: hasPasscode,
      hasTransactionPin: hasTransactionPin);
  if (resume != null) return (name: resume.name, args: resume.args);

  if (!hasPasscode) {
    return (
      name: AppRoutes.passcodeSetup,
      args: <String, dynamic>{
        'fromLoginFlow': true,
        'hasTransactionPin': hasTransactionPin,
      },
    );
  }

  // Phone re-verification gate. Only fires when an admin has turned the
  // requirement on AND the account actually has a number to verify — with no
  // phone on file there is nothing to send a code to, and blocking would
  // strand the user with no way forward.
  if (phoneVerificationRequired && !phoneVerified && (phone?.isNotEmpty ?? false)) {
    return (
      name: AppRoutes.phoneVerification,
      args: <String, dynamic>{
        'phoneNumber': phone,
        'isRequired': true,
        'nextRoute': AppRoutes.dashboard,
      },
    );
  }

  if (!hasTransactionPin) {
    return (
      name: AppRoutes.transactionPinSetup,
      args: <String, dynamic>{'fromLoginFlow': true},
    );
  }

  // Identity verification as a resumption step.
  //
  // This is what "users always have to complete KYC" means in routing terms:
  // with the admin setting ON, an unverified account resumes INTO verification
  // on every login, exactly like any other unfinished onboarding step, and
  // there is no skip. With it OFF this never fires and the dashboard shows the
  // dismissible prompt instead — one setting, two coherent products, and the
  // two cannot disagree because both read the same gate.
  //
  // `inReview` does not land here: that holder has done their part and would
  // otherwise be walked back into a form they already submitted. See KycState.
  if (kyc.blocksDashboard) {
    return (
      name: AppRoutes.kycBVNVerification,
      // No args. The verification screen does not read `isRequired` or
      // `nextRoute` — it reads its own Prove status and enforces a stricter
      // rule than this flag asks for: compulsory below Tier 2, everywhere it
      // appears, with no skip until a BVN is inserted.
      //
      // An earlier version of this passed `isRequired: true` with a comment
      // saying it hid the skip. It did not — the screen ignores it — and a
      // parameter that looks like it enforces something while enforcing
      // nothing is worse than no parameter, because the next person reads the
      // comment instead of the screen.
      args: null,
    );
  }

  return (name: AppRoutes.dashboard, args: null);
}
