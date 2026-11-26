import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/services/deep_link_service.dart';

/// The parser half of a shared ticketed event.
///
/// EventShareService mints `https://lazervault.app/tickets/<id>`, and an
/// organiser's shared link IS the distribution for a ticketed event — so an
/// unparsed link does not merely degrade the feature, it means every event ever
/// shared sent buyers to a web page instead of to the buy sheet. Exactly the
/// hole crowdfund, lazerspray and groups each shipped with before this.
///
/// The platform halves (the Android `pathPrefix` and the AASA `paths` entry)
/// and the routing half (main.dart) are asserted by
/// test/core/share_link_is_claimed_end_to_end_test.dart; all four must agree.
void main() {
  DeepLinkData parse(String uri) =>
      DeepLinkService.parseUriForTest(Uri.parse(uri));

  // A real uuid, because the parser shape-checks the id.
  const id = '3b85aad2-1c4e-4f2a-9b77-0e1f2a3b4c5d';

  group('a shared event parses', () {
    test('universal link carries the event id', () {
      final d = parse('https://lazervault.app/tickets/$id');
      expect(d.type, DeepLinkType.ticketEvent);
      expect(d.ticketEventId, id);
    });

    test('custom scheme carries the event id', () {
      // app_links turns lazervault://tickets/<id> into host='events' with the
      // id as the first SEGMENT, not as a second path element — the shape the
      // universal link has. Both have to be handled.
      final d = parse('lazervault://tickets/$id');
      expect(d.type, DeepLinkType.ticketEvent);
      expect(d.ticketEventId, id);
    });

    test('a query string rides along without breaking the parse', () {
      final d = parse('https://lazervault.app/tickets/$id?utm_source=whatsapp');
      expect(d.type, DeepLinkType.ticketEvent);
      expect(d.ticketEventId, id);
      expect(d.param('utm_source'), 'whatsapp');
    });

    test('the id is case-insensitive, as a uuid in a URL may be', () {
      final d = parse('https://lazervault.app/tickets/${id.toUpperCase()}');
      expect(d.type, DeepLinkType.ticketEvent);
      expect(d.ticketEventId, id.toUpperCase());
    });
  });

  group('and refuses what is not an event id', () {
    test('a trailing slash with no id does NOT route to the event screen', () {
      // Routing with an empty id opens the detail screen with nothing to load
      // and leaves a permanent spinner — worse than landing on the dashboard.
      expect(parse('https://lazervault.app/tickets/').type,
          isNot(DeepLinkType.ticketEvent));
      expect(parse('https://lazervault.app/tickets').type,
          isNot(DeepLinkType.ticketEvent));
    });

    test("a `tickets/<verb>` shape is not read as an id", () {
      // THE TRAP THE DONATION-RECEIPT BRANCH ALREADY RECORDS HAVING HIT ONCE:
      // `crowdfund/donation/<txn>` was read as a campaign whose id was
      // literally "donation". Ticketing owns /events-mine, /events-create and
      // /events-edit as app routes, and if any ever becomes a shared URL a
      // naive segments[0] would do the same thing here.
      for (final path in [
        'https://lazervault.app/tickets/mine',
        'https://lazervault.app/tickets/create',
        'https://lazervault.app/tickets/checkin/\$id',
        'lazervault://tickets/mine',
      ]) {
        final d = parse(path);
        expect(d.type, isNot(DeepLinkType.ticketEvent),
            reason: '$path was read as an event');
        expect(d.ticketEventId, isNull, reason: path);
      }
    });

    test('a non-uuid id is refused rather than sent to a gRPC call', () {
      // The id goes straight into a request that rejects a bad uuid with an
      // opaque error, so the user would get a permanent spinner and no reason.
      for (final bad in ['not-a-uuid', '12345', 'null', '%20']) {
        expect(parse('https://lazervault.app/tickets/$bad').type,
            isNot(DeepLinkType.ticketEvent),
            reason: bad);
      }
    });

    test("the WEBSITE's own /events/<slug> is left alone", () {
      // The website serves its marketing events there. If the app claimed and
      // parsed that path, a shared workshop link would be intercepted and
      // dropped on the dashboard — a feature broken by one it has nothing to
      // do with.
      for (final path in [
        'https://lazervault.app/events/lagos-workshop-2026',
        'https://lazervault.app/events/\$id',
      ]) {
        expect(parse(path).type, isNot(DeepLinkType.ticketEvent), reason: path);
      }
    });

    test('a different feature on the same host is untouched', () {
      // The events branch sits beside the crowdfund one and must not shadow it.
      final cf = parse('https://lazervault.app/crowdfund/abc-123');
      expect(cf.type, DeepLinkType.crowdfundCampaign);
      expect(cf.ticketEventId, isNull);

      final grp = parse('https://lazervault.app/groups/abc-123');
      expect(grp.type, DeepLinkType.groupAccount);
      expect(grp.ticketEventId, isNull);
    });
  });
}
