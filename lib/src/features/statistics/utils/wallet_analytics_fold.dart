import '../../../generated/accounts.pb.dart' as accounts_pb;

/// Combines the analytics of SEVERAL LazerVault wallets into one view.
///
/// WHY THIS EXISTS
/// ---------------
/// A user holds a personal, business, savings, family and campaign wallet per
/// currency, and production carries 24 to 40 accounts per user. The analytics
/// screen used to read `accountManager.activeAccountId` alone, so one wallet
/// was presented as the whole LazerVault picture. Answering honestly means
/// asking accounts-service per wallet and folding the results.
///
/// Extracted from StatisticsCubit so this money arithmetic can be tested
/// without a gRPC stack, and so the cubit stays about state rather than sums.
///
/// SAFE TO ADD, AND ONLY BECAUSE:
/// every wallet in a fold shares ONE currency. The selector never offers
/// wallets outside the active currency, because adding NGN 100 to USD 5 gives
/// a number that means nothing. Within a currency the aggregates are additive,
/// so these sums are exact rather than an approximation.
class WalletAnalyticsFold {
  const WalletAnalyticsFold._();

  /// Period-over-period change. A previous period of zero cannot yield a
  /// meaningful ratio, so it reads as 100% when there is activity now and 0%
  /// when there is none, rather than dividing by zero.
  static double changePercent(double current, double previous) {
    if (previous <= 0) return current > 0 ? 100.0 : 0.0;
    return ((current - previous) / previous) * 100.0;
  }

  /// Rewrites each item's share of [total]. Percentages are always recomputed
  /// from summed amounts, never averaged: the mean of two percentages is not
  /// the percentage of the sum.
  static void repercent(
      List<accounts_pb.CategoryBreakdownItem> items, double total) {
    for (final item in items) {
      item.percentage = total > 0 ? (item.amount / total) * 100.0 : 0.0;
    }
  }

  static accounts_pb.GetFinancialAnalyticsResponse financial(
      List<accounts_pb.GetFinancialAnalyticsResponse> parts) {
    final d = accounts_pb.GetFinancialAnalyticsResponse()
      ..currentPeriod = accounts_pb.PeriodTotals()
      ..previousPeriod = accounts_pb.PeriodTotals();
    for (final p in parts) {
      d.currentPeriod.totalIncome += p.currentPeriod.totalIncome;
      d.currentPeriod.totalExpenses += p.currentPeriod.totalExpenses;
      d.currentPeriod.transactionCount += p.currentPeriod.transactionCount;
      d.previousPeriod.totalIncome += p.previousPeriod.totalIncome;
      d.previousPeriod.totalExpenses += p.previousPeriod.totalExpenses;
      d.previousPeriod.transactionCount += p.previousPeriod.transactionCount;
    }
    d.currentPeriod.net =
        d.currentPeriod.totalIncome - d.currentPeriod.totalExpenses;
    d.previousPeriod.net =
        d.previousPeriod.totalIncome - d.previousPeriod.totalExpenses;
    d.incomeChangePercent = changePercent(
        d.currentPeriod.totalIncome, d.previousPeriod.totalIncome);
    d.expenseChangePercent = changePercent(
        d.currentPeriod.totalExpenses, d.previousPeriod.totalExpenses);
    return d;
  }

  static accounts_pb.GetCategoryAnalyticsResponse categories(
      List<accounts_pb.GetCategoryAnalyticsResponse> parts) {
    final d = accounts_pb.GetCategoryAnalyticsResponse();
    for (final p in parts) {
      _addInto(d.expenseCategories, p.expenseCategories);
      _addInto(d.incomeCategories, p.incomeCategories);
      d.totalExpenses += p.totalExpenses;
      d.totalIncome += p.totalIncome;
    }
    repercent(d.expenseCategories, d.totalExpenses);
    repercent(d.incomeCategories, d.totalIncome);
    // Sub-category shares are relative to their PARENT category, not to the
    // page total, so they are recomputed separately.
    for (final list in [d.expenseCategories, d.incomeCategories]) {
      for (final c in list) {
        for (final s in c.subCategories) {
          s.percentage = c.amount > 0 ? (s.amount / c.amount) * 100.0 : 0.0;
        }
      }
    }
    d.expenseCategories.sort((a, b) => b.amount.compareTo(a.amount));
    d.incomeCategories.sort((a, b) => b.amount.compareTo(a.amount));
    return d;
  }

  /// Merges [extra] into [target] on a case-insensitive category name, which is
  /// the same key the wallet+bank merge uses, so a category cannot appear twice
  /// under different capitalisation.
  static void _addInto(List<accounts_pb.CategoryBreakdownItem> target,
      List<accounts_pb.CategoryBreakdownItem> extra) {
    final byName = <String, accounts_pb.CategoryBreakdownItem>{
      for (final t in target) t.categoryName.toLowerCase(): t,
    };
    for (final e in extra) {
      final existing = byName[e.categoryName.toLowerCase()];
      if (existing == null) {
        final copy = e.clone();
        target.add(copy);
        byName[copy.categoryName.toLowerCase()] = copy;
        continue;
      }
      existing.amount += e.amount;
      existing.transactionCount += e.transactionCount;
      final subByName = {
        for (final s in existing.subCategories) s.name.toLowerCase(): s,
      };
      for (final s in e.subCategories) {
        final hit = subByName[s.name.toLowerCase()];
        if (hit != null) {
          hit.amount += s.amount;
          hit.transactionCount += s.transactionCount;
        } else {
          existing.subCategories.add(s.clone());
        }
      }
    }
  }

  static accounts_pb.GetExpenseTimeSeriesResponse series(
      List<accounts_pb.GetExpenseTimeSeriesResponse> parts) {
    final d = accounts_pb.GetExpenseTimeSeriesResponse();
    final byDate = <String, accounts_pb.DailyExpensePoint>{};
    for (final p in parts) {
      for (final point in p.dataPoints) {
        final hit = byDate[point.date];
        if (hit != null) {
          hit.amount += point.amount;
        } else {
          final copy = accounts_pb.DailyExpensePoint(
              date: point.date, amount: point.amount);
          d.dataPoints.add(copy);
          byDate[point.date] = copy;
        }
      }
    }
    d.dataPoints.sort((a, b) => a.date.compareTo(b.date));
    var total = 0.0;
    for (final p in d.dataPoints) {
      total += p.amount;
    }
    d.totalExpenses = total;
    // Average over days that HAVE data. Dividing by the window length instead
    // would report a lower daily spend simply because a wallet was idle.
    d.dailyAverage =
        d.dataPoints.isNotEmpty ? total / d.dataPoints.length : 0.0;
    return d;
  }
}
