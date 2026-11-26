import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/vendor_campaigns/domain/vendor_entities.dart';

/// "ALREADY SERVED" NOW MEANS TWO DIFFERENT THINGS, AND THE DOOR HAS TO KNOW
/// WHICH.
///
///   campaign scope — served on THIS campaign. A bare clock time is exactly
///       right: the only question is whether it was just now on the other till.
///   vendor scope   — served by this VENDOR, possibly on another campaign,
///       possibly days ago at another venue. A bare "served at 19:42" reads as
///       tonight, so the attendant tells a customer they were here when they
///       were not — an argument neither can settle, because the customer knows
///       they did not come and the screen says they did.
void main() {
  VendorCampaign campaign({String? scope}) => VendorCampaign(
        id: 'c1',
        name: 'Launch night',
        currency: 'NGN',
        unitAmountKobo: 500000,
        maxRedemptions: 200,
        redeemedCount: 10,
        remainingRedemptions: 190,
        accruedAmountKobo: 5000000,
        paidOutKobo: 0,
        outstandingKobo: 5000000,
        status: 'active',
        startsAt: DateTime(2026, 11, 18, 18),
        endsAt: DateTime(2026, 11, 18, 23),
        closeReason: '',
        uniquenessScope: scope ?? 'campaign',
      );

  group('the client reads the scope the same way the server resolves it', () {
    test('only the exact "vendor" widens the rule', () {
      expect(campaign(scope: 'vendor').isVendorScoped, isTrue);
      for (final narrow in ['campaign', '', 'VENDOR', 'vendor_wide', 'junk']) {
        expect(campaign(scope: narrow).isVendorScoped, isFalse,
            reason: '"$narrow" must not widen the rule — the client and the '
                'server fall back identically, or the app refuses a customer '
                'the backend would have served (or promises one it will not)');
      }
    });

    test('an absent scope defaults to the narrow rule', () {
      expect(campaign().isVendorScoped, isFalse,
          reason: 'a server that predates the field sends nothing, and those '
              'campaigns genuinely run the once-per-campaign rule');
    });
  });

  // The copy is the whole point of carrying the scope to the client.
  test('the refusal sheet distinguishes the two rules', () {
    final src = File(
      'lib/src/features/vendor_campaigns/presentation/widgets/'
      'vendor_result_sheet.dart',
    ).readAsStringSync();

    expect(src.contains('campaign.isVendorScoped'), isTrue,
        reason: 'the sheet says only "Served at HH:MM", which under the wide '
            'rule asserts the customer was here tonight when they may have '
            'been served days ago at another venue');

    expect(src.contains('_when('), isTrue,
        reason: 'the wide rule can refuse on a scan from another day, so the '
            'date has to appear — a bare clock time reads as tonight');
  });

  // A vendor must learn the rule BEFORE the queue, not from a refusal in it.
  test('the card advertises the wide rule up front', () {
    final src = File(
      'lib/src/features/vendor_campaigns/presentation/widgets/'
      'vendor_campaign_card.dart',
    ).readAsStringSync();
    expect(src.contains('campaign.isVendorScoped'), isTrue,
        reason: 'once-per-business refuses customers this venue has never '
            'seen; a vendor who discovers that mid-queue has learned it too '
            'late');
  });

  // The generator must own this proto, or the Dart drifts by hand again.
  test('generate_proto.sh covers vendor_campaigns', () {
    final src = File('generate_proto.sh').readAsStringSync();
    expect(src.contains('vendor_campaigns.proto'), isTrue,
        reason: 'the Dart output existed while this script never produced it, '
            'so fifteen admin messages had no Dart class at all — absent '
            'rather than broken, which is the hard kind to notice');
  });
}
