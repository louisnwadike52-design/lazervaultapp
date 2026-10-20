import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// EVERY quick service must be switchable from the admin dashboard.
///
/// The gate loop in `_effectiveHiddenServices` iterates
/// `getAllServicesUnfiltered()`, so the APP side covers a new service the
/// moment it is added to the enum — the keys are a family, not a fixed list.
/// The DASHBOARD side is a hand-written array, so it is the half that drifts:
/// add a service and it is live with no way for an operator to withdraw it,
/// which is exactly the "enforced but not operable" gap that turns every
/// support ticket into a DB write.
///
/// Measured when this was written: 39 services, 39 dashboard rows, no
/// difference either way.
void main() {
  test('the dashboard can control every service in the app enum', () {
    // Resolved relative to the app package, which sits beside apps/ in the
    // umbrella checkout. Skipped rather than failed when the dashboard is not
    // present, because lazervaultapp is also cloned on its own — a test that
    // hard-failed there would be noise, not a finding.
    final enumFile = File('lib/core/types/services.dart');
    final tabFile = File(
      '../apps/admin-dashboard/src/app/settings/page/QuickServiceGatesTab.tsx',
    );
    if (!tabFile.existsSync()) {
      markTestSkipped('admin dashboard not in this checkout');
      return;
    }

    final enumBody = RegExp(r'enum AppServiceName \{(.*?)\n\}', dotAll: true)
        .firstMatch(enumFile.readAsStringSync())
        ?.group(1);
    expect(enumBody, isNotNull,
        reason: 'AppServiceName moved; re-point this guard');

    final services = enumBody!
        .split('\n')
        .map((l) => l.trim().replaceAll(',', ''))
        .where((l) => RegExp(r'^[A-Za-z0-9]+$').hasMatch(l))
        .toList();
    expect(services.length, greaterThan(30),
        reason: 'parsed too few services — the regex stopped matching');

    final tab = tabFile.readAsStringSync();
    final controllable = RegExp(r'key:\s*"([A-Za-z0-9]+)"')
        .allMatches(tab)
        .map((m) => m.group(1)!)
        .toSet();

    final missing = services.where((s) => !controllable.contains(s)).toList();
    expect(missing, isEmpty,
        reason: 'these services exist in the app but an operator cannot hide '
            'or whitelist them from the dashboard: $missing. Add them to '
            'SERVICES in QuickServiceGatesTab.tsx.');

    final stale = controllable.where((c) => !services.contains(c)).toList();
    expect(stale, isEmpty,
        reason: 'the dashboard offers switches for services that no longer '
            'exist: $stale. The rows would write keys nothing reads.');
  });
}
