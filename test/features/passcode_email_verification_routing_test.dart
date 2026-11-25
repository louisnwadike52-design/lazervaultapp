import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A ROUTING DECISION MUST NOT BE GOVERNED BY A COSMETIC DE-DUPE.
///
/// `_lastError` on the passcode screen exists for one reason, stated at its
/// declaration: shake the dots once per distinct error rather than on every
/// rebuild. Navigation was later folded inside the same guard, which made
/// routing de-dupe on the MESSAGE TEXT.
///
/// That broke resumption completely. `Get.toNamed` PUSHES the email
/// verification screen, so the passcode widget is never disposed and
/// `_lastError` survives the trip. On returning, the user's next passcode
/// entry produced a byte-identical `email_not_verified` refusal, the guard
/// swallowed it, and because that error maps to `suppressBanner: true` there
/// was no snackbar either — the screen did nothing at all, permanently.
/// Reported 2026-11-19 by a user who could not get past it and made a second
/// account to get in.
///
/// This is a source guard rather than a widget test because the behaviour
/// depends on GetX route lifecycle, which a widget test cannot exercise
/// honestly. It pins the two properties that matter.
void main() {
  final src = File(
    'lib/src/features/authentication/presentation/widgets/passcode_sign_in.dart',
  );

  late String text;

  setUpAll(() {
    expect(src.existsSync(), isTrue,
        reason: 'passcode screen moved — this guard needs updating');
    text = src.readAsStringSync();
  });

  String emailBranch() {
    final i = text.indexOf("contains('email_not_verified')");
    expect(i, greaterThan(-1),
        reason: 'the email_not_verified branch is gone — if the refusal is no '
            'longer routed, resumption is broken again');
    // The branch body: from the match to the start of the next else.
    final rest = text.substring(i);
    final end = rest.indexOf('} else {');
    return end > 0 ? rest.substring(0, end) : rest;
  }

  // THE ROUTING MOVED INTO A SHARED HELPER, AND THE GUARD FOLLOWED IT.
  //
  // This branch used to open the route itself. It now calls
  // routeToVerificationGate, which does the same thing for every login
  // surface AND carries the address auth-service attaches to the refusal —
  // without which the verification screen opened with no inbox named and
  // nothing to resend to (reported 2026-11-25).
  //
  // So the assertion is split: the branch must delegate, and the helper must
  // still do the two things this file exists to protect. Checking only the
  // branch would pass with a helper that routes nowhere.
  final helper = File('lib/core/utils/verification_gate_routing.dart');

  test('the refusal still routes to the email verification screen', () {
    expect(emailBranch(), contains('routeToVerificationGate('),
        reason: 'the branch must delegate to the shared router');
    expect(helper.existsSync(), isTrue,
        reason: 'the shared router is gone — this guard needs updating');
    expect(helper.readAsStringSync(), contains('AppRoutes.emailVerification'),
        reason: 'the router no longer opens the verification screen');
  });

  test('returning from that screen re-arms the branch', () {
    final branch = emailBranch();
    expect(
      branch,
      contains('_lastError = null'),
      reason: 'Without clearing _lastError when the pushed route pops, a user '
          'who comes back and re-enters their passcode hits the de-dupe and '
          'the screen does nothing — no navigation and no banner. That is the '
          'exact dead end this test exists to prevent.',
    );
    expect(
      helper.readAsStringSync(),
      contains('whenComplete'),
      reason: 'the reset must be tied to the route actually returning, not '
          'fired eagerly before the user has had a chance to verify. It is '
          'the helper that owns the route now, so it is the helper that must '
          'tie onReturn to the pop.',
    );
    expect(
      helper.readAsStringSync(),
      contains('onReturn?.call()'),
      reason: 'a helper that takes onReturn and never calls it re-arms '
          'nothing, and the branch above would de-dupe for ever',
    );
  });

  test('_lastError is still what de-dupes the shake, and only that', () {
    // If this declaration comment disappears, someone has repurposed the
    // field and the separation above is no longer self-evident.
    expect(text, contains('_lastError de-dupes'));
  });
}
