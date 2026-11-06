import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// NOBODY MAY BE SEALED INTO THE VERIFICATION SCREEN.
///
/// Verification is compulsory below Tier 2 and the screen offers no skip —
/// correct, and the screen enforces it itself rather than trusting a route
/// argument. The hazard is the COMBINATION: when that screen is also the
/// navigation root (an `offAllNamed` from signup, or from the post-login router
/// once kyc_required_on_signup is on), there is no skip, the back arrow pops an
/// empty stack, and without a sign-out the app is unusable for anyone who
/// cannot verify on that device.
///
/// Asserted against the SOURCE because the condition is a build-time branch on
/// two private getters; the thing that must not regress is that the branch
/// exists and is gated on exactly "root AND no skip".
void main() {
  final screen = File(
    'lib/src/features/kyc/presentation/views/bvn_verification_screen.dart',
  ).readAsStringSync();
  final cta = File(
    'lib/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart',
  ).readAsStringSync();

  /// The screen with every run of whitespace collapsed to one space.
  ///
  /// WHY. The assertions below pin CODE STRUCTURE, but several were written as
  /// literals carrying the indentation the file happened to have, so they also
  /// pinned LAYOUT. Wrapping the build method in one more conditional pushed
  /// those lines past the formatter's column limit, dart format re-wrapped
  /// them, and three tests failed over whitespace while the behaviour they
  /// guard was untouched.
  ///
  /// A guard that fails on reformatting teaches people to edit the test
  /// instead of reading it. Comparing squashed text keeps exactly the
  /// assertion that matters — these tokens, in this order — and drops the one
  /// that never did.
  final screenSquashed = screen.replaceAll(RegExp(r'\s+'), ' ');

  group('the verification gate always has an exit', () {
    test('the screen offers a sign-out when root AND skip is unavailable', () {
      expect(
        screenSquashed.contains(
            'if (_isOnboardingRoot && !_allowSkip) const KycGateExitCta()'),
        isTrue,
        reason: 'without this a user who cannot verify is sealed in: no skip '
            'below Tier 2, a back arrow onto an empty stack, and no sign-out',
      );
    });

    test('it is NOT shown when a skip already exists', () {
      // Gated on !_allowSkip. A sign-out alongside a working skip is just an
      // invitation to lose your session for no reason.
      expect(
          screenSquashed.contains('!_allowSkip) const KycGateExitCta()'), isTrue);
    });

    test('verification stays compulsory below Tier 2', () {
      // The exit must not have loosened the gate it exists beside.
      //
      // The gate has TWO allowances beyond Tier 2, and both are one principle:
      // the customer has nothing left to do, and the delay is ours.
      //
      //   _heldForReview — a name decision is outstanding; we are deciding.
      //   _nameRefused   — we have DECIDED, against them, on the name.
      //
      // The second was added 2026-11-06 after a customer hit it. Prove refused
      // on her name, and every self-service path then refused her too: no skip
      // (not Tier 2), no defer (_heldForReview needs 'name_review' AND both
      // names, and a refusal deliberately omits them), no correction and no
      // BVN-name adoption (banking answers NO_HELD_REVIEW for both). The screen
      // told her to contact support and then kept her on it. That is not
      // compulsion, it is a trap, and a guaranteed drop-off.
      //
      // Neither grants anything: both route to _deferWhileUnderReview, which
      // writes no skip flag, calls no skip RPC and moves no tier. That is the
      // whole allowance — asserted literally, so a FOURTH disjunct cannot be
      // added without this failing and somebody justifying it as this one is.
      expect(
        screenSquashed.contains(
            'bool get _allowSkip => _reachedTier2 || _heldForReview || _nameRefused;'),
        isTrue,
        reason: 'skip must stay gated on Tier 2, plus the two name states '
            'where the customer has no action left, and nothing else',
      );
      expect(
        screenSquashed.contains(
            "bool get _nameRefused => (_status?.failureReason ?? '') == 'name_mismatch';"),
        isTrue,
        reason: 'the refusal must come from the authoritative Prove reason and '
            'default to false, so an unknown status stays compulsory',
      );
      // And the hold must be a SERVER state, not a local flag anyone can set.
      expect(
        screen.contains(
            'bool get _heldForReview => _status?.nameUnderReview ?? false;'),
        isTrue,
        reason: 'the hold must come from the authoritative Prove status, and '
            'default to false so an unknown status stays compulsory',
      );
      expect(screen.contains('if (!_reachedTier2) {'), isTrue,
          reason: '_skipForNow must keep its authority guard');
    });

    // THE BUTTON THAT APPEARED AND REFUSED.
    //
    // `_allowSkip` admits `_heldForReview`, so the CTA shows. `_skipForNow`'s
    // authority guard is `!_reachedTier2`, which refuses such a holder — so the
    // control was present, tapped, and answered "Verification required", at the
    // exact moment the customer is waiting on us.
    test('a held holder gets a working deferral, not the skip path', () {
      expect(
        screenSquashed.contains(
            'onPressed: (_heldForReview || _nameRefused) && !_reachedTier2 '
            '? _deferWhileUnderReview : _skipForNow,'),
        isTrue,
        reason: 'a held holder OR a name-refused customer must not be routed '
            'into _skipForNow, whose authority guard (!_reachedTier2) refuses '
            'them — the control would appear, be tapped, and answer '
            '"Verification required" at the moment they are already stuck',
      );
    });

    // Deferring while held must not be a BYPASS. _skipForNow writes
    // has_skipped_kyc, calls skipKYCUpgrade (which persists a tier
    // server-side) and deletes kyc_onboarding_pending. The hold grants
    // nothing, so none of the three may happen on this path — and the gate has
    // to come back on the next launch, where the same deferral is available
    // again. Reminded, never sealed in.
    test('the deferral writes nothing and grants nothing', () {
      final start = screen.indexOf('Future<void> _deferWhileUnderReview()');
      expect(start, isNot(-1), reason: 'the deferral path must exist');
      final end = screen.indexOf('Future<void> _skipForNow()', start);
      expect(end, greaterThan(start));
      final body = screen.substring(start, end);
      expect(body.contains('has_skipped_kyc'), isFalse);
      expect(body.contains('skipKYCUpgrade'), isFalse);
      expect(body.contains('kyc_onboarding_pending'), isFalse);
      // The one thing it DOES keep from the skip path: leaving for the
      // dashboard must not auto-resume a deposit the holder never completed.
      expect(body.contains('PendingDeposit'), isTrue);
    });
  });

  group('signing out is an exit, not a bypass', () {
    test('it does not route to the dashboard', () {
      expect(cta.contains('AppRoutes.dashboard'), isFalse,
          reason: 'leaving the gate must never land on the dashboard — that '
              'would turn the escape hatch into the bypass');
    });

    test('it ends the session and returns to login', () {
      expect(cta.contains('authCubit.logout()'), isTrue);
      expect(cta.contains('Get.offAllNamed(AppRoutes.loginEntry)'), isTrue,
          reason: 'loginEntry is mode-aware; logout keeps the cached identity '
              'so this is a returning user, not a fresh one');
    });

    test('it does not touch the KYC flags', () {
      // Clearing kyc_onboarding_pending or writing has_skipped_kyc here would
      // let someone walk past verification by signing out and back in.
      expect(cta.contains('kyc_onboarding_pending'), isFalse);
      expect(cta.contains('has_skipped_kyc'), isFalse);
    });

    test('it confirms first', () {
      // One stray tap must not end a session the user is midway through.
      expect(cta.contains('showDialog<bool>'), isTrue);
    });
  });
}
