import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

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

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final List<String> timePeriods = ["Week", "Month", "Quarter", "Year"];
  String selectedPeriod = "Month";

  final List<Color> categoryColors = [
    const Color(0xFF4A90E2),
    const Color(0xFFE2844A),
    const Color(0xFF4AE28D),
    const Color(0xFFE24A67),
    const Color(0xFF9B4AE2),
    const Color(0xFFE2E24A),
  ];

  bool showIncome = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatisticsCubit>().loadStatistics();
      context.read<OpenBankingCubit>().fetchCreditScore(userId: '');
      context.read<OpenBankingCubit>().fetchLinkedAccounts(userId: '', accessToken: '');
      context.read<BudgetCubit>().loadBudgetProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatisticsCubit, StatisticsState>(
      listener: (context, state) {
        if (state is StatisticsLoaded) {
          final cubitPeriod = state.currentPeriod;
          final capitalized = cubitPeriod.isNotEmpty
              ? cubitPeriod[0].toUpperCase() + cubitPeriod.substring(1)
              : selectedPeriod;
          if (capitalized != selectedPeriod) {
            setState(() => selectedPeriod = capitalized);
          }
        }

        if (state is StatisticsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  context.read<StatisticsCubit>().refresh();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is StatisticsLoading) {
          return Container(
            color: AppColors.secondaryBackgroundColor,
            child: _buildLoadingShimmer(),
          );
        }

        return Container(
          color: const Color(0xFF0A0A0A),
          child: RefreshIndicator(
            onRefresh: () => context.read<StatisticsCubit>().refresh(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: 16.h),
                  _buildQuickStats(state),
                  SizedBox(height: 16.h),
                  _buildFeatureGrid(state),
                  SizedBox(height: 16.h),
                  _buildPeriodSelector(),
                  SizedBox(height: 16.h),
                  _buildSpendingChart(state),
                  SizedBox(height: 16.h),
                  _buildMonthlyTrendChart(state),
                  SizedBox(height: 16.h),
                  _buildBudgetSection(),
                  SizedBox(height: 16.h),
                  _buildToggleSection(),
                  showIncome ? _buildIncomeAnalysis(state) : _buildExpenseAnalysis(state),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Budgeting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Smart budgeting powered by AI',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            _buildAccountSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSelector() {
    final accountManager = serviceLocator<AccountManager>();
    final accountCubit = context.read<AccountCardsSummaryCubit>();
    final accountState = accountCubit.state;

    List<AccountSummaryEntity> accounts = [];
    if (accountState is AccountCardsSummaryLoaded) {
      accounts = accountState.accountSummaries;
    } else if (accountState is AccountBalanceUpdated) {
      accounts = accountState.accountSummaries;
    }

    if (accounts.isEmpty) {
      return const SizedBox.shrink();
    }

    final activeId = accountManager.activeAccountId;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: activeId != null && accounts.any((a) => a.id == activeId)
              ? activeId
              : accounts.first.id,
          dropdownColor: const Color(0xFF1F1F1F),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 20.r),
          isDense: true,
          style: TextStyle(color: Colors.white, fontSize: 13.sp),
          items: accounts.map((account) {
            return DropdownMenuItem<String>(
              value: account.id,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${account.accountType} •••• ${account.accountNumberLast4}',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      account.currency,
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newAccountId) {
            if (newAccountId != null && newAccountId != activeId) {
              accountManager.setActiveAccount(newAccountId);
              context.read<StatisticsCubit>().refresh();
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuickStats(StatisticsState state) {
    double totalSpending = 0.0;
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    double savingsRate = 0.0;

    if (state is StatisticsLoaded && state.financialAnalytics != null) {
      final analytics = state.financialAnalytics!;
      if (analytics.hasCurrentPeriod()) {
        totalIncome = analytics.currentPeriod.totalIncome;
        totalExpenses = analytics.currentPeriod.totalExpenses;
        totalSpending = totalExpenses;
        if (totalIncome > 0) {
          savingsRate = ((totalIncome - totalExpenses) / totalIncome * 100);
        }
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Financial Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  selectedPeriod,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _QuickStatCard(
                  label: 'Income',
                  value: CurrencySymbols.formatAmount(totalIncome),
                  icon: Icons.arrow_downward,
                  color: Colors.green[300]!,
                  trend: '+12%',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickStatCard(
                  label: 'Expenses',
                  value: CurrencySymbols.formatAmount(totalExpenses),
                  icon: Icons.arrow_upward,
                  color: Colors.red[300]!,
                  trend: '-5%',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickStatCard(
                  label: 'Savings',
                  value: '${savingsRate.toStringAsFixed(0)}%',
                  icon: Icons.savings,
                  color: Colors.amber[300]!,
                  trend: '+8%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(StatisticsState state) {
    final features = [
      _FeatureItem(
        title: 'Budgets',
        description: 'Manage your budgets',
        icon: Icons.account_balance_wallet,
        color: const Color(0xFF3B82F6),
        route: AppRoutes.budgetList,
      ),
      _FeatureItem(
        title: 'AI Insights',
        description: 'Smart recommendations',
        icon: Icons.auto_awesome,
        color: const Color(0xFF8B5CF6),
        route: AppRoutes.budgetAIInsights,
      ),
      _FeatureItem(
        title: 'Goals',
        description: 'Track financial goals',
        icon: Icons.flag,
        color: const Color(0xFF10B981),
        route: AppRoutes.financialGoals,
      ),
      _FeatureItem(
        title: 'Bills',
        description: 'Recurring bills',
        icon: Icons.receipt_long,
        color: const Color(0xFFF59E0B),
        route: AppRoutes.recurringBills,
      ),
      _FeatureItem(
        title: 'Reminders',
        description: 'Budget alerts',
        icon: Icons.notifications_active,
        color: const Color(0xFFEF4444),
        route: AppRoutes.budgetReminders,
      ),
      _FeatureItem(
        title: 'Spending',
        description: 'Analyze spending',
        icon: Icons.pie_chart,
        color: const Color(0xFFEC4899),
        route: AppRoutes.statisticsSpendingDetail,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.5,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _FeatureCard(feature: features[index]);
      },
    );
  }

  Widget _buildBudgetSection() {
    return BlocBuilder<BudgetCubit, BudgetState>(
      buildWhen: (prev, curr) =>
          curr is BudgetProgressLoaded ||
          curr is BudgetInitial ||
          curr is BudgetLoading,
      builder: (context, state) {
        if (state is BudgetInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<BudgetCubit>().loadBudgetProgress();
          });
          return const SizedBox.shrink();
        }

        if (state is BudgetLoading) {
          return Container(
            margin: EdgeInsets.all(16.r),
            height: 180.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            ),
          );
        }

        if (state is BudgetProgressLoaded) {
          final progressData = state;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Budgets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.budgetList),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: const Color(0xFF3B82F6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 160.h,
                child: progressData.items.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: progressData.items.length.clamp(0, 5),
                        itemBuilder: (context, index) {
                          final item = progressData.items[index];
                          return _BudgetPreviewCard(
                            name: item.budgetName.isNotEmpty ? item.budgetName : 'Budget ${index + 1}',
                            spent: item.spentAmount,
                            budget: item.budgetAmount,
                            percentage: item.percentageUsed,
                            onTap: () => Get.toNamed(AppRoutes.budgetList),
                          );
                        },
                      )
                    : _EmptyBudgetsCard(onTap: () => Get.toNamed(AppRoutes.createBudget)),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timePeriods.length,
        itemBuilder: (context, index) {
          final isSelected = timePeriods[index] == selectedPeriod;
          return GestureDetector(
            onTap: () {
              setState(() => selectedPeriod = timePeriods[index]);
              context.read<StatisticsCubit>().changePeriod(
                    timePeriods[index].toLowerCase(),
                  );
            },
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6C5CE7)
                    : const Color(0xFF2D2D3F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              alignment: Alignment.center,
              child: Text(
                timePeriods[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpendingChart(StatisticsState state) {
    List<FlSpot> spots = [];

    if (state is StatisticsLoaded && state.expenseTimeSeries != null) {
      final dataPoints = state.expenseTimeSeries!.dataPoints;
      if (dataPoints.isNotEmpty) {
        for (int i = 0; i < dataPoints.length; i++) {
          spots.add(FlSpot(i.toDouble(), dataPoints[i].amount));
        }
      }
    }

    if (spots.isEmpty) {
      return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.statisticsSpendingDetail),
        child: Container(
          height: 200.h,
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart, color: Colors.white60, size: 40.r),
                SizedBox(height: 8.h),
                Text(
                  'No expense data for this period',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.statisticsSpendingDetail),
      child: Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spending Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See Details',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 140.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C5CE7), Color(0xFF8E5CE7)],
                      ),
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                            const Color(0xFF8E5CE7).withValues(alpha: 0.0),
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
      ),
    );
  }

  Widget _buildMonthlyTrendChart(StatisticsState state) {
    List<accounts_pb.MonthlyDataPoint> monthlyPoints = [];

    if (state is StatisticsLoaded && state.monthlyTrends != null) {
      monthlyPoints = state.monthlyTrends!.months.toList();
    }

    if (monthlyPoints.isEmpty) {
      return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.statisticsMonthlyTrends),
        child: Container(
          height: 280.h,
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, color: Colors.white60, size: 40.r),
                SizedBox(height: 8.h),
                Text(
                  'No monthly trend data available',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final maxY = monthlyPoints.fold<double>(0.0, (max, point) {
      final bigger = point.income > point.expenses ? point.income : point.expenses;
      return bigger > max ? bigger : max;
    });
    final roundedMaxY = maxY > 0 ? (maxY * 1.2).ceilToDouble() : 10000.0;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.statisticsMonthlyTrends),
      child: Container(
        height: 300.h,
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Trends',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: roundedMaxY,
                  barTouchData: BarTouchData(enabled: false),
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
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${CurrencySymbols.currentSymbol}${value.toInt()}',
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: roundedMaxY > 0 ? roundedMaxY / 5 : 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withValues(alpha: 0.1),
                        strokeWidth: 1,
                      );
                    },
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
                          width: 12.w,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        BarChartRodData(
                          toY: monthlyPoints[index].expenses,
                          color: Colors.red[300],
                          width: 12.w,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChartLegend('Income', Colors.green[300]!),
                SizedBox(width: 24.w),
                _buildChartLegend('Expenses', Colors.red[300]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: showIncome
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: showIncome ? Colors.transparent : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Text(
                  'Income',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !showIncome
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: !showIncome ? Colors.transparent : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Text(
                  'Expenses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: !showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeAnalysis(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return const SizedBox.shrink();
    }

    final catAnalytics = state.categoryAnalytics;
    if (catAnalytics != null && catAnalytics.incomeCategories.isNotEmpty) {
      return _buildIncomeCategoryAnalytics(catAnalytics);
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Center(
        child: Text(
          'No income data available',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _buildIncomeCategoryAnalytics(accounts_pb.GetCategoryAnalyticsResponse catAnalytics) {
    final categories = catAnalytics.incomeCategories;
    final totalIncome = catAnalytics.totalIncome;

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.statisticsCategoryAnalysis,
        arguments: {'type': 'income'},
      ),
      child: Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Income Breakdown',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  CurrencySymbols.formatAmount(totalIncome),
                  style: TextStyle(
                    color: Colors.green[300],
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
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: _generateCategoryBreakdownSections(categories, totalIncome),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Column(
              children: categories.asMap().entries.map((entry) {
                final index = entry.key;
                final cat = entry.value;
                return _buildAnalyticsCategoryItem(
                  cat.categoryName,
                  cat.amount,
                  totalIncome,
                  categoryColors[index % categoryColors.length],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseAnalysis(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return const SizedBox.shrink();
    }

    final catAnalytics = state.categoryAnalytics;
    if (catAnalytics != null && catAnalytics.expenseCategories.isNotEmpty) {
      final categories = catAnalytics.expenseCategories;
      final totalExpenses = catAnalytics.totalExpenses;

      return GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.statisticsCategoryAnalysis,
          arguments: {'type': 'expense'},
        ),
        child: Container(
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expense Analysis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    CurrencySymbols.formatAmount(totalExpenses),
                    style: TextStyle(
                      color: Colors.red[300],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              if (categories.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: _generateCategoryBreakdownSections(categories, totalExpenses),
                    ),
                  ),
                ),
              SizedBox(height: 20.h),
              Column(
                children: categories.asMap().entries.map((entry) {
                  final index = entry.key;
                  final cat = entry.value;
                  return _buildAnalyticsCategoryItem(
                    cat.categoryName,
                    cat.amount,
                    totalExpenses,
                    categoryColors[index % categoryColors.length],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Center(
        child: Text(
          'No expense analysis data available',
          style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 14.sp),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateCategoryBreakdownSections(
    List<accounts_pb.CategoryBreakdownItem> categories,
    double total,
  ) {
    if (total == 0 || categories.isEmpty) return [];

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
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildAnalyticsCategoryItem(
    String categoryName,
    double amount,
    double total,
    Color color,
  ) {
    final safeTotal = total > 0 ? total : 1.0;
    final percentage = (amount / safeTotal * 100).toStringAsFixed(1);
    final displayName = _friendlyCategoryName(categoryName);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    displayName,
                    style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 14.sp),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '$percentage%',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                ],
              ),
              Text(
                CurrencySymbols.formatAmount(amount),
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
            value: (amount / safeTotal).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 280.h,
            margin: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.05),
                  Colors.white.withValues(alpha: 0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          ...[200.0, 280.0, 160.0, 50.0, 200.0, 180.0].map((h) => Container(
                height: h.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              )),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(feature.route),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: feature.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                feature.icon,
                color: feature.color,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              feature.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              feature.description,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  const _QuickStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          trend,
          style: TextStyle(
            color: color,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _BudgetPreviewCard extends StatelessWidget {
  final String name;
  final double spent;
  final double budget;
  final double percentage;
  final VoidCallback onTap;

  const _BudgetPreviewCard({
    required this.name,
    required this.spent,
    required this.budget,
    required this.percentage,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isOverBudget = percentage >= 90;
    final progressColor = isOverBudget
        ? const Color(0xFFEF4444)
        : percentage >= 70
            ? const Color(0xFFF59E0B)
            : const Color(0xFF10B981);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              CurrencySymbols.formatAmount(spent),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'of ${CurrencySymbols.formatAmount(budget)}',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: percentage.clamp(0, 100) / 100,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6.h,
              borderRadius: BorderRadius.circular(3.r),
            ),
            SizedBox(height: 8.h),
            Text(
              '${percentage.toStringAsFixed(0)}% used',
              style: TextStyle(
                color: progressColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyBudgetsCard extends StatelessWidget {
  final VoidCallback onTap;

  const _EmptyBudgetsCard({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: const Color(0xFF3B82F6),
              size: 32.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              'Create Budget',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Get Started',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  _FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}
