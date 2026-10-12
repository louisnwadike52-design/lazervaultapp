import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/shared_widgets/staggered_entrance.dart';

/// The saved-recipients list reads in one by one once the page has finished
/// rising. The delay has to be measured from the PAGE, not from each item's
/// own mount: a slow fetch would otherwise hold the list a further 780ms
/// after the sheet had already settled, which is a dead gap at exactly the
/// moment the data arrived.
void main() {
  const start = Duration(milliseconds: 780);
  const gap = Duration(milliseconds: 90);

  group('StaggeredEntrance.delayFor', () {
    test('items are spaced one after another', () {
      expect(StaggeredEntrance.delayFor(0), start);
      expect(StaggeredEntrance.delayFor(1), start + gap);
      expect(StaggeredEntrance.delayFor(3), start + gap * 3);
    });

    test('the tail is capped so a long list has no late arrival', () {
      final capped = StaggeredEntrance.delayFor(50);
      expect(capped, StaggeredEntrance.delayFor(8));
      expect(capped, start + gap * 8);
    });

    test('a negative index is treated as the first item', () {
      expect(StaggeredEntrance.delayFor(-3), start);
    });

    test('time already spent on the page comes off the start delay', () {
      // Item mounts 300ms after the screen: only 480ms of the hold is left.
      final d = StaggeredEntrance.delayFor(
        0,
        elapsed: const Duration(milliseconds: 300),
      );
      expect(d, const Duration(milliseconds: 480));
    });

    test('a late list starts immediately but STILL reads in one by one', () {
      // The page settled long ago, so there is nothing left to wait for —
      // but the items must not all land at once.
      const late = Duration(seconds: 5);
      expect(
        StaggeredEntrance.delayFor(0, elapsed: late),
        Duration.zero,
      );
      expect(
        StaggeredEntrance.delayFor(1, elapsed: late),
        gap,
        reason: 'the per-item gap survives, only the start is dropped',
      );
      expect(StaggeredEntrance.delayFor(4, elapsed: late), gap * 4);
    });

    test('elapsed never produces a negative delay', () {
      for (final e in [
        const Duration(milliseconds: 781),
        const Duration(seconds: 30),
      ]) {
        expect(
          StaggeredEntrance.delayFor(0, elapsed: e) >= Duration.zero,
          isTrue,
        );
      }
    });

    test('no anchor keeps the original behaviour', () {
      expect(
        StaggeredEntrance.delayFor(2),
        StaggeredEntrance.delayFor(2, elapsed: Duration.zero),
      );
    });
  });
}
