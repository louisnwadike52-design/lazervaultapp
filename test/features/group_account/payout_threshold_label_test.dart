import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

/// The payout threshold shown on the contribution summary card.
///
/// minimum_balance is settable at creation and was displayed NOWHERE: its only
/// appearance was inside the payout banner, to an admin, and only once it was
/// already blocking a payout. A member paying into a pot had no way to see what
/// it has to reach, so a payout that had not happened was indistinguishable
/// from a payout that was simply late.
///
/// Mirrors _payoutThresholdLabel in contribution_details_screen.dart, which in
/// turn mirrors the server's guard (current_amount < minimum_balance →
/// ErrInsufficientFunds).
String fmt(double amount) {
  final hasFraction = amount != amount.truncateToDouble();
  final f = NumberFormat.decimalPattern();
  f.minimumFractionDigits = hasFraction ? 2 : 0;
  f.maximumFractionDigits = 2;
  return f.format(amount);
}

String? payoutThresholdLabel({
  required double? minimumBalance,
  required double currentAmount,
  required String currency,
}) {
  final min = minimumBalance ?? 0;
  if (min <= 0) return null;
  final pot = currentAmount;
  if (pot >= min) return 'Pays out at $currency ${fmt(min)} — reached';
  return '$currency ${fmt(min - pot)} more before this can pay out '
      '(needs $currency ${fmt(min)})';
}

void main() {
  group('payout threshold line', () {
    test('no minimum set says nothing at all', () {
      expect(
        payoutThresholdLabel(
            minimumBalance: null, currentAmount: 500, currency: 'NGN'),
        isNull,
        reason: 'most circles never set one; a line would be noise',
      );
      expect(
        payoutThresholdLabel(
            minimumBalance: 0, currentAmount: 500, currency: 'NGN'),
        isNull,
      );
    });

    test('short pot names what is still needed, not just the target', () {
      final s = payoutThresholdLabel(
          minimumBalance: 1000, currentAmount: 250, currency: 'NGN')!;
      expect(s, contains('750'), reason: 'the gap is the actionable number');
      expect(s, contains('1,000'));
      expect(s, contains('more before this can pay out'));
    });

    test('an empty pot still states the full amount', () {
      final s = payoutThresholdLabel(
          minimumBalance: 200, currentAmount: 0, currency: 'NGN')!;
      expect(s, contains('200'));
    });

    test('exactly at the minimum reads as reached, not short', () {
      final s = payoutThresholdLabel(
          minimumBalance: 1000, currentAmount: 1000, currency: 'NGN')!;
      expect(s, contains('reached'));
      expect(s, isNot(contains('more before')));
    });

    test('over the minimum also reads as reached', () {
      final s = payoutThresholdLabel(
          minimumBalance: 1000, currentAmount: 2500, currency: 'NGN')!;
      expect(s, contains('reached'));
    });

    test('kobo never leaks — these are major units', () {
      // currentAmount and minimumBalance both arrive already divided by 100.
      final s = payoutThresholdLabel(
          minimumBalance: 50, currentAmount: 10, currency: 'NGN')!;
      expect(s, contains('40'));
      expect(s, isNot(contains('4000')));
    });

    test('fractions survive', () {
      final s = payoutThresholdLabel(
          minimumBalance: 100.50, currentAmount: 0.25, currency: 'NGN')!;
      expect(s, contains('100.25'));
    });

    test('the currency travels', () {
      final s = payoutThresholdLabel(
          minimumBalance: 100, currentAmount: 0, currency: 'GHS')!;
      expect(s, contains('GHS'));
    });
  });
}
