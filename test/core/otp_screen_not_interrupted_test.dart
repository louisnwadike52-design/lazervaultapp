import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Nothing optional may cover a one-time-code entry.
///
/// WHAT CHANGED, AND WHEN. This was not happening before 2026-10-29. Two
/// commits in the window made it start:
///
///   2026-10-31  the optional-update sheet was switched to Get.context so it
///               would render over auth screens. Before that it used the
///               gate's OWN context, which sits above the Navigator, so
///               showModalBottomSheet could not find one and THREW — and the
///               throw was swallowed by _run's catch-all. The sheet therefore
///               never appeared on an auth screen, which is why nobody had
///               seen this.
///   2026-11-03  the gate began re-running on EVERY resume.
///
/// Entering an OTP is the one flow that requires leaving the app — the code is
/// in a mail client or the SMS shade. So "every resume" is precisely "every
/// time the user comes back with the code", and the first screen the sheet
/// lands on is the one they had to leave to complete. From the user's side that
/// reads as the app reloading and scattering the screen as they try to paste.
void main() {
  late String gate;

  setUpAll(() {
    gate = File('lib/src/features/app_status/widgets/app_startup_gate.dart')
        .readAsStringSync();
  });

  test('the optional update sheet is deferred on a code screen', () {
    final guard = gate.indexOf('_isEnteringOneTimeCode()');
    expect(guard, greaterThan(-1),
        reason: 'the one-time-code guard is gone, so an update prompt can '
            'cover the code field again');

    final optional = gate.indexOf('info.type == AppUpdateType.optional');
    final show = gate.indexOf('showUpdateModal(');
    expect(optional, greaterThan(-1));
    expect(show, greaterThan(-1));

    final between = gate.substring(optional, show);
    expect(between.contains('_isEnteringOneTimeCode()'), isTrue,
        reason: 'the guard must sit between the optional-update branch and the '
            'show, or the sheet still appears over the code entry');
  });

  test('a FORCED update still blocks, because that build is unusable', () {
    expect(gate.contains('ForcedUpdateScreen'), isTrue);
    final forced = gate.indexOf('info.type == AppUpdateType.forced');
    final guard = gate.indexOf('_isEnteringOneTimeCode()', forced);
    final optional = gate.indexOf('info.type == AppUpdateType.optional');
    expect(forced, lessThan(optional),
        reason: 'forced must be decided before optional');
    expect(guard, greaterThan(optional),
        reason: 'the guard must apply to the OPTIONAL branch only — suppressing '
            'a forced update would leave someone stuck on a build the backend '
            'no longer supports, with no prompt to escape it');
  });

  test('a TRANSIENT connectivity verdict does not cover the code field', () {
    expect(
      gate.contains('OutageKind.connection') &&
          gate.contains('OutageKind.slowConnection'),
      isTrue,
    );
    final at = gate.indexOf('_isEnteringOneTimeCode() &&');
    expect(at, greaterThan(-1),
        reason: 'returning from a mail app is exactly when the radio is still '
            're-establishing, so a reachability probe reports a connection '
            'problem that has usually already resolved — and the modal is '
            'Positioned.fill, so it blocks the one action the user came back '
            'to perform');
  });

  test('a REAL outage is still shown on a code screen', () {
    // server / plannedMaintenance are ours, are not false positives from a
    // waking radio, and genuinely explain why the code cannot be verified.
    final at = gate.indexOf('_isEnteringOneTimeCode() &&');
    final window = gate.substring(at, at + 260);
    expect(window.contains('OutageKind.server'), isFalse,
        reason: 'suppressing a real server outage would leave the user typing '
            'a code into a backend that cannot answer, with no explanation');
    expect(window.contains('OutageKind.plannedMaintenance'), isFalse,
        reason: 'a declared maintenance window must still be announced');
  });

  test('the guard covers anonymously-pushed code screens', () {
    expect(
      gate.contains("contains('otp')"),
      isTrue,
      reason: 'LoginOtpScreen is pushed with Get.to(() => ...), so it has no '
          'AppRoutes constant and GetX names it /LoginOtpScreen. A named set '
          'alone silently stops protecting a screen the moment someone pushes '
          'it that way.',
    );
  });
}
