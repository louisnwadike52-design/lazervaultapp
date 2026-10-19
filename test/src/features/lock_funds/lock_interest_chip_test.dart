import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';
import 'package:lazervault/src/features/lock_funds/presentation/utils/lock_interest_chip.dart';

/// A FINISHED PIGGYVAULT PLAN SAID IT WAS STILL EARNING.
///
/// The chip's caption came from `hasPaidOutInterest` alone, so any plan that
/// had ever paid ROI out read "still accruing" — including one fully withdrawn
/// or cancelled, where nothing accrues. The amount was wrong in the same
/// breath: it showed `accruedInterest`, the UNPAID remainder, which on a
/// withdrawn plan is zero. So a user who had just banked real interest was
/// shown "+₦0 still accruing" about their own finished plan.
///
/// The rule under test: a RUNNING term reports what is still riding on the
/// plan; a stopped term reports LIFETIME interest, because that is final.

LockFund plan({
  required LockStatus status,
  double accrued = 0,
  double paidOut = 0,
}) {
  final t = DateTime(2026, 10, 1);
  return LockFund(
    id: 'p1',
    userId: 'u1',
    lockType: LockType.values.first,
    amount: 10000,
    currency: 'NGN',
    lockDurationDays: 90,
    interestRate: 12,
    lockedAt: t,
    unlockAt: t.add(const Duration(days: 90)),
    status: status,
    accruedInterest: accrued,
    interestPaidOut: paidOut,
    createdAt: t,
    updatedAt: t,
  );
}

void main() {
  group('a plan that has stopped earning never says it is accruing', () {
    test('withdrawn: reports LIFETIME interest, not the zero remainder', () {
      // The reported bug, exactly. All ROI paid out, plan unlocked.
      final c = LockInterestChip.of(
        plan(status: LockStatus.unlocked, accrued: 0, paidOut: 450),
      );
      expect(c.caption, isNot(contains('accruing')),
          reason: 'a withdrawn plan is not accruing anything');
      expect(c.caption, 'total interest earned');
      expect(c.amount, contains('450'),
          reason: 'lifetime interest is the only honest figure left — '
              'accruedInterest is 0 on a withdrawn plan, and showing it '
              'tells the user the plan earned them nothing');
    });

    test('cancelled: same', () {
      final c = LockInterestChip.of(
        plan(status: LockStatus.cancelled, accrued: 0, paidOut: 120),
      );
      expect(c.caption, 'total interest earned');
      expect(c.amount, contains('120'));
    });

    test('matured: the term is over, so it is a final figure too', () {
      // Matured is the subtle one — the money is still in the plan, so it
      // looks live, but accrual has stopped. isEarning is false for it.
      final c = LockInterestChip.of(
        plan(status: LockStatus.matured, accrued: 300, paidOut: 0),
      );
      expect(c.caption, 'total interest earned');
      expect(c.amount, contains('300'));
    });

    test('a withdrawn plan that never paid ROI out still reads correctly', () {
      final c = LockInterestChip.of(
        plan(status: LockStatus.unlocked, accrued: 0, paidOut: 0),
      );
      expect(c.caption, isNot(contains('accruing')));
    });
  });

  group('a running plan', () {
    test('with ROI already banked, the chip IS only the remainder', () {
      // The original, correct behaviour this must not lose: say "still
      // accruing" or the user reads the smaller number as the plan losing it.
      final c = LockInterestChip.of(
        plan(status: LockStatus.active, accrued: 80, paidOut: 450),
      );
      expect(c.caption, 'still accruing');
      expect(c.amount, contains('80'),
          reason: 'what is still riding on a live plan, not the lifetime total');
    });

    test('with nothing paid out, it is simply interest earned', () {
      final c = LockInterestChip.of(
        plan(status: LockStatus.active, accrued: 80),
      );
      expect(c.caption, 'interest earned');
      expect(c.amount, contains('80'));
    });
  });

  group('the dense stat label carries the same distinction', () {
    test('a finished plan is labelled a total, not "earned so far"', () {
      // The list card and the details Interest Summary both used the fixed
      // string 'Interest Earned' beside the UNPAID remainder, so a withdrawn
      // plan read "+N0 Interest Earned" to someone who had banked real ROI.
      final done = LockInterestChip.of(
        plan(status: LockStatus.unlocked, accrued: 0, paidOut: 450),
      );
      expect(done.statLabel, 'Total Interest');
      expect(done.amount, contains('450'));

      final live = LockInterestChip.of(
        plan(status: LockStatus.active, accrued: 80, paidOut: 450),
      );
      expect(live.statLabel, 'Interest Earned');
      expect(live.amount, contains('80'));
    });
  });

  test('a plan awaiting approval has not started earning', () {
    // It is neither running nor finished, and its deposit is reserved. Saying
    // "earned" of it invites the user to expect ROI that cannot exist yet.
    final c = LockInterestChip.of(plan(status: LockStatus.pendingApproval));
    expect(c.caption, 'not earning yet');
    expect(c.caption, isNot(contains('accruing')));
  });
}
