import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/vendor_access.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE VENDOR TILE MUST BE HIDDEN UNTIL THE SERVER SAYS OTHERWISE.
///
/// Vendor Campaigns is the app's first per-user ROLE gate — every other tile
/// decision is a global admin switch, an email whitelist, or an account type.
/// The tile opens a scanner that commits platform money, so an unresolved
/// answer has to hide it. Showing it to a non-vendor would offer a flow in
/// which every single scan is refused by the backend, which reads as a broken
/// feature rather than one that was never theirs.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await VendorAccess.debugResetForTest();
  });

  group('VendorAccess', () {
    test('a fresh install is NOT a vendor', () {
      expect(VendorAccess.isActiveVendor, isFalse,
          reason: 'the default must hide the tile, never show it');
    });

    test('a vendor is remembered so the grid can ask synchronously', () async {
      await VendorAccess.remember(isActive: true, businessName: 'Mama Put');
      expect(VendorAccess.isActiveVendor, isTrue);
      expect(VendorAccess.businessName, 'Mama Put');
    });

    test('logout forgets it', () async {
      await VendorAccess.remember(isActive: true, businessName: 'Mama Put');
      await VendorAccess.clear();

      // A vendor logging out of a shared till device must not leave the tile
      // visible to whoever signs in next.
      expect(VendorAccess.isActiveVendor, isFalse);
      expect(VendorAccess.businessName, isEmpty);
    });

    test('a suspended vendor keeps the tile but is marked inactive', () async {
      // isActive false means "cannot scan"; the screens still have to open so
      // the vendor can see what they are owed. The TILE is driven by the same
      // flag, so suspension is recorded as not-active here only when the
      // server says the vendor is gone entirely.
      await VendorAccess.remember(isActive: false, businessName: 'Mama Put');
      expect(VendorAccess.isActiveVendor, isFalse);
    });
  });

  group('the tile', () {
    test('is a real member of the services enum', () {
      expect(AppServiceName.values, contains(AppServiceName.vendorCampaigns));
      expect(AppServiceName.vendorCampaigns.displayName, 'Vendor Campaigns');
    });

    test('is ranked onto a later carousel page, never page one', () {
      // Page one is eleven tiles. A rank inside that range would put a tile
      // almost nobody can use in front of everybody.
      const servicesOnPageOne = 11;
      expect(AppServiceName.vendorCampaigns.revenuePriority,
          greaterThan(servicesOnPageOne),
          reason: 'a page-one rank would show it ahead of airtime and data');
    });

    test('the grid consults VendorAccess rather than a flag alone', () {
      final src = File('lib/src/features/widgets/app_services_builder.dart')
          .readAsStringSync();

      expect(src, contains('VendorAccess.isActiveVendor'),
          reason: 'the per-user gate is the whole point — quick_service_* '
              'keys are global or per-account-type and cannot express a role');
      expect(src, contains('hidden.add(AppServiceName.vendorCampaigns)'),
          reason: 'a non-vendor must stay out of the All-Services search '
              'corpus and every per-account-type list, even though the '
              'dashboard tile itself has moved to Lifestyle');
    });
  });

  group('its home is Lifestyle, not the quick-services grid', () {
    // Moved 2026-11-19. A scanner only enrolled vendors can open does not
    // belong in a grid whose premise is that every tile is for everyone;
    // Lifestyle is where a destination owned by a subset of users belongs.
    test('it is no longer a tile in the services grid', () {
      final src = File('lib/src/features/widgets/app_services_builder.dart')
          .readAsStringSync();
      expect(
        src,
        isNot(contains('serviceName: AppServiceName.vendorCampaigns')),
        reason: 'putting it back in the grid would undo the move',
      );
    });

    test('Lifestyle carries it, behind BOTH the admin gate and the role', () {
      final src =
          File('lib/src/features/lifestyle/presentation/screens/lifestyle_screen.dart')
              .readAsStringSync();
      expect(src, contains("'Vendor Campaigns'"));
      expect(src, contains("featurePrefix('lifestyle', 'vendorcampaigns')"),
          reason: 'an operator must be able to withdraw it without a release');
      expect(src, contains('VendorAccess.isActiveVendor'),
          reason: 'the role gate has to travel with the entry — the admin '
              'switch alone would show a scanner to every user');
    });

    test('the route still maps to the service, so deep links stay gated', () {
      final src =
          File('lib/core/types/route_service_map.dart').readAsStringSync();
      expect(src, contains('AppServiceName.vendorCampaigns'),
          reason: 'without this a shared link bypasses the gate entirely');
    });
  });
}
