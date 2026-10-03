import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/route_service_map.dart';
import 'package:lazervault/core/types/services.dart';

// kRouteToService lets the notification deep-link path apply the same
// "temporarily unavailable" gate the quick-service tile applies. It is DERIVED
// from the tile dispatcher's own switch, so the two must not drift: a service
// whose route changes and is not updated here silently stops being guarded on
// deep links, and nothing in the UI would reveal it.
//
// This test re-derives the mapping from the dispatcher source and compares.

void main() {
  test('every service the dispatcher opens is reachable from the map', () {
    final src = File(
      'lib/src/features/widgets/app_service_builder.dart',
    ).readAsStringSync();
    final start = src.indexOf('void _handleGotoService()');
    expect(start, greaterThan(-1),
        reason: 'the dispatcher was renamed — this test is now blind');
    // Clamp: the dispatcher may sit near the end of the file.
    final end = (start + 20000).clamp(0, src.length);
    final seg = src.substring(start, end);

    final re = RegExp(
      r'case AppServiceName\.([a-zA-Z0-9]+):(?:(?!case AppServiceName\.)[\s\S])*?'
      r'Get\.toNamed\(\s*AppRoutes\.([a-zA-Z0-9]+)',
    );
    final dispatcherServices = <String>{};
    for (final m in re.allMatches(seg)) {
      dispatcherServices.add(m.group(1)!);
    }
    expect(dispatcherServices, isNotEmpty,
        reason: 'the scan found nothing — the matcher is broken, not the map');

    final mapped = kRouteToService.values.map((e) => e.name).toSet();
    // A service that deliberately shares another's route is covered by that
    // route's owner, not missing. Only UNDECLARED omissions are failures.
    mapped.addAll(kServiceRouteAliases.keys.map((e) => e.name));
    final missing = dispatcherServices.difference(mapped).toList()..sort();
    expect(missing, isEmpty,
        reason: 'these services are opened by the dispatcher but absent from '
            'kRouteToService, so a notification deep link into them bypasses '
            'the unavailable gate: ${missing.join(", ")}');
  });

  test('a declared alias points at a route that really is mapped', () {
    // An alias naming an owner that is itself unmapped would be a gate that
    // silently covers nothing.
    for (final e in kServiceRouteAliases.entries) {
      expect(kRouteToService.values.contains(e.value), isTrue,
          reason: '${e.key.name} aliases ${e.value.name}, which is not mapped');
    }
  });

  test('a non-service route resolves to nothing', () {
    // Settings, receipts and auth routes must not be mistaken for services,
    // or an unrelated deep link could be blocked by a service gate.
    expect(serviceForRoute(null), isNull);
    expect(serviceForRoute(''), isNull);
    expect(serviceForRoute('/definitely-not-a-service'), isNull);
  });

  test('a known service route resolves', () {
    expect(serviceForRoute(AppRoutes.airtime), AppServiceName.airtime);
    expect(serviceForRoute(AppRoutes.billsHub), AppServiceName.payBills);
  });

  test('every mapped service has a display name for the modal', () {
    // The modal titles itself with displayName; an empty one would render
    // " is unavailable".
    for (final svc in kRouteToService.values) {
      expect(svc.displayName.trim(), isNotEmpty, reason: '${svc.name}');
    }
  });
}
