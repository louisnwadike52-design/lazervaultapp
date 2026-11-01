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

/// Whether the carousel shows its fixed navigation tile.
///
/// Only when there is genuinely another page: the tile consumes a cell, so a
/// grid that already fits gains nothing and loses a slot. With exactly
/// `itemsPerPage` services the tile creates the second page, which is the
/// intended trade — one service moved one swipe away, in exchange for the
/// carousel advertising that it can be swiped at all.
///
/// A navigation tile that leads nowhere is worse than none, which is why this
/// is a strict `>`.
bool showsMoreTile(int serviceCount, int itemsPerPage) =>
    serviceCount > itemsPerPage - 1;

/// Services per page once the navigation tile is in play.
///
/// EVERY page gives up its last cell, not just the first. The tile used to
/// live on page one alone, which left later pages with no way out except the
/// swipe the tile exists to compensate for — a user who arrived on page two by
/// tapping "More" found nothing offering the trip back. One reserved cell per
/// page keeps the geometry identical on every slide, so the grid does not
/// reflow as you swipe and the control is always in the same corner.
int quickServicePerPage(int itemsPerPage) => itemsPerPage - 1;

/// Split [count] services into pages, reserving the last cell of each page for
/// the navigation tile when [showsMoreTile] says so.
///
/// Returns the COUNT of services on each page, which is all the caller needs
/// to slice its own list and all a test needs to check the shape.
List<int> quickServicePageSizes(int count, int itemsPerPage) {
  if (count <= 0) return const [];
  final perPage =
      showsMoreTile(count, itemsPerPage) ? quickServicePerPage(itemsPerPage) : itemsPerPage;
  final sizes = <int>[];
  for (int i = 0; i < count; i += perPage) {
    sizes.add((i + perPage < count) ? perPage : count - i);
  }
  return sizes;
}

/// Index into the flat, ordered service list for the tile at [indexOnPage] of
/// [pageIndex].
///
/// NOT `pageIndex * itemsPerPage + indexOnPage` once the navigation tile is
/// shown: it takes the last cell of every page, so each page carries one fewer
/// service and the stride shrinks by one accordingly.
int serviceIndexAt(
  int pageIndex,
  int indexOnPage,
  int itemsPerPage, {
  required bool moreTileShown,
}) {
  final stride =
      moreTileShown ? quickServicePerPage(itemsPerPage) : itemsPerPage;
  return pageIndex * stride + indexOnPage;
}

/// Which way the navigation tile on [pageIndex] should point.
///
/// Forward everywhere except the last page, which can only go back. A "More"
/// tile on the final page would be a control that does nothing — the exact
/// failure the first page's tile was added to avoid.
bool quickServiceTileGoesBack(int pageIndex, int pageCount) =>
    pageCount > 0 && pageIndex >= pageCount - 1;
