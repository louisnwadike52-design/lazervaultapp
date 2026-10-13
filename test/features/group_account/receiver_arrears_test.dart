import 'package:flutter_test/flutter_test.dart';

/// "Behind 1 cycle" on a contribution created minutes ago.
///
/// Reported three times, most recently against the Set Payout Receiver sheet,
/// where the circle's own CREATOR was marked behind and therefore could not be
/// picked as the first receiver of a rotation nobody had paid into yet.
///
/// The sheet computed arrears as
///
///   owed = missedCycles; if (!hasPaidCurrentCycle) owed++;
///
/// `hasPaidCurrentCycle` is false for somebody with nothing to pay yet, so a
/// brand-new member always read as one cycle behind. This mirrors the fixed
/// rule (and the server's arrearsOwed) so the two cannot drift apart again.
int owedCycles({
  required bool awaitingOpen,
  required int missedCycles,
  required bool hasPaidCurrentCycle,
  required DateTime? nextPaymentDate,
  required DateTime now,
}) {
  if (awaitingOpen) return 0;
  if (hasPaidCurrentCycle) return missedCycles;
  if (nextPaymentDate == null || now.isBefore(nextPaymentDate)) {
    return missedCycles;
  }
  return missedCycles + 1;
}

void main() {
  final now = DateTime(2026, 10, 13, 10, 30);

  group('a member is only behind when a cycle has actually passed them', () {
    test('an esusu that has not started owes nothing', () {
      expect(
        owedCycles(
          awaitingOpen: true,
          missedCycles: 0,
          hasPaidCurrentCycle: false,
          nextPaymentDate: null,
          now: now,
        ),
        0,
        reason: 'no cycle exists, so nobody can be behind on one',
      );
    });

    test('the creator of a just-created circle is not behind', () {
      expect(
        owedCycles(
          awaitingOpen: true,
          missedCycles: 0,
          hasPaidCurrentCycle: false,
          nextPaymentDate: now.add(const Duration(days: 30)),
          now: now,
        ),
        0,
      );
    });

    test('inside a started cycle, unpaid but not yet due is not behind', () {
      expect(
        owedCycles(
          awaitingOpen: false,
          missedCycles: 0,
          hasPaidCurrentCycle: false,
          nextPaymentDate: now.add(const Duration(days: 5)),
          now: now,
        ),
        0,
        reason: 'they are early, not late',
      );
    });

    test('once the due date passes, the unpaid cycle counts', () {
      expect(
        owedCycles(
          awaitingOpen: false,
          missedCycles: 0,
          hasPaidCurrentCycle: false,
          nextPaymentDate: now.subtract(const Duration(days: 1)),
          now: now,
        ),
        1,
      );
    });

    test('historical misses always count, due date or not', () {
      expect(
        owedCycles(
          awaitingOpen: false,
          missedCycles: 2,
          hasPaidCurrentCycle: true,
          nextPaymentDate: now.add(const Duration(days: 5)),
          now: now,
        ),
        2,
      );
    });

    test('misses plus an overdue current cycle add up', () {
      expect(
        owedCycles(
          awaitingOpen: false,
          missedCycles: 2,
          hasPaidCurrentCycle: false,
          nextPaymentDate: now.subtract(const Duration(hours: 1)),
          now: now,
        ),
        3,
      );
    });

    test('paying the current cycle never increases what is owed', () {
      for (final due in [
        now.subtract(const Duration(days: 10)),
        now.add(const Duration(days: 10)),
        null,
      ]) {
        expect(
          owedCycles(
            awaitingOpen: false,
            missedCycles: 1,
            hasPaidCurrentCycle: true,
            nextPaymentDate: due,
            now: now,
          ),
          1,
          reason: 'due=$due',
        );
      }
    });

    test('a missing due date does not invent arrears', () {
      expect(
        owedCycles(
          awaitingOpen: false,
          missedCycles: 0,
          hasPaidCurrentCycle: false,
          nextPaymentDate: null,
          now: now,
        ),
        0,
      );
    });
  });
}
