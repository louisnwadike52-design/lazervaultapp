import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/presentation/widgets/paged_pagination_bar.dart';

void main() {
  group('pagination window', () {
    // An off-by-one here renders a page that does not exist, and tapping it
    // returns an empty list that looks like lost data.
    test('short ranges show every page and no gaps', () {
      for (var total = 1; total <= 6; total++) {
        final w = PagedPaginationBar.windowFor(1, total);
        expect(w, [for (var i = 1; i <= total; i++) i], reason: 'total=$total');
        expect(w, isNot(contains(0)), reason: 'total=$total');
      }
    });

    test('first and last are always reachable', () {
      for (final page in [1, 2, 25, 49, 50]) {
        final w = PagedPaginationBar.windowFor(page, 50);
        expect(w.first, 1, reason: 'page=$page');
        expect(w.last, 50, reason: 'page=$page');
      }
    });

    test('the current page is always in the window', () {
      for (final page in [1, 2, 3, 24, 25, 26, 48, 49, 50]) {
        expect(PagedPaginationBar.windowFor(page, 50), contains(page),
            reason: 'page=$page');
      }
    });

    test('gaps mark a skip, and never sit at an edge', () {
      final w = PagedPaginationBar.windowFor(25, 50);
      expect(w, contains(0));
      expect(w.first, isNot(0));
      expect(w.last, isNot(0));
      // A gap must stand for at least one hidden page, never for nothing.
      for (var i = 1; i < w.length - 1; i++) {
        if (w[i] == 0) {
          expect(w[i + 1] - w[i - 1], greaterThan(1));
        }
      }
    });

    test('no duplicates and strictly ascending outside gaps', () {
      for (final page in [1, 3, 25, 48, 50]) {
        final w = PagedPaginationBar.windowFor(page, 50);
        final nums = w.where((n) => n != 0).toList();
        expect(nums.toSet().length, nums.length, reason: 'page=$page');
        for (var i = 1; i < nums.length; i++) {
          expect(nums[i], greaterThan(nums[i - 1]), reason: 'page=$page');
        }
      }
    });

    test('a page outside the range does not produce junk', () {
      // Defensive: a stale page index after a filter change must not render
      // negative or out-of-range numbers.
      final w = PagedPaginationBar.windowFor(99, 10);
      expect(w.where((n) => n != 0), everyElement(inInclusiveRange(1, 10)));
      expect(PagedPaginationBar.windowFor(1, 0), isEmpty);
      expect(PagedPaginationBar.windowFor(0, 0), isEmpty);
    });
  });
}
