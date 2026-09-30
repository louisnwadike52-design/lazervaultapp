import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

/// Family & Friends under per-member allocation: the PIN sheet has to say what
/// the member's own ceiling is BEFORE the PIN is typed.
///
/// Under `equal_split` / `custom_allocation` a member spends their allocation,
/// not the family pool, and the backend refuses anything above it. Without this
/// line the member typed a PIN and got a rejection, which reads as a fault
/// rather than as a rule.
///
/// The line must NOT appear on shared_pool or on a non-family account, where no
/// member has an allocation and the pool balance is already the honest figure —
/// a spurious "allocation" line there invents a limit that does not exist.

Future<String> _labelFor(
  WidgetTester tester, {
  required double amount,
  required double? allowance,
  double? fee,
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: TransactionPinModal(
              amount: amount,
              fee: fee,
              currency: 'NGN',
              currencySymbol: '₦',
              memberAllocationRemaining: allowance,
              onPinSubmitted: (_) {},
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  final finder = find.byKey(const Key('pin_member_allocation'));
  if (finder.evaluate().isEmpty) return '';
  return tester.widget<Text>(finder).data ?? '';
}

void main() {
  group('the PIN sheet allocation line', () {
    testWidgets('is absent when the account has no member allocation',
        (tester) async {
      // Every non-family flow, and shared_pool. Rendering nothing is the point.
      expect(await _labelFor(tester, amount: 500, allowance: null), '');
    });

    testWidgets('shows what is left when the amount is within allocation',
        (tester) async {
      final label = await _labelFor(tester, amount: 500, allowance: 2000);
      expect(label, contains('Your allocation'));
      expect(label, contains('₦2000.00'));
      expect(label, isNot(contains('Over')));
    });

    testWidgets('says so when the amount uses the allocation EXACTLY',
        (tester) async {
      // Spending your whole allocation is legal. Flagging it as "over" would
      // tell a member their own money is a breach.
      final label = await _labelFor(tester, amount: 2000, allowance: 2000);
      expect(label, contains('full allocation'));
      expect(label, isNot(contains('Over')));
    });

    testWidgets('an exact match survives float arithmetic', (tester) async {
      // 117.27 + 10.75 is 128.01999999999998 in doubles, not 128.02. Compared
      // as doubles this member is told they are OVER an allocation their
      // payment exactly fits — and the only reason is binary rounding.
      final label = await _labelFor(
        tester,
        amount: 117.27,
        fee: 10.75,
        allowance: 128.02,
      );
      expect(label, contains('full allocation'), reason: 'fee-inclusive total');
      expect(label, isNot(contains('Over')));
    });

    testWidgets('warns when the amount exceeds the allocation',
        (tester) async {
      final label = await _labelFor(tester, amount: 5000, allowance: 2000);
      expect(label, contains('Over your allocation'));
      expect(label, contains('₦2000.00'));
    });

    testWidgets('counts the FEE against the allocation', (tester) async {
      // The backend debits principal + fee, so a fee is what tips a payment
      // over. A line that ignored it would say "within" on a debit that the
      // server then refuses.
      final label = await _labelFor(
        tester,
        amount: 2000,
        fee: 25,
        allowance: 2000,
      );
      expect(label, contains('Over your allocation'));
    });

    testWidgets('does not lock PIN entry when over', (tester) async {
      // The server is the authority on spendability: the allocation figure here
      // is a snapshot and may be stale (another device just topped the member
      // up, or an allocation was raised). Warn, never block — a disabled sheet
      // would strand a payment the backend would have accepted.
      await _labelFor(tester, amount: 5000, allowance: 2000);
      final boxes = find.byType(TextField);
      expect(boxes, findsWidgets);
      for (final f in boxes.evaluate()) {
        expect((f.widget as TextField).enabled ?? true, isTrue);
      }
    });
  });

  group('AccountSummaryEntity.memberSpendAllowance', () {
    AccountSummaryEntity build({
      required bool isFamily,
      String? mode,
      double? remaining,
      double? allocated,
    }) =>
        AccountSummaryEntity(
          id: 'a1',
          accountType: 'family',
          currency: 'NGN',
          balance: 10000,
          availableBalance: 10000,
          accountNumberLast4: '1234',
          trendPercentage: 0,
          isFamilyAccount: isFamily,
          fundDistributionMode: mode,
          memberRemainingBalance: remaining,
          memberAllocatedBalance: allocated,
        );

    test('null on a non-family account even if a mode leaked through', () {
      expect(
        build(isFamily: false, mode: 'custom_allocation', remaining: 500)
            .memberSpendAllowance,
        isNull,
      );
    });

    test('null on shared_pool — every member spends the whole pool', () {
      expect(
        build(isFamily: true, mode: 'shared_pool', remaining: 500)
            .memberSpendAllowance,
        isNull,
      );
    });

    test('null when the mode is unknown, rather than guessing a cap', () {
      expect(build(isFamily: true, remaining: 500).memberSpendAllowance, isNull);
      expect(
        build(isFamily: true, mode: '', remaining: 500).memberSpendAllowance,
        isNull,
      );
    });

    test('the remaining figure wins under equal_split', () {
      expect(
        build(
          isFamily: true,
          mode: 'equal_split',
          remaining: 300,
          allocated: 500,
        ).memberSpendAllowance,
        300,
      );
    });

    test('falls back to allocated when nothing has been spent yet', () {
      // An allocation with no spend recorded against it is entirely available,
      // so the allocated amount IS the remainder. Returning null here would
      // hide the cap on a freshly allocated member.
      expect(
        build(isFamily: true, mode: 'custom_allocation', allocated: 500)
            .memberSpendAllowance,
        500,
      );
    });

    test('zero remaining is a real cap, not a missing value', () {
      // The trap: `remaining ?? allocated` on a 0.0 remainder must keep 0, or a
      // member who has spent everything is shown their original allocation.
      expect(
        build(
          isFamily: true,
          mode: 'equal_split',
          remaining: 0,
          allocated: 500,
        ).memberSpendAllowance,
        0,
      );
    });
  });
}
