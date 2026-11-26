import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// THE QUICK AMOUNTS ARE ONE ROW, SPREAD ACROSS IT.
///
/// They were a Wrap, which lays children out from the start of a line and
/// centres the LINE — so four pills narrower than the sheet sat as one short
/// block with the slack split either side, reading as tilted to the left
/// against the full-width field above and the full-width button below.
///
/// A Row with spaceBetween puts the slack BETWEEN them instead, so the first
/// and last align with the edges of everything else on the sheet. The cost of
/// a Row is that it cannot wrap — so each child has to be Flexible, or a
/// narrow phone gets a yellow overflow stripe instead of a layout.
void main() {
  final src = File('lib/src/features/funds/presentation/widgets/'
          'send_funds/send_funds_amount_sheet.dart')
      .readAsStringSync();

  /// The pill row and nothing else.
  String pillRow() {
    final start = src.indexOf('children: _quickAmounts.map((a) {');
    expect(start, greaterThan(0), reason: 'the pill builder moved');
    // Walk back to the widget that owns it.
    final rowAt = src.lastIndexOf('Row(', start);
    final wrapAt = src.lastIndexOf('Wrap(', start);
    expect(rowAt, greaterThan(wrapAt),
        reason: 'the pills are laid out by a Wrap again — it centres the '
            'line rather than spreading the pills across it');
    // To the end of the pill builder — `}).toList(),` — rather than a fixed
    // character window, which stopped short of the Text widget and made the
    // ellipsis assertion fail on code that was correct.
    final end = src.indexOf('}).toList(),', start);
    expect(end, greaterThan(start), reason: 'the pill builder is unterminated');
    return src.substring(rowAt, end);
  }

  test('the pills are spread, not bunched', () {
    expect(pillRow().contains('MainAxisAlignment.spaceBetween'), isTrue,
        reason: 'without spaceBetween the slack goes to the outside and the '
            'pills read as left-tilted');
  });

  test('each pill can shrink, so the row cannot overflow', () {
    // A Row does not wrap. Four or five fixed-width pills that do not fit
    // produce an overflow stripe, which is why the Wrap was chosen first.
    expect(pillRow().contains('Flexible('), isTrue,
        reason: 'a non-Flexible child in a Row overflows on a narrow phone');
    expect(pillRow().contains('TextOverflow.ellipsis'), isTrue,
        reason: 'a shrunk pill must ellipsise rather than overflow its box');
  });

  test('a small amount is offered', () {
    // The commonest real transfer is not a round thousand, and starting at
    // ₦1,000 made the shortcuts useless for airtime money or a share of a
    // bill.
    final m = RegExp(r'_quickAmounts = \[([^\]]+)\]').firstMatch(src);
    expect(m, isNotNull);
    final amounts = m!
        .group(1)!
        .split(',')
        .map((s) => int.parse(s.trim()))
        .toList();
    expect(amounts.any((a) => a < 1000), isTrue,
        reason: 'every shortcut was ≥ ₦1,000');
    expect(amounts.first, lessThan(amounts.last),
        reason: 'ascending, so the row reads left to right');
  });

  test('there are never more than five', () {
    // They share ONE row. A sixth shrinks the others until "₦10,000"
    // ellipsises into "₦10,0…", which is worse than not offering it.
    final m = RegExp(r'_quickAmounts = \[([^\]]+)\]').firstMatch(src);
    final count = m!.group(1)!.split(',').length;
    expect(count, lessThanOrEqualTo(5),
        reason: '$count pills cannot share one row legibly — add one only by '
            'removing one');
  });
}
