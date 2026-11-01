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
      expect(quickServicePageSizes(3, 4), [3]);
      expect(quickServicePageSizes(11, 12), [11]);
    });

    test('empty list pages to nothing', () {
      expect(quickServicePageSizes(0, 4), isEmpty);
    });

    test('every page gives up a cell', () {
      // 4 services, page size 4: page one holds 3 + the tile, the 4th moves
      // over and sits beside a Back tile.
      expect(quickServicePageSizes(4, 4), [3, 1]);
      expect(quickServicePageSizes(12, 12), [11, 1]);
    });

    test('the stride is uniform, so no page is wider than another', () {
      // Previously the shift applied to page one ALONE and later pages were
      // full-size. That made the grid reflow mid-swipe and left later pages
      // with no cell for a way back.
      expect(quickServicePageSizes(8, 4), [3, 3, 2]);
      expect(quickServicePageSizes(11, 4), [3, 3, 3, 2]);
      // The real geometry: 20 services over two pages of 11.
      expect(quickServicePageSizes(20, 12), [11, 9]);
    });

    test('every service lands on exactly one page, at every size', () {
      for (var itemsPerPage in [2, 3, 4, 12]) {
        for (var n = 0; n <= 60; n++) {
          final sizes = quickServicePageSizes(n, itemsPerPage);
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
          // Page one must leave room for the tile exactly when it is shown.
          if (sizes.isNotEmpty) {
            final expectFirst = showsMoreTile(n, itemsPerPage)
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
      for (var itemsPerPage in [2, 3, 4, 12]) {
        for (var n = 1; n <= 40; n++) {
          final sizes = quickServicePageSizes(n, itemsPerPage);
          final more = showsMoreTile(n, itemsPerPage);
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
}
