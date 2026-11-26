import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Builds the shareable URL for a ticketed event.
///
/// Mirrors CrowdfundShareService exactly, including where the base URL comes
/// from: the `EVENT_SHARE_BASE_URL` env var, falling back to the crowdfund
/// one and then to the production host — so an operator repointing shares
/// does not have to remember that ticketing has its own variable.
///
/// WHY AN ORGANISER NEEDS THIS AT ALL. Publishing an event and then having no
/// way to send anyone to it makes the feature a list nobody finds. The link is
/// the distribution.
class EventShareService {
  static const String _defaultBase = 'https://lazervault.app';

  String get baseUrl {
    final raw = (dotenv.env['EVENT_SHARE_BASE_URL'] ??
            dotenv.env['CROWDFUND_SHARE_BASE_URL'])
        ?.trim();
    if (raw == null || raw.isEmpty) return _defaultBase;
    return raw.endsWith('/') ? raw.substring(0, raw.length - 1) : raw;
  }

  /// The shareable URL for [eventId].
  ///
  /// `/tickets/`, NOT `/events/`.
  ///
  /// The website already owns `/events` and `/events/[slug]` for Lazervault's
  /// OWN marketing events — live sessions and workshops, served from its
  /// eventsDb and matched by public_id, slug or numeric id. Minting ticketed
  /// events at `/events/<uuid>` would have collided with that twice over:
  ///
  ///   * with no app installed, the share link lands on the marketing event
  ///     page, which looks the id up, finds nothing and 404s — on the one path
  ///     that is a ticketed event's whole acquisition route;
  ///   * and claiming `/events/` for the app would have REGRESSED the
  ///     website's own links: a marketing event shared to a device with the
  ///     app would be intercepted by the OS, handed to a parser with no such
  ///     event, and dropped on the dashboard.
  ///
  /// `/tickets/` is unclaimed on both sides. The in-app route stays
  /// `/events/:eventId` — the deep-link handler maps between them, exactly as
  /// it does for `/groups/<id>` → AppRoutes.groupAccount.
  String shareUrlFor(String eventId) => '$baseUrl/tickets/$eventId';

  /// The message that travels with the link.
  ///
  /// Carries the price and the date because a bare URL in a group chat gets
  /// ignored — the recipient has to see what it is before they decide to tap.
  String messageFor({
    required String eventId,
    required String title,
    String? whenLabel,
    String? venue,
    String? priceLabel,
  }) {
    final parts = <String>[title];
    if (whenLabel != null && whenLabel.isNotEmpty) parts.add(whenLabel);
    if (venue != null && venue.isNotEmpty) parts.add(venue);
    if (priceLabel != null && priceLabel.isNotEmpty) {
      parts.add('Tickets $priceLabel');
    }
    return '${parts.join('\n')}\n\n${shareUrlFor(eventId)}';
  }
}
