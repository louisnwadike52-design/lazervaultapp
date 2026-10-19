import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as pb;
import 'package:lazervault/src/features/statistics/utils/wallet_analytics_fold.dart';

/// Multi-wallet analytics must carry SAVINGS like every other total.
///
/// accounts-service now reports spending and savings separately — a PiggyVault
/// lock is a debit, but the money did not leave the user, and counting it as
/// spending made saving read as spending. The fold that merges several wallets
/// into one view summed income and expenses only, so the multi-wallet screen
/// would have dropped savings entirely and disagreed with every single-wallet
/// one.
///
/// Net is income - spending - savings on both sides, so the two cannot differ.

pb.GetFinancialAnalyticsResponse part({
  required double income,
  required double expenses,
  required double savings,
  int count = 1,
  double prevIncome = 0,
  double prevExpenses = 0,
  double prevSavings = 0,
}) {
  return pb.GetFinancialAnalyticsResponse()
    ..currentPeriod = (pb.PeriodTotals()
      ..totalIncome = income
      ..totalExpenses = expenses
      ..totalSavings = savings
      ..transactionCount = count)
    ..previousPeriod = (pb.PeriodTotals()
      ..totalIncome = prevIncome
      ..totalExpenses = prevExpenses
      ..totalSavings = prevSavings);
}

void main() {
  test('savings is summed across wallets, not dropped', () {
    final d = WalletAnalyticsFold.financial([
      part(income: 1000, expenses: 300, savings: 200),
      part(income: 500, expenses: 100, savings: 50),
    ]);
    expect(d.currentPeriod.totalIncome, 1500);
    expect(d.currentPeriod.totalExpenses, 400);
    expect(d.currentPeriod.totalSavings, 250,
        reason: 'dropping savings would silently re-merge it into '
            '"unaccounted for" on the multi-wallet view only');
  });

  test('net is income minus spending minus savings', () {
    final d = WalletAnalyticsFold.financial([
      part(income: 1000, expenses: 300, savings: 200),
    ]);
    expect(d.currentPeriod.net, 500,
        reason: 'leaving savings out of net overstates what the user has '
            'free by exactly the amount they put away');
  });

  test('the previous period gets the same treatment', () {
    final d = WalletAnalyticsFold.financial([
      part(
          income: 0,
          expenses: 0,
          savings: 0,
          prevIncome: 800,
          prevExpenses: 200,
          prevSavings: 100),
    ]);
    expect(d.previousPeriod.totalSavings, 100);
    expect(d.previousPeriod.net, 500);
  });

  test('a wallet with no savings does not disturb the others', () {
    final d = WalletAnalyticsFold.financial([
      part(income: 1000, expenses: 300, savings: 200),
      part(income: 200, expenses: 50, savings: 0),
    ]);
    expect(d.currentPeriod.totalSavings, 200);
    expect(d.currentPeriod.net, 1200 - 350 - 200);
  });

  test('an empty list folds to zeroes rather than throwing', () {
    final d = WalletAnalyticsFold.financial([]);
    expect(d.currentPeriod.totalSavings, 0);
    expect(d.currentPeriod.net, 0);
  });
}
