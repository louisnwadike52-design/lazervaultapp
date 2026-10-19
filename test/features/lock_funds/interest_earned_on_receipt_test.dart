import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

/// A WITHDRAWN LOCK'S RECEIPT SAID IT HAD EARNED NOTHING.
///
/// Reported with a screenshot: a Flex Savings plan at 10% p.a., unlocked —
/// and the receipt listed the RATE but no interest, while the shared PDF
/// printed "+0.00".
///
/// The plan's interest lives in two disjoint fields: `accruedInterest` is the
/// unpaid remainder still riding on the plan, `interestPaidOut` is what has
/// already reached the wallet. A plan that has paid its interest out has an
/// accrued figure of zero — so reading either one alone understates what the
/// plan made, and the PDF's projection is computed from what is still locked,
/// which for a withdrawn plan is nothing.
LockFund lock({double accrued = 0, double paidOut = 0}) => LockFund(
      id: 'l1',
      userId: 'u1',
      amount: 7200,
      currency: 'NGN',
      lockType: LockType.savings,
      status: LockStatus.unlocked,
      interestRate: 10,
      lockedAt: DateTime(2026, 9, 1),
      unlockAt: DateTime(2026, 10, 1),
      lockDurationDays: 30,
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 10, 19),
      accruedInterest: accrued,
      interestPaidOut: paidOut,
    );

void main() {
  group('what the plan actually earned', () {
    test('counts the paid-out half as well as the accruing half', () {
      expect(lock(accrued: 20, paidOut: 40).interestEarned, 60);
      expect(lock(accrued: 20, paidOut: 40).hasEarnedInterest, isTrue);
    });

    test('a plan that already paid everything out still shows its interest',
        () {
      // THE REPORTED CASE: accrued is zero because it was all paid out.
      final l = lock(paidOut: 59.18);
      expect(l.accruedInterest, 0);
      expect(l.interestEarned, 59.18);
      expect(l.hasEarnedInterest, isTrue,
          reason: 'this is the plan whose receipt read as having earned 0');
    });

    test('a brand-new lock has earned nothing, and says so', () {
      expect(lock().interestEarned, 0);
      expect(lock().hasEarnedInterest, isFalse);
    });
  });

  group('the receipt', () {
    final src = File(
      'lib/src/features/lock_funds/presentation/screens/'
      'lock_fund_receipt_screen.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('shows interest earned when there is any', () {
      expect(src, contains('lockFund.hasEarnedInterest'));
      expect(src, contains("'Interest Earned'"));
    });

    test('splits paid-out from accruing only when both exist', () {
      expect(src, contains('lockFund.interestPaidOut > 0 &&'));
      expect(src, contains('lockFund.accruedInterest > 0'));
    });
  });

  group('the shared PDF', () {
    final pdf = File(
      'lib/src/features/lock_funds/services/lock_funds_pdf_service.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('prints what was earned instead of a projection of zero', () {
      expect(pdf, contains("'Interest Earned'"));
      expect(pdf, contains('lockFund.interestEarned.toStringAsFixed(2)'));
    });

    test('the projection remains for a plan that has earned nothing yet', () {
      expect(pdf, contains("'Expected Interest'"),
          reason: 'a fresh lock has only a projection to show');
    });

    test('the total follows whichever figure is real', () {
      expect(pdf, contains("? 'Total Value'"));
      expect(pdf, contains("'Expected Total at Maturity'"));
    });
  });
}
