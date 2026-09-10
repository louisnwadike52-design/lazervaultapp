import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

// What the withdrawal screen quotes is a PROMISE — "You will receive ₦X" over
// a confirm button. It must mirror what accounts-service actually pays
// (accounts_lockfunds_cancel.go step 9), which the preview used to ignore:
// it added the accrued interest onto an early break that forfeits it.

LockFund lock({
  double amount = 100000,
  double penaltyPercent = 10,
  double accrued = 2500,
}) =>
    LockFund(
      id: 'lf-1',
      userId: 'u-1',
      lockType: LockType.savings,
      amount: amount,
      currency: 'NGN',
      lockDurationDays: 30,
      interestRate: 10,
      lockedAt: DateTime(2026, 9, 1),
      unlockAt: DateTime(2026, 10, 1),
      status: LockStatus.active,
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 9, 1),
      earlyUnlockPenaltyPercent: penaltyPercent,
      accruedInterest: accrued,
      totalValue: amount + accrued,
    );

void main() {
  group('early break', () {
    test('forfeits the interest entirely', () {
      expect(lock().interestPayableOnUnlock(early: true), 0);
    });

    test('pays principal MINUS penalty, with no interest added', () {
      // ₦100,000 at 10% penalty → ₦90,000. NOT ₦92,500: the ₦2,500 accrued is
      // forfeited, and quoting it over-promised by the interest AND the
      // penalty.
      expect(lock().proceedsOnUnlock(early: true), 90000);
    });

    test('a zero-penalty plan still pays its interest', () {
      // The backend zeroes interest only when a penalty actually applied, so a
      // 0% plan broken early is not punished twice.
      final l = lock(penaltyPercent: 0);
      expect(l.interestPayableOnUnlock(early: true), 2500);
      expect(l.proceedsOnUnlock(early: true), 102500);
    });

    test('earlyWithdrawalAmount agrees with proceedsOnUnlock', () {
      // The legacy getter had its own formula that added forfeited interest.
      expect(lock().earlyWithdrawalAmount, lock().proceedsOnUnlock(early: true));
    });
  });

  group('holding to maturity', () {
    test('pays principal plus the full accrued interest', () {
      expect(lock().proceedsOnUnlock(early: false), 102500);
      expect(lock().interestPayableOnUnlock(early: false), 2500);
    });

    test('no penalty is deducted', () {
      // A matured unlock is not an early break, so the penalty rate is
      // irrelevant however high it is.
      expect(lock(penaltyPercent: 50).proceedsOnUnlock(early: false), 102500);
    });

    test('an upfront-interest plan pays principal only', () {
      // The gateway reports accruedInterest = 0 for plans that paid the whole
      // term at creation (Year Lock, Treasury Lock), because unlock forces the
      // interest to zero. The proceeds must follow that, not re-add anything.
      expect(lock(accrued: 0).proceedsOnUnlock(early: false), 100000);
    });
  });

  test('penalty matches the backend formula', () {
    // accounts_lockfunds_cancel.go: amount * penalty_rate / 100
    expect(lock(amount: 250000, penaltyPercent: 4).earlyWithdrawalPenalty,
        10000);
  });
}
