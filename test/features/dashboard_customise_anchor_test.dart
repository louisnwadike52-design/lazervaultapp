import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/dashboard_widgets.dart';

/// EVERY ANCHOR AN OPERATOR CAN PICK MUST ACTUALLY RENDER SOMETHING.
///
/// The customise card's position is a console setting, and the dashboard asks
/// `customiseGoesAfter('<anchor>')` once per section. The two lists are
/// written in different files, so an anchor added to the vocabulary without a
/// matching render site would be offered in the console, saved without
/// complaint, and then make the card VANISH — the one control that gets a
/// customer back to a full dashboard, gone, with nothing anywhere reporting
/// it. That is the silent-failure shape this guard exists to close.
void main() {
  final dashboard = File(
    'lib/src/features/widgets/dashboard/dashboard.dart',
  ).readAsStringSync();

  test('every anchor in the vocabulary has a render site', () {
    final missing = <String>[];
    for (final anchor in kCustomiseAnchors) {
      if (!dashboard.contains("customiseGoesAfter('$anchor')")) {
        missing.add(anchor);
      }
    }
    expect(
      missing,
      isEmpty,
      reason: 'these anchors can be set in the console and render nothing, so '
          'the customise card would disappear: ${missing.join(", ")}',
    );
  });

  test('the default anchor is one of the offered ones', () {
    expect(kCustomiseAnchors, contains(kCustomiseAnchorDefault));
  });

  test('the default puts it under recent activity', () {
    // Not an arbitrary pin: the card used to sit at the foot of the page,
    // below the one section every customer scrolls to. If this moves, it
    // should be a decision rather than a drift.
    expect(kCustomiseAnchorDefault, 'history');
  });

  test('the card renders once per anchor and no more', () {
    // Each site is guarded by its own anchor check, so exactly one can be
    // true at a time. An unguarded extra would print the card twice.
    final rendered = RegExp(r'const CustomiseDashboardRow\(\)')
        .allMatches(dashboard)
        .length;
    final guards = RegExp(r"customiseGoesAfter\('[a-z_]+'\)")
        .allMatches(dashboard)
        .length;
    expect(rendered, guards,
        reason: 'a CustomiseDashboardRow with no anchor guard would show '
            'alongside the one the operator chose');
  });

  test('an operator change redraws a live dashboard', () {
    // The user's own changes bump DashboardWidgets.revision; an operator's
    // arrive by settings snapshot and bump FeatureFlags
    // .dashboardLayoutRevision. The sections read BOTH — move the customise
    // card in the console and a running app must redraw, not wait for a
    // restart.
    expect(dashboard.contains('Listenable.merge'), isTrue,
        reason: 'the section builder listens to one notifier again, so an '
            'operator-side change lands in settings and never reaches the page');
    final i = dashboard.indexOf('Listenable.merge');
    final body = dashboard.substring(i, i + 220);
    expect(body.contains('DashboardWidgets.revision'), isTrue);
    expect(body.contains('FeatureFlags.dashboardLayoutRevision'), isTrue);

    final flags =
        File('lib/core/config/feature_flags.dart').readAsStringSync();
    final j = flags.indexOf('static Future<void> applyRemoteSnapshot');
    final snap = flags.substring(j, flags.indexOf('\n  }\n', j));
    expect(snap.contains('dashboardLayoutRevision.value++'), isTrue,
        reason: 'a settings snapshot no longer tells the dashboard anything '
            'changed');
  });

  test('an unknown console value falls back rather than hiding the card', () {
    // customisePosition reads SharedPreferences, which is not available in a
    // plain unit test — so the contract is pinned on the source instead: the
    // resolver must fall back to the default for anything it does not know.
    final cfg = File('lib/core/config/dashboard_widgets.dart')
        .readAsStringSync();
    final i = cfg.indexOf('static String get customisePosition');
    expect(i, greaterThan(-1), reason: 'the resolver has moved');
    final body = cfg.substring(i, i + 400);
    expect(body.contains('kCustomiseAnchorDefault'), isTrue);
    expect(body.contains('kCustomiseAnchors.contains'), isTrue,
        reason: 'a typo in the console must not make the only way back to a '
            'full dashboard disappear');
  });
}
