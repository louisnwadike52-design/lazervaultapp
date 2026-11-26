import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/app_status/widgets/app_startup_gate.dart';

/// A DEEP LINK MUST NOT BE SPENT ON A SCREEN NOBODY CAN SEE.
///
/// Every other "is it safe to navigate" check reads either `Get.currentRoute`
/// or `Get.isDialogOpen`. AppStartupGate's two blockers are neither:
///
///   * the forced-update screen is returned INSTEAD of `child`, so the app's
///     Navigator is not in the tree at all;
///   * the maintenance overlay is a `Positioned.fill` inside a Stack.
///
/// Both leave the route unchanged and register no dialog, so a replay
/// concluded the coast was clear, "navigated", and CONSUMED the stash. The
/// link was then gone — on precisely the outdated or offline build most likely
/// to have been sent one. `AppStartupGate.blockingTheScreen` is what closes
/// that, and these pin the wiring on both sides.
void main() {
  tearDown(() => AppStartupGate.blockingTheScreen = false);

  test('the flag exists and defaults to not-blocking', () {
    expect(AppStartupGate.blockingTheScreen, isFalse,
        reason: 'defaulting to blocked would strand every link');
  });

  test('the gate RAISES the flag for the forced-update screen', () {
    final src = File(
      'lib/src/features/app_status/widgets/app_startup_gate.dart',
    ).readAsStringSync();

    final forcedAt = src.indexOf('return ForcedUpdateScreen(');
    expect(forcedAt, greaterThan(-1),
        reason: 'the forced-update branch moved — recheck this wiring by hand');
    final before = src.substring(0, forcedAt);
    expect(
      before.contains('AppStartupGate.blockingTheScreen = true'),
      isTrue,
      reason: 'the flag must be raised BEFORE returning the forced-update '
          'screen, or a replay runs against a Navigator that is not mounted',
    );
  });

  test('the gate tracks the maintenance overlay too', () {
    final src = File(
      'lib/src/features/app_status/widgets/app_startup_gate.dart',
    ).readAsStringSync();
    expect(
      src.contains('AppStartupGate.blockingTheScreen = maintenanceVisible'),
      isTrue,
      reason: 'the overlay covers the screen on a pre-login route; a link '
          'replayed underneath it renders against a backend that is down',
    );
  });

  test('the navigator CONSULTS the flag', () {
    // The other half. A flag nobody reads is worse than no flag: it reads as
    // handled.
    final src = File(
      'lib/core/notifications/notification_navigator.dart',
    ).readAsStringSync();
    expect(
      src.contains('AppStartupGate.blockingTheScreen'),
      isTrue,
      reason: 'notification_navigator must defer while the gate is blocking',
    );

    // And it must be checked INSIDE the gate predicate, next to the dialog
    // check — not somewhere a later edit would bypass.
    final predicateAt = src.indexOf('bool _onAuthOrLockRoute()');
    expect(predicateAt, greaterThan(-1));
    final predicate = src.substring(predicateAt);
    final end = predicate.indexOf('\n  }');
    expect(
      predicate.substring(0, end > 0 ? end : predicate.length),
      contains('AppStartupGate.blockingTheScreen'),
    );
  });
}
