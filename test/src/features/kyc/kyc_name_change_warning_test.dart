import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A CORRECTED NAME CAN LOCK VERIFICATION, AND THE SCREEN HAS TO SAY SO.
///
/// Measured in production 2026-11-09. A customer ran eight Prove attempts
/// under one surname, corrected it on this screen, and every attempt after
/// that was refused by Mono:
///
///   400 "Customer name does not match the existing record."
///
/// Mono registers a customer against the details we send and then refuses a
/// DIFFERENT name for the same person. 27 refusals before anybody looked.
///
/// The correction itself is right and must stay — Mono validates the name
/// against the BVN record, so a typo makes verification impossible until it is
/// fixed. What was missing is that the screen never said the change has a cost
/// once verification has already been started.
///
/// This is a source assertion because the screen's warning depends on a live
/// `ProveKycHttpService` lookup that a widget test cannot stand up without
/// faking the whole service locator. What is pinned here is the RULE, which is
/// what regresses: that the warning exists, that it is conditional on having
/// started, and that it points at support rather than at retrying.
void main() {
  late String src;

  setUpAll(() {
    src = File('lib/src/features/kyc/presentation/views/'
            'kyc_update_details_screen.dart')
        .readAsStringSync();
  });

  test('the screen warns about an already-started verification', () {
    expect(src.contains('_alreadyStartedWarning'), isTrue,
        reason: 'the warning widget is gone');
    expect(src.contains('verification partner'), isTrue,
        reason: 'the customer must be told WHO holds the conflicting name');
  });

  test('the warning is conditional, not unconditional noise', () {
    // A first-timer who has never started verification is told nothing,
    // because for them a correction really is free. `false` means "we know
    // there is no session".
    expect(src.contains('_verificationStarted != false'), isTrue,
        reason: 'the warning must be suppressed when we KNOW nothing was '
            'started — otherwise it is noise on every signup');
  });

  test('an unknown status still warns, hedged', () {
    // Null is "we could not find out". Not warning somebody who needed it
    // costs them a locked verification; over-warning costs a sentence.
    expect(src.contains('bool? _verificationStarted'), isTrue,
        reason: 'the three-state null is what makes the hedge possible');
    expect(src.contains('If you have already started verification'), isTrue,
        reason: 'the hedged heading for the unknown case is missing');
  });

  test('it points at support, never at retrying', () {
    expect(src.contains('contact support'), isTrue);
    // The whole failure mode was a customer retrying a wall 27 times. The
    // warning must not send them back into it.
    final warn = src.substring(src.indexOf('_alreadyStartedWarning'));
    expect(warn.toLowerCase().contains('try again in a moment'), isFalse);
  });

  test('the correction itself is still offered', () {
    // The fix for this trap must never become "stop letting people fix their
    // name" — that is the only route to passing Mono's BVN name check.
    expect(src.contains('applyCorrectedName'), isTrue,
        reason: 'the correction path was removed, which re-breaks every '
            'customer whose name has a typo');
  });
}
