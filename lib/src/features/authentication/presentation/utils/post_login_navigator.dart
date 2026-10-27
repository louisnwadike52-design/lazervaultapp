import 'dart:async';

import 'package:get/get.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/login_facts_store.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_login_prompt.dart';

/// THE ONE CALL EVERY SUCCESSFUL LOGIN MAKES.
///
/// [resolvePostLoginRoute] decides WHERE an authenticated user goes; this
/// decides what to feed it and then goes there. It exists so the six auth
/// surfaces share not just the routing rule but the INPUTS to it — which is
/// where the previous divergence actually lived.
///
/// When each screen assembled its own arguments, each could omit one. The
/// passcode lock screen read `FeatureFlags.isPhoneVerificationRequired` and the
/// email sign-in did not, so the same account was re-gated on one login surface
/// and waved through on the other, with nothing in either file to suggest the
/// other existed. A new input — identity verification being the current one —
/// would have had six chances to be forgotten.
///
/// There is one here instead. A gate added to the resolver reaches every way
/// into the app the moment this function passes it.
///
/// ## The user must carry the facts
///
/// The resolver gates on `hasPasscode`, `hasTransactionPin`, `verified`
/// (phone), `isEmailVerified` and the KYC fields. A credential login carries
/// all of them on the auth proto. A biometric or voice unlock rebuilds the user
/// from the PROFILE proto, which carries none — every one of those defaults to
/// false, and false means "go and set one up". That is how a Face ID unlock
/// came to open on "Set Up Passcode" for someone who had typed their passcode
/// that morning. Those paths must enrich the user first; see
/// `SessionLoginCompleter` and `enrichSessionUser`.
///
/// Always `offAllNamed`: the credential screens behind this must not stay on
/// the stack, or a back gesture returns to a login the user has already passed.
void goAfterLogin(
  User user, {
  bool fromForgotPasscode = false,

  /// True when this call follows the passcode-setup screen completing INSIDE
  /// the login flow. The `User` in hand predates that write, so its
  /// `hasPasscode` is still false; without this the resolver would send the
  /// person straight back to the screen they just finished.
  bool passcodeJustSet = false,

  /// True when this call follows the passcode-setup screen being SKIPPED from
  /// inside the login flow — which only a provider-linked account can do (see
  /// [resolvePostLoginRoute]). Unlike [passcodeJustSet] it asserts nothing
  /// about the account: no passcode was created, nothing is recorded, and the
  /// next login offers it again. It only stops this one routing pass from
  /// sending the person back to the screen they just declined.
}) {
  // A NEW SESSION STARTS HERE, so the once-per-login verification prompt is
  // armed again. Placed in the shared navigator rather than at each login
  // screen for the same reason everything else is: six places to remember is
  // six places to forget, and forgetting would mean someone who skipped once
  // is never asked again.
  KycLoginPrompt.resetForNewSession();

  // Record what THIS login saw, when it saw anything. Biometric and voice
  // logins carry no KYC fields (see KycSnapshot) and deliberately do not
  // overwrite — remember() ignores an empty reading, so the last credential
  // login's answer survives.
  //
  // Fire-and-forget: routing must not wait on a preferences write, and a
  // failed write only costs a prompt that does not fire.
  unawaited(KycSnapshot.remember(
    tier: user.kycTier,
    status: user.kycStatus,
  ));

  // Write down what this login knows, so the NEXT biometric or voice unlock
  // can open on it without a round trip. See LoginFactsStore. Fire-and-forget
  // for the same reason as the snapshot above.
  //
  // Only when the user LOOKS like a backend answer. A session unlock whose
  // backend lookups all failed arrives here carrying fail-safe defaults over a
  // profile-proto user — no signup status, no KYC status — and writing those
  // down would turn one outage into a month of "has a PIN".
  if (user.signupStatus != null || user.kycStatus != null) {
    unawaited(LoginFactsStore.record(
      user.hasPasscode || passcodeJustSet
          ? user.copyWith(hasPasscode: true)
          : user,
    ));
  }

  final route = resolvePostLoginRoute(
    step: user.currentSignupStep,
    status: user.signupStatus,
    email: user.email,
    phone: user.phoneNumber,
    hasPasscode: user.hasPasscode || passcodeJustSet,
    hasTransactionPin: user.hasTransactionPin,
    fromForgotPasscode: fromForgotPasscode,
    // Reads the live admin setting, so turning verification on or off in the
    // dashboard changes where the NEXT login lands with no app release.
    kyc: KycLoginGate.forHolder(
      kycStatus: user.kycStatus,
      kycTier: user.kycTier,
    ),
    phoneVerificationRequired: FeatureFlags.isPhoneVerificationRequired,
    // `User.verified` mirrors the proto's phone_verified (see
    // UserModel.fromAuthProto) — not a general "is this account verified".
    phoneVerified: user.verified,
    emailVerificationRequired: FeatureFlags.isEmailVerificationRequired,
    isEmailVerified: user.isEmailVerified,
    // A Google/Apple account is OFFERED a passcode rather than required to
    // set one — the provider link is already its credential.
  );
  Get.offAllNamed(route.name, arguments: route.args);
}
