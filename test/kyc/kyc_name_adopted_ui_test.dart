import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The adoption notice, and the navigation it must not reinvent.
///
/// When Prove finds a PARTIAL name match the server now takes the BVN's
/// spelling and verifies the customer, rather than holding them. The app has
/// to say so — people notice a changed name later and wonder who did it —
/// and then let them through.
///
/// THE NAVIGATION IS THE DELICATE PART, because this screen is reached two
/// ways and they need opposite handling:
///
///   onboarding root — the stack is empty, so popping lands nowhere;
///                     it must offAllNamed(dashboard)
///   from Settings   — the stack is real, so offAllNamed would destroy it;
///                     it must Get.back
///
/// and on top of that a customer sent here from a deposit has a pending
/// deposit to resume, the auth profile must be refreshed or Settings shows a
/// stale Tier 1, the kyc_onboarding_pending flag must be cleared, and the
/// accounts need refetching because verification is what mints their NUBANs.
///
/// _finishVerified already does all six. These tests exist to stop the
/// notice growing its own navigation and getting one of them wrong.
void main() {
  late String code;

  setUpAll(() {
    final raw = File(
      'lib/src/features/kyc/presentation/views/bvn_verification_screen.dart',
    ).readAsStringSync();
    // Comments stripped: the block below is heavily commented and the
    // comments name the very symbols being asserted.
    code = raw
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
  });

  group('name adoption notice', () {
    test('it renders for an adopted name', () {
      expect(code.contains('status.nameAutoAdopted'), isTrue,
          reason: 'the adoption notice is gone, so a customer whose name we '
              'changed is never told we changed it');
    });

    test('it is checked BEFORE the review card', () {
      // Both arrive on failureReason; only the reason string separates them.
      // If the review branch is reached first, a customer who is already
      // through sees a card asking them to wait for a decision that has
      // already been made.
      final adopted = code.indexOf('status.nameAutoAdopted');
      final review = code.indexOf('status.nameUnderReview');
      expect(adopted, greaterThan(-1));
      expect(review, greaterThan(-1));
      expect(adopted, lessThan(review),
          reason: 'the resolved case must win over the review case');
    });

    test('the Proceed CTA reuses _finishVerified', () {
      final at = code.indexOf('status.nameAutoAdopted');
      final end = code.indexOf('status.nameUnderReview', at);
      final block = code.substring(at, end);

      expect(block.contains('onPressed: _isSubmitting ? null : _finishVerified'),
          isTrue,
          reason: 'the notice must route through _finishVerified, which '
              'already clears the onboarding flag, resumes a pending '
              'deposit, refreshes the profile, refetches the accounts and '
              'chooses offAllNamed vs Get.back by entry point');

      // It must NOT navigate on its own — that is how one of the six gets
      // forgotten.
      for (final direct in [
        'Get.offAllNamed',
        'Get.toNamed',
        'Get.back(',
        'Navigator.of',
      ]) {
        expect(block.contains(direct), isFalse,
            reason: 'the notice navigates directly with $direct instead of '
                'using _finishVerified');
      }
    });

    test('_finishVerified still branches on the entry point', () {
      // The guarantee the notice is leaning on.
      final at = code.indexOf('Future<void> _finishVerified');
      expect(at, greaterThan(-1), reason: '_finishVerified is gone');
      final body = code.substring(at);
      final end = body.indexOf('\n  }');
      final fn = body.substring(0, end == -1 ? body.length : end);

      expect(fn.contains('if (_isOnboardingRoot)'), isTrue,
          reason: 'the onboarding root must be distinguished; popping an '
              'empty stack lands nowhere');
      expect(fn.contains('Get.offAllNamed(AppRoutes.dashboard)'), isTrue,
          reason: 'the onboarding root must clear the stack to the dashboard');
      expect(fn.contains('Get.back(result: true)'), isTrue,
          reason: 'a Settings entry must pop, not destroy its stack');
      expect(fn.contains("_deleteFlag('kyc_onboarding_pending')"), isTrue,
          reason: 'the pending flag must be cleared or the gate re-arms');
      expect(fn.contains('refreshProfile'), isTrue,
          reason: 'without this Settings keeps showing a stale Tier 1');
    });

    test('two names are only shown when both are present', () {
      final at = code.indexOf('status.nameAutoAdopted');
      final end = code.indexOf('status.nameUnderReview', at);
      final block = code.substring(at, end);
      expect(
        block.contains('status.profileName.isNotEmpty') &&
            block.contains('status.bvnName.isNotEmpty'),
        isTrue,
        reason: 'the server omits a name in the degraded case; rendering the '
            'comparison anyway puts a labelled blank on the screen',
      );
    });
  });
}
