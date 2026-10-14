import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A gate on a hub screen is decorative if the service has another door.
///
/// Counting `Get.toNamed` call sites for the gated bill routes found between 3
/// and 24 EACH: saved beneficiaries, repeat-purchase shortcuts, transaction
/// history, auto-recharge management, notification taps, the chat and voice
/// agents, and deep links all navigate straight to these screens without
/// passing the Bills hub. Gating only the hub would leave every one of those
/// open while the dashboard reported the service switched off.
///
/// Wrapping the ROUTE closes them all at once, including paths added later —
/// a screen registered through AppRouter cannot be reached without going
/// through its own `page:` builder.
///
/// This test fails when a gated route loses its guard, which is the easy
/// mistake: someone edits the page builder to add a BlocProvider and drops the
/// wrapper while doing it.
void main() {
  final src = File('lib/src/features/presentation/app_router.dart')
      .readAsStringSync()
      // Strip comment lines: this file explains the guard at length, and a raw
      // scan would match the explanation rather than the code.
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  /// Every bill route whose tile the admin can switch off, with the gate id
  /// the Bills hub uses for it. These MUST agree — a route guarded with the
  /// wrong id is gated by someone else's switch.
  const gatedRoutes = <String, String>{
    'airtime': 'airtime',
    'dataBundlesHome': 'data',
    'electricityBillHome': 'electricity',
    'cableTVHome': 'cable_tv',
    'internetBillHome': 'internet',
    'waterBillHome': 'water',
    'educationHome': 'education',
    'epinHome': 'epin',
    'bettingHome': 'betting',
  };

  gatedRoutes.forEach((route, gateId) {
    test('$route is wrapped in FeatureGateGuard with gate "$gateId"', () {
      final anchor = 'name: AppRoutes.$route,';
      final at = src.indexOf(anchor);
      expect(at, greaterThan(-1), reason: '$route is not registered any more');

      // Look only at this GetPage's own body, bounded by the next `name:`.
      final nextName = src.indexOf('name: AppRoutes.', at + anchor.length);
      final body = src.substring(at, nextName == -1 ? src.length : nextName);

      expect(body, contains('FeatureGateGuard'),
          reason: 'AppRoutes.$route can be opened directly from notifications, '
              'beneficiaries, history and deep links. Without the route guard '
              'the admin switch only hides the Bills hub tile.');
      expect(body, contains("'bill', '$gateId'"),
          reason: 'the route guard must use the SAME gate id the Bills hub '
              'uses, or the tile and the screen answer to different switches');
    });
  });

  test('the scan can tell a guarded route from an unguarded one', () {
    // Guards that pass on broken code are worse than none. Prove the matcher
    // discriminates by checking a route that is deliberately NOT gated.
    const ungated = 'name: AppRoutes.dashboard,';
    final at = src.indexOf(ungated);
    if (at == -1) return; // route renamed; the other tests still cover us
    final nextName = src.indexOf('name: AppRoutes.', at + ungated.length);
    final body = src.substring(at, nextName == -1 ? src.length : nextName);
    expect(body.contains('FeatureGateGuard'), isFalse,
        reason: 'the dashboard is not gated, so finding a guard here means the '
            'body-slicing is wrong and every other assertion is meaningless');
  });
}
