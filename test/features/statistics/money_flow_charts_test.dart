import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_analytics_charts.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/money_flow_charts.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as pb;

/// The AI analytics page draws the same money-flow charts NOVA draws in chat.
///
/// Every series comes from responses StatisticsCubit already holds — category
/// analytics carries BOTH expense_categories and income_categories, and
/// monthly trends carries income and expenses per month — so this is a
/// rendering change with no RPC behind it.
void main() {
  pb.CategoryBreakdownItem cat(String name, double amount) =>
      pb.CategoryBreakdownItem(
        categoryName: name,
        amount: amount,
        transactionCount: 1,
        percentage: 10,
      );

  pb.GetMonthlyTrendsResponse months(List<List<double>> rows) =>
      pb.GetMonthlyTrendsResponse(
        months: [
          for (var i = 0; i < rows.length; i++)
            pb.MonthlyDataPoint(
              month: '2026-0${i + 1}',
              monthLabel: 'M${i + 1}',
              income: rows[i][0],
              expenses: rows[i][1],
            ),
        ],
      );

  Future<void> pumpIt(
    WidgetTester tester, {
    pb.GetCategoryAnalyticsResponse? categories,
    pb.GetMonthlyTrendsResponse? trends,
  }) async {
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: MoneyFlowCharts(
              currency: 'NGN',
              categoryAnalytics: categories,
              monthlyTrends: trends,
            ),
          ),
        ),
      ),
    ));
    await tester.pump();
  }

  testWidgets('expenses draw a donut and income draws bars', (tester) async {
    await pumpIt(tester,
        categories: pb.GetCategoryAnalyticsResponse(
          expenseCategories: [cat('Transfers', 43046), cat('Crypto', 13156)],
          incomeCategories: [cat('Deposits', 115000), cat('Refunds', 900)],
        ));
    expect(find.text('Where your money went'), findsOneWidget);
    expect(find.byType(AnalyticsDonut), findsOneWidget);
    expect(find.text('Where your money came from'), findsOneWidget);
    expect(find.byType(AnalyticsBars), findsOneWidget);
  });

  testWidgets('two or more months draw the in-vs-out trend', (tester) async {
    await pumpIt(tester,
        trends: months([
          [10, 5],
          [20, 9],
          [30, 12],
        ]));
    expect(find.text('Money in vs money out'), findsOneWidget);
    expect(find.byType(AnalyticsTrendLine), findsOneWidget);
  });

  testWidgets('a single month draws NO trend and no heading', (tester) async {
    // One dot is not a trend — it invites the reader to infer a direction the
    // data does not contain. The chart already refuses; the heading must too,
    // or the page shows a title over empty space.
    await pumpIt(tester,
        trends: months([
          [10, 5],
        ]));
    expect(find.text('Money in vs money out'), findsNothing);
  });

  testWidgets('zero-value categories are dropped', (tester) async {
    // "Escrow ₦0.00 0%" is a legend row that says nothing, and a zero slice is
    // invisible in the ring anyway.
    await pumpIt(tester,
        categories: pb.GetCategoryAnalyticsResponse(
          expenseCategories: [cat('Real', 100), cat('Empty', 0)],
        ));
    expect(find.textContaining('Empty'), findsNothing);
    expect(find.textContaining('Real'), findsWidgets);
  });

  testWidgets('nothing loaded renders nothing at all', (tester) async {
    // A new account, or a filter that excluded everything. Empty axes under a
    // heading look like a failure; the page has its own empty states above.
    await pumpIt(tester);
    expect(find.byType(AnalyticsDonut), findsNothing);
    expect(find.byType(AnalyticsBars), findsNothing);
    expect(find.byType(AnalyticsTrendLine), findsNothing);
    expect(find.textContaining('Where your money'), findsNothing);
  });
}
