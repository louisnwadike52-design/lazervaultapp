import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/dashboard_widgets.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// BASIC OR ADVANCED, AND WHO DECIDES WHAT.
///
/// The dashboard showed every section it has to every user from their first
/// session. The operator's ask was a Revolut shape: a money-first page by
/// default, with the rest added deliberately — and all of it tunable from the
/// console rather than compiled.
///
/// The ordering of the three questions in [DashboardWidgets.isVisible] is the
/// whole contract, so each is pinned separately.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    await FeatureFlags.debugResetForTest();
    await DashboardWidgets.followMode();
    await FeatureFlags.applyRemoteSnapshot(const {});
  });

  test('advanced is what ships', () {
    expect(DashboardWidgets.operatorDefaultMode, DashboardUiMode.advanced,
        reason: 'nothing changes for anyone until an operator chooses');
    expect(DashboardWidgets.isBasic, isFalse);
    for (final w in kDashboardWidgets) {
      expect(DashboardWidgets.isVisible(w.id), isTrue, reason: w.id);
    }
  });

  test('the operator can start users in basic', () async {
    await FeatureFlags.applyRemoteSnapshot(
        {'${DashboardWidgets.basicDefaultPrefix}_available': 'true'});
    expect(DashboardWidgets.isBasic, isTrue);
    for (final w in kDashboardWidgets) {
      expect(DashboardWidgets.isVisible(w.id), isFalse,
          reason: '${w.id} is opt-in in basic mode');
    }
  });

  test("a withdrawn section beats the user's own choice", () async {
    // The ordering that matters most: a product taken off the shelf is off,
    // whatever anyone switched on for themselves.
    await DashboardWidgets.setVisible('portfolio', true);
    expect(DashboardWidgets.isVisible('portfolio'), isTrue);

    await FeatureFlags.applyRemoteSnapshot(
        {'feature_dashboardwidget_portfolio_available': 'false'});
    expect(DashboardWidgets.isVisible('portfolio'), isFalse);
  });

  test("the user's choice beats the mode, in both directions", () async {
    await FeatureFlags.applyRemoteSnapshot(
        {'${DashboardWidgets.basicDefaultPrefix}_available': 'true'});

    await DashboardWidgets.setVisible('crowdfunds', true);
    expect(DashboardWidgets.isVisible('crowdfunds'), isTrue,
        reason: 'added to a basic dashboard');

    await DashboardWidgets.setMode(DashboardUiMode.advanced);
    await DashboardWidgets.setVisible('crowdfunds', false);
    expect(DashboardWidgets.isVisible('crowdfunds'), isFalse,
        reason: 'removed from an advanced one');
  });

  test('following the mode again is what a mode switch does', () async {
    await DashboardWidgets.setVisible('portfolio', false);
    await DashboardWidgets.setVisible('exchange_rates', false);
    expect(DashboardWidgets.hasUserChoice('portfolio'), isTrue);

    await DashboardWidgets.setMode(DashboardUiMode.advanced);
    await DashboardWidgets.followMode();

    expect(DashboardWidgets.isVisible('portfolio'), isTrue,
        reason: 'upgrading into a dashboard still missing three sections '
            'reads as the switch not working');
    expect(DashboardWidgets.hasUserChoice('portfolio'), isFalse);
  });

  test('withdrawing the customise feature does not strand anyone', () async {
    await DashboardWidgets.setMode(DashboardUiMode.basic);
    expect(DashboardWidgets.isBasic, isTrue);

    await FeatureFlags.applyRemoteSnapshot(
        {'${DashboardWidgets.customisePrefix}_available': 'false'});
    expect(DashboardWidgets.customisable, isFalse);
    expect(DashboardWidgets.isBasic, isFalse,
        reason: "the operator's mode takes over — a user must never be left "
            'in a mode they can no longer leave');
  });

  group('basic quick services', () {
    test('advanced never narrows the grid', () {
      expect(DashboardWidgets.showsService('invest'), isTrue);
      expect(DashboardWidgets.showsService('anythingAtAll'), isTrue);
    });

    test('basic shows the money set and nothing else', () async {
      await FeatureFlags.applyRemoteSnapshot(
          {'${DashboardWidgets.basicDefaultPrefix}_available': 'true'});
      for (final id in DashboardWidgets.defaultBasicServices) {
        expect(DashboardWidgets.showsService(id), isTrue, reason: id);
      }
      expect(DashboardWidgets.showsService('invest'), isFalse);
    });

    test('the set is the operator\'s, and a blank one is not a choice',
        () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${DashboardWidgets.basicDefaultPrefix}_available': 'true',
        DashboardWidgets.basicServicesKey: ' sendFunds , invest ',
      });
      expect(DashboardWidgets.showsService('invest'), isTrue);
      expect(DashboardWidgets.showsService('giftCards'), isFalse);

      await FeatureFlags.applyRemoteSnapshot(
          {DashboardWidgets.basicServicesKey: '  ,  , '});
      expect(
          DashboardWidgets.basicServices, DashboardWidgets.defaultBasicServices,
          reason: 'a list that parses to nothing is a typo, and an empty grid '
              'is indistinguishable from a broken one');
    });
  });

  test('the ids used by the app are the ids the console writes', () {
    // The console offers feature_dashboardwidget_<id>_available for exactly
    // these, and the app gates on the same ids. A rename on one side alone is
    // a section that can never be withdrawn — or one nobody can get back.
    final tab = File(
            '../apps/admin-dashboard/src/app/settings/page/FeatureGatesTab.tsx')
        .readAsStringSync();
    final block = tab.substring(tab.indexOf('domain: "dashboardwidget"'));
    final gates = block.substring(0, block.indexOf(']'));
    for (final w in kDashboardWidgets) {
      expect(gates, contains('id: "${w.id}"'), reason: w.id);
    }
  });
}
