import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_receipt_total.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// A RECEIPT TOLD A MEMBER THEIR PAYMENT RAISED NOTHING.
///
/// Measured on prod 2026-10-19: a member paid NGN 200 into a NGN 400 esusu
/// cycle and the receipt for that very payment read
///
///   Target NGN 400.00 · New total NGN 0.00 · Remaining NGN 400.00 · Progress 0%
///
/// Two independent faults produced it, and the shared PDF had a third:
///
///  1. the figure came from `currentAmount`, the LIVE POT, which a rotating
///     payout sweeps to that cycle's receiver — leaving 0;
///  2. the contribution object reaching the receipt predates the debit (both
///     live payment paths forward the `widget.contribution` they were opened
///     with), so this payment was missing from it either way; and
///  3. the PDF added `payment.amount` while the screen did not, so the receipt
///     on screen and the PDF generated FROM it printed different totals.
///
/// The arithmetic is a plain function precisely so the part that tells someone
/// the wrong figure about their own money is testable without a widget.

Contribution cycle({
  required double target,
  required double pot,
  double raisedThisCycle = 0,
}) =>
    Contribution(
      id: 'c1',
      groupId: 'g1',
      title: 'Ikeja circle',
      description: '',
      targetAmount: target,
      currentAmount: pot,
      raisedThisCycle: raisedThisCycle,
      currency: 'NGN',
      deadline: DateTime(2026, 11, 1),
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 19),
      status: ContributionStatus.active,
      createdBy: 'u1',
      payments: const [],
      type: ContributionType.rotatingSavings,
      currentCycle: 2,
      totalCycles: 4,
    );

void main() {
  group('the prod incident', () {
    test('a payment into a swept cycle is not reported as nothing raised', () {
      // THE EXACT CASE. The payout had swept the pot to cycle 1's receiver,
      // so currentAmount was 0 and the server had not yet counted this
      // payment into the cycle.
      final c = cycle(target: 400, pot: 0);
      final total = contributionReceiptTotal(
        contribution: c,
        paymentAmount: 200,
        cameFromPayment: true,
      );
      expect(total, 200, reason: 'the receipt must at least count ITS payment');
      expect(contributionReceiptRemaining(target: 400, total: total), 200);
      expect(contributionReceiptProgress(target: 400, total: total), 50);
    });

    test('the cycle figure is preferred over the pot once the server has it',
        () {
      // Two earlier members had paid 100 each this cycle; the pot is still
      // empty because the payout swept it.
      final c = cycle(target: 400, pot: 0, raisedThisCycle: 200);
      final total = contributionReceiptTotal(
        contribution: c,
        paymentAmount: 200,
        cameFromPayment: true,
      );
      expect(total, 400);
      expect(contributionReceiptProgress(target: 400, total: total), 100);
      expect(contributionReceiptRemaining(target: 400, total: total), 0);
    });
  });

  group('which contribution the receipt was handed', () {
    test('the live payment path adds this payment, because it is missing', () {
      final c = cycle(target: 1000, pot: 300, raisedThisCycle: 300);
      expect(
        contributionReceiptTotal(
            contribution: c, paymentAmount: 200, cameFromPayment: true),
        500,
      );
    });

    test('a historical receipt does NOT add it again', () {
      // "Generate receipt" on a past payment row passes the contribution
      // currently on screen, which already counts that payment. Adding would
      // overstate the pot on the person's own receipt.
      final c = cycle(target: 1000, pot: 500, raisedThisCycle: 500);
      expect(
        contributionReceiptTotal(
            contribution: c, paymentAmount: 200, cameFromPayment: false),
        500,
      );
    });
  });

  group('edges that used to print as a failed payment', () {
    test('overfunding leaves nothing remaining, never a negative', () {
      final c = cycle(target: 400, pot: 0, raisedThisCycle: 400);
      final total = contributionReceiptTotal(
          contribution: c, paymentAmount: 100, cameFromPayment: true);
      expect(total, 500);
      expect(contributionReceiptRemaining(target: 400, total: total), 0);
      expect(contributionReceiptProgress(target: 400, total: total), 100,
          reason: 'clamped: 125% on a receipt reads as a bug');
    });

    test('an open-ended pot has no percentage to state', () {
      // Target 0 is a real state (a collection with no goal). The old code
      // divided by it; before that it printed "Progress 0%", which reads as
      // a payment that did nothing.
      expect(contributionReceiptProgress(target: 0, total: 250), isNull);
      expect(contributionReceiptRemaining(target: 0, total: 250), 0);
    });
  });

  /// Code only. The incident is DESCRIBED in the comments of both files, so a
  /// raw search for the old expression matches the explanation of why it is
  /// gone.
  String codeOf(String path) => File(path)
      .readAsLinesSync()
      .where((l) => !l.trimLeft().startsWith('//') &&
          !l.trimLeft().startsWith('///'))
      .join('\n');

  group('the two receipts cannot drift apart again', () {
    // The screen and the PDF printed different totals for the same payment.
    // Both must read the shared helper, and the PDF must take the screen's
    // figure rather than deriving its own.
    test('neither surface computes a total from the live pot', () {
      for (final path in const [
        'lib/src/features/group_account/presentation/views/'
            'contribution_payment_confirmation_screen.dart',
        'lib/src/features/group_account/services/'
            'group_contribution_pdf_service.dart',
      ]) {
        final src = codeOf(path);
        expect(src, contains('contributionReceiptTotal('),
            reason: '$path must read the shared helper');
        expect(src, isNot(contains('currentAmount + payment.amount')),
            reason: '$path is deriving the total from the live pot again');
      }
    });

    test('the PDF is handed the total the screen displayed', () {
      final screen = codeOf(
        'lib/src/features/group_account/presentation/views/'
        'contribution_payment_confirmation_screen.dart',
      );
      expect(
        RegExp(r'cycleTotal: _cycleTotal').allMatches(screen).length,
        2,
        reason: 'both the download and the share path must pass it',
      );
    });
  });
}
