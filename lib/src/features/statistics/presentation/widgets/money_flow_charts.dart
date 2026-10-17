import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_analytics_charts.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

/// The money-flow charts NOVA draws in chat, on the AI analytics page.
///
/// The assistant could already answer "where did my money go" with a donut, a
/// bar chart of income sources and an in-vs-out trend — but the analytics page
/// those questions belong on had none of them. Asking a chatbot for a picture
/// of your month, when there is a whole page for exactly that, is the wrong
/// way round.
///
/// ## No new data is fetched
///
/// Every series here comes from responses StatisticsCubit already holds:
///
///   donut   expense_categories  (GetCategoryAnalyticsResponse)
///   bars    income_categories   (same response — it carries both)
///   trend   monthly_trends      (MonthlyDataPoint.income / .expenses)
///
/// So this is a rendering change only: no RPC, no proto, no backend work.
///
/// The chart widgets themselves are the chat's, imported rather than copied.
/// Two implementations of the same donut would drift the first time one is
/// restyled, and the user asked for charts *like* the chat's — not ones that
/// merely resemble them today.
class MoneyFlowCharts extends StatelessWidget {
  const MoneyFlowCharts({
    super.key,
    required this.currency,
    this.categoryAnalytics,
    this.monthlyTrends,
  });

  final String currency;
  final accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics;
  final accounts_pb.GetMonthlyTrendsResponse? monthlyTrends;

  /// Categories that actually carry money, largest first.
  ///
  /// Zero-value rows are dropped: a legend entry reading "Escrow ₦0.00 0%" is
  /// noise, and a zero slice is invisible in the ring anyway.
  static List<AnalyticsPointView> _fromCategories(
    List<accounts_pb.CategoryBreakdownItem> items,
  ) {
    final points = <AnalyticsPointView>[];
    for (final c in items) {
      if (c.amount <= 0) continue;
      points.add(AnalyticsPointView(
        label: c.categoryName,
        value: c.amount,
        percentage: c.percentage,
        count: c.transactionCount,
      ));
    }
    points.sort((a, b) => b.value.compareTo(a.value));
    return points;
  }

  /// Income as the primary series, expenses as the secondary — the pairing
  /// AnalyticsTrendLine expects, and the same order as the chat's legend.
  static List<AnalyticsPointView> _fromMonths(
    List<accounts_pb.MonthlyDataPoint> months,
  ) =>
      [
        for (final m in months)
          AnalyticsPointView(
            label: m.monthLabel.isNotEmpty ? m.monthLabel : m.month,
            value: m.income,
            secondary: m.expenses,
          ),
      ];

  @override
  Widget build(BuildContext context) {
    final expense =
        _fromCategories(categoryAnalytics?.expenseCategories ?? const []);
    final income =
        _fromCategories(categoryAnalytics?.incomeCategories ?? const []);
    final months = _fromMonths(monthlyTrends?.months ?? const []);

    final sections = <Widget>[
      if (expense.isNotEmpty)
        _section(
          'Where your money went',
          AnalyticsDonut(points: expense, currency: currency),
        ),
      if (income.isNotEmpty)
        _section(
          'Where your money came from',
          AnalyticsBars(points: income, currency: currency),
        ),
      // AnalyticsTrendLine renders nothing below two points — one dot invites
      // the reader to infer a direction the data does not contain — so the
      // heading is gated on the same rule rather than labelling an empty box.
      if (months.length >= 2)
        _section(
          'Money in vs money out',
          AnalyticsTrendLine(
            points: months,
            currency: currency,
            seriesLabels: const ['Money in', 'Money out'],
          ),
        ),
    ];

    // Nothing to draw: a brand-new account, or a filter that excluded
    // everything. Render NOTHING rather than empty axes — the page already
    // has its own empty states above this.
    if (sections.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    );
  }

  Widget _section(String title, Widget chart) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            chart,
          ],
        ),
      );
}
