import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/presentation/widgets/list_pager.dart';

/// The window decides which page buttons exist. An off-by-one here puts the
/// user on the wrong page, which is worse than it merely looking wrong — so
/// the shape is asserted rather than eyeballed. 0 stands for an ellipsis.
void main() {
  group('ListPager.windowFor', () {
    test('no pages draws nothing', () {
      expect(ListPager.windowFor(1, 0), isEmpty);
      expect(ListPager.windowFor(1, -3), isEmpty);
    });

    test('a short list shows every page, with no ellipsis', () {
      expect(ListPager.windowFor(1, 1), [1]);
      expect(ListPager.windowFor(2, 3), [1, 2, 3]);
      expect(ListPager.windowFor(5, 5), [1, 2, 3, 4, 5]);
      expect(ListPager.windowFor(3, 5), isNot(contains(0)));
    });

    test('the first and last page are ALWAYS reachable', () {
      // "Jump to the end" has to be one tap from anywhere, which is the
      // thing a plain next/prev pager cannot do.
      for (final current in [1, 5, 10, 20]) {
        final w = ListPager.windowFor(current, 20);
        expect(w.first, 1, reason: 'page 1 missing from $w');
        expect(w.last, 20, reason: 'last page missing from $w');
      }
    });

    test('the current page is always in the window', () {
      for (var current = 1; current <= 20; current++) {
        expect(ListPager.windowFor(current, 20), contains(current),
            reason: 'current page $current was not drawn');
      }
    });

    test('never draws more buttons than it was allowed', () {
      for (var current = 1; current <= 50; current++) {
        final w = ListPager.windowFor(current, 50);
        final numbered = w.where((p) => p != 0).length;
        expect(numbered, lessThanOrEqualTo(5),
            reason: 'page $current produced $numbered buttons: $w');
      }
    });

    test('ellipsis appears only where pages are actually skipped', () {
      final early = ListPager.windowFor(1, 20);
      // Nothing is skipped between 1 and 2, so no leading ellipsis.
      expect(early[1], isNot(0), reason: '$early');
      expect(early, contains(0), reason: 'a trailing gap should be marked');

      final late = ListPager.windowFor(20, 20);
      expect(late, contains(0));
      expect(late[late.length - 2], isNot(0), reason: '$late');

      final middle = ListPager.windowFor(10, 20);
      // Gaps on both sides.
      expect(middle.where((p) => p == 0).length, 2, reason: '$middle');
    });

    test('pages are in ascending order with no duplicates', () {
      for (var current = 1; current <= 20; current++) {
        final numbered =
            ListPager.windowFor(current, 20).where((p) => p != 0).toList();
        expect(numbered.toSet().length, numbered.length,
            reason: 'duplicate page button at $current: $numbered');
        final sorted = [...numbered]..sort();
        expect(numbered, sorted, reason: 'out of order at $current');
      }
    });

    test('a current page outside the range still produces a usable window', () {
      // Defensive: a stale page number after rows were deleted must not
      // produce an empty pager the user cannot escape.
      final w = ListPager.windowFor(99, 10);
      expect(w, isNotEmpty);
      expect(w.first, 1);
      expect(w.last, 10);
    });
  });
}
