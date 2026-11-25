import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/route_service_map.dart';
import 'package:lazervault/core/types/services.dart';

/// THE CATALOGUE THE ADMIN DASHBOARD PICKS DEEP LINKS FROM.
///
/// A marketing push names a SERVICE, never a route — the app resolves the
/// route itself, so a rename cannot break links already sitting on handsets,
/// and a payload can never nominate an arbitrary screen. That safety only
/// works if the person composing the campaign is choosing from the real list,
/// rather than typing a service name and hoping.
///
/// So the list is EXPORTED from the app's own map and committed. The
/// dashboard renders it; this test regenerates it and fails when the two
/// disagree — which is what makes "a route changed" a build failure here
/// instead of a dead link discovered from a support ticket.
///
/// Regenerate with:
///   UPDATE_DEEPLINK_CATALOGUE=1 flutter test test/core/deeplink_catalogue_export_test.dart
void main() {
  final file = File('../apps/admin-dashboard/src/lib/deeplinkCatalogue.json');

  Map<String, dynamic> build() {
    final services = <Map<String, String>>[];
    for (final entry in kServiceToRoute.entries) {
      services.add({
        'service': entry.key.name,
        'route': entry.value,
        'label': _label(entry.key.name),
      });
    }
    services.sort((a, b) => a['service']!.compareTo(b['service']!));
    return {
      '_comment': 'GENERATED from lazervaultapp lib/core/types/route_service_map.dart. '
          'Do not hand-edit: regenerate with UPDATE_DEEPLINK_CATALOGUE=1 '
          'flutter test test/core/deeplink_catalogue_export_test.dart',
      'services': services,
    };
  }

  test('every service the app can open is in the dashboard catalogue', () {
    final current = const JsonEncoder.withIndent('  ').convert(build());

    if (Platform.environment['UPDATE_DEEPLINK_CATALOGUE'] == '1') {
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('$current\n');
      return;
    }

    expect(file.existsSync(), isTrue,
        reason: 'the dashboard catalogue is missing — regenerate it');
    expect(file.readAsStringSync().trim(), current.trim(),
        reason: 'the app can open a different set of services than the '
            'dashboard offers. A campaign composed against a stale catalogue '
            'sends a push nobody can land. Regenerate with '
            'UPDATE_DEEPLINK_CATALOGUE=1.');
  });

  test('every catalogued service resolves the way a push would', () {
    for (final entry in kServiceToRoute.entries) {
      expect(routeForServiceName(entry.key.name), entry.value,
          reason: '${entry.key.name} is catalogued but a push naming it does '
              'not resolve to its route');
    }
  });

  test('the catalogue is not empty and covers the quick services', () {
    // A floor, not an exact count: services are added often, and a test that
    // fails on every addition gets its number bumped without being read.
    expect(kServiceToRoute.length, greaterThanOrEqualTo(40),
        reason: 'the catalogue has shrunk — a service that is no longer '
            'linkable cannot be promoted');
    for (final must in [
      AppServiceName.escrow, // the push that started this
      AppServiceName.airtime,
      AppServiceName.data,
      AppServiceName.crowdfund,
    ]) {
      expect(kServiceToRoute.containsKey(must), isTrue,
          reason: '${must.name} has no deep link');
    }
  });
}

/// A human label for the dashboard's picker: "giftCards" -> "Gift Cards".
String _label(String camel) {
  final spaced = camel.replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}');
  return spaced[0].toUpperCase() + spaced.substring(1);
}
