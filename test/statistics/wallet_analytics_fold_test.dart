import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/statistics/utils/wallet_analytics_fold.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as pb;

/// These cover the arithmetic behind "show me my personal AND business
/// wallets together". The screen used to read one wallet and present it as the
/// whole LazerVault picture, so the fold is what makes the combined view true.
///
/// The cases that matter are the ones where a naive implementation looks right:
/// percentages must come from summed amounts (not be averaged), categories must
/// merge by name rather than duplicate, and a same-day point from two wallets
/// must add rather than overwrite.
void main() {
  pb.GetFinancialAnalyticsResponse financial({
    required double income,
    required double expenses,
    double prevIncome = 0,
    double prevExpenses = 0,
    int count = 0,
  }) =>
      pb.GetFinancialAnalyticsResponse()
        ..currentPeriod = (pb.PeriodTotals()
          ..totalIncome = income
          ..totalExpenses = expenses
          ..transactionCount = count)
        ..previousPeriod = (pb.PeriodTotals()
          ..totalIncome = prevIncome
          ..totalExpenses = prevExpenses);

  pb.CategoryBreakdownItem cat(String name, double amount,
          {int count = 1, List<pb.SubCategoryItem> subs = const []}) =>
      pb.CategoryBreakdownItem(
        categoryName: name,
        amount: amount,
        transactionCount: count,
        subCategories: subs,
      );

  group('financial fold', () {
    test('adds totals across wallets and derives net from the sum', () {
      final r = WalletAnalyticsFold.financial([
        financial(income: 1000, expenses: 400, count: 3),
        financial(income: 250, expenses: 100, count: 2),
      ]);

      expect(r.currentPeriod.totalIncome, 1250);
      expect(r.currentPeriod.totalExpenses, 500);
      expect(r.currentPeriod.net, 750);
      expect(r.currentPeriod.transactionCount, 5);
    });

    test('change percent comes from combined totals, not per-wallet averages',
        () {
      // Wallet A doubled (100 -> 200), wallet B halved (100 -> 50).
      // Averaging the two percentages gives (+100 + -50)/2 = +25%.
      // The truth is 200+50=250 against 100+100=200, i.e. +25%... so use
      // figures where the two differ to prove which one is computed.
      final r = WalletAnalyticsFold.financial([
        financial(income: 300, expenses: 0, prevIncome: 100),
        financial(income: 100, expenses: 0, prevIncome: 300),
      ]);

      // Summed: 400 now vs 400 before = 0% change.
      // Averaged percentages would be (+200 + -66.7)/2 = +66.7%.
      expect(r.incomeChangePercent, closeTo(0, 0.0001));
    });

    test('a zero previous period reports 100 percent rather than dividing by zero',
        () {
      final r = WalletAnalyticsFold.financial([
        financial(income: 500, expenses: 0, prevIncome: 0),
      ]);
      expect(r.incomeChangePercent, 100);

      final quiet = WalletAnalyticsFold.financial([
        financial(income: 0, expenses: 0, prevIncome: 0),
      ]);
      expect(quiet.incomeChangePercent, 0);
    });

    test('folding nothing yields zeros, never a crash', () {
      final r = WalletAnalyticsFold.financial([]);
      expect(r.currentPeriod.totalIncome, 0);
      expect(r.currentPeriod.net, 0);
      expect(r.incomeChangePercent, 0);
    });
  });

  group('category fold', () {
    test('merges the same category across wallets instead of listing it twice',
        () {
      final r = WalletAnalyticsFold.categories([
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 300
          ..expenseCategories.addAll([cat('Transfers', 200), cat('Airtime', 100)]),
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 100
          ..expenseCategories.add(cat('Transfers', 100, count: 2)),
      ]);

      expect(r.expenseCategories.length, 2);
      final transfers =
          r.expenseCategories.firstWhere((c) => c.categoryName == 'Transfers');
      expect(transfers.amount, 300);
      expect(transfers.transactionCount, 3);
      expect(r.totalExpenses, 400);
    });

    test('matches category names case-insensitively', () {
      final r = WalletAnalyticsFold.categories([
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 100
          ..expenseCategories.add(cat('Bills & Utilities', 100)),
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 50
          ..expenseCategories.add(cat('bills & utilities', 50)),
      ]);
      expect(r.expenseCategories.length, 1);
      expect(r.expenseCategories.single.amount, 150);
    });

    test('percentages are recomputed against the combined total', () {
      final r = WalletAnalyticsFold.categories([
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 100
          ..expenseCategories.add(cat('Transfers', 100)), // 100% alone
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 300
          ..expenseCategories.add(cat('Airtime', 300)), // 100% alone
      ]);

      final transfers =
          r.expenseCategories.firstWhere((c) => c.categoryName == 'Transfers');
      final airtime =
          r.expenseCategories.firstWhere((c) => c.categoryName == 'Airtime');
      expect(transfers.percentage, closeTo(25, 0.0001));
      expect(airtime.percentage, closeTo(75, 0.0001));
      expect(transfers.percentage + airtime.percentage, closeTo(100, 0.0001));
    });

    test('sub-categories merge and are scored against their own parent', () {
      final r = WalletAnalyticsFold.categories([
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 100
          ..expenseCategories.add(cat('Bills & Utilities', 100, subs: [
            pb.SubCategoryItem(name: 'Airtime', amount: 100, transactionCount: 1),
          ])),
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 100
          ..expenseCategories.add(cat('Bills & Utilities', 100, subs: [
            pb.SubCategoryItem(name: 'Airtime', amount: 40, transactionCount: 1),
            pb.SubCategoryItem(name: 'Data', amount: 60, transactionCount: 1),
          ])),
      ]);

      final bills = r.expenseCategories.single;
      expect(bills.amount, 200);
      expect(bills.subCategories.length, 2);

      final airtime =
          bills.subCategories.firstWhere((s) => s.name == 'Airtime');
      expect(airtime.amount, 140);
      expect(airtime.transactionCount, 2);
      // 140 of the parent's 200, NOT of the page total.
      expect(airtime.percentage, closeTo(70, 0.0001));
    });

    test('orders categories by amount so the biggest spend leads', () {
      final r = WalletAnalyticsFold.categories([
        pb.GetCategoryAnalyticsResponse()
          ..totalExpenses = 600
          ..expenseCategories
              .addAll([cat('Small', 100), cat('Big', 500)]),
      ]);
      expect(r.expenseCategories.first.categoryName, 'Big');
    });
  });

  group('series fold', () {
    test('adds same-day spend from different wallets rather than replacing it',
        () {
      final r = WalletAnalyticsFold.series([
        pb.GetExpenseTimeSeriesResponse()
          ..dataPoints.addAll([
            pb.DailyExpensePoint(date: '2026-09-01', amount: 100),
            pb.DailyExpensePoint(date: '2026-09-02', amount: 50),
          ]),
        pb.GetExpenseTimeSeriesResponse()
          ..dataPoints.add(pb.DailyExpensePoint(date: '2026-09-01', amount: 25)),
      ]);

      expect(r.dataPoints.length, 2);
      expect(r.dataPoints.first.date, '2026-09-01');
      expect(r.dataPoints.first.amount, 125);
      expect(r.totalExpenses, 175);
    });

    test('keeps points in date order for the chart', () {
      final r = WalletAnalyticsFold.series([
        pb.GetExpenseTimeSeriesResponse()
          ..dataPoints.addAll([
            pb.DailyExpensePoint(date: '2026-09-03', amount: 1),
            pb.DailyExpensePoint(date: '2026-09-01', amount: 1),
          ]),
      ]);
      expect([for (final p in r.dataPoints) p.date],
          ['2026-09-01', '2026-09-03']);
    });

    test('daily average divides by days with data, not by the window', () {
      final r = WalletAnalyticsFold.series([
        pb.GetExpenseTimeSeriesResponse()
          ..dataPoints.addAll([
            pb.DailyExpensePoint(date: '2026-09-01', amount: 100),
            pb.DailyExpensePoint(date: '2026-09-02', amount: 200),
          ]),
      ]);
      expect(r.dailyAverage, 150);
    });

    test('an empty fold does not divide by zero', () {
      final r = WalletAnalyticsFold.series([]);
      expect(r.totalExpenses, 0);
      expect(r.dailyAverage, 0);
    });
  });
}
