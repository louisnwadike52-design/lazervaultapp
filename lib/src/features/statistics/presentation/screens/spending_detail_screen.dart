import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

class SpendingDetailScreen extends StatelessWidget {
  const SpendingDetailScreen({super.key});

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
