import 'package:flutter_test/flutter_test.dart';

/// The move a drag performs, isolated from Flutter.
///
/// Flutter's ReorderableList reports `newIndex` as the slot BEFORE the item
/// is removed, so a downward move is one too high. Forgetting the decrement
/// is the classic off-by-one of this API and it leaves the card one place
/// from where the user let go — which reads as the app ignoring the drop.
List<T> applyReorder<T>(List<T> items, int oldIndex, int newIndex) {
  if (newIndex > oldIndex) newIndex -= 1;
  if (oldIndex == newIndex) return List<T>.from(items);
  final out = List<T>.from(items);
  out.insert(newIndex, out.removeAt(oldIndex));
  return out;
}

void main() {
  const start = ['a', 'b', 'c', 'd', 'e'];

  group('reorder maths', () {
    test('moving down lands where the user dropped it', () {
      // Drag 'a' (0) to sit after 'c'. Flutter reports newIndex 3.
      expect(applyReorder(start, 0, 3), ['b', 'c', 'a', 'd', 'e']);
    });

    test('moving up needs no adjustment', () {
      // Drag 'd' (3) to the top. Flutter reports newIndex 0.
      expect(applyReorder(start, 3, 0), ['d', 'a', 'b', 'c', 'e']);
    });

    test('dropping an item back where it started changes nothing', () {
      expect(applyReorder(start, 2, 2), start);
      // newIndex 3 for oldIndex 2 is also a no-op after the decrement.
      expect(applyReorder(start, 2, 3), start);
    });

    test('moving the first item to the end', () {
      expect(applyReorder(start, 0, 5), ['b', 'c', 'd', 'e', 'a']);
    });

    test('moving the last item to the front', () {
      expect(applyReorder(start, 4, 0), ['e', 'a', 'b', 'c', 'd']);
    });

    test('the set is never changed, only its order', () {
      for (var from = 0; from < start.length; from++) {
        for (var to = 0; to <= start.length; to++) {
          final out = applyReorder(start, from, to);
          expect(out.length, start.length, reason: '$from -> $to');
          expect(out.toSet(), start.toSet(), reason: '$from -> $to');
        }
      }
    });

    test('a one-item list cannot be reordered into nonsense', () {
      expect(applyReorder(['only'], 0, 0), ['only']);
      expect(applyReorder(['only'], 0, 1), ['only']);
    });
  });

  group('page offsets', () {
    /// What the reorder write sends as start_index. Page 3 of a 5-per-page
    /// list must number its rows 10,11,… — numbering them 0..4 would
    /// teleport them to the front of the whole list.
    int startIndexFor(int page, int pageSize) => (page - 1) * pageSize;

    test('page 1 starts at zero', () {
      expect(startIndexFor(1, 5), 0);
    });

    test('later pages carry their offset', () {
      expect(startIndexFor(2, 5), 5);
      expect(startIndexFor(3, 5), 10);
      expect(startIndexFor(7, 5), 30);
    });

    test('the offset follows the page size', () {
      expect(startIndexFor(3, 20), 40);
      expect(startIndexFor(3, 1), 2);
    });
  });
}
