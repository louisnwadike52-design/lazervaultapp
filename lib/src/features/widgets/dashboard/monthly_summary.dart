import 'dart:async';
import 'package:lazervault/core/services/active_account_snapshot.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/account_manager.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/services/locale_manager.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../statistics/cubit/statistics_cubit.dart';
import '../../statistics/cubit/statistics_state.dart';
import '../../../generated/accounts.pb.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/services/dashboard_state_manager.dart';
import 'expenditure_chart.dart';
import 'expenditure_chart_controls.dart';
import 'expenditure_chart_type.dart';
part 'monthly_summary_widgets.dart';

class MonthlySummary extends StatefulWidget {
  const MonthlySummary({super.key});

  @override
  State<MonthlySummary> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
  TimePeriod _selectedPeriod = TimePeriod.month;

  /// Held in the dashboard singleton, not in this State: leaving the dashboard
  /// disposes this widget and the user's choice would not survive the trip.
  final DashboardStateManager _dashboardState = DashboardStateManager();
  StreamSubscription<String?>? _accountSub;
  StreamSubscription<String>? _localeSub;

  @override
  void initState() {
    super.initState();
    _loadDataForPeriod(_selectedPeriod);

    // Re-scope monthly spending when the swiped account or locale changes
    // (mirrors RecentHistory) — the StatisticsCubit fetch carries the active
    // account + locale via gRPC metadata, so a reload re-scopes it.
    final accountManager = serviceLocator<AccountManager>();
    final localeManager = serviceLocator<LocaleManager>();
    _accountSub = accountManager.accountIdStream
        .distinct()
        .where((id) => id != null)
        .listen((_) {
      if (mounted) _loadDataForPeriod(_selectedPeriod);
    });
    _localeSub = localeManager.countryStream.distinct().listen((_) {
      if (mounted) _loadDataForPeriod(_selectedPeriod);
    });
  }

  @override
  void dispose() {
    _accountSub?.cancel();
    _localeSub?.cancel();
    super.dispose();
  }

  void _loadDataForPeriod(TimePeriod period) {
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;

    switch (period) {
      case TimePeriod.day:
        startDate = DateTime(now.year, now.month, now.day - 7);
        break;
      case TimePeriod.week:
        startDate = DateTime(now.year, now.month, now.day - 30);
        break;
      case TimePeriod.month:
        startDate = DateTime(now.year, now.month, 1);
        break;
    }

    context.read<StatisticsCubit>().loadStatistics(
          startDate: startDate,
          endDate: endDate,
        );
  }

  /// Currency symbol for the money shown here. The statistics are already
  /// scoped to the active account + locale (carried on the gRPC fetch), so the
  /// symbol must match: prefer the active account's currency, fall back to the
  /// active locale's currency (never a hardcoded £).
  String get _currencySymbol {
    final acctCurrency = activeAccountSnapshot()?.currency;
    if (acctCurrency != null && acctCurrency.trim().isNotEmpty) {
      return CurrencySymbols.getSymbol(acctCurrency);
    }
    return CurrencySymbols.currentSymbol;
  }

  void _onPeriodChanged(TimePeriod period) {
    setState(() {
      _selectedPeriod = period;
    });
    _loadDataForPeriod(period);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is StatisticsLoading) {
          return _buildLoadingState();
        } else if (state is StatisticsError) {
          return _buildErrorState(state.message);
        } else if (state is StatisticsLoaded) {
          return _buildLoadedState(state);
        }
        return _buildEmptyState();
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 57, 2, 111),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 57, 2, 111).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading expenditure data...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 57, 2, 111),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 57, 2, 111).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to load data',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => _loadDataForPeriod(_selectedPeriod),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 57, 2, 111),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 57, 2, 111).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insights_outlined,
            color: Colors.white.withValues(alpha: 0.5),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No expenditure data available',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(StatisticsLoaded state) {
    final timeSeries = state.expenseTimeSeries;

    // If no analytics data, show empty state
    if (timeSeries == null) {
      return _buildEmptyState();
    }

    final dailyTrend = timeSeries.dataPoints;
    final totalSpent = timeSeries.totalExpenses;
    final transactionCount =
        state.financialAnalytics?.currentPeriod.transactionCount ?? 0;

    // If no daily trend data, show empty state
    if (dailyTrend.isEmpty) {
      return _buildEmptyDataState();
    }

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 57, 2, 111),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 57, 2, 111).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section with Period Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getPeriodTitle(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _formatDateRange(state.startDate, state.endDate),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$_currencySymbol${totalSpent.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Period Selector Tabs
          _buildPeriodSelector(),
          SizedBox(height: 24.h),

          // Chart Section — shape is user-selectable; see _buildChartSection.
          _buildChartSection(state, dailyTrend, totalSpent, transactionCount),
          SizedBox(height: 24.h),

          // Statistics Section
          // Typed fallback: `?? []` builds a List<dynamic>, and the implicit
          // downcast to List<CategoryBreakdownItem> at this call boundary
          // throws AT RUNTIME whenever categoryAnalytics is null (grey
          // dashboard card in release). Same family as the Spending Details
          // crash fixed 2026-09-07.
          _buildStatisticsRow(
              totalSpent,
              transactionCount,
              state.categoryAnalytics?.expenseCategories ??
                  <CategoryBreakdownItem>[]),
        ],
      ),
    );
  }

  Widget _buildEmptyDataState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 57, 2, 111),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 57, 2, 111).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getPeriodTitle(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildPeriodSelector(),
          SizedBox(height: 40.h),
          Icon(
            Icons.receipt_long_outlined,
            color: Colors.white.withValues(alpha: 0.3),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No expenses recorded',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start tracking your expenses to see insights',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildPeriodTab('Day', TimePeriod.day),
          ),
          Expanded(
            child: _buildPeriodTab('Week', TimePeriod.week),
          ),
          Expanded(
            child: _buildPeriodTab('Month', TimePeriod.month),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodTab(String label, TimePeriod period) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () => _onPeriodChanged(period),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color:
                isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  /// The chart block: a small control row, the chart itself, and a colour key
  /// when the chart is a category one.
  ///
  /// The SHAPE is the user's choice and cycles on each tap of the CTA. What it
  /// may cycle through is decided by the data, not by the enum — see
  /// [availableChartTypes]. That matters because the two chart families read
  /// different datasets: a pie needs the category breakdown, which is absent
  /// on a quiet account and on some periods, and cycling onto an empty pie was
  /// the obvious way to get this wrong.
  Widget _buildChartSection(
    StatisticsLoaded state,
    List<DailyExpensePoint> dailyTrend,
    double totalSpent,
    int transactionCount,
  ) {
    final points = <ExpenditurePoint>[
      for (final p in dailyTrend)
        ExpenditurePoint(
          // A row whose date the backend could not format must not take the
          // whole card down; it falls back to today and still plots its amount.
          date: DateTime.tryParse(p.date) ?? DateTime.now(),
          amount: p.amount,
        ),
    ];

    // Only categories with money in them. A zero-amount category is a slice
    // with no sweep: invisible in the pie, a dead spoke on the radar, and a
    // legend row claiming a colour the user cannot find.
    final slices = <ExpenditureSlice>[
      for (final c
          in (state.categoryAnalytics?.expenseCategories ??
              <CategoryBreakdownItem>[]))
        if (c.amount > 0)
          ExpenditureSlice(name: c.categoryName, amount: c.amount),
    ];

    final available = availableChartTypes(
      trendPoints: points.length,
      categoryCount: slices.length,
    );

    // Nothing drawable at all — the card keeps its own empty state rather than
    // an axis with no series on it.
    if (available.isEmpty) {
      return Container(
        height: 240.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: _buildNoDataChart(),
      );
    }

    // Clamp the remembered choice onto what today's data supports: a user who
    // left this on Radar and returns to a period with two categories must not
    // hit fl_chart's "Radar needs at least 3" assert.
    final type =
        resolveChartType(_dashboardState.expenditureChartType, available)!;
    final next = nextChartType(type, available)!;
    final showLegend = type.isCategoryChart && slices.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(type.icon,
                size: 14.sp, color: Colors.white.withValues(alpha: 0.75)),
            SizedBox(width: 6.w),
            Text(
              type.isCategoryChart ? 'By category' : 'Daily trend',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
            ExpenditureChartInfoButton(
              onTap: () => showExpenditureChartInfoSheet(
                context,
                type: type,
                categories: slices,
                currencySymbol: _currencySymbol,
                periodTitle: _getPeriodTitle(),
                dateRange: _formatDateRange(state.startDate, state.endDate),
                transactionCount: transactionCount,
                totalSpent: totalSpent,
                available: available,
              ),
            ),
            const Spacer(),
            // Hidden when there is only one shape to show: a cycle button that
            // cycles back to itself is a dead control.
            if (available.length > 1)
              ExpenditureChartCta(
                next: next,
                onTap: () => setState(
                    () => _dashboardState.setExpenditureChartType(next)),
                // Long-press jumps straight to the explanation of every shape,
                // which is also where a user can see why one is unavailable.
                onLongPress: () => showExpenditureChartInfoSheet(
                  context,
                  type: type,
                  categories: slices,
                  currencySymbol: _currencySymbol,
                  periodTitle: _getPeriodTitle(),
                  dateRange: _formatDateRange(state.startDate, state.endDate),
                  transactionCount: transactionCount,
                  totalSpent: totalSpent,
                  available: available,
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          height: 240.h,
          // Asymmetric on purpose: the Y labels need room on the left, and the
          // right only needs enough that the last point is not flush to the
          // edge. The old uniform all(4.w) was why the first and last dots
          // were sliced by the container.
          padding: EdgeInsets.fromLTRB(4.w, 12.h, 12.w, 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: ExpenditureChart(
            // Keyed by shape so fl_chart rebuilds rather than trying to
            // animate a line's spots into a pie's sections.
            key: ValueKey(type),
            type: type,
            trend: points,
            categories: slices,
            currencySymbol: _currencySymbol,
            bottomLabel: _formatBottomLabel,
            totalSpent: totalSpent,
          ),
        ),
        if (showLegend) ...[
          SizedBox(height: 12.h),
          ExpenditureChartLegend(
            categories: slices,
            currencySymbol: _currencySymbol,
          ),
        ],
      ],
    );
  }

  Widget _buildNoDataChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart,
            color: Colors.white.withValues(alpha: 0.3),
            size: 48.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'No data to display',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow(
    double totalSpent,
    int transactionCount,
    List<CategoryBreakdownItem> categoryBreakdown,
  ) {
    final topCategory =
        categoryBreakdown.isNotEmpty ? categoryBreakdown.first : null;
    final avgTransaction =
        transactionCount > 0 ? totalSpent / transactionCount : 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                'Transactions',
                transactionCount.toString(),
                Icons.receipt_outlined,
              ),
              Container(
                width: 1,
                height: 40.h,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _buildStatItem(
                'Average',
                '$_currencySymbol${avgTransaction.toStringAsFixed(2)}',
                Icons.analytics_outlined,
              ),
            ],
          ),
          if (topCategory != null) ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.white.withValues(alpha: 0.2), height: 1),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.category_outlined,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top Category',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        Text(
                          topCategory.categoryName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '$_currencySymbol${topCategory.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.7),
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatBottomLabel(DateTime date) {
    switch (_selectedPeriod) {
      case TimePeriod.day:
        return DateFormat('E').format(date); // Mon, Tue, etc.
      case TimePeriod.week:
        return DateFormat('d').format(date); // Day of month
      case TimePeriod.month:
        return DateFormat('d').format(date); // Day of month
    }
  }

  String _getPeriodTitle() {
    switch (_selectedPeriod) {
      case TimePeriod.day:
        return 'Daily Expenditure';
      case TimePeriod.week:
        return 'Weekly Expenditure';
      case TimePeriod.month:
        return 'Monthly Expenditure';
    }
  }

  String _formatDateRange(DateTime start, DateTime end) {
    if (start.year == end.year && start.month == end.month) {
      return DateFormat('MMMM yyyy').format(start);
    }
    return '${DateFormat('MMM d').format(start)} - ${DateFormat('MMM d, yyyy').format(end)}';
  }
}
