part of 'notification_route_resolver.dart';

/// PROMOTIONAL campaigns — the daily "here is what Lazervault can do" sends.
///
/// WHY ONE TYPE INSTEAD OF A CASE PER SERVICE. Every other domain in this
/// resolver maps an EVENT ("your transfer failed") to the record it is about.
/// A promotion is not about a record; it is about a SERVICE, and there are
/// forty of them. Hand-writing forty cases would mean a new service silently
/// has no promotional deep link until someone remembers to add one, and a
/// renamed route breaks links already sitting on handsets.
///
/// So a campaign names the service — `lazervault://n/promo?service=airtime` —
/// and the route is looked up in the same map the availability gate uses.
/// That has three consequences worth stating:
///
///   * every service with a named route is linkable the day it is added;
///   * the campaign payload never contains an internal route name, so routes
///     can be renamed without invalidating links already delivered;
///   * a promo cannot point somewhere the gate does not know about, because
///     both read one map. The navigator then applies the frozen-account and
///     admin-unavailable checks exactly as it does for any other deep link,
///     so a service switched off mid-campaign explains itself rather than
///     opening a dead screen.
///
/// `serviceLanding` precision, always: a promotion is an invitation to a
/// service, not a pointer at a record.
NotificationTarget? _resolvePromo(String type, Map<String, String> data) {
  if (!_is(type, 'promo') &&
      !_is(type, 'campaign') &&
      !_is(type, 'announcement')) {
    return null;
  }

  // The service is the whole payload. Several spellings accepted because an
  // operator types this into a campaign form and a typo must not become a
  // dead link on every handset that received the push.
  final route = routeForServiceName(
    _first(data, ['service', 'service_name', 'target_service', 'feature']),
  );
  if (route != null) return _landing(route);

  // A campaign may also name a raw destination for something that is not a
  // service at all — a referral page, the rewards screen. Only accepted when
  // it is a route this build actually registers, so a link minted against a
  // newer app does not dead-end here: falling through returns null, and the
  // navigator opens the notifications feed where the message can still be
  // read.
  final named = _first(data, ['route', 'screen', 'destination']);
  if (named != null && kKnownPromoRoutes.contains(named)) {
    return _landing(named);
  }

  // A promotion with no usable destination is still a message worth reading,
  // and the feed is where it lives. Returning the feed rather than null means
  // the tap always does something — a promo that opens nothing reads as the
  // app being broken, which is a worse outcome for a marketing send than a
  // slightly generic landing.
  return _landing(AppRoutes.notificationsFeed);
}

/// Non-service destinations a campaign may legitimately link to.
///
/// A CLOSED list. The alternative — accepting any route string from the
/// payload — turns a push into an arbitrary-navigation primitive, where a
/// malformed or hostile payload could drop a user straight onto a
/// money-moving screen with attacker-chosen arguments. These are the pages a
/// promotion has a reason to open, and nothing else.
const Set<String> kKnownPromoRoutes = {
  AppRoutes.notificationsFeed,
  AppRoutes.dashboard,
  // Referral and rewards: the two non-service pages a campaign has an actual
  // reason to open ("invite a friend", "you have points to spend").
  AppRoutes.referralDashboard,
  AppRoutes.lazerPoints,
};
