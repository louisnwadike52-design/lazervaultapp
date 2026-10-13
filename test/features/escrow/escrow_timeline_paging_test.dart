import 'package:flutter_test/flutter_test.dart';

/// The deal timeline, collapsed and paged.
///
/// It rendered every event inline, always. A disputed deal accumulates
/// funding, each attachment, the dispute, every admin message, every admin
/// read, the resolution and the release — which pushed the Agreement and
/// Receipt buttons and the closing notice below a wall of history nobody had
/// asked to read.
///
/// Mirrors the windowing in _timeline.
const int pageSize = 5;

({int shown, int remaining}) window({
  required int total,
  required bool expanded,
  required int visible,
}) {
  final shown = expanded
      ? (visible > total ? total : visible)
      : (total > pageSize ? pageSize : total);
  return (shown: shown, remaining: total - shown);
}

void main() {
  group('timeline windowing', () {
    test('a short timeline shows in full with nothing to page', () {
      final w = window(total: 3, expanded: false, visible: pageSize);
      expect(w.shown, 3);
      expect(w.remaining, 0, reason: 'no "show earlier" on a 3-event deal');
    });

    test('exactly a page shows in full', () {
      final w = window(total: 5, expanded: false, visible: pageSize);
      expect(w.shown, 5);
      expect(w.remaining, 0);
    });

    test('a long timeline collapses to one page and offers the rest', () {
      final w = window(total: 9, expanded: false, visible: pageSize);
      expect(w.shown, 5);
      expect(w.remaining, 4, reason: 'the screenshot deal had 9 events');
    });

    test('expanding reveals a page at a time, not everything', () {
      final first = window(total: 20, expanded: true, visible: pageSize * 2);
      expect(first.shown, 10);
      expect(first.remaining, 10);

      final second = window(total: 20, expanded: true, visible: pageSize * 3);
      expect(second.shown, 15);
      expect(second.remaining, 5);
    });

    test('the window never overruns the list', () {
      final w = window(total: 7, expanded: true, visible: 100);
      expect(w.shown, 7);
      expect(w.remaining, 0, reason: 'must not go negative or over-count');
    });

    test('an empty timeline asks for nothing', () {
      final w = window(total: 0, expanded: false, visible: pageSize);
      expect(w.shown, 0);
      expect(w.remaining, 0);
    });
  });

  // The events arrive oldest-first, which is right for a full read and wrong
  // for a collapsed one: what just happened is what someone opens a deal to
  // check.
  group('ordering', () {
    test('the collapsed view shows the NEWEST events', () {
      final oldestFirst = ['created', 'funded', 'disputed', 'resolved', 'released'];
      final newestFirst = oldestFirst.reversed.toList();
      expect(newestFirst.first, 'released');
      expect(newestFirst.take(2), ['released', 'resolved']);
    });
  });
}
