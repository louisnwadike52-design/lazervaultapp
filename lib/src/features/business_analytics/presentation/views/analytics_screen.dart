import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/business_analytics_cubit.dart';
import '../cubit/business_analytics_state.dart';
import '../widgets/analytics_period_selector.dart';
import '../widgets/analytics_summary_cards.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/monthly_trend_line_chart.dart';
import '../widgets/revenue_expense_bar_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<BusinessAnalyticsCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Business Analytics',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF3B82F6),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 13.sp),
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Revenue'),
            Tab(text: 'Expenses'),
          ],
        ),
      ),
      body: BlocBuilder<BusinessAnalyticsCubit, BusinessAnalyticsState>(
        builder: (context, state) {
          return switch (state) {
            BusinessAnalyticsInitial() => _buildInitialState(),
            BusinessAnalyticsLoading() => _buildLoadingState(),
            BusinessAnalyticsLoaded() => _buildLoadedState(state),
            BusinessAnalyticsError() => _buildErrorState(state),
          };
        },
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
    );
  }

  Widget _buildLoadedState(BusinessAnalyticsLoaded state) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildOverviewTab(state),
        _buildRevenueTab(state),
        _buildExpensesTab(state),
      ],
    );
  }

  Widget _buildOverviewTab(BusinessAnalyticsLoaded state) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          AnalyticsPeriodSelector(
            selectedPeriod: state.selectedPeriod,
            onPeriodChanged: (period) {
              context.read<BusinessAnalyticsCubit>().changePeriod(period);
            },
          ),
          SizedBox(height: 16.h),
          AnalyticsSummaryCards(analytics: state.financialAnalytics),
          SizedBox(height: 20.h),
          RevenueExpenseBarChart(months: state.monthlyTrends.months),
          SizedBox(height: 20.h),
          CategoryPieChart(categoryAnalytics: state.categoryAnalytics),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildRevenueTab(BusinessAnalyticsLoaded state) {
    final financial = state.financialAnalytics;
    final incomeCategories = state.categoryAnalytics.incomeCategories;

    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          AnalyticsPeriodSelector(
            selectedPeriod: state.selectedPeriod,
            onPeriodChanged: (period) {
              context.read<BusinessAnalyticsCubit>().changePeriod(period);
            },
          ),
          SizedBox(height: 16.h),
          _buildRevenueHeader(financial),
          SizedBox(height: 20.h),
          RevenueExpenseBarChart(months: state.monthlyTrends.months),
          SizedBox(height: 20.h),
          if (incomeCategories.isNotEmpty) ...[
            _buildCategoryList('Income Sources', incomeCategories,
                const Color(0xFF10B981)),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }

  Widget _buildExpensesTab(BusinessAnalyticsLoaded state) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          AnalyticsPeriodSelector(
            selectedPeriod: state.selectedPeriod,
            onPeriodChanged: (period) {
              context.read<BusinessAnalyticsCubit>().changePeriod(period);
            },
          ),
          SizedBox(height: 16.h),
          _buildExpenseHeader(state.financialAnalytics),
          SizedBox(height: 20.h),
          MonthlyTrendLineChart(timeSeries: state.expenseTimeSeries),
          SizedBox(height: 20.h),
          CategoryPieChart(categoryAnalytics: state.categoryAnalytics),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildRevenueHeader(dynamic financial) {
    final current = financial.currentPeriod;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Revenue',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'NGN ${_formatAmount(current.totalIncome * 100)}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF10B981),
            ),
          ),
          if (financial.incomeChangePercent != 0) ...[
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  financial.incomeChangePercent >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 16.sp,
                  color: financial.incomeChangePercent >= 0
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                ),
                SizedBox(width: 4.w),
                Text(
                  '${financial.incomeChangePercent.abs().toStringAsFixed(1)}% from previous period',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpenseHeader(dynamic financial) {
    final current = financial.currentPeriod;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Expenses',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'NGN ${_formatAmount(current.totalExpenses * 100)}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFEF4444),
            ),
          ),
          if (financial.expenseChangePercent != 0) ...[
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  financial.expenseChangePercent >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 16.sp,
                  color: financial.expenseChangePercent >= 0
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
                ),
                SizedBox(width: 4.w),
                Text(
                  '${financial.expenseChangePercent.abs().toStringAsFixed(1)}% from previous period',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryList(
      String title, List<dynamic> categories, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          ...categories.map((cat) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatCategoryName(cat.categoryName),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: cat.percentage / 100,
                            backgroundColor: const Color(0xFF2D2D2D),
                            valueColor: AlwaysStoppedAnimation(color),
                            minHeight: 4.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'NGN ${_formatAmount(cat.amount)}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  Widget _buildErrorState(BusinessAnalyticsError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load analytics',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.message,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                context.read<BusinessAnalyticsCubit>().refresh();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double amountInKobo) {
    final amount = amountInKobo / 100;
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toStringAsFixed(0);
  }

  String _formatCategoryName(String name) {
    return name
        .replaceAll('_', ' ')
        .split(' ')
        .map(
            (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
        .join(' ');
  }
}
