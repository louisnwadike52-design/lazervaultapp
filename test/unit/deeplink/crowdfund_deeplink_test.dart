import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/services/deep_link_service.dart';

/// Crowdfund funding links opened a BROWSER instead of the app, because
/// `/crowdfund/` was claimed nowhere: absent from the Android intent filters,
/// absent from apple-app-site-association, and unknown to the parser. Someone
/// sharing their campaign was sending supporters to a web page rather than into
/// the app, which is where the donation actually happens.
///
/// These cover the parser half. The platform halves are the AndroidManifest
/// pathPrefix and the AASA paths entry, which cannot be asserted from here — but
/// all three must agree, and the manifest comment records why.
void main() {
  // The parser is private to the service; exercise it the way the app does, via
  // a constructed link.
  DeepLinkData parse(String uri) {
    // getInitialLink/_handleUri both funnel into the same parser, so round-trip
    // through the public data class the stream emits.
    return DeepLinkService.parseUriForTest(Uri.parse(uri));
  }

  group('crowdfund deep links', () {
    test('universal link carries the campaign id', () {
      final d = parse('https://lazervault.app/crowdfund/abc-123');
      expect(d.type, DeepLinkType.crowdfundCampaign);
      expect(d.crowdfundCampaignId, 'abc-123');
    });

    test('custom scheme carries the campaign id', () {
      final d = parse('lazervault://crowdfund/abc-123');
      expect(d.type, DeepLinkType.crowdfundCampaign);
      expect(d.crowdfundCampaignId, 'abc-123');
    });

    test('a trailing slash with no id does NOT route to the campaign screen',
        () {
      // Routing with an empty id would open the campaign screen with nothing to
      // load and leave a permanent spinner, which is worse than landing on the
      // dashboard.
      final d = parse('https://lazervault.app/crowdfund/');
      expect(d.type, isNot(DeepLinkType.crowdfundCampaign));
    });

    test('does not swallow the other claimed paths', () {
      expect(parse('https://lazervault.app/family/invite/tok').type,
          DeepLinkType.familyInvite);
      expect(parse('https://lazervault.app/escrow/offer/tok').type,
          DeepLinkType.escrowOffer);
    });

    test('query parameters survive, so campaign attribution is not lost', () {
      final d = parse('https://lazervault.app/crowdfund/abc-123?ref=whatsapp');
      expect(d.crowdfundCampaignId, 'abc-123');
      expect(d.param('ref'), 'whatsapp');
    });
  });
}
