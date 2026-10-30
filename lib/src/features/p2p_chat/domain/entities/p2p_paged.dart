/// A page of results plus the metadata needed to ask for the next one.
///
/// WHY THIS EXISTS. The p2p-chat service has always returned `total`, `page`
/// and `limit` alongside the rows; the client parsed only the rows and threw
/// the rest away. With nothing recording how many connections existed, the list
/// could not know there was a second page — so a user with more than 20
/// connections simply could not see the rest, and the fix needed no backend
/// change at all, only somewhere to put the numbers the server was already
/// sending.
class P2PPaged<T> {
  const P2PPaged({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });

  final List<T> items;

  /// Total rows across every page, as the server counted them.
  final int total;

  /// 1-based page this payload represents.
  final int page;

  /// Rows per page the server honoured (it may clamp what we asked for).
  final int limit;

  /// Whether another page exists.
  ///
  /// Derived from the server's own total rather than from "did this page come
  /// back full". A full page is ambiguous when total is an exact multiple of
  /// limit: 40 rows at 20 per page would look like there is a third page, and
  /// the list would keep asking for one forever.
  bool get hasMore {
    if (total <= 0) return false;
    final effectiveLimit = limit > 0 ? limit : items.length;
    if (effectiveLimit <= 0) return false;
    return page * effectiveLimit < total;
  }

  /// The page number to request next, or null when the list is complete.
  int? get nextPage => hasMore ? page + 1 : null;

  P2PPaged<T> copyWith({List<T>? items, int? total, int? page, int? limit}) =>
      P2PPaged<T>(
        items: items ?? this.items,
        total: total ?? this.total,
        page: page ?? this.page,
        limit: limit ?? this.limit,
      );

  static P2PPaged<T> empty<T>() =>
      P2PPaged<T>(items: const [], total: 0, page: 1, limit: 0);
}
