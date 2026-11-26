import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE SIGNUP OTP STEP WAS A DEAD END ON RESUMPTION.
///
/// Two ways in, and only one had an exit:
///
///   * DIRECT SIGNUP — phone_entry pushes it with Get.toNamed, so the stack
///     can pop and PhoneFlowScaffold derives a working back arrow.
///   * RESUMPTION — main.dart routes a half-finished phone signup here as the
///     INITIAL route. Empty stack, so the arrow is correctly suppressed; and
///     with the SMS provider active there is deliberately no skip. Nothing
///     left to tap: a shared handset or a number typed wrongly yesterday, and
///     the app opened on a code that could never arrive.
///
/// Asserted on the source because the trap is a NAVIGATION-ENTRY property —
/// it needs a cold boot with a persisted half-signup, which a widget test
/// cannot stage without rebuilding main()'s routing.
void main() {
  final otp = File(
    'lib/src/features/authentication/presentation/views/phone_otp_screen.dart',
  ).readAsStringSync();

  test('the resumed-signup exit is present on the OTP step', () {
    expect(otp.contains('SignupSwitchAccountCta'), isTrue,
        reason: 'on a resumption this screen is the navigation root with no '
            'back arrow and no skip — without this there is no way out of the '
            'app at all');
  });

  // WHERE IT SITS DECIDES WHETHER IT CAN BE SEEN, and the first attempt got
  // this wrong in the opposite direction.
  //
  // It went into `children` with the light-surface (grey) variant. But
  // `children` scroll over the light middle of the curve and end against the
  // PURPLE band at the bottom, so #6B7280 on purple was an exit that existed
  // and could not be read — reported as "items at the bottom are not
  // visible".
  //
  // PhoneFlowScaffold has a slot for exactly this: `footer` floats over the
  // background bottom, expects white text, and hides itself while the keyboard
  // is up so it can never cover the input.
  test('the exit sits in the footer slot, not the scrolling body', () {
    final atFooter = RegExp(r'footer:\s*const SignupSwitchAccountCta')
        .hasMatch(otp);
    expect(atFooter, isTrue,
        reason: 'in the body it renders against the purple band at the bottom '
            'of the curve, where the light-surface grey cannot be read');

    expect(otp.contains('onLightSurface: true'), isFalse,
        reason: 'the footer is the purple band — the light-surface variant is '
            'grey, which is the combination that made it invisible');
  });

  // The gate is what keeps first-run signup clean. Without it, everyone
  // halfway through creating an account is invited to abandon it.
  test('the exit gates itself on a RESUME, not on having a draft', () {
    final cta = File(
      'lib/src/features/authentication/presentation/widgets/'
      'signup_switch_account_cta.dart',
    ).readAsStringSync();

    expect(cta.contains('SignupStateService.wasResumedThisLaunch'), isTrue,
        reason: 'gating on has_incomplete_signup instead would show an '
            '"abandon this" link to people mid-signup, which is the opposite '
            'of what is wanted there');
  });

  // main.dart must actually set the flag on the path that reaches this screen,
  // or the exit never renders on the one entry that needs it.
  test('main.dart marks the phone-signup resume', () {
    final main = File('lib/main.dart').readAsStringSync();
    final idx = main.indexOf('SignupStateService.wasResumedThisLaunch = true');
    expect(idx, greaterThan(-1),
        reason: 'nothing sets the resume flag, so the exit can never show');

    // It must be set BEFORE the route is resolved, or the screen builds with
    // the flag still false and renders nothing.
    final routeCall = main.indexOf('_getRouteForPhoneSignupStep');
    expect(idx, lessThan(routeCall),
        reason: 'the flag is set after the resume route is chosen, so the '
            'screen would build before it is true');
  });
}
