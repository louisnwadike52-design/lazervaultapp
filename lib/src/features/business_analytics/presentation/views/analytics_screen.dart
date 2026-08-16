import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import '../cubit/business_analytics_cubit.dart';
import '../cubit/business_analytics_state.dart';
import '../widgets/analytics_period_selector.dart';
import '../widgets/analytics_summary_cards.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/monthly_trend_line_chart.dart';
import '../widgets/revenue_expense_bar_chart.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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

    final accountManager = serviceLocator<AccountManager>();
    final cubit = context.read<BusinessAnalyticsCubit>();
    // Prefer the business account handed in by the dashboard so analytics is
    // scoped to THAT business's wallet ledger, not the user's global active
    // account (which may be personal, or null → the screen would otherwise sit
    // on the "select a business account" state). Falls back to the active
    // account when opened without an argument (e.g. a deep link), preserving the
    // previous behaviour.
    final args = Get.arguments;
    final accountId = args is AccountSummaryEntity
        ? args.id
        : (args is String && args.isNotEmpty
            ? args
            : accountManager.activeAccountId);
    if (accountId != null) {
      cubit.setAccountId(accountId);
      cubit.loadAnalytics();
    }
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
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new,
              color: InvoiceThemeColors.textWhite, size: 18),
        ),
        title: Text(
          'Business Analytics',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: InvoiceThemeColors.textWhite,
          ),
        ),
        centerTitle: true,
        actions: [
          ServiceVoiceButton(serviceName: 'analytics'),
          SizedBox(width: 8.w),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: MicroserviceChatIcon(
              serviceName: 'Analytics',
              sourceContext: 'statistics',
              chatAccentColor: InvoiceThemeColors.primaryPurple,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: Container(
            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple,
                borderRadius: BorderRadius.circular(12.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: InvoiceThemeColors.textGray400,
              labelStyle:
                  GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Revenue'),
                Tab(text: 'Expenses'),
              ],
            ),
          ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_rounded,
            size: 48.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            'Select a business account to view analytics',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: LazerVaultLoader.small(),
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
      color: InvoiceThemeColors.primaryPurpleLight,
      backgroundColor: InvoiceThemeColors.secondaryBackground,
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
    final incomeCategories = state.categoryAnalytics.incomeCategories;

    return RefreshIndicator(
      onRefresh: _refresh,
      color: InvoiceThemeColors.primaryPurpleLight,
      backgroundColor: InvoiceThemeColors.secondaryBackground,
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
          _buildSalesRevenueHeader(state),
          SizedBox(height: 20.h),
          RevenueExpenseBarChart(months: state.monthlyTrends.months),
          SizedBox(height: 20.h),
          if (incomeCategories.isNotEmpty) ...[
            _buildCategoryList('Wallet inflows', incomeCategories,
                const Color(0xFF10B981)),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }

  /// Revenue headline from the SALES ledger (GetSalesSummary via the business
  /// overview), not the wallet. Recorded sales show here as revenue + outstanding
  /// receivables without ever crediting the wallet balance.
  Widget _buildSalesRevenueHeader(BusinessAnalyticsLoaded state) {
    final cur = state.salesCurrency.isNotEmpty ? state.salesCurrency : 'NGN';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.point_of_sale_rounded,
                  size: 16.sp, color: InvoiceThemeColors.primaryPurpleLight),
              SizedBox(width: 6.w),
              Text(
                'Sales revenue',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: InvoiceThemeColors.textGray400,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '$cur ${_formatAmount(state.salesRevenue.toDouble())}',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: InvoiceThemeColors.primaryPurpleLight,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'From recorded sales · does not include wallet transfers',
            style: GoogleFonts.inter(
                fontSize: 11.sp, color: InvoiceThemeColors.textGray500),
          ),
          if (state.salesReceivables > 0) ...[
            SizedBox(height: 14.h),
            Divider(color: InvoiceThemeColors.borderColor, height: 1),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule_rounded,
                        size: 15.sp, color: const Color(0xFFFB923C)),
                    SizedBox(width: 6.w),
                    Text(
                      'Outstanding receivables',
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp,
                          color: InvoiceThemeColors.textGray400),
                    ),
                  ],
                ),
                Text(
                  '$cur ${_formatAmount(state.salesReceivables.toDouble())}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFB923C),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpensesTab(BusinessAnalyticsLoaded state) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: InvoiceThemeColors.primaryPurpleLight,
      backgroundColor: InvoiceThemeColors.secondaryBackground,
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

  Widget _buildExpenseHeader(dynamic financial) {
    final current = financial.currentPeriod;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16.r),
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
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: InvoiceThemeColors.borderColor),
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
                    // cat.amount is in MAJOR units (transactions.amount); _formatAmount
                    // expects minor units (it divides by 100), so scale up — matches
                    // the expenses header (line ~362) which does the same *100.
                    'NGN ${_formatAmount(cat.amount * 100)}',
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
                backgroundColor: InvoiceThemeColors.primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Retry',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
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
