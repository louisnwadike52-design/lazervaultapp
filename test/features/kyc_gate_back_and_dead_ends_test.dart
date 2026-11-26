import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE KYC GATES MUST NOT BE ESCAPABLE, OR INESCAPABLE.
///
/// Both of those were true at once on the signup path. `bvn_signup_screen`
/// and `bvn_verification_screen` are reached by `Get.offAllNamed`, so each is
/// the ONLY route on the stack — Android's back press then has nothing to pop
/// and hands it to the system, which CLOSES THE APP on somebody who is signed
/// in and half-way through verifying. Meanwhile the dialogs those screens
/// show had one button each, so the only way off them was a support ticket.
///
/// Source-text guards, deliberately: these screens construct a service
/// locator, three cubits and a live status poll, so pumping them in a unit
/// test proves less than it costs. Every assertion below strips COMMENT lines
/// first — a guard that the paragraph explaining the fix can satisfy is a
/// guard that passes with the fix deleted.
String _code(String path) {
  final raw = File(path).readAsStringSync();
  return raw
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}

void main() {
  final signup = _code(
      'lib/src/features/kyc/presentation/views/bvn_signup_screen.dart');
  final verification = _code(
      'lib/src/features/kyc/presentation/views/bvn_verification_screen.dart');
  final exitCta = _code(
      'lib/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart');

  group('the OS back gesture has somewhere to go', () {
    test('the signup gate intercepts back instead of closing the app', () {
      expect(signup, contains('PopScope('),
          reason: 'without one, back on the only route on the stack closes '
              'the app on a signed-in customer mid-onboarding');
      expect(signup, contains('KycGateExitCta.confirmExit('),
          reason: 'back must route through the ONE sanctioned exit, the same '
              'confirmation the "Not you?" link shows');
    });

    test('the verification gate routes back through _onBack, not a bare pop',
        () {
      expect(verification, contains('PopScope('));
      expect(verification, contains('canPop: false'),
          reason: 'canPop must be false even when back is ALLOWED: the pop '
              'has to go through _onBack, which clears the pending deposit '
              'first. A plain pop leaves a saved deposit to auto-resume a '
              'bank link behind an unfinished verification.');
      expect(verification, contains('_onBack();'));
      expect(verification, contains('KycGateExitCta.confirmExit('),
          reason: 'below Tier 2 there is no skip, so the only honest exit is '
              'signing out');
    });

    test('the exit confirmation is callable from outside its widget', () {
      expect(exitCta, contains('static Future<void> confirmExit('),
          reason: 'one answer to "how do I leave this screen", wherever it '
              'is asked from');
    });
  });

  group('no dialog is a one-button dead end', () {
    test('an already-registered number offers a way back to the field', () {
      expect(signup, contains("'Use a different number'"),
          reason: 'the barrier is non-dismissible and the commonest real '
              'cause is a MISTYPED number that happens to belong to somebody '
              "else's account — the customer must be able to fix eleven "
              'digits without opening a support ticket');
      expect(signup, contains('requestFocus(_bvnFocus)'),
          reason: 'the correction should be one action, not a hunt');
    });

    test('a dismissed name confirmation can be re-opened', () {
      expect(signup, contains('_pendingNameConfirmation'),
          reason: 'the server is already holding the decision open; '
              're-running the lookup to reach the same question costs a '
              "second Mono session and a second code to the holder's phone");
      expect(signup, contains("'Confirm your name'"));
    });

    test('nothing sends a customer to the immutable Settings name field', () {
      // The field cannot be edited; an earlier version of this very flow sent
      // people there and silently discarded the edit, which is the dead end
      // kyc_profile_fix.dart exists to prevent.
      expect(signup.contains('name in Settings'), isFalse,
          reason: 'the profile name is immutable there — pointing at it is a '
              'dead end dressed as an instruction');
    });
  });

  group('an identity write is never fire-and-forget', () {
    test('adopting the BVN name runs behind the blocking overlay', () {
      expect(verification, contains('runKycSave<String>('),
          reason: 'with nothing on screen a congested cell looks exactly '
              'like a tap that did nothing, and the next tap is a SECOND '
              'identity write against a provider that counts attempts');
      expect(verification, contains('_prove.adoptBvnName()'));
      expect(verification, contains('_prove.submitNameCorrection('));
    });

    test('a timeout is reported as a timeout, never as a refusal', () {
      expect(verification, contains('on TimeoutException'),
          reason: 'the write may well have landed; "could not update" sends '
              'the customer to support over a change that applied');
    });
  });
}
