import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// OUTSIDE NAIRA, MOST OF THE ANALYTICS PAGE HAS NOTHING BEHIND IT.
///
/// Budgets, Budget AI and Goals are all measured against CATEGORISED
/// spending, and categorisation is fed by open banking — a Nigeria-only rail.
/// On a foreign-currency account there are no linked banks, so those screens
/// open and every figure on them is zero. The Bank and Both statistics scopes
/// are the same story: Both is the union, and half of it is the half that
/// cannot exist.
///
/// Three properties, because gating any one of them alone leaves a door:
///
///  1. the ROUTES are guarded — the account and commerce notification
///     resolvers land on budgetList and financialGoals directly, and the
///     budget list and budget detail screens each carry their own AI button,
///     so dimming four tiles on one page closes none of those;
///  2. the TILES and the Budget AI card on the page say so before the tap,
///     rather than walking the user into the guard's explanation;
///  3. the page does not OPEN on a scope it has just disabled —
///     _statsSource defaults to `both`.
void main() {
  String stripComments(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final router = stripComments(
      File('lib/src/features/presentation/app_router.dart').readAsStringSync());
  final stats = stripComments(
      File('lib/src/features/widgets/statistics.dart').readAsStringSync());
  final widgets = stripComments(
      File('lib/src/features/widgets/statistics_widgets.dart')
          .readAsStringSync());

  /// Just this GetPage's own body, bounded by the next `name:`.
  String routeBody(String route) {
    final anchor = 'name: AppRoutes.$route,';
    final at = router.indexOf(anchor);
    expect(at, greaterThan(-1), reason: '$route is not registered any more');
    final next = router.indexOf('name: AppRoutes.', at + anchor.length);
    return router.substring(at, next == -1 ? router.length : next);
  }

  for (final route in const ['budgetList', 'budgetAIInsights', 'financialGoals']) {
    test('$route is wrapped in LocaleGateGuard', () {
      expect(routeBody(route), contains('LocaleGateGuard'),
          reason: 'AppRoutes.$route is reachable from notification taps and '
              'from the budget screens themselves. Without the route guard '
              'the locale restriction only dims tiles on one page.');
    });
  }

  test('the scan can tell a guarded route from an unguarded one', () {
    // A guard that passes on broken code is worse than none. Spending analysis
    // reads the wallet's own transactions, so it is deliberately NOT gated —
    // which makes it the control.
    expect(routeBody('statisticsSpendingDetail').contains('LocaleGateGuard'),
        isFalse,
        reason: 'spending analysis works in every region and must stay open; '
            'if this is guarded the matcher is matching the wrong thing');
  });

  test('the three tiles are disabled and carry a reason', () {
    expect(stats.contains('final restricted = LocaleGating.restricted;'), isTrue,
        reason: 'the grid no longer consults the locale gate');
    // Three tiles disabled, and the reason named for each.
    expect(
        'enabled: !restricted'.allMatches(stats).length,
        3,
        reason: 'Budgets, Budget AI and Goals must each be gated; Spending '
            'must not be');
    for (final what in const [
      "LocaleGating.reasonFor('Budgets')",
      "LocaleGating.reasonFor('Budget AI insights')",
      "LocaleGating.reasonFor('Goals')",
    ]) {
      expect(stats, contains(what),
          reason: 'a dimmed tile that explains nothing is worse than a live '
              'one: $what missing');
    }
  });

  test('a disabled tile explains itself instead of navigating', () {
    final i = widgets.indexOf('class _FeatureCard');
    final body = widgets.substring(i, (i + 1400).clamp(0, widgets.length));
    expect(body.contains('if (!feature.enabled) {'), isTrue);
    final guardAt = body.indexOf('if (!feature.enabled) {');
    final navAt = body.indexOf('Get.toNamed(feature.route');
    expect(guardAt, lessThan(navAt),
        reason: 'the refusal has to come before the navigation');
  });

  test('Bank and Both scopes are disabled, Lazervault is not', () {
    expect(stats.contains("bool get _bankScopesOffered => "
            "LocaleGating.aiScopeAllowed('banks')"),
        isTrue,
        reason: 'the scope gate must resolve through the same LocaleGating '
            'decision the bank pills already use, or the two drift');
    expect('enabled: _bankScopesOffered'.allMatches(stats).length, 2,
        reason: 'exactly Bank and Both are gated — Lazervault is the one '
            'scope that always has data');
  });

  test('the page does not open on a scope it has disabled', () {
    final i = stats.indexOf('void initState() {');
    final body = stats.substring(i, (i + 900).clamp(0, stats.length));
    expect(
        body.contains("if (!LocaleGating.aiScopeAllowed('banks')) {") &&
            body.contains('_statsSource = StatisticsSource.lazervault;'),
        isTrue,
        reason: '_statsSource defaults to `both`, so without this the page '
            'opened on a disabled segment showing zeros, and the only way '
            'out was a tap the user had just been refused');
  });
}
