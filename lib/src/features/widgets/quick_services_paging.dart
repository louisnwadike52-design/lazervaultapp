/// Paging arithmetic for the quick-services carousel.
///
/// Extracted as pure top-level functions because the grid's correctness rests
/// on them and they were otherwise unreachable from a test: they lived as
/// private methods on a State that needs the whole DI graph to pump. The
/// dangerous one is [serviceIndexAt] — a reorder drag reports positions
/// through it, so an off-by-one moves the wrong service AND persists the
/// result, with nothing on screen to say so.
///
/// Both take `itemsPerPage` rather than reading a constant, so a test can
/// exercise the boundaries at a small, readable page size.
library;

/// Whether the first page should end in the fixed "More" tile.
///
/// Only when there is genuinely a later page: the tile consumes a cell, so
/// page one carries `itemsPerPage - 1` services and anything beyond that flows
/// onward. With exactly `itemsPerPage` services the tile creates the second
/// page, which is the intended trade — one service moved one swipe away, in
/// exchange for the carousel advertising that it can be swiped.
///
/// A More tile that advances to nothing is worse than none at all, which is
/// why this is a strict `>`.
bool showsMoreTile(int serviceCount, int itemsPerPage) =>
    serviceCount > itemsPerPage - 1;

/// Split [count] services into pages, reserving the last cell of page one for
/// the More tile when [showsMoreTile] says so.
///
/// Returns the COUNT of services on each page, which is all the caller needs
/// to slice its own list and all a test needs to check the shape.
List<int> quickServicePageSizes(int count, int itemsPerPage) {
  if (count <= 0) return const [];
  final sizes = <int>[];
  if (!showsMoreTile(count, itemsPerPage)) {
    for (int i = 0; i < count; i += itemsPerPage) {
      sizes.add((i + itemsPerPage < count) ? itemsPerPage : count - i);
    }
    return sizes;
  }
  final first = itemsPerPage - 1;
  sizes.add(first);
  for (int i = first; i < count; i += itemsPerPage) {
    sizes.add((i + itemsPerPage < count) ? itemsPerPage : count - i);
  }
  return sizes;
}

/// Index into the flat, ordered service list for the tile at [indexOnPage] of
/// [pageIndex].
///
/// NOT `pageIndex * itemsPerPage + indexOnPage` once the More tile is shown:
/// it occupies the last cell of page one, so page one holds one fewer service
/// and every later page begins one position earlier.
int serviceIndexAt(
  int pageIndex,
  int indexOnPage,
  int itemsPerPage, {
  required bool moreTileShown,
}) {
  if (!moreTileShown) return pageIndex * itemsPerPage + indexOnPage;
  if (pageIndex == 0) return indexOnPage;
  return (itemsPerPage - 1) + (pageIndex - 1) * itemsPerPage + indexOnPage;
}
