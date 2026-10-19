import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// TWO BILLS CALLED "DINNER", AND NO WAY TO TELL THEM APART.
///
/// Reported with a screenshot: two created bills, same title, same NGN 500,
/// same "Created by you" line. One had a co-payer paying, one did not, and
/// nothing on the row said which was which.
///
/// A uniqueness rule would be the wrong fix — "Dinner" is a thing people
/// split every week, and refusing a repeat would block something perfectly
/// reasonable. Two changes instead: make the rows distinguishable, and make
/// an ACCIDENTAL duplicate something you have to confirm.
void main() {
  final card = File(
    'lib/src/features/split_bills/presentation/widgets/split_bill_card.dart',
  ).readAsStringSync();

  group('telling two same-titled bills apart', () {
    test('the row carries the date it was created', () {
      expect(card, contains('_shortDate(bill.createdAt)'));
      expect(card, contains("'Created by you · "));
    });

    test('today and yesterday read as words', () {
      expect(card, contains("return 'Today'"));
      expect(card, contains("return 'Yesterday'"));
    });

    test('a bill from another year says so', () {
      expect(card, contains('when.year == now.year'));
    });
  });

  group('the receiver line is legible on a near-black card', () {
    test('it uses the lighter accent, not the brand indigo', () {
      expect(card, isNot(contains('color: Color(0xFF4834D4)')),
          reason: '#4834D4 all but disappears on #1F1F1F');
      expect(card, contains('Color(0xFF8B5CF6)'));
    });
  });

  group('creating a second bill with the same name', () {
    final create = File(
      'lib/src/features/split_bills/presentation/view/'
      'create_split_bill_screen.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('is allowed, but confirmed', () {
      expect(create, contains('_confirmDuplicateTitle('));
      expect(create, contains('Create anyway'),
          reason: 'it must remain possible — people really do split Dinner twice');
      expect(create, contains('Go back'));
    });

    test('only OPEN bills count as a clash', () {
      // A settled bill from last week is history, not a conflict.
      expect(create, contains('b.isActive &&'));
    });

    test('the check runs before the bill is created', () {
      final check = create.indexOf('_confirmDuplicateTitle(');
      final call = create.indexOf('createSplitBill(', check);
      expect(check, greaterThan(0));
      expect(call, greaterThan(check));
    });
  });
}
