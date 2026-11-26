import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/route_service_map.dart';
import 'package:lazervault/core/types/services.dart';

/// FINANCIAL CONNECTIONS IS AN ICON, NOT A QUICK-SERVICE TILE.
///
/// It shipped briefly as a grid tile ranked onto page one. That was wrong twice
/// over: it took a quick-action slot from an actual errand, and what it opens
/// is an existing PAGE — somewhere you go to look, not something you do. It now
/// lives as an icon on the trailing edge of the services card
/// (_buildFinancialConnectionsCta in app_services_builder.dart).
///
/// These tests previously asserted the opposite. They are rewritten rather than
/// deleted because the enum facts below still matter.
void main() {
  group('financial connections placement', () {
    // Page one holds 11 services: a 4 x 3 grid with the last cell reserved for
    // the More tile (quickServicePerPage = itemsPerPage - 1).
    const servicesOnPageOne = 11;

    test('it is NOT ranked into the quick-services grid', () {
      expect(AppServiceName.financialConnections.revenuePriority,
          greaterThan(servicesOnPageOne),
          reason: 'a page-one rank would put it back in the grid, taking a '
              'slot from an errand and duplicating the icon entry point');
    });

    test('batch transfer kept its page-one slot', () {
      // It was displaced to make room when this was briefly a tile; removing
      // the tile must give the slot back rather than leave it stranded.
      expect(AppServiceName.batchTransfer.revenuePriority,
          lessThanOrEqualTo(servicesOnPageOne));
    });

    test('the icon still has a route to open', () {
      expect(serviceForRoute(AppRoutes.linkedBanks),
          AppServiceName.financialConnections,
          reason: 'the enum value is load-bearing for deep links even though '
              'it is not a tile — removing it would break links naming it');
      expect(AppRoutes.linkedBanks, isNotEmpty);
    });

    test('it has a label and a backing service', () {
      expect(AppServiceName.financialConnections.displayName, isNotEmpty);
      expect(AppServiceName.financialConnections.displayName,
          contains('Financial'));
    });

    test('it was APPENDED to the enum, never inserted', () {
      // The fallback rank is `100 + index`, so inserting mid-enum silently
      // reshuffles every service after it.
      //
      // WHAT THIS GUARDS, precisely: that nothing was inserted BEFORE
      // financialConnections, which would move it and everything after it.
      // It does NOT guard against further appends — appending is the safe
      // operation this test exists to encourage, and asserting on `.last`
      // made every correct append look like a regression. `vendorCampaigns`
      // was appended after it on 2026-11-11 and is the current last member.
      final vals = AppServiceName.values;
      final at = vals.indexOf(AppServiceName.financialConnections);

      expect(at, greaterThan(0), reason: 'the member must still exist');
      expect(vals[at - 1], AppServiceName.data,
          reason: 'the member before it must be unchanged, or ranks shifted');
      expect(vals.sublist(0, at + 1).last, AppServiceName.financialConnections,
          reason: 'nothing may be inserted ahead of it');
    });

    test('every later addition was appended too', () {
      // The same rule, stated once for the whole tail rather than pinned to
      // one member: each service added after `data` must sit at the END of
      // the enum at the time it was added, so no existing rank moved.
      final vals = AppServiceName.values;
      final tail = [
        AppServiceName.data,
        AppServiceName.financialConnections,
        AppServiceName.vendorCampaigns,
        AppServiceName.ticketing,
      ];
      expect(
        vals.sublist(vals.length - tail.length),
        tail,
        reason: 'the appended tail changed order — some service\'s fallback '
            'rank has silently shifted',
      );
    });
  });
}
