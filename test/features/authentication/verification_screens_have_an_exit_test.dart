import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// EVERY COMPULSORY VERIFICATION SCREEN NEEDS A WAY OFF IT.
///
/// ## The trap, reported from production 2026-11-11
///
/// A holder was parked on "Verify Your Email" for an address they could not
/// reach, with no exit of any kind:
///
///   * no skip — production hides "Skip for now" because email verification
///     is mandatory there;
///   * no back — the post-login router arrives via `Get.offAllNamed`, so the
///     stack it would pop to does not exist;
///   * no sign-out — `SignupSwitchAccountCta` IS on that screen, but it is
///     gated on `wasResumedThisLaunch`, which means a local SIGNUP DRAFT that
///     main.dart reopened. A post-login resumption is not that, so the widget
///     rendered nothing.
///
/// The app was unusable with no route even back to login. The gate was doing
/// its job; the absence of an exit was not part of the job.
///
/// ## Why a source test
///
/// The failure is a MISSING widget under a combination of conditions, so there
/// is no behaviour to assert against — a widget test would have to reproduce
/// the exact route stack, the environment and the admin flag to see the hole,
/// and would pass for the wrong reason if any of them drifted. What actually
/// needs protecting is simpler and stated directly here: these screens must
/// each carry the sign-out escape.
void main() {
  const screens = <String, String>{
    'lib/src/features/authentication/presentation/views/email_verification_screen.dart':
        'email verification',
    'lib/src/features/authentication/presentation/views/phone_verification_screen.dart':
        'phone verification',
    'lib/src/features/kyc/presentation/views/bvn_signup_screen.dart':
        'BVN capture',
  };

  screens.forEach((path, label) {
    test('$label offers a sign-out when there is nothing to pop back to', () {
      final src = File(path).readAsStringSync();
      expect(
        src.contains('KycGateExitCta'),
        isTrue,
        reason:
            '$path is reachable as the navigation ROOT via '
            'Get.offAllNamed, where back pops an empty stack. Without '
            'KycGateExitCta a holder who cannot complete this step — a '
            'mistyped address, an inbox they no longer control, someone '
            "else's handset — has no route even back to login.",
      );
      expect(
        src.contains('Navigator.of(context).canPop()'),
        isTrue,
        reason:
            '$path must show the exit ONLY when genuinely trapped. '
            'Offering a sign-out to someone who could simply press back is an '
            'invitation to lose their session for no reason.',
      );
    });
  });

  // The remedy is shared across three different gates, so its copy cannot name
  // one of them. A dialog telling an email-verification holder that "verifying
  // your identity is required" explains the wrong thing on the one screen
  // whose whole job is to explain itself.
  test('the sign-out dialog names the step that is actually blocking', () {
    final src = File(
      'lib/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart',
    ).readAsStringSync();
    expect(
      src.contains('this.blockedBy'),
      isTrue,
      reason: 'KycGateExitCta must accept the blocking step as a parameter',
    );
    expect(
      src.contains(r"${blockedBy ?? 'Verifying your identity'}"),
      isTrue,
      reason: 'the dialog body must use it, defaulting to identity',
    );
  });
}
