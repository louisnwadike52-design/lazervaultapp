/// Ordering for the quick-services grid when the user has a saved
/// arrangement.
///
/// Pure and top-level for the same reason as the paging math: it decides what
/// a user sees without swiping, and as a private method on a State that needs
/// the whole DI graph to pump it was unreachable from a test.
library;

import 'package:lazervault/core/types/services.dart';

/// Order [services] by the user's hand-placed [ranks], slotting services that
/// have no rank into the position the DEFAULT order implies.
///
/// THE BUG THIS FIXES
/// ------------------
/// Unranked services used to be appended to the end. The saved arrangement is
/// a snapshot of the services that existed the day the user last dragged
/// something, so every service added or re-keyed afterwards had no rank and
/// went to the very end — which, on a paginated grid, is the last page.
///
/// Airtime and data carry the two lowest default ranks precisely because they
/// are the errands people open the app for several times a week, and they were
/// rendering in the final two cells of the second carousel, below everything.
/// One drag, once, permanently hid every service shipped since, and nothing on
/// screen said why.
///
/// THE RULE
/// --------
/// An unranked service sits immediately BEFORE the first arranged service that
/// the default order puts after it. A hand rank still wins outright wherever
/// the user set one, and the moment they drag the new service themselves it
/// gets a rank and this path stops applying to it.
///
/// [ranks] empty means no arrangement — the caller uses its own default/
/// adaptive sort instead, so this returns the list untouched.
List<T> orderByUserArrangement<T>(
  List<T> services, {
  required Map<AppServiceName, int> ranks,
  required AppServiceName Function(T) nameOf,
}) {
  if (ranks.isEmpty) return List<T>.from(services);

  // Half-steps, so an unranked service can sit strictly between two adjacent
  // integer ranks without colliding with either.
  final maxRank = ranks.values.fold<int>(-1, (m, r) => r > m ? r : m);

  double effectiveRank(T service) {
    final name = nameOf(service);
    final own = ranks[name];
    if (own != null) return own.toDouble();
    final priority = name.revenuePriority;
    int? firstAfter;
    for (final other in services) {
      final otherRank = ranks[nameOf(other)];
      if (otherRank == null) continue;
      if (nameOf(other).revenuePriority <= priority) continue;
      if (firstAfter == null || otherRank < firstAfter) firstAfter = otherRank;
    }
    // Nothing arranged belongs after it, so the end really is its place.
    return (firstAfter?.toDouble() ?? (maxRank + 1).toDouble()) - 0.5;
  }

  final ordered = List<T>.from(services);
  ordered.sort((a, b) {
    final cmp = effectiveRank(a).compareTo(effectiveRank(b));
    if (cmp != 0) return cmp;
    // Two unranked services can share an insertion point. Default order breaks
    // the tie, which keeps it deterministic — a wobbling grid would move a
    // tile out from under a finger mid-drag.
    return nameOf(a).revenuePriority.compareTo(nameOf(b).revenuePriority);
  });
  return ordered;
}
