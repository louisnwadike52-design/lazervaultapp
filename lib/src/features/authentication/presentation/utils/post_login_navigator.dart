import 'dart:async';

import 'package:get/get.dart';

import 'package:lazervault/core/config/feature_flags.dart';
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
/// Always `offAllNamed`: the credential screens behind this must not stay on
/// the stack, or a back gesture returns to a login the user has already passed.
void goAfterLogin(User user, {bool fromForgotPasscode = false}) {
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

  final route = resolvePostLoginRoute(
    step: user.currentSignupStep,
    status: user.signupStatus,
    email: user.email,
    phone: user.phoneNumber,
    hasPasscode: user.hasPasscode,
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
  );
  Get.offAllNamed(route.name, arguments: route.args);
}
