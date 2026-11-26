import 'dart:async';

/// ONE PAGE AHEAD, AND ONLY THE RIGHT ONE.
///
/// Escrow Pay fetches page N+1 in the background as soon as page N has been
/// painted, so tapping "2" on the pager is instant rather than a second
/// shimmer. The pattern is small and the two details that make it correct are
/// easy to get wrong, which is why it lives here rather than being copied
/// into every list:
///
///  * **It is KEYED.** A prefetch is only served for exactly the list and
///    page it was fetched for. Without the key, changing a filter and paging
///    serves rows from the previous filter — a prefetch that shows the wrong
///    data is worse than no prefetch at all, and it fails silently because
///    the rows look plausible.
///  * **It is fired AFTER the emit, and its failures are swallowed.** A
///    prefetch that delays the page the user asked for has inverted its own
///    purpose, and one that surfaces an error turns a missed optimisation
///    into something the customer has to read.
///
/// Holds exactly one page. A list the user is paging through only ever needs
/// the next one, and a cache of many is a cache that has to be invalidated.
class NextPagePrefetch<T> {
  String? _key;
  T? _hit;

  /// The prefetched page for [key], or null. Consumes it either way: a page
  /// served once is a page the caller now owns, and a stale hit for a
  /// different key must not survive to be matched later.
  T? take(String key) {
    final T? hit = _hit;
    final matched = hit != null && _key == key;
    _hit = null;
    _key = null;
    if (!matched) return null;
    return hit;
  }

  /// Fetch [key] in the background and hold it.
  ///
  /// Call AFTER the current page has been emitted. Never awaited by the
  /// caller, and never throws.
  void warm(String key, Future<T> Function() fetch) {
    unawaited(fetch().then((page) {
      _hit = page;
      _key = key;
    }).catchError((_) {
      _hit = null;
      _key = null;
      return;
    }));
  }

  /// Drop whatever is held — on sign-out, or when the list it belongs to is
  /// invalidated by a mutation.
  void clear() {
    _hit = null;
    _key = null;
  }

  /// Whether a page is held for [key]. For tests and for a cubit that wants
  /// to report "instant" in its state.
  bool has(String key) => _hit != null && _key == key;
}

/// The key a prefetch is stored under: every axis that changes WHICH rows
/// come back, plus the page.
///
/// Build it from the same values the request is built from. A filter left out
/// here is a filter whose change serves the previous filter's rows.
String pageKey(List<Object?> scope, int page) =>
    '${scope.map((s) => s?.toString() ?? '').join('|')}#$page';
