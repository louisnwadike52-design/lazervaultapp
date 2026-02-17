import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/budget_ai_service.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Maps category names from backend to display-friendly names.
String _friendlyCategoryName(String raw) => switch (raw.toLowerCase()) {
  'p2p transfers' || 'bank transfers' || 'international transfers' ||
  'gift cards' || 'bills & utilities' ||
  'service fees' || 'tagpay' || 'invoices' || 'investments' ||
  'payroll' || 'crowdfunding' || 'deposits' || 'withdrawals' ||
  'reversals' || 'transfers' || 'banking' || 'payments' ||
  'food & drinks' || 'shopping' || 'transportation' || 'entertainment' => raw,
  'piggyvault' || 'piggy vault' || 'lock funds' || 'lock_funds' => 'PiggyVault',
  'autosave' => 'AutoSave',
  'savings & products' => 'Savings & Products',
  'transfer' || 'c2c_transfer' => 'P2P Transfers',
  'domestic_transfer' => 'Bank Transfers',
  'international_transfer' => 'International Transfers',
  'deposit' => 'Deposits',
  'withdrawal' => 'Withdrawals',
  'fee' => 'Service Fees',
  'reversal' => 'Reversals',
  'payment' || 'invoice_payment' => 'Payments',
  'tag-pay' => 'TagPay',
  'invoice' => 'Invoices',
  'giftcards' || 'gift-cards' || 'gift_card' => 'Gift Cards',
  'airtime' || 'bill_payment' => 'Bills & Utilities',
  'investment' || 'investments' => 'Investments',
  'core-payments-service' || 'core-payments' => 'Transfers',
  'banking-service' => 'Banking',
  'invoice-service' => 'Invoices',
  'giftcards-service' => 'Gift Cards',
  'utility-payments-service' => 'Bills & Utilities',
  'tag-pay-service' => 'TagPay',
  'financial-products-service' => 'Savings & Products',
  'investments-service' => 'Investments',
  'payroll-service' => 'Payroll',
  'crowdfund-service' => 'Crowdfunding',
  'accounts-service' => 'Other',
  _ => raw.replaceAll('-', ' ').replaceAll('_', ' ').split(' ').map((w) =>
      w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '').join(' '),
};

class SpendingDetailScreen extends StatefulWidget {
  const SpendingDetailScreen({super.key});

  @override
  State<SpendingDetailScreen> createState() => _SpendingDetailScreenState();
}

class _SpendingDetailScreenState extends State<SpendingDetailScreen> {
  static const List<Color> _categoryColors = [
    Color(0xFF4A90E2),
    Color(0xFFE2844A),
    Color(0xFF4AE28D),
    Color(0xFFE24A67),
    Color(0xFF9B4AE2),
    Color(0xFFE2E24A),
    Color(0xFF4AE2D4),
    Color(0xFFE24ABB),
  ];

  // AI state
  bool _aiLoading = false;
  String? _aiError;
  BudgetAIInsightsResponse? _aiInsights;
  Map<String, CategoryInsightItem> _categoryAIMap = {};

  // Track expanded categories (by name to avoid stale indices on refresh)
  final Set<String> _expandedCategories = {};

  Future<void> _loadAIAnalysis() async {
    // Prevent concurrent calls
    if (_aiLoading) return;

    final statsState = context.read<StatisticsCubit>().state;
    if (statsState is! StatisticsLoaded || statsState.categoryAnalytics == null) return;

    final catAnalytics = statsState.categoryAnalytics!;
    // Nothing to analyze if no expense categories
    if (catAnalytics.expenseCategories.isEmpty) return;

    setState(() {
      _aiLoading = true;
      _aiError = null;
    });

    try {
      final analytics = statsState.financialAnalytics;
      final monthlyIncome = (analytics != null && analytics.hasCurrentPeriod())
          ? analytics.currentPeriod.totalIncome
          : 0.0;
      final totalExpenses = catAnalytics.totalExpenses;

      final spendingData = <Map<String, dynamic>>[];
      for (final cat in catAnalytics.expenseCategories) {
        final subCats = cat.subCategories.map((sub) => {
          'name': sub.name,
          'amount': sub.amount,
          'transaction_count': sub.transactionCount,
          'percentage': cat.amount > 0 ? (sub.amount / cat.amount * 100).round() : 0,
        }).toList();

        spendingData.add({
          'category': cat.categoryName,
          'amount': cat.amount,
          'percentage': totalExpenses > 0 ? (cat.amount / totalExpenses * 100).round() : 0,
          'transaction_count': cat.transactionCount,
          if (subCats.isNotEmpty) 'sub_categories': subCats,
        });
      }

      final aiService = serviceLocator<BudgetAIService>();
      final response = await aiService.getAIInsights(
        monthlyIncome: monthlyIncome > 0 ? monthlyIncome : 500000,
        spendingData: spendingData,
        activeBudgets: const [],
        goals: const ['Optimize spending'],
        riskTolerance: 'moderate',
        currency: CurrencySymbols.currentCurrency,
      );

      if (!mounted) return;

      final map = <String, CategoryInsightItem>{};
      for (final ci in response.categoryInsights) {
        map[ci.categoryName.toLowerCase()] = ci;
      }

      setState(() {
        _aiInsights = response;
        _categoryAIMap = map;
        _aiLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _aiError = 'Failed to load AI analysis. Try again.';
        _aiLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Spending Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state is! StatisticsLoaded) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<StatisticsCubit>().refresh(),
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              children: [
                _buildFullChart(state),
                SizedBox(height: 24.h),
                _buildSummaryCards(state),
                SizedBox(height: 24.h),
                _buildCategoryBreakdown(state),
                SizedBox(height: 16.h),
                _buildAIAnalysisSection(),
                SizedBox(height: 24.h),
                _buildDailyDataTable(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFullChart(StatisticsLoaded state) {
    final dataPoints = state.expenseTimeSeries?.dataPoints ?? [];

    if (dataPoints.isEmpty) {
      return Container(
        height: 300.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.show_chart, color: Colors.white60, size: 48.r),
              SizedBox(height: 12.h),
              Text(
                'No expense data for this period',
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < dataPoints.length; i++) {
      spots.add(FlSpot(i.toDouble(), dataPoints[i].amount));
    }

    final maxY = spots.fold<double>(0.0, (max, s) => s.y > max ? s.y : max);
    final roundedMaxY = maxY > 0 ? (maxY * 1.2).ceilToDouble() : 100.0;

    return Container(
      height: 300.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Trend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: LineChart(
              LineChartData(
                maxY: roundedMaxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: roundedMaxY > 0 ? roundedMaxY / 5 : 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withValues(alpha: 0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: (dataPoints.length / 5).ceilToDouble().clamp(1, double.infinity),
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= dataPoints.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          dataPoints[index].date,
                          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) => Text(
                        '${CurrencySymbols.currentSymbol}${value.toInt()}',
                        style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                      ),
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final index = spot.x.toInt();
                        final label = index < dataPoints.length ? dataPoints[index].date : '';
                        return LineTooltipItem(
                          '$label\n${CurrencySymbols.formatAmount(spot.y)}',
                          TextStyle(color: Colors.white, fontSize: 12.sp),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D9668), Color(0xFF10B981), Color(0xFF34D399)],
                    ),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                        radius: 3,
                        color: const Color(0xFF10B981),
                        strokeWidth: 1,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF10B981).withValues(alpha: 0.3),
                          const Color(0xFF34D399).withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(StatisticsLoaded state) {
    final dataPoints = state.expenseTimeSeries?.dataPoints ?? [];
    final total = dataPoints.fold<double>(0.0, (sum, p) => sum + p.amount);
    final dailyAvg = dataPoints.isNotEmpty ? total / dataPoints.length : 0.0;
    final maxDay = dataPoints.isNotEmpty
        ? dataPoints.reduce((a, b) => a.amount > b.amount ? a : b)
        : null;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total',
            CurrencySymbols.formatAmount(total),
            Icons.account_balance_wallet,
            Colors.red[300]!,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSummaryCard(
            'Daily Avg',
            CurrencySymbols.formatAmount(dailyAvg),
            Icons.calendar_today,
            Colors.orange[300]!,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSummaryCard(
            'Peak Day',
            maxDay != null ? '${CurrencySymbols.currentSymbol}${maxDay.amount.toStringAsFixed(0)}' : '--',
            Icons.arrow_upward,
            Colors.purple[300]!,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.r),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  /// Category breakdown section — pie chart style breakdown of expense categories
  Widget _buildCategoryBreakdown(StatisticsLoaded state) {
    final catAnalytics = state.categoryAnalytics;
    final categories = catAnalytics?.expenseCategories ?? [];
    final total = catAnalytics?.totalExpenses ?? 0.0;

    if (categories.isEmpty) return const SizedBox.shrink();

    final safeTotal = total > 0 ? total : 1.0;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Where Your Money Goes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(total),
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final cat = entry.value;
            final color = _categoryColors[index % _categoryColors.length];
            final percentage = (cat.amount / safeTotal * 100);
            final hasSubCats = cat.subCategories.isNotEmpty;
            final hasAI = _aiInsights != null;
            final isExpanded = _expandedCategories.contains(cat.categoryName);

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (hasSubCats || hasAI)
                        ? () => setState(() {
                              if (isExpanded) {
                                _expandedCategories.remove(cat.categoryName);
                              } else {
                                _expandedCategories.add(cat.categoryName);
                              }
                            })
                        : null,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            _friendlyCategoryName(cat.categoryName),
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          CurrencySymbols.formatAmount(cat.amount),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (hasSubCats || hasAI) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: const Color(0xFF9CA3AF),
                            size: 18.sp,
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: LinearProgressIndicator(
                      value: (cat.amount / safeTotal).clamp(0.0, 1.0),
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 5.h,
                    ),
                  ),
                  // Expanded: sub-categories + AI
                  if (isExpanded) ...[
                    if (hasSubCats)
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        padding: EdgeInsets.only(left: 22.w),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: color.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Column(
                          children: cat.subCategories.map((sub) {
                            final subPct = cat.amount > 0
                                ? (sub.amount / cat.amount * 100).toStringAsFixed(1)
                                : '0.0';
                            final subBarValue = cat.amount > 0
                                ? (sub.amount / cat.amount).clamp(0.0, 1.0)
                                : 0.0;

                            // Find AI tip
                            final aiCat = _categoryAIMap[cat.categoryName.toLowerCase()] ??
                                _categoryAIMap[_friendlyCategoryName(cat.categoryName).toLowerCase()];
                            final aiSub = aiCat?.subCategories
                                .where((s) => s.name.toLowerCase() == sub.name.toLowerCase())
                                .firstOrNull;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 7.w,
                                              height: 7.w,
                                              decoration: BoxDecoration(
                                                color: color.withValues(alpha: 0.6),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Flexible(
                                              child: Text(
                                                sub.name.isNotEmpty ? sub.name : 'Other',
                                                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              '$subPct%',
                                              style: TextStyle(color: const Color(0xFF6B7280), fontSize: 10.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        CurrencySymbols.formatAmount(sub.amount),
                                        style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3.h),
                                  LinearProgressIndicator(
                                    value: subBarValue,
                                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                                    valueColor: AlwaysStoppedAnimation<Color>(color.withValues(alpha: 0.5)),
                                    minHeight: 3.h,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  if (aiSub != null && aiSub.insight.isNotEmpty) ...[
                                    SizedBox(height: 3.h),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.lightbulb_outline, color: const Color(0xFFFB923C), size: 11.sp),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            aiSub.insight,
                                            style: TextStyle(
                                              color: const Color(0xFF9CA3AF),
                                              fontSize: 10.sp,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    _buildCategoryAIInsight(cat.categoryName, color),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// AI analysis section — button/loading/results
  Widget _buildAIAnalysisSection() {
    if (_aiInsights != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'AI Spending Insights',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _loadAIAnalysis,
                  child: Icon(Icons.refresh, color: const Color(0xFF9CA3AF), size: 18.sp),
                ),
              ],
            ),
            if (_aiInsights!.summary.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Text(
                _aiInsights!.summary,
                style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 13.sp, height: 1.5),
              ),
            ],
            if (_aiInsights!.savingsOpportunities.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                'Savings Tips',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              ..._aiInsights!.savingsOpportunities.take(3).map((tip) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb_outline, color: const Color(0xFFFB923C), size: 14.sp),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      );
    }

    if (_aiLoading) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF8B5CF6),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Analyzing your spending...',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          ],
        ),
      );
    }

    if (_aiError != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(_aiError!, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
            ),
            GestureDetector(
              onTap: _loadAIAnalysis,
              child: Text('Retry', style: TextStyle(color: const Color(0xFF8B5CF6), fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _loadAIAnalysis,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 20.sp),
            SizedBox(width: 10.w),
            Text(
              'Get AI Spending Analysis',
              style: TextStyle(
                color: const Color(0xFF8B5CF6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Inline AI analysis for a specific category.
  Widget _buildCategoryAIInsight(String categoryName, Color color) {
    if (_aiInsights == null) return const SizedBox.shrink();

    final aiCat = _categoryAIMap[categoryName.toLowerCase()] ??
        _categoryAIMap[_friendlyCategoryName(categoryName).toLowerCase()];
    if (aiCat == null || aiCat.analysis.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 13.sp),
              SizedBox(width: 5.w),
              Text(
                'AI Analysis',
                style: TextStyle(
                  color: const Color(0xFF8B5CF6),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            aiCat.analysis,
            style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 11.sp, height: 1.4),
          ),
          if (aiCat.subCategories.isNotEmpty) ...[
            SizedBox(height: 6.h),
            ...aiCat.subCategories.map((sub) => Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${sub.name.isNotEmpty ? sub.name : 'Other'}: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (sub.amount > 0)
                                TextSpan(
                                  text: '${CurrencySymbols.formatAmount(sub.amount)} — ',
                                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                                ),
                              TextSpan(
                                text: sub.insight,
                                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          if (aiCat.actionItems.isNotEmpty) ...[
            SizedBox(height: 6.h),
            ...aiCat.actionItems.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 12.sp),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 10.sp, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildDailyDataTable(StatisticsLoaded state) {
    final dataPoints = state.expenseTimeSeries?.dataPoints ?? [];

    if (dataPoints.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Breakdown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...dataPoints.map((point) => Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      point.date,
                      style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 14.sp),
                    ),
                    Text(
                      CurrencySymbols.formatAmount(point.amount),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
