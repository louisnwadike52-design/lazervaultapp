import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/quick_services_paging.dart';

/// The quick-services carousel reserves the last cell of EVERY page for a
/// fixed navigation tile, because the carousel's only affordance was a row of
/// dots and a swipe nobody knew to try — so the second page of services went
/// undiscovered.
///
/// It was page one only at first, which solved discovery and created its
/// mirror image: a user who tapped "More" landed on page two with nothing
/// offering the way back. Every page now ends in the tile — forward on the way
/// out, back on the last page.
///
/// Reserving a cell on every page shrinks the stride. A reorder drag reports
/// positions through [serviceIndexAt] and the grid persists the result, so an
/// off-by-one here moves a service the user did not touch and saves that. The
/// production grid is 4x3 = 12; these tests use 4 so the boundaries are
/// readable, and repeat the real size where the boundary is the point.
void main() {
  group('showsMoreTile', () {
    test('not shown when everything already fits', () {
      // 3 of 4 cells used, one spare: nothing is hidden, so nothing to offer.
      expect(showsMoreTile(3, 4), isFalse);
      expect(showsMoreTile(11, 12), isFalse);
    });

    test('not shown for an empty or single-service grid', () {
      expect(showsMoreTile(0, 4), isFalse);
      expect(showsMoreTile(1, 4), isFalse);
    });

    test('shown at exactly one full page — the tile creates page two', () {
      // The deliberate trade: 12 services would have filled page one exactly,
      // so the 12th moves one swipe away and the carousel gains its signpost.
      expect(showsMoreTile(4, 4), isTrue);
      expect(showsMoreTile(12, 12), isTrue);
    });

    test('shown whenever there is more than one page of services', () {
      expect(showsMoreTile(13, 12), isTrue);
      expect(showsMoreTile(30, 12), isTrue);
    });
  });

  group('quickServicePageSizes', () {
    test('no paging needed — one short page, no reserved cell', () {
      expect(quickServicePageSizes(3, 4, reservesCell: true), [3]);
      expect(quickServicePageSizes(11, 12, reservesCell: true), [11]);
    });

    test('empty list pages to nothing', () {
      expect(quickServicePageSizes(0, 4, reservesCell: true), isEmpty);
    });

    test('every page gives up a cell', () {
      // 4 services, page size 4: page one holds 3 + the tile, the 4th moves
      // over and sits beside a Back tile.
      expect(quickServicePageSizes(4, 4, reservesCell: true), [3, 1]);
      expect(quickServicePageSizes(12, 12, reservesCell: true), [11, 1]);
    });

    test('the stride is uniform, so no page is wider than another', () {
      // Previously the shift applied to page one ALONE and later pages were
      // full-size. That made the grid reflow mid-swipe and left later pages
      // with no cell for a way back.
      expect(quickServicePageSizes(8, 4, reservesCell: true), [3, 3, 2]);
      expect(quickServicePageSizes(11, 4, reservesCell: true), [3, 3, 3, 2]);
      // The real geometry: 20 services over two pages of 11.
      expect(quickServicePageSizes(20, 12, reservesCell: true), [11, 9]);
    });

    test('every service lands on exactly one page, at every size', () {
      // Swept across BOTH placements: the invariant "no service is lost or
      // duplicated" has to hold whether or not the control takes a cell.
      for (var reservesCell in [true, false])
      for (var itemsPerPage in [2, 3, 4, 12]) {
        for (var n = 0; n <= 60; n++) {
          final sizes =
              quickServicePageSizes(n, itemsPerPage, reservesCell: reservesCell);
          expect(sizes.fold<int>(0, (a, b) => a + b), n,
              reason: 'n=$n perPage=$itemsPerPage lost or duplicated a '
                  'service: $sizes');
          for (final s in sizes) {
            expect(s, greaterThan(0),
                reason: 'n=$n perPage=$itemsPerPage produced an empty page, '
                    'which renders as a blank carousel slide: $sizes');
            expect(s, lessThanOrEqualTo(itemsPerPage),
                reason: 'n=$n perPage=$itemsPerPage overfilled a page: '
                    '$sizes');
          }
          // Page one leaves room for the tile exactly when the tile is DRAWN
          // in the grid — placement, not merely "is there another page".
          if (sizes.isNotEmpty) {
            final expectFirst =
                (reservesCell && showsMoreTile(n, itemsPerPage))
                    ? itemsPerPage - 1
                    : (n < itemsPerPage ? n : itemsPerPage);
            expect(sizes.first, expectFirst,
                reason: 'n=$n perPage=$itemsPerPage mis-sized page one');
          }
        }
      }
    });
  });

  group('serviceIndexAt', () {
    test('without the More tile it is the plain flat index', () {
      expect(serviceIndexAt(0, 0, 4, moreTileShown: false), 0);
      expect(serviceIndexAt(0, 3, 4, moreTileShown: false), 3);
      expect(serviceIndexAt(1, 0, 4, moreTileShown: false), 4);
      expect(serviceIndexAt(2, 1, 4, moreTileShown: false), 9);
    });

    test('with the tile, page one is unshifted', () {
      expect(serviceIndexAt(0, 0, 4, moreTileShown: true), 0);
      expect(serviceIndexAt(0, 2, 4, moreTileShown: true), 2);
    });

    test('with the tile, the stride is one shorter on every page', () {
      // Page one holds services 0..2, so page two begins at 3, not 4. Reading
      // it as 4 would make a drag move the service AFTER the one grabbed.
      expect(serviceIndexAt(1, 0, 4, moreTileShown: true), 3);
      expect(serviceIndexAt(1, 2, 4, moreTileShown: true), 5);
      // The shift COMPOUNDS now that every page reserves a cell: page three
      // starts at 6, not 7. Under the old page-one-only rule this was 7, and
      // reading it that way skips a service.
      expect(serviceIndexAt(2, 0, 4, moreTileShown: true), 6);
      // Production geometry: page two starts at the 12th service (index 11).
      expect(serviceIndexAt(1, 0, 12, moreTileShown: true), 11);
    });

    test('the navigation tile points back only on the last page', () {
      // "More" on the final page is a control that does nothing — the exact
      // failure the tile was introduced to avoid.
      expect(quickServiceTileGoesBack(0, 3), isFalse);
      expect(quickServiceTileGoesBack(1, 3), isFalse);
      expect(quickServiceTileGoesBack(2, 3), isTrue);
      // Two pages: out on one, back on the other.
      expect(quickServiceTileGoesBack(0, 2), isFalse);
      expect(quickServiceTileGoesBack(1, 2), isTrue);
    });

    test('walking the grid visits every service index exactly once', () {
      // The property that actually matters for reorder: the mapping from
      // (page, cell) to service index is a bijection onto 0..n-1. Anything
      // else means some service cannot be dragged, or two cells claim one.
      // Both placements again. The indexing stride is derived from the SAME
      // placement the pages were built with — passing one answer to the pager
      // and another to serviceIndexAt is precisely how a reorder drag comes to
      // move the wrong service.
      for (var reservesCell in [true, false])
      for (var itemsPerPage in [2, 3, 4, 12]) {
        for (var n = 1; n <= 40; n++) {
          final sizes =
              quickServicePageSizes(n, itemsPerPage, reservesCell: reservesCell);
          final more = reservesCell && showsMoreTile(n, itemsPerPage);
          final seen = <int>[];
          for (var p = 0; p < sizes.length; p++) {
            for (var i = 0; i < sizes[p]; i++) {
              seen.add(serviceIndexAt(p, i, itemsPerPage,
                  moreTileShown: more));
            }
          }
          seen.sort();
          expect(seen, List.generate(n, (i) => i),
              reason: 'n=$n perPage=$itemsPerPage does not map the grid onto '
                  'the service list one-to-one — a reorder drag would move '
                  'the wrong service and persist it');
        }
      }
    });
  });

  _navTilePlacement();
  _indicatorRowArrangement();
}

/// THE INDICATOR-ROW ARRANGEMENT — the default, and the one that was broken.
///
/// The page-turn control has two placements. As a grid TILE it consumes a
/// cell, so every page carries itemsPerPage - 1 services. As a PILL on the
/// indicator row it consumes nothing, so every page must carry a full
/// itemsPerPage.
///
/// Page sizes were computed from `showsMoreTile` alone, which only asks "is
/// there another page" — it knows nothing about where the control is drawn.
/// With the pill arrangement every page therefore still surrendered its last
/// square to a tile that was never there: a 4x3 grid rendered ELEVEN services
/// and one permanent blank, with "More 11" sitting in the bar underneath it.
void _indicatorRowArrangement() {
  group('page-turn control on the indicator row', () {
    test('pages fill completely — no cell is held for an absent tile', () {
      // The exact shape from the report: a 4x3 grid, control on the bar.
      expect(quickServicePageSizes(23, 12, reservesCell: false), [12, 11]);
      expect(quickServicePageSizes(12, 12, reservesCell: false), [12]);
      expect(quickServicePageSizes(4, 4, reservesCell: false), [4]);
      expect(quickServicePageSizes(9, 4, reservesCell: false), [4, 4, 1]);
    });

    test('the two arrangements disagree exactly where they should', () {
      // Same service count, different placement, different geometry. If these
      // two ever match, the placement is being ignored again.
      expect(quickServicePageSizes(12, 12, reservesCell: true), [11, 1]);
      expect(quickServicePageSizes(12, 12, reservesCell: false), [12]);
    });

    test('a count that fits on one page needs no control at all', () {
      // 12 services with the pill arrangement is ONE page. The old rule asked
      // showsMoreTile(12, 12) -> true and rendered a pill reading "More 0"
      // that turned to a page which did not exist.
      expect(quickServicePageSizes(12, 12, reservesCell: false).length, 1);
      expect(quickServicePageSizes(11, 12, reservesCell: true).length, 1);
    });

    test('indexing follows the same stride the pages were built with', () {
      // serviceIndexAt takes the placement through moreTileShown; passing a
      // different answer than the pager used is how a reorder drag moves the
      // wrong service.
      expect(serviceIndexAt(1, 0, 12, moreTileShown: false), 12);
      expect(serviceIndexAt(1, 0, 12, moreTileShown: true), 11);
    });

    test('an empty or single-service list is unchanged by placement', () {
      for (final reserves in [true, false]) {
        expect(quickServicePageSizes(0, 12, reservesCell: reserves), isEmpty);
        expect(quickServicePageSizes(1, 12, reservesCell: reserves), [1]);
      }
    });
  });
}

/// WHERE THE NAVIGATION TILE SITS.
///
/// Trailing the last service on every page EXCEPT the final one, where the
/// operator asked for it at the start of the last row: going forward it
/// reads as "and then more", which belongs where the eye already is; coming
/// back it is the way OUT and should read as a control, not another service.
void _navTilePlacement() {
  group('navTileIndexOnPage', () {
    test('a forward page keeps the tile after the last service', () {
      expect(navTileIndexOnPage(11, 4, isLastPage: false), 11);
      expect(navTileIndexOnPage(3, 4, isLastPage: false), 3);
    });

    test('the last page puts it first on the final row', () {
      // 9 services, 4 columns: rows are [0-3] [4-7] [8]. The tile takes
      // index 8, so the last row renders [Back, 9th service].
      expect(navTileIndexOnPage(9, 4, isLastPage: true), 8);
      // 6 services: rows [0-3] [4-5] -> tile at 4, last row [Back, 5th, 6th].
      expect(navTileIndexOnPage(6, 4, isLastPage: true), 4);
    });

    test('an exactly-full last row starts a new one', () {
      // 8 services fill two whole rows, so the final row is the tile alone.
      expect(navTileIndexOnPage(8, 4, isLastPage: true), 8);
    });

    test('degenerate inputs do not produce a negative index', () {
      expect(navTileIndexOnPage(0, 4, isLastPage: true), 0);
      expect(navTileIndexOnPage(5, 0, isLastPage: true), 5);
    });
  });

  group('serviceSlotForCell', () {
    test('cells before the tile map to themselves', () {
      expect(serviceSlotForCell(0, 8), 0);
      expect(serviceSlotForCell(7, 8), 7);
    });

    test('cells after the tile map one service earlier', () {
      // THE OFF-BY-ONE THAT MATTERS: a reorder drag reports positions
      // through here, so getting this wrong moves a service the user never
      // touched and then persists it.
      expect(serviceSlotForCell(9, 8), 8);
      expect(serviceSlotForCell(11, 8), 10);
    });

    test('every service on a page is reachable exactly once', () {
      for (final n in [1, 5, 8, 9, 11]) {
        final nav = navTileIndexOnPage(n, 4, isLastPage: true);
        final seen = <int>[];
        for (var cell = 0; cell <= n; cell++) {
          if (cell == nav) continue;
          seen.add(serviceSlotForCell(cell, nav));
        }
        seen.sort();
        expect(seen, List.generate(n, (i) => i),
            reason: 'n=$n nav=$nav does not map the grid onto the page one '
                'to one — a drag would move the wrong service');
      }
    });
  });
}

