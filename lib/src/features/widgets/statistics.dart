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
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/open_banking_status_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/financial_health_score_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/cash_flow_insights_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/failed_transactions_card.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Maps category names from backend to display-friendly names.
/// The backend now returns meaningful names (e.g., "P2P Transfers", "Gift Cards")
/// but this function handles legacy/fallback values and raw service names.
String _friendlyCategoryName(String raw) => switch (raw.toLowerCase()) {
  // Backend display names (pass through as-is since they're already friendly)
  'p2p transfers' || 'bank transfers' || 'international transfers' ||
  'gift cards' || 'bills & utilities' ||
  'service fees' || 'tagpay' || 'invoices' || 'investments' ||
  'payroll' || 'crowdfunding' || 'deposits' || 'withdrawals' ||
  'reversals' || 'transfers' || 'banking' || 'payments' ||
  'food & drinks' || 'shopping' || 'transportation' || 'entertainment' => raw,

  // PiggyVault (Lock Funds) — savings product
  'piggyvault' || 'piggy vault' || 'lock funds' || 'lock_funds' => 'PiggyVault',
  'autosave' => 'AutoSave',
  'savings & products' => 'Savings & Products',

  // Legacy raw category values (from older transactions)
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

  // Raw service names (fallback if somehow still passed through)
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

  // Fallback: capitalize and clean up
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
  bool _isSyncing = false;
  String _userId = '';
  String _accessToken = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatisticsCubit>().loadStatistics();
      context.read<BudgetCubit>().loadBudgetProgress();
      _initOpenBanking();
    });
  }

  Future<void> _initOpenBanking() async {
    final secureStorage = serviceLocator<SecureStorageService>();
    final userId = await secureStorage.getUserId() ?? '';
    final accessToken = await secureStorage.getAccessToken() ?? '';
    if (userId.isNotEmpty && mounted) {
      setState(() {
        _userId = userId;
        _accessToken = accessToken;
      });
      context.read<OpenBankingCubit>().fetchCreditScore(userId: userId);
      context.read<OpenBankingCubit>().fetchLinkedAccounts(userId: userId, accessToken: accessToken);
    }
  }

  Future<void> _syncLinkedAccounts(List<LinkedBankAccount> accounts) async {
    if (_isSyncing || _userId.isEmpty || accounts.isEmpty) return;
    setState(() => _isSyncing = true);
    final cubit = context.read<OpenBankingCubit>();
    try {
      for (final account in accounts) {
        try {
          await cubit.refreshBalance(
            accountId: account.id,
            userId: _userId,
            accessToken: _accessToken,
          );
        } catch (_) {
          // Continue syncing remaining accounts even if one fails
        }
      }
      // Re-fetch to get updated data
      if (mounted) {
        await cubit.fetchLinkedAccounts(userId: _userId, accessToken: _accessToken);
      }
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
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
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: 16.h),
                  _buildQuickStats(state),
                  SizedBox(height: 12.h),
                  _buildPerformanceAlert(state),
                  SizedBox(height: 16.h),
                  _buildFinancialHealthScore(state),
                  SizedBox(height: 12.h),
                  _buildCashFlowInsights(state),
                  SizedBox(height: 16.h),
                  _buildFeatureGrid(state),
                  SizedBox(height: 16.h),
                  _buildOpenBankingSection(),
                  SizedBox(height: 16.h),
                  _buildPeriodSelector(),
                  SizedBox(height: 16.h),
                  _buildSpendingChart(state),
                  SizedBox(height: 16.h),
                  _buildMonthlyTrendChart(state),
                  SizedBox(height: 16.h),
                  _buildBudgetSection(),
                  SizedBox(height: 16.h),
                  _buildFailedTransactionsSection(state),
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF10B981).withValues(alpha: 0.08),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.insights,
                      color: const Color(0xFF10B981),
                      size: 28.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'AI Budgeting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Smart budgeting powered by AI',
                  style: TextStyle(
                    color: const Color(0xFF10B981).withValues(alpha: 0.7),
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

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 160.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: activeId != null && accounts.any((a) => a.id == activeId)
                ? activeId
                : accounts.first.id,
            dropdownColor: const Color(0xFF1F1F1F),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18.r),
            isDense: true,
            isExpanded: true,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
            items: accounts.map((account) {
              return DropdownMenuItem<String>(
                value: account.id,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        '•••• ${account.accountNumberLast4}',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        account.currency,
                        style: TextStyle(
                          color: const Color(0xFF10B981),
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
      ),
    );
  }

  Widget _buildQuickStats(StatisticsState state) {
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    double savingsRate = 0.0;
    double incomeChange = 0.0;
    double expenseChange = 0.0;

    if (state is StatisticsLoaded && state.financialAnalytics != null) {
      final analytics = state.financialAnalytics!;
      if (analytics.hasCurrentPeriod()) {
        totalIncome = analytics.currentPeriod.totalIncome;
        totalExpenses = analytics.currentPeriod.totalExpenses;
        if (totalIncome > 0) {
          savingsRate = ((totalIncome - totalExpenses) / totalIncome * 100);
        }
      }
      incomeChange = analytics.incomeChangePercent;
      expenseChange = analytics.expenseChangePercent;
    }

    String formatTrend(double change) {
      final prefix = change >= 0 ? '+' : '';
      return '$prefix${change.toStringAsFixed(1)}%';
    }

    final savingsChange = incomeChange - expenseChange;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D9668), Color(0xFF10B981), Color(0xFF34D399)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.analytics_outlined, color: Colors.white, size: 18.sp),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Financial Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                  color: Colors.white,
                  trend: formatTrend(incomeChange),
                  isPositive: incomeChange >= 0,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickStatCard(
                  label: 'Expenses',
                  value: CurrencySymbols.formatAmount(totalExpenses),
                  icon: Icons.arrow_upward,
                  color: Colors.white,
                  trend: formatTrend(expenseChange),
                  isPositive: expenseChange <= 0,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickStatCard(
                  label: 'Savings',
                  value: '${savingsRate.toStringAsFixed(0)}%',
                  icon: Icons.savings,
                  color: Colors.white,
                  trend: formatTrend(savingsChange),
                  isPositive: savingsChange >= 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceAlert(StatisticsState state) {
    if (state is! StatisticsLoaded || state.financialAnalytics == null) {
      return const SizedBox.shrink();
    }

    final analytics = state.financialAnalytics!;
    double totalIncome = 0;
    double totalExpenses = 0;
    double savingsRate = 0;
    double expenseChange = analytics.expenseChangePercent;

    if (analytics.hasCurrentPeriod()) {
      totalIncome = analytics.currentPeriod.totalIncome;
      totalExpenses = analytics.currentPeriod.totalExpenses;
      if (totalIncome > 0) {
        savingsRate = (totalIncome - totalExpenses) / totalIncome * 100;
      }
    }

    // Don't show if no income data
    if (totalIncome <= 0) return const SizedBox.shrink();

    // Determine alert type
    String emoji;
    String message;
    Color borderColor;

    if (expenseChange > 20) {
      emoji = '\u{1F534}'; // red circle
      message = 'Spending up ${expenseChange.toStringAsFixed(0)}% vs last period';
      borderColor = const Color(0xFFEF4444).withValues(alpha: 0.3);
    } else if (savingsRate >= 20) {
      emoji = '\u{1F389}'; // party popper
      message = 'Great job! You\'re saving ${savingsRate.toStringAsFixed(0)}% this month';
      borderColor = const Color(0xFF10B981).withValues(alpha: 0.3);
    } else if (savingsRate >= 10) {
      emoji = '\u{1F4AA}'; // flexed bicep
      message = 'Good progress \u2014 you saved ${savingsRate.toStringAsFixed(0)}% this month';
      borderColor = const Color(0xFF3B82F6).withValues(alpha: 0.3);
    } else {
      emoji = '\u{26A0}\u{FE0F}'; // warning
      message = 'Heads up \u2014 only ${savingsRate.toStringAsFixed(0)}% saved this month';
      borderColor = const Color(0xFFFB923C).withValues(alpha: 0.3);
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.budgetAIInsights),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 22.sp)),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.auto_awesome,
              color: const Color(0xFF8B5CF6),
              size: 18.sp,
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF9CA3AF),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialHealthScore(StatisticsState state) {
    if (state is! StatisticsLoaded || state.financialAnalytics == null) {
      return const SizedBox.shrink();
    }

    final analytics = state.financialAnalytics!;
    if (!analytics.hasCurrentPeriod()) return const SizedBox.shrink();

    final current = analytics.currentPeriod;

    // Don't show if user has zero activity
    if (current.totalIncome <= 0 && current.totalExpenses <= 0) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<BudgetCubit, BudgetState>(
      buildWhen: (prev, curr) =>
          curr is BudgetProgressLoaded || curr is BudgetInitial,
      builder: (context, budgetState) {
        List<({double spent, double budget})> budgetItems = [];
        if (budgetState is BudgetProgressLoaded) {
          budgetItems = budgetState.items
              .map((item) => (spent: item.spentAmount, budget: item.budgetAmount))
              .toList();
        }

        return FinancialHealthScoreCard(
          data: FinancialHealthData(
            totalIncome: current.totalIncome,
            totalExpenses: current.totalExpenses,
            incomeChangePercent: analytics.incomeChangePercent,
            expenseChangePercent: analytics.expenseChangePercent,
            budgetItems: budgetItems,
          ),
          onTap: () => Get.toNamed(AppRoutes.budgetAIInsights),
        );
      },
    );
  }

  Widget _buildCashFlowInsights(StatisticsState state) {
    if (state is! StatisticsLoaded || state.financialAnalytics == null) {
      return const SizedBox.shrink();
    }

    final analytics = state.financialAnalytics!;
    if (!analytics.hasCurrentPeriod()) return const SizedBox.shrink();

    final current = analytics.currentPeriod;
    if (current.totalIncome <= 0 && current.totalExpenses <= 0) {
      return const SizedBox.shrink();
    }

    // Get daily average from expense time series (falls back to manual calculation)
    double dailyAverage = 0;
    if (state.expenseTimeSeries != null && state.expenseTimeSeries!.dailyAverage > 0) {
      dailyAverage = state.expenseTimeSeries!.dailyAverage;
    } else if (current.totalExpenses > 0) {
      final elapsed = DateTime.now().difference(state.startDate).inDays.clamp(1, 366);
      dailyAverage = current.totalExpenses / elapsed;
    }

    // Build top categories from expense breakdown
    List<({String name, double amount, double percentage})> topCategories = [];
    if (state.categoryAnalytics != null) {
      topCategories = state.categoryAnalytics!.expenseCategories
          .map((c) => (
                name: _friendlyCategoryName(c.categoryName),
                amount: c.amount,
                percentage: c.percentage,
              ))
          .toList();
      // Already sorted by amount desc from backend, just take top 3
      if (topCategories.length > 3) {
        topCategories = topCategories.sublist(0, 3);
      }
    }

    return CashFlowInsightsCard(
      data: CashFlowData(
        totalIncome: current.totalIncome,
        totalExpenses: current.totalExpenses,
        dailyAverage: dailyAverage,
        expenseChangePercent: analytics.expenseChangePercent,
        period: state.currentPeriod,
        periodStart: state.startDate,
        periodEnd: state.endDate,
        topCategories: topCategories,
        transactionCount: current.transactionCount,
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
      _FeatureItem(
        title: 'Categories',
        description: 'Manage categories',
        icon: Icons.category,
        color: const Color(0xFF06B6D4),
        route: AppRoutes.categoryManagement,
      ),
      _FeatureItem(
        title: 'Linked Banks',
        description: 'Open banking',
        icon: Icons.account_balance,
        color: const Color(0xFF9B4AE2),
        route: AppRoutes.openBankingConnect,
        arguments: {'userId': _userId, 'accessToken': _accessToken},
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

  Widget _buildOpenBankingSection() {
    return BlocBuilder<OpenBankingCubit, OpenBankingState>(
      buildWhen: (prev, curr) =>
          curr is LinkedAccountsLoaded ||
          curr is OpenBankingInitial ||
          curr is OpenBankingError,
      builder: (context, state) {
        final isConnected = state is LinkedAccountsLoaded && state.accounts.isNotEmpty;
        final linkedAccounts = state is LinkedAccountsLoaded ? state.accounts : <LinkedBankAccount>[];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: OpenBankingStatusCard(
            isConnected: isConnected,
            isSyncing: _isSyncing,
            linkedAccounts: linkedAccounts,
            onConnectBank: () => Get.toNamed(
              AppRoutes.openBankingConnect,
              arguments: {'userId': _userId, 'accessToken': _accessToken},
            ),
            onSync: () => _syncLinkedAccounts(linkedAccounts),
            onViewAll: () => Get.toNamed(
              AppRoutes.openBankingConnect,
              arguments: {'userId': _userId, 'accessToken': _accessToken},
            ),
          ),
        );
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
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF10B981), strokeWidth: 2.5),
                  SizedBox(height: 12.h),
                  Text(
                    'Loading budgets...',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                ],
              ),
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
                    Row(
                      children: [
                        Container(
                          width: 3.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Your Budgets',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.budgetList),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: const Color(0xFF10B981),
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
                    ? const Color(0xFF10B981)
                    : const Color(0xFF2D2D3F),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF10B981).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
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
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(Icons.show_chart, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 32.r),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No expense data for this period',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tap to view detailed spending',
                  style: TextStyle(color: const Color(0xFF10B981).withValues(alpha: 0.6), fontSize: 12.sp),
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
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 3.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Spending Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'See Details',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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
                        colors: [Color(0xFF10B981), Color(0xFF34D399)],
                      ),
                      barWidth: 3,
                      dotData: FlDotData(show: false),
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
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(Icons.bar_chart, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 32.r),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No monthly trend data available',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tap to view monthly trends',
                  style: TextStyle(color: const Color(0xFF10B981).withValues(alpha: 0.6), fontSize: 12.sp),
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
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 3.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Monthly Trends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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

  Widget _buildFailedTransactionsSection(StatisticsState state) {
    if (state is! StatisticsLoaded || state.failedTransactions == null) {
      return const SizedBox.shrink();
    }
    final transactions = state.failedTransactions!.transactions;
    if (transactions.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        FailedTransactionsCard(transactions: transactions),
        SizedBox(height: 16.h),
      ],
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
                      ? const Color(0xFF10B981)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: showIncome
                      ? [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
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
                      ? const Color(0xFF10B981)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: !showIncome
                      ? [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
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
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.trending_up, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 28.r),
          ),
          SizedBox(height: 12.h),
          Text(
            'No income data available',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Income will appear after transactions',
            style: TextStyle(color: const Color(0xFF6B7280), fontSize: 12.sp),
          ),
        ],
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
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 3.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Income Breakdown',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                return _ExpandableCategoryItem(
                  categoryName: cat.categoryName,
                  amount: cat.amount,
                  total: totalIncome,
                  color: categoryColors[index % categoryColors.length],
                  subCategories: cat.subCategories,
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
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 3.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Expense Analysis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  return _ExpandableCategoryItem(
                    categoryName: cat.categoryName,
                    amount: cat.amount,
                    total: totalExpenses,
                    color: categoryColors[index % categoryColors.length],
                    subCategories: cat.subCategories,
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
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.trending_down, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 28.r),
          ),
          SizedBox(height: 12.h),
          Text(
            'No expense analysis data available',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Expenses will appear after transactions',
            style: TextStyle(color: const Color(0xFF6B7280), fontSize: 12.sp),
          ),
        ],
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
          // Header shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 160.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
          // Quick stats shimmer
          Container(
            height: 160.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF10B981).withValues(alpha: 0.08),
                  const Color(0xFF10B981).withValues(alpha: 0.03),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          SizedBox(height: 16.h),
          // Feature grid shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 1.5,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Chart shimmer blocks
          ...[200.0, 300.0, 160.0].map((h) => Container(
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
      onTap: () => Get.toNamed(feature.route, arguments: feature.arguments),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: feature.color.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: feature.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    feature.icon,
                    color: feature.color,
                    size: 22.sp,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: feature.color.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
              ],
            ),
            const Spacer(),
            Text(
              feature.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
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
  final bool isPositive;

  const _QuickStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
    this.isPositive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color.withValues(alpha: 0.8), size: 14.sp),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: (isPositive ? Colors.white : const Color(0xFFEF4444)).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              trend,
              style: TextStyle(
                color: isPositive ? Colors.white : const Color(0xFFFFCDD2),
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
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
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: progressColor.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
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
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: const Color(0xFF10B981),
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

class _ExpandableCategoryItem extends StatefulWidget {
  final String categoryName;
  final double amount;
  final double total;
  final Color color;
  final List<accounts_pb.SubCategoryItem> subCategories;

  const _ExpandableCategoryItem({
    required this.categoryName,
    required this.amount,
    required this.total,
    required this.color,
    required this.subCategories,
  });

  @override
  State<_ExpandableCategoryItem> createState() => _ExpandableCategoryItemState();
}

class _ExpandableCategoryItemState extends State<_ExpandableCategoryItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final safeTotal = widget.total > 0 ? widget.total : 1.0;
    final percentage = (widget.amount / safeTotal * 100).toStringAsFixed(1);
    final displayName = _friendlyCategoryName(widget.categoryName);
    final hasSubCategories = widget.subCategories.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          // Main category row
          GestureDetector(
            onTap: hasSubCategories ? () => setState(() => _expanded = !_expanded) : null,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          displayName,
                          style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 14.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '$percentage%',
                        style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                      ),
                      if (hasSubCategories) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: const Color(0xFF9CA3AF),
                          size: 16.sp,
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  CurrencySymbols.formatAmount(widget.amount),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: (widget.amount / safeTotal).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
          // Expanded sub-categories
          if (_expanded && hasSubCategories)
            Container(
              margin: EdgeInsets.only(top: 8.h),
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: widget.color.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: widget.subCategories.map((sub) {
                  final subPct = widget.amount > 0
                      ? (sub.amount / widget.amount * 100).toStringAsFixed(1)
                      : '0.0';
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: BoxDecoration(
                                  color: widget.color.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                child: Text(
                                  sub.name,
                                  style: TextStyle(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 12.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '$subPct%',
                                style: TextStyle(
                                  color: const Color(0xFF6B7280),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          CurrencySymbols.formatAmount(sub.amount),
                          style: TextStyle(
                            color: const Color(0xFFD1D5DB),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
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
  final Map<String, dynamic>? arguments;

  _FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    this.arguments,
  });
}
