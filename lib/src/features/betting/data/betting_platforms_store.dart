import '../domain/entities/betting_entities.dart';

/// Process-level cache for the bookmaker list.
///
/// WHY IT EXISTS. BettingCubit is a FACTORY registration, so every entry into
/// the funding screen builds a new one, and its `initState` called
/// `loadPlatforms()` — which emits Loading first. The screen renders a
/// full-page spinner on that state, so leaving the page and coming back
/// blanked the whole form and refetched over the network every single time.
/// That is the reported "clicking out and into this fund betting page leads
/// to constant reloading".
///
/// The list is near-static reference data — which bookmakers the platform
/// supports — not the user's money or anything that changes between two taps.
/// Refetching it on every visit buys nothing and costs a visible blank.
///
/// Cached here rather than in the cubit precisely because the cubit does not
/// outlive the route. The TTL is long enough that normal back-and-forth
/// navigation never refetches, short enough that a bookmaker added or
/// disabled in the admin dashboard reaches handsets the same session.
class BettingPlatformsStore {
  BettingPlatformsStore._();

  static const Duration ttl = Duration(minutes: 15);

  static List<BettingPlatform> _platforms = const [];
  static DateTime? _fetchedAt;

  /// The cached list, empty when nothing has been fetched yet.
  static List<BettingPlatform> get platforms => _platforms;

  static bool get hasValue => _platforms.isNotEmpty;

  /// Whether the cache is old enough to be worth replacing.
  ///
  /// A stale cache is still SERVED — it is shown immediately while a refresh
  /// runs behind it. "Stale" here only decides whether to make the call, not
  /// whether to render.
  static bool get isStale {
    final at = _fetchedAt;
    if (at == null) return true;
    return DateTime.now().difference(at) > ttl;
  }

  static void save(List<BettingPlatform> platforms) {
    // An empty result does not overwrite a good list. A transient backend
    // blip returning nothing would otherwise empty the screen and, worse,
    // stamp itself fresh so nothing retried for the whole TTL.
    if (platforms.isEmpty) return;
    _platforms = List<BettingPlatform>.unmodifiable(platforms);
    _fetchedAt = DateTime.now();
  }

  /// Drops the cache — for sign-out, so one user's view of the catalogue
  /// cannot persist into another's session.
  static void clear() {
    _platforms = const [];
    _fetchedAt = null;
  }
}
