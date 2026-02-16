import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
class MonthlyTrendsDetailScreen extends StatelessWidget {
  const MonthlyTrendsDetailScreen({super.key});

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
          'Monthly Trends',
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
                _buildFullBarChart(state),
                SizedBox(height: 24.h),
                _buildTotalSummary(state),
                SizedBox(height: 24.h),
                _buildMonthlyDataTable(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFullBarChart(StatisticsLoaded state) {
    final monthlyPoints = state.monthlyTrends?.months.toList() ?? [];

    if (monthlyPoints.isEmpty) {
      return Container(
        height: 350.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, color: Colors.white60, size: 48.r),
              SizedBox(height: 12.h),
              Text(
                'No monthly trend data available',
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    final maxY = monthlyPoints.fold<double>(0.0, (max, point) {
      final bigger = point.income > point.expenses ? point.income : point.expenses;
      return bigger > max ? bigger : max;
    });
    final roundedMaxY = maxY > 0 ? (maxY * 1.2).ceilToDouble() : 10000.0;

    return Container(
      height: 350.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income vs Expenses',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: roundedMaxY,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final label = rodIndex == 0 ? 'Income' : 'Expenses';
                      return BarTooltipItem(
                        '$label\n${CurrencySymbols.formatAmount(rod.toY)}',
                        TextStyle(color: Colors.white, fontSize: 12.sp),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= monthlyPoints.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          monthlyPoints[index].monthLabel,
                          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
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
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: roundedMaxY > 0 ? roundedMaxY / 5 : 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withValues(alpha: 0.1),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  monthlyPoints.length,
                  (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: monthlyPoints[index].income,
                        color: Colors.green[300],
                        width: 14.w,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      BarChartRodData(
                        toY: monthlyPoints[index].expenses,
                        color: Colors.red[300],
                        width: 14.w,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend('Income', Colors.green[300]!),
              SizedBox(width: 24.w),
              _buildLegend('Expenses', Colors.red[300]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(label, style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 12.sp)),
      ],
    );
  }

  Widget _buildTotalSummary(StatisticsLoaded state) {
    final monthlyPoints = state.monthlyTrends?.months.toList() ?? [];
    final totalIncome = monthlyPoints.fold<double>(0.0, (sum, p) => sum + p.income);
    final totalExpenses = monthlyPoints.fold<double>(0.0, (sum, p) => sum + p.expenses);
    final netSavings = totalIncome - totalExpenses;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Income',
            CurrencySymbols.formatAmount(totalIncome),
            Colors.green[300]!,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSummaryCard(
            'Total Expenses',
            CurrencySymbols.formatAmount(totalExpenses),
            Colors.red[300]!,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSummaryCard(
            'Net Savings',
            CurrencySymbols.formatAmount(netSavings),
            netSavings >= 0 ? Colors.green[300]! : Colors.red[300]!,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(label, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
        ],
      ),
    );
  }

  Widget _buildMonthlyDataTable(StatisticsLoaded state) {
    final monthlyPoints = state.monthlyTrends?.months.toList() ?? [];

    if (monthlyPoints.isEmpty) return const SizedBox.shrink();

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
            'Monthly Breakdown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          // Header row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Month', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontWeight: FontWeight.w600)),
              ),
              Expanded(
                child: Text('Income', style: TextStyle(color: Colors.green[300], fontSize: 12.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.right),
              ),
              Expanded(
                child: Text('Expenses', style: TextStyle(color: Colors.red[300], fontSize: 12.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.right),
              ),
              Expanded(
                child: Text('Net', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.right),
              ),
            ],
          ),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 20.h),
          ...monthlyPoints.map((point) {
            final net = point.income - point.expenses;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(point.monthLabel, style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 13.sp)),
                  ),
                  Expanded(
                    child: Text(
                      '${CurrencySymbols.currentSymbol}${point.income.toStringAsFixed(0)}',
                      style: TextStyle(color: Colors.green[300], fontSize: 13.sp),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${CurrencySymbols.currentSymbol}${point.expenses.toStringAsFixed(0)}',
                      style: TextStyle(color: Colors.red[300], fontSize: 13.sp),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${CurrencySymbols.currentSymbol}${net.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: net >= 0 ? Colors.green[300] : Colors.red[300],
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
