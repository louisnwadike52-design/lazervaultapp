/// WHICH SCOPE PILLS A "VIEW ALL" HISTORY SCREEN SHOULD RENDER.
///
/// THE PROBLEM. Airtime's history screen hardcoded four pills
/// (All / Buy / International / Sell) and the data history screen hardcoded
/// three (All / Local / International). Meanwhile the LANDING tabs for the
/// same services are admin-tunable and have been for a while
/// (`FeatureFlags.airtimeTabAllowed`, `FeatureFlags.dataTabAllowed`). So an
/// operator could close International on the landing screen and still have an
/// "International" filter sitting on the history screen — selecting it gave a
/// permanently empty list for a product the platform does not sell.
///
/// AND A FILTER THAT CANNOT DISCRIMINATE IS WORSE THAN NO FILTER. With only
/// local active, "All" and "Local" select exactly the same rows. Two pills that
/// do the same thing invite the user to tap one, see nothing change, and
/// wonder what they missed. So the rule below removes the whole row rather
/// than leaving a decorative one.
///
/// ONE PLACE, because there are at least four of these screens (airtime, data,
/// and the other utility bills as they grow scopes) and the answer has to be
/// the same on all of them. Pure and synchronous: it reads nothing itself, the
/// caller passes the admin verdict in, which is what makes it testable without
/// SharedPreferences or a running app.
library;

/// The pills to render, in order, or an EMPTY LIST meaning "render no filter
/// row at all".
///
/// [candidates] are the real scopes in display order (e.g. `['buy',
/// 'international', 'sell']`), NOT including the implicit "All".
/// [isAllowed] is the admin tunable — pass `FeatureFlags.airtimeTabAllowed` or
/// `FeatureFlags.dataTabAllowed`.
/// [allScope] is the value of the "no filter" pill, prepended when a row is
/// worth showing.
///
/// Returns `[]` when fewer than two candidates are active, because:
///   * zero active  — there is nothing to filter between.
///   * one  active  — "All" and that one scope select identical rows, so the
///                    row is decoration that implies a choice the user does
///                    not have.
List<String> historyScopePills({
  required List<String> candidates,
  required bool Function(String scope) isAllowed,
  String allScope = 'all',
}) {
  final active = candidates.where(isAllowed).toList(growable: false);
  if (active.length < 2) return const <String>[];
  return <String>[allScope, ...active];
}

/// Whether a scope a screen is currently showing is still a legitimate one.
///
/// Guards the DEEP-LINK case, which is the one that bites: a 'View All' link,
/// a saved route or a notification can carry `scope: 'intl'` from before the
/// operator closed International. Without this the screen would open on a
/// scope that has no pill to deselect it — a filtered, empty list the user
/// cannot escape except by leaving the screen.
bool scopeStillSelectable(String scope, List<String> pills, {String allScope = 'all'}) =>
    scope == allScope || pills.contains(scope);

/// The scope a screen should actually use, given what it was asked for.
///
/// Falls back to [allScope] whenever the requested scope is no longer
/// selectable, so a stale deep link lands on the unfiltered list — which is
/// the honest result: we are not hiding their history, that scope simply no
/// longer exists as a distinction.
String resolveHistoryScope(
  String requested,
  List<String> pills, {
  String allScope = 'all',
}) =>
    scopeStillSelectable(requested, pills, allScope: allScope) ? requested : allScope;
