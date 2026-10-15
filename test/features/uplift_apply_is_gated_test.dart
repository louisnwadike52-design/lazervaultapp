import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every Apply control must withdraw the offer rather than walk a business
/// into a server-side refusal at the END of a long pitch form.
///
/// `ApplyToUpliftFund` refuses three ways — your own fund, an application you
/// already have live, and a passed application deadline — and each refusal
/// arrives only after the whole form has been written and submitted.
///
/// This is a SOURCE-level test because the defect is the ABSENCE of a branch
/// on a surface, and a new surface is exactly how it comes back: `upCanApply`
/// was written to be "the single predicate behind every Apply control" and
/// then had zero call sites, so the rule lived only in a comment.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  const widgets =
      'lib/src/features/uplift/presentation/widgets/uplift_widgets.dart';

  /// Every file that renders an Apply affordance.
  const applySurfaces = [
    'lib/src/features/uplift/presentation/views/uplift_home_screen.dart',
    'lib/src/features/uplift/presentation/views/uplift_detail_screen.dart',
  ];

  test('the rule is written down in one place', () {
    final s = code(widgets);
    expect(s, contains('bool upCanApply('));
    for (final cond in [
      '!f.isFunder',
      'UPLIFT_FUND_STATUS_OPEN',
      '!upApplicationsClosed(f)',
      '!upHasLiveApplication(f)',
    ]) {
      expect(s, contains(cond),
          reason: 'upCanApply no longer states "$cond" — if the rule changed, '
              'every surface below must change with it');
    }
  });

  test('every Apply surface checks a passed application deadline', () {
    // The window between the deadline and the worker flipping the fund to
    // `expired` is exactly when somebody racing the deadline taps.
    for (final p in applySurfaces) {
      final s = code(p);
      expect(s, contains('Apply'), reason: '$p no longer has an Apply control');
      expect(s, contains('upApplicationsClosed(f)'),
          reason: '$p offers Apply without asking whether the window shut');
    }
  });

  test('every Apply surface checks for an application already in flight', () {
    for (final p in applySurfaces) {
      final s = code(p);
      final hasHelper = s.contains('upHasLiveApplication(f)');
      final hasOwn = s.contains('hasApplied');
      expect(hasHelper || hasOwn, isTrue,
          reason: '$p would offer Apply to somebody who has already applied — '
              'they fill the whole form and are refused at the end');
    }
  });

  test('a fund you own is never offered an Apply control', () {
    for (final p in applySurfaces) {
      final s = code(p);
      expect(s, contains('isFunder'),
          reason: '$p would offer "apply to your own fund", which the server '
              'refuses outright');
    }
  });

  test('each refusal says WHY, rather than just hiding the button', () {
    // A missing button with no explanation is the failure this replaced.
    final home = code(applySurfaces[0]);
    expect(home, contains('Your fund'));
    expect(home, contains('Applications closed'));

    final detail = code(applySurfaces[1]);
    expect(detail, contains('Applications have closed for this fund'));
  });

  test('the deadline is compared in LOCAL time', () {
    // The deadline arrives as a UTC timestamp and "has today passed" is a
    // question about the user's clock. Comparing UTC to local would offer
    // Apply for up to a day past the deadline in some zones, and withdraw it
    // early in others.
    final s = code(widgets);
    final i = s.indexOf('bool upApplicationsClosed(');
    expect(i, greaterThan(-1));
    final body = s.substring(i, s.indexOf('\n}', i));
    expect(body, contains('.toLocal()'));
    expect(body, contains('hasApplicationDeadline()'),
        reason: 'a fund with NO deadline must never read as closed');
  });
}
