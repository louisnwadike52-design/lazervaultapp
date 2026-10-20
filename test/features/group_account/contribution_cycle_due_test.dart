import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_cycle_due.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

// THE SCREEN SHOWED THE CIRCLE'S END DATE AND CALLED IT THE DUE DATE.
//
// A rotation carries two dates. `deadline` is when the whole circle ends and
// does not move as cycles run. `next_payment_date` is when the ACTIVE cycle
// closes, and the server re-anchors it forward every time a cycle opens that
// would otherwise start already overdue.
//
// Measured on prod 2026-10-20: 9 live rotations, all 9 with a
// next_payment_date, and 2 of them on a different day from their deadline. On
// those two the summary card, the listing card and the "Days Remaining"
// statistic were all naming a date the member was not actually paying to,
// while the red overdue styling right beside them was measured off
// `isOverdue`, which already read next_payment_date.

Contribution _contribution({
  required ContributionType type,
  required DateTime deadline,
  DateTime? nextPaymentDate,
}) {
  return Contribution(
    id: 'c1',
    groupId: 'g1',
    title: 'Test circle',
    description: '',
    targetAmount: 1000,
    currentAmount: 0,
    currency: 'NGN',
    deadline: deadline,
    createdBy: 'u1',
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
    status: ContributionStatus.active,
    payments: const [],
    type: type,
    nextPaymentDate: nextPaymentDate,
  );
}

void main() {
  group('activeCycleDue', () {
    test('a rotation uses the active cycle close, not the circle end', () {
      final c = _contribution(
        type: ContributionType.rotatingSavings,
        deadline: DateTime(2026, 12, 31),
        nextPaymentDate: DateTime(2026, 3, 15),
      );
      expect(c.activeCycleDue, DateTime(2026, 3, 15),
          reason: 'the member pays into the cycle, not into the circle end');
      expect(c.cycleDueIsCircleEnd, isFalse);
    });

    test('an extended cycle is reflected without any other change', () {
      // This is the reported case: the cycle started late because someone had
      // not paid, so the server re-anchored the close. Only
      // next_payment_date moves — the deadline is untouched.
      final before = _contribution(
        type: ContributionType.rotatingSavings,
        deadline: DateTime(2026, 12, 31),
        nextPaymentDate: DateTime(2026, 3, 15),
      );
      final after = before.copyWith(nextPaymentDate: DateTime(2026, 4, 15));
      expect(before.activeCycleDue, DateTime(2026, 3, 15));
      expect(after.activeCycleDue, DateTime(2026, 4, 15));
      expect(after.deadline, before.deadline);
    });

    test('a one-time collection has no cycles, so its deadline IS the date',
        () {
      final c = _contribution(
        type: ContributionType.oneTime,
        deadline: DateTime(2026, 6, 1),
      );
      expect(c.activeCycleDue, DateTime(2026, 6, 1));
      expect(c.cycleDueIsCircleEnd, isTrue,
          reason: 'nothing to de-duplicate when both dates are the same fact');
    });

    test('a rotation the wire gave no cycle close still renders a date', () {
      // Falling back rather than returning null: the card has to print
      // something, and the circle end is the only honest value left.
      final c = _contribution(
        type: ContributionType.rotatingSavings,
        deadline: DateTime(2026, 9, 9),
      );
      expect(c.activeCycleDue, DateTime(2026, 9, 9));
      expect(c.cycleDueIsCircleEnd, isTrue);
    });

    test('same day at different times is not a duplicate to flag twice', () {
      // The circle end is stored at end of day, a cycle close at midnight.
      // Comparing instants would call these different dates and print the
      // same day under two labels.
      final c = _contribution(
        type: ContributionType.rotatingSavings,
        deadline: DateTime(2026, 5, 20, 23, 59),
        nextPaymentDate: DateTime(2026, 5, 20, 0, 0),
      );
      expect(c.cycleDueIsCircleEnd, isTrue);
    });
  });
}
