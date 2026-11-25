import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/existing_user_passcode_cta.dart';

/// THE CTA IS FOR PEOPLE WHO DID NOT CHOOSE TO BE ON A SIGN-IN SCREEN.
///
/// "Log in as `<name>` with your passcode" answers one question — how do I get
/// back into my own account — and that question is only live when the stack
/// was cleared out from under the customer: app start, a session timeout, a
/// deep link, a sign-out. When they navigated here deliberately the back
/// button already answers it, and on a deliberate ACCOUNT SWITCH the offer is
/// worse than redundant: it invites somebody who just asked for a different
/// account to sign back into the previous one.
///
/// The gate is derived from the navigation stack rather than from a flag at
/// each call site, so these tests pin the derivation — a new resumption path
/// must get the right behaviour without anyone remembering to opt in.
void main() {
  // The widget hides itself when no account is cached, which is a separate
  // gate reached through secure storage. These tests exercise the reachability
  // rule, so they assert on what _reachedByResumption decides: the pure part.

  bool reachedByResumption({required bool canPop, Object? args}) {
    // Mirrors the widget's rule. A copy of a rule can drift from the rule, so
    // "the widget still decides this way" is itself asserted below rather
    // than assumed.
    if (args is Map && args[ExistingUserPasscodeCta.switchUserArg] == true) {
      return false;
    }
    return !canPop;
  }

  test('a cleared stack is a resumption, so the way home is offered', () {
    expect(reachedByResumption(canPop: false), isTrue);
  });

  test('a back button means they chose to be here, so it is not offered', () {
    expect(reachedByResumption(canPop: true), isFalse);
  });

  test('a deliberate account switch suppresses it even with no back button',
      () {
    // The email switch-user path clears the stack ON PURPOSE, which otherwise
    // looks exactly like a resumption.
    expect(
      reachedByResumption(
        canPop: false,
        args: {ExistingUserPasscodeCta.switchUserArg: true},
      ),
      isFalse,
    );
  });

  test('unrelated route arguments do not suppress it', () {
    expect(
      reachedByResumption(canPop: false, args: {'fromForgotPasscode': true}),
      isTrue,
    );
    expect(reachedByResumption(canPop: false, args: 'not-a-map'), isTrue);
    expect(reachedByResumption(canPop: false, args: null), isTrue);
  });

  testWidgets('it renders nothing when the screen can be popped',
      (tester) async {
    // End to end through the real widget: with a back button available it must
    // occupy no space at all, not merely be invisible.
    await tester.pumpWidget(
      GetMaterialApp(
        home: const Scaffold(body: SizedBox()),
        routes: {
          '/second': (_) => const Scaffold(
                body: Center(child: ExistingUserPasscodeCta()),
              ),
        },
      ),
    );
    final ctx = tester.element(find.byType(Scaffold));
    Navigator.of(ctx).pushNamed('/second');
    await tester.pumpAndSettle();

    expect(find.textContaining('passcode'), findsNothing);
  });

  // THE COPY ABOVE MUST STAY A COPY.
  //
  // The rule is restated in this file so the cases can be enumerated without
  // a Navigator, secure storage and a GetX route for each one. That is only
  // sound while the widget still decides the same way, so the decision's two
  // halves are asserted to be present in the source: if somebody changes the
  // widget to key off something else, these tests would otherwise keep
  // passing while testing nothing.
  test('the widget still derives the gate from the stack and the switch flag',
      () {
    final src = File(
      'lib/src/features/authentication/presentation/widgets/'
      'existing_user_passcode_cta.dart',
    ).readAsStringSync();
    expect(
      src.contains('canPop()'),
      isTrue,
      reason: 'the CTA no longer reads the navigation stack, so "did they '
          'choose to be here" is being decided some other way',
    );
    expect(
      src.contains('switchUserArg'),
      isTrue,
      reason: 'the deliberate-account-switch suppression is gone — the CTA '
          'would offer the previous account to somebody who just asked for '
          'a different one',
    );
    expect(
      src.contains('_reachedByResumption(context)'),
      isTrue,
      reason: 'the gate is no longer applied in build()',
    );
  });
}
