/// One place that decides how long the app waits for the backend.
///
/// WHY THESE NUMBERS ARE LARGE.
///
/// Most of this app's users are in Nigeria and across Africa, on congested
/// 2G/3G cells and mid-range handsets. On those networks a request that
/// WOULD have succeeded regularly takes ten to twenty seconds — DNS, TCP,
/// TLS and the round trip each costing multiples of what they cost on
/// office wifi.
///
/// A short timeout on a slow-but-working network does not protect anybody.
/// It converts a slow success into a failure, and the user, who has no way
/// to tell the two apart, sees an app that does not work on their phone. The
/// retry that follows then pays the same DNS and TLS cost over again on a
/// link that was already saturated, so aggressive timeouts make a congested
/// cell worse, not better.
///
/// The timeouts here are therefore set by the question "how long before the
/// USER gives up", not "how long should this normally take". A request still
/// in flight at 45 seconds has failed in every sense that matters; one still
/// in flight at 6 seconds very often has not.
///
/// HOW TO CHOOSE ONE. Pick by what the user is doing, not by what the call
/// is:
///
///   * [interactive] — they tapped something and are watching a spinner.
///   * [background]  — a refresh they did not ask for and will not miss.
///   * [upload]      — bytes are moving; a slow link is slow by the megabyte.
///   * [probe]       — an optional enrichment with a usable fallback, where
///                     waiting costs more than not having the answer.
///
/// A timeout shorter than [probe] needs a comment saying why.
library;

class NetworkTimeouts {
  NetworkTimeouts._();

  /// The user tapped something and is watching. Was commonly 6–10s, which
  /// failed real users on real networks.
  static const Duration interactive = Duration(seconds: 45);

  /// Establishing the connection, separately from waiting for the answer.
  /// DNS + TCP + TLS on a congested cell is most of a slow request's cost.
  static const Duration connect = Duration(seconds: 30);

  /// Work nobody is waiting on: a prefetch, a cache revalidation, a sync.
  /// Generous because failing costs nothing and retrying costs the cell.
  static const Duration background = Duration(seconds: 60);

  /// Bytes in either direction. A 2 MB receipt image over 3G is minutes,
  /// not seconds.
  static const Duration upload = Duration(seconds: 120);

  /// Optional enrichment with a usable fallback — the only tier where
  /// giving up quickly is right, because the screen renders either way.
  static const Duration probe = Duration(seconds: 12);
}
