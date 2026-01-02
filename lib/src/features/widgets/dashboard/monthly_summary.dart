import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../statistics/cubit/statistics_cubit.dart';
import '../../statistics/cubit/statistics_state.dart';
import '../../../generated/statistics.pb.dart';

enum TimePeriod { day, week, month }

class MonthlySummary extends StatefulWidget {
  const MonthlySummary({super.key});

  @override
  State<MonthlySummary> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
  TimePeriod _selectedPeriod = TimePeriod.month;

  @override
  void initState() {
    super.initState();
    _loadDataForPeriod(_selectedPeriod);
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

    context.read<StatisticsCubit>().loadAnalytics(
          startDate: startDate,
          endDate: endDate,
        );
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
            color: Color.fromARGB(255, 57, 2, 111).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading expenditure data...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.7),
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
            color: Color.fromARGB(255, 57, 2, 111).withOpacity(0.3),
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
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => _loadDataForPeriod(_selectedPeriod),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
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
            color: Color.fromARGB(255, 57, 2, 111).withOpacity(0.3),
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
            color: Colors.white.withOpacity(0.5),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No expenditure data available',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(StatisticsLoaded state) {
    final analytics = state.analytics;

    // If no analytics data, show empty state
    if (analytics == null) {
      return _buildEmptyState();
    }

    final dailyTrend = analytics.dailyTrend;
    final totalSpent = analytics.totalSpent;
    final transactionCount = analytics.transactionCount;

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
            color: Color.fromARGB(255, 57, 2, 111).withOpacity(0.3),
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
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '£${totalSpent.toStringAsFixed(2)}',
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

          // Chart Section
          Container(
            height: 240.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: dailyTrend.isEmpty
                ? _buildNoDataChart()
                : _buildExpenditureChart(dailyTrend),
          ),
          SizedBox(height: 24.h),

          // Statistics Section
          _buildStatisticsRow(totalSpent, transactionCount, state.categoryBreakdown),
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
            color: Color.fromARGB(255, 57, 2, 111).withOpacity(0.3),
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
            color: Colors.white.withOpacity(0.3),
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
              color: Colors.white.withOpacity(0.6),
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
        color: Colors.white.withOpacity(0.1),
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
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenditureChart(List<DailySpending> dailyTrend) {
    final spots = _createSpotsFromDailyTrend(dailyTrend);

    if (spots.isEmpty) {
      return _buildNoDataChart();
    }

    final maxAmount = _getMaxAmountFromTrend(dailyTrend);

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxAmount > 0 ? maxAmount / 4 : 100,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: _getBottomInterval(dailyTrend.length),
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= dailyTrend.length) {
                  return const Text('');
                }
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    _formatBottomLabel(dailyTrend[index].date.toDateTime()),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: maxAmount > 0 ? maxAmount / 4 : 100,
              reservedSize: 46,
              getTitlesWidget: (value, meta) {
                return Text(
                  '£${value.toInt()}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (dailyTrend.length - 1).toDouble(),
        minY: 0,
        maxY: maxAmount + (maxAmount * 0.2),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.8),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Color.fromARGB(255, 78, 3, 208),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart,
            color: Colors.white.withOpacity(0.3),
            size: 48.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'No data to display',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow(
    double totalSpent,
    int transactionCount,
    List<CategorySpending> categoryBreakdown,
  ) {
    final topCategory = categoryBreakdown.isNotEmpty ? categoryBreakdown.first : null;
    final avgTransaction = transactionCount > 0 ? totalSpent / transactionCount : 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
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
                color: Colors.white.withOpacity(0.2),
              ),
              _buildStatItem(
                'Average',
                '£${avgTransaction.toStringAsFixed(2)}',
                Icons.analytics_outlined,
              ),
            ],
          ),
          if (topCategory != null) ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.white.withOpacity(0.2), height: 1),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.category_outlined,
                      color: Colors.white.withOpacity(0.7),
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
                            color: Colors.white.withOpacity(0.6),
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
                  '£${topCategory.amount.toStringAsFixed(2)}',
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
            color: Colors.white.withOpacity(0.7),
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
                  color: Colors.white.withOpacity(0.6),
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

  List<FlSpot> _createSpotsFromDailyTrend(List<DailySpending> dailyTrend) {
    return List.generate(dailyTrend.length, (index) {
      return FlSpot(index.toDouble(), dailyTrend[index].amount);
    });
  }

  double _getMaxAmountFromTrend(List<DailySpending> dailyTrend) {
    if (dailyTrend.isEmpty) return 0;
    return dailyTrend
        .map((e) => e.amount)
        .reduce((max, value) => max > value ? max : value);
  }

  double _getBottomInterval(int dataLength) {
    if (dataLength <= 7) return 1;
    if (dataLength <= 14) return 2;
    if (dataLength <= 30) return 5;
    return 7;
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
