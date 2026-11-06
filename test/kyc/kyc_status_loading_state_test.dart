import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The Identity Verification screen must not state an outcome it does not
/// know yet.
///
/// WHAT WENT WRONG. While the KYC status was still loading, the screen
/// rendered its real content with a two-pixel LinearProgressIndicator tucked
/// under the header. Because `status` was null at that point, `isMaxTier` was
/// false and the header read "Verify Your Identity" — so an already-verified
/// customer opened a page telling them to verify, waited, and watched it
/// rewrite itself into "You're Verified" with a tier card appearing beneath.
///
/// The first paint was not a loading state. It was a confident wrong answer,
/// and the reflow that corrected it read as a bug.
///
/// Asserted on the source: a widget test for this screen would need the KYC
/// cubit, the profile repository and the whole DI graph stood up to prove one
/// branch, and the thing worth protecting is structural — that the loading
/// branch renders a skeleton and nothing that names an outcome.
void main() {
  late String source;

  setUpAll(() {
    source = File(
      'lib/src/features/kyc/presentation/views/bvn_verification_screen.dart',
    ).readAsStringSync();
  });

  group('Identity Verification loading state', () {
    test('the loading branch renders the skeleton', () {
      expect(
        source.contains('_loadingStatus'),
        isTrue,
        reason: 'the loading flag is gone; this test can no longer tell '
            'whether the screen has a loading branch at all',
      );
      expect(
        source.contains('? const KycStatusSkeleton()'),
        isTrue,
        reason: 'the loading branch no longer renders KycStatusSkeleton. '
            'Rendering the real screen while status is unknown is what showed '
            'verified customers a "Verify Your Identity" header that then '
            'rewrote itself.',
      );
    });

    test('nothing that names an outcome renders while loading', () {
      // The guard: the loading branch must be the skeleton ALONE. If a
      // conditional slips back in ahead of it, the header can paint again.
      final loadingAt = source.indexOf('child: _loadingStatus');
      expect(loadingAt, greaterThan(-1),
          reason: 'the loading branch moved; re-point this guard');

      final skeletonAt = source.indexOf('KycStatusSkeleton()', loadingAt);
      final elseAt = source.indexOf(': Column(', loadingAt);
      expect(skeletonAt, greaterThan(-1));
      expect(elseAt, greaterThan(skeletonAt),
          reason: 'the skeleton must be the WHOLE loading branch, with the '
              'real Column only in the else');

      // COMMENTS STRIPPED FIRST. The loading branch carries a comment
      // explaining the bug, and that comment quotes the very strings this
      // test forbids — so the first version of this test failed on its own
      // prose rather than on any rendered widget. Anchor on code only.
      final loadingBranch = source
          .substring(loadingAt, elseAt)
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      for (final phrase in [
        "You\\'re Verified",
        'Verify Your Identity',
        '_buildTierCard',
        '_buildBenefitsSection',
      ]) {
        expect(
          loadingBranch.contains(phrase),
          isFalse,
          reason: '"$phrase" renders while the status is still loading. '
              'Either outcome shown before it is known is a guess, and the '
              'customer sees it corrected a moment later.',
        );
      }
    });

    test('the hairline progress indicator is gone from the status load', () {
      // Not forbidden everywhere — the SUBMIT button legitimately has its own
      // spinner — but it must no longer be the status-loading treatment.
      final loadingAt = source.indexOf('child: _loadingStatus');
      final elseAt = source.indexOf(': Column(', loadingAt);
      final branch = source
          .substring(loadingAt, elseAt)
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(
        branch.contains('LinearProgressIndicator'),
        isFalse,
        reason: 'a 2px progress line under a fully-rendered wrong screen is '
            'the behaviour this replaced',
      );
    });
  });
}
