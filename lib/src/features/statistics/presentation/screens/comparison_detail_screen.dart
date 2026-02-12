import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

class ComparisonDetailScreen extends StatelessWidget {
  const ComparisonDetailScreen({super.key});

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
          'Period Comparison',
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
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              children: [
                _buildPeriodHeader(state),
                SizedBox(height: 24.h),
                _buildComparisonCard(state),
                SizedBox(height: 24.h),
                _buildDetailedBreakdown(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPeriodHeader(StatisticsLoaded state) {
    final analytics = state.financialAnalytics;
    final periodLabel = analytics != null && analytics.periodLabel.isNotEmpty
        ? analytics.periodLabel
        : 'Month-over-Month';

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundColor,
            const Color.fromARGB(255, 95, 20, 225),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            '$periodLabel Comparison',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Compare your financial performance across periods',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(StatisticsLoaded state) {
    final analytics = state.financialAnalytics;
    double currentIncome = 0.0;
    double previousIncome = 0.0;
    double currentExpenses = 0.0;
    double previousExpenses = 0.0;
    int currentTxnCount = 0;
    int previousTxnCount = 0;

    if (analytics != null) {
      if (analytics.hasCurrentPeriod()) {
        currentIncome = analytics.currentPeriod.totalIncome;
        currentExpenses = analytics.currentPeriod.totalExpenses;
        currentTxnCount = analytics.currentPeriod.transactionCount;
      }
      if (analytics.hasPreviousPeriod()) {
        previousIncome = analytics.previousPeriod.totalIncome;
        previousExpenses = analytics.previousPeriod.totalExpenses;
        previousTxnCount = analytics.previousPeriod.transactionCount;
      }
    }

    final currentSavings = currentIncome - currentExpenses;
    final previousSavings = previousIncome - previousExpenses;
    final currentNet = currentIncome - currentExpenses;
    final previousNet = previousIncome - previousExpenses;

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
            'Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildComparisonRow('Income', currentIncome, previousIncome, Icons.trending_up, true),
          _buildComparisonRow('Expenses', currentExpenses, previousExpenses, Icons.trending_down, false),
          _buildComparisonRow('Savings', currentSavings, previousSavings, Icons.savings, true),
          _buildComparisonRow('Net', currentNet, previousNet, Icons.account_balance, true),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
          _buildComparisonRowInt('Transactions', currentTxnCount, previousTxnCount, Icons.receipt_long),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    String label,
    double current,
    double previous,
    IconData icon,
    bool isPositive,
  ) {
    final change = previous != 0 ? ((current - previous) / previous * 100) : 0.0;
    final isIncreased = current > previous;
    final bothZero = current == 0 && previous == 0;
    final changeText = bothZero ? '--' : '${isIncreased ? '+' : ''}${change.toStringAsFixed(1)}%';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: (bothZero
                      ? Colors.grey
                      : (isIncreased == isPositive ? Colors.green : Colors.red))[300]!
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: (bothZero
                  ? Colors.grey
                  : (isIncreased == isPositive ? Colors.green : Colors.red))[300],
              size: 18.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'Current: ${CurrencySymbols.formatAmount(current)}',
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Previous: ${CurrencySymbols.formatAmount(previous)}',
                      style: TextStyle(color: Colors.white60, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: (bothZero
                      ? Colors.grey
                      : (isIncreased == isPositive ? Colors.green : Colors.red))[300]!
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              changeText,
              style: TextStyle(
                color: bothZero
                    ? Colors.white60
                    : (isIncreased == isPositive ? Colors.green : Colors.red)[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRowInt(
    String label,
    int current,
    int previous,
    IconData icon,
  ) {
    final change = previous != 0 ? ((current - previous) / previous * 100) : 0.0;
    final isIncreased = current > previous;
    final bothZero = current == 0 && previous == 0;
    final changeText = bothZero ? '--' : '${isIncreased ? '+' : ''}${change.toStringAsFixed(1)}%';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.blue[300]!.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: Colors.blue[300], size: 18.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text(
                  'Current: $current  |  Previous: $previous',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: (bothZero ? Colors.grey : Colors.blue)[300]!.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              changeText,
              style: TextStyle(
                color: bothZero ? Colors.white60 : Colors.blue[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdown(StatisticsLoaded state) {
    final analytics = state.financialAnalytics;
    if (analytics == null || !analytics.hasCurrentPeriod()) {
      return Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            'No detailed data for this period',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          ),
        ),
      );
    }

    final currentIncome = analytics.currentPeriod.totalIncome;
    final currentExpenses = analytics.currentPeriod.totalExpenses;
    final savingsRate = currentIncome > 0
        ? ((currentIncome - currentExpenses) / currentIncome * 100)
        : 0.0;

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
            'Key Metrics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildMetricRow('Savings Rate', '${savingsRate.toStringAsFixed(1)}%'),
          _buildMetricRow('Income Change', '${analytics.incomeChangePercent >= 0 ? '+' : ''}${analytics.incomeChangePercent.toStringAsFixed(1)}%'),
          _buildMetricRow('Expense Change', '${analytics.expenseChangePercent >= 0 ? '+' : ''}${analytics.expenseChangePercent.toStringAsFixed(1)}%'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 14.sp)),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
