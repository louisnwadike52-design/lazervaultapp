import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/split_bills/presentation/utils/split_method_copy.dart';

/// Selecting "Percentage" on step 1 of Create Split Bill changed a chip and
/// nothing else. The per-person % fields are on step 2, inside each co-payer's
/// card, and nothing on screen said so — so the flow read as unfinished, with
/// no way to enter the thing the method is named after.
///
/// The co-payer toggle made it worse by continuing to show the EQUAL figure
/// ("My share: ₦800.00") under a percentage split where nothing had been
/// allocated. Under custom and percentage the creator's share is the
/// REMAINDER, so that number was the whole bill presented as the creator's
/// own share.

void main() {
  group('where do I type the shares', () {
    test('equal needs no input, so it offers no hint', () {
      expect(splitMethodHint(SplitShareInput.none, coPayerCount: 0), isNull);
      expect(splitMethodHint(SplitShareInput.none, coPayerCount: 3), isNull);
    });

    test('percentage points at the next step, and at adding people first', () {
      final empty = splitMethodHint(SplitShareInput.percent, coPayerCount: 0)!;
      expect(empty, contains('next step'));
      expect(empty, contains('%'));
      expect(empty, contains('co-payers'),
          reason: 'with nobody added, adding people is the first move');
    });

    test('once people are added it just says where the fields are', () {
      final some = splitMethodHint(SplitShareInput.percent, coPayerCount: 2)!;
      expect(some, contains('next step'));
      expect(some, isNot(contains('Add your co-payers')));
    });

    test('custom asks for an amount, not a percentage', () {
      final custom = splitMethodHint(SplitShareInput.amount, coPayerCount: 1)!;
      expect(custom, contains('amount'));
      expect(custom, isNot(contains('%')));
    });
  });

  group('my share', () {
    test('equal states the figure', () {
      expect(
        myShareSubtitle(
          input: SplitShareInput.none,
          includeMyself: true,
          myShare: 800,
          totalAmount: 1600,
          assignedToOthers: 800,
          currencySymbol: '₦',
        ),
        'My share: ₦800.00',
      );
    });

    test('THE BUG: percentage with nothing allocated never shows a figure',
        () {
      // _calculateSplits leaves myShare == the full total until a co-payer
      // has a percentage. Printing that as "My share: ₦800.00" told the
      // creator they owed the entire bill.
      final s = myShareSubtitle(
        input: SplitShareInput.percent,
        includeMyself: true,
        myShare: 800,
        totalAmount: 800,
        assignedToOthers: 0,
        currencySymbol: '₦',
      )!;
      expect(s, isNot(contains('800')));
      expect(s, contains('whatever is left'));
    });

    test('once co-payers have shares, the remainder is named as such', () {
      final s = myShareSubtitle(
        input: SplitShareInput.percent,
        includeMyself: true,
        myShare: 300,
        totalAmount: 1000,
        assignedToOthers: 700,
        currencySymbol: '₦',
      )!;
      expect(s, contains('₦300.00'));
      expect(s, contains('the rest'));
    });

    test('co-payers covering 100% says so instead of showing a bare zero', () {
      final s = myShareSubtitle(
        input: SplitShareInput.percent,
        includeMyself: true,
        myShare: 0,
        totalAmount: 1000,
        assignedToOthers: 1000,
        currencySymbol: '₦',
      )!;
      expect(s, contains('nothing left'));
    });

    test('not a co-payer means no line at all', () {
      expect(
        myShareSubtitle(
          input: SplitShareInput.percent,
          includeMyself: false,
          myShare: 800,
          totalAmount: 800,
          assignedToOthers: 0,
          currencySymbol: '₦',
        ),
        isNull,
      );
    });

    test('no amount entered yet says nothing rather than ₦0.00', () {
      expect(
        myShareSubtitle(
          input: SplitShareInput.percent,
          includeMyself: true,
          myShare: 0,
          totalAmount: 0,
          assignedToOthers: 0,
          currencySymbol: '₦',
        ),
        isNull,
      );
    });
  });
}
