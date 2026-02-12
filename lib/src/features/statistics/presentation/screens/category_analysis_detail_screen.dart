import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/core/utils/currency_formatter.dart';

String _friendlyCategoryName(String raw) => switch (raw.toLowerCase()) {
  'transfer' => 'Transfers',
  'deposit' => 'Deposits',
  'withdrawal' => 'Withdrawals',
  'fee' => 'Service Fees',
  'reversal' => 'Reversals',
  'payment' => 'Payments',
  'tag-pay' || 'tagpay' => 'TagPay',
  'invoice' => 'Invoices',
  'giftcards' || 'gift-cards' => 'Gift Cards',
  'airtime' => 'Airtime & Bills',
  'investment' || 'investments' => 'Investments',
  'core-payments' => 'Transfers',
  'banking' => 'Banking',
  'utility-payments' => 'Bills & Utilities',
  _ => raw.replaceAll('-', ' ').replaceAll('_', ' ').split(' ').map((w) =>
      w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '').join(' '),
};

class CategoryAnalysisDetailScreen extends StatelessWidget {
  final String analysisType;

  const CategoryAnalysisDetailScreen({
    super.key,
    required this.analysisType,
  });

  bool get isIncome => analysisType == 'income';

  static const List<Color> categoryColors = [
    Color(0xFF4A90E2),
    Color(0xFFE2844A),
    Color(0xFF4AE28D),
    Color(0xFFE24A67),
    Color(0xFF9B4AE2),
    Color(0xFFE2E24A),
    Color(0xFF4AE2D4),
    Color(0xFFE24ABB),
  ];

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
          isIncome ? 'Income Analysis' : 'Expense Analysis',
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
                _buildPieChart(state),
                SizedBox(height: 24.h),
                _buildCategoryList(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPieChart(StatisticsLoaded state) {
    final catAnalytics = state.categoryAnalytics;
    final categories = isIncome
        ? (catAnalytics?.incomeCategories ?? [])
        : (catAnalytics?.expenseCategories ?? []);
    final total = isIncome
        ? (catAnalytics?.totalIncome ?? 0.0)
        : (catAnalytics?.totalExpenses ?? 0.0);

    if (categories.isEmpty) {
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
              Icon(Icons.pie_chart_outline, color: Colors.white60, size: 48.r),
              SizedBox(height: 12.h),
              Text(
                'No ${isIncome ? 'income' : 'expense'} data available',
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isIncome ? 'Income Breakdown' : 'Expense Breakdown',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(total),
                style: TextStyle(
                  color: isIncome ? Colors.green[300] : Colors.red[300],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 50,
                sections: _generateSections(categories, total),
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections(
    List<accounts_pb.CategoryBreakdownItem> categories,
    double total,
  ) {
    if (total == 0) return [];

    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final cat = entry.value;
      final percentage = cat.percentage > 0
          ? cat.percentage.roundToDouble()
          : (cat.amount / total * 100).roundToDouble();
      return PieChartSectionData(
        color: categoryColors[index % categoryColors.length],
        value: cat.amount,
        title: '$percentage%',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildCategoryList(StatisticsLoaded state) {
    final catAnalytics = state.categoryAnalytics;
    final categories = isIncome
        ? (catAnalytics?.incomeCategories ?? [])
        : (catAnalytics?.expenseCategories ?? []);
    final total = isIncome
        ? (catAnalytics?.totalIncome ?? 0.0)
        : (catAnalytics?.totalExpenses ?? 0.0);

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
          Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final cat = entry.value;
            final color = categoryColors[index % categoryColors.length];
            final percentage = (cat.amount / safeTotal * 100);

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 14.w,
                            height: 14.w,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            _friendlyCategoryName(cat.categoryName),
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${percentage.toStringAsFixed(1)}%',
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Text(
                        CurrencySymbols.formatAmount(cat.amount),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: (cat.amount / safeTotal).clamp(0.0, 1.0),
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6.h,
                    borderRadius: BorderRadius.circular(3.r),
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
