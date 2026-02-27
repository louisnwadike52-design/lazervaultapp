import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/widgets/service_categories.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/linked_banks_widget.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/financial_health_score_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/cash_flow_insights_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/failed_transactions_card.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Returns true for platform/internal fee categories that should be
/// included in totals but hidden from the UI breakdown.
bool _isPlatformFee(String categoryName) {
  final n = categoryName.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
  return const {
    'fee',
    'fees',
    'service_fees',
    'service_fee',
    'transfer_fee',
    'transfer_fees',
    'exchange_margin',
    'exchange_fee',
    'platform_fee',
    'platform_fees',
    'processing_fee',
    'processing_fees',
    'commission',
    'commissions',
  }.contains(n);
}

/// Maps category names from backend to display-friendly names.
/// Uses ServiceCategories for service subcategory mappings where available.
String _friendlyCategoryName(String raw, {String? serviceName}) {
  // First try to find in ServiceCategories by subcategory name
  final normalized = raw.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
  final serviceCat = ServiceCategories.getBySubCategory(normalized);
  if (serviceCat != null) {
    return serviceCat.displayName;
  }

  // Legacy mappings for backward compatibility
  return switch (raw.toLowerCase()) {
    'p2p transfers' || 'bank transfers' || 'international transfers' => raw,
    'gift cards' || 'bills & utilities' => raw,
    'service fees' || 'tagpay' || 'invoices' => raw,
    'payroll' || 'crowdfunding' || 'deposits' || 'withdrawals' => raw,
    'reversals' || 'transfers' || 'banking' || 'payments' => raw,
    'food & drinks' || 'shopping' || 'transportation' || 'entertainment' => raw,

    'piggyvault' || 'piggy vault' || 'lock funds' || 'lock_funds' => 'PiggyVault',
    'autosave' => 'AutoSave',
    'savings & products' => 'Savings & Products',

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
    'airtime' => 'Airtime',
    'bill_payment' => 'Bill Payments',
    'investment' || 'investments' => 'Investments',

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

    _ => raw.replaceAll('-', ' ').replaceAll('_', ' ').split(' ').map((w) =>
        w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '').join(' '),
  };
}

/// Get category color from service categories or fallback
Color _getCategoryColor(String categoryName, {String? serviceName}) {
  final normalized = categoryName.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
  final serviceCat = ServiceCategories.getBySubCategory(normalized);
  if (serviceCat != null) {
    return serviceCat.color;
  }

  // Legacy colors
  return switch (normalized) {
    'p2p_transfers' || 'transfer' => const Color(0xFF4A90E2),
    'bank_transfers' || 'domestic_transfer' => const Color(0xFFE2844A),
    'international_transfers' => const Color(0xFF4AE28D),
    'bills_&_utilities' || 'bill_payment' => const Color(0xFFE24A67),
    'gift_cards' => const Color(0xFF9B4AE2),
    'tagpay' => const Color(0xFFE2E24A),
    'invoices' => const Color(0xFFE2E24A),
    'investments' || 'investment' => const Color(0xFF4AE2D4),
    'payroll' => const Color(0xFFE24ABB),
    'crowdfunding' => const Color(0xFF4AE28D),
    _ => const Color(0xFF6B7280),
  };
}

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final List<String> timePeriods = ["Day", "Week", "Month", "Quarter", "Year"];
  String selectedPeriod = "Week"; // Default to week instead of Day

  bool showIncome = true;
  bool _isSyncing = false;
  bool _includeExternalBanks = true; // Track external banks filter state
  String _userId = '';
  String _accessToken = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureActiveAccount();
      context.read<StatisticsCubit>().loadStatistics();
      context.read<BudgetCubit>().loadBudgetProgress();
      _initOpenBanking();
    });
  }

  /// Ensure AccountManager has an active account before loading statistics.
  /// Syncs from the dashboard carousel selection, or falls back to
  /// the first available account.
  void _ensureActiveAccount() {
    final accountManager = serviceLocator<AccountManager>();
    if (accountManager.activeAccountId != null) return;

    final accountCubit = context.read<AccountCardsSummaryCubit>();
    final accountState = accountCubit.state;

    List<AccountSummaryEntity> accounts = [];
    if (accountState is AccountCardsSummaryLoaded) {
      accounts = accountState.accountSummaries;
    } else if (accountState is AccountBalanceUpdated) {
      accounts = accountState.accountSummaries;
    }

    if (accounts.isNotEmpty) {
      // Prefer personal account, fallback to first
      final personal = accounts.where((a) => a.accountType == 'personal');
      final selected = personal.isNotEmpty ? personal.first : accounts.first;
      accountManager.setActiveAccount(selected.id);
    }
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
      // Await linked accounts first to avoid race condition —
      // both methods emit to the same cubit, so running them
      // concurrently causes the second to overwrite the first state.
      await context.read<OpenBankingCubit>().fetchLinkedAccounts(userId: userId, accessToken: accessToken);
      if (mounted) {
        context.read<OpenBankingCubit>().fetchCreditScore(userId: userId);
      }
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
          // Sync external banks filter state
          if (_includeExternalBanks != state.includeExternalBanks) {
            setState(() => _includeExternalBanks = state.includeExternalBanks);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 16.h),

                  // ==================== OVERVIEW SECTION ====================
                  _buildSectionHeader('Overview', trailing: _buildAccountSourceFilter()),
                  SizedBox(height: 12.h),
                  _buildQuickStats(state),
                  SizedBox(height: 12.h),
                  _buildPerformanceAlert(state),
                  SizedBox(height: 16.h),

                  // ==================== INSIGHTS SECTION ====================
                  _buildSectionHeader('Insights'),
                  SizedBox(height: 12.h),
                  _buildFinancialHealthScore(state),
                  SizedBox(height: 12.h),
                  _buildCashFlowInsights(state),
                  SizedBox(height: 16.h),

                  // ==================== QUICK ACTIONS SECTION ====================
                  _buildSectionHeader('Quick Actions'),
                  SizedBox(height: 12.h),
                  _buildFeatureGrid(state),
                  SizedBox(height: 16.h),

                  // ==================== CREDIT SCORE CTA ====================
                  _buildCreditScoreCTA(),
                  SizedBox(height: 12.h),

                  // ==================== LINKED BANKS SECTION ====================
                  _buildLinkedBanksSection(),
                  SizedBox(height: 16.h),

                  // ==================== ANALYTICS SECTION ====================
                  _buildSectionHeader('Analytics', trailing: _buildPeriodSelector()),
                  SizedBox(height: 12.h),
                  _buildSpendingChart(state),
                  SizedBox(height: 12.h),
                  _buildMonthlyTrendChart(state),
                  SizedBox(height: 16.h),

                  // ==================== CATEGORY BREAKDOWN SECTION ====================
                  _buildCategoryAnalysisSection(state),
                  SizedBox(height: 16.h),

                  // ==================== MANAGEMENT SECTION ====================
                  _buildManagementSection(state),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
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

    if (totalIncome <= 0) return const SizedBox.shrink();

    String emoji;
    String message;
    Color borderColor;

    if (expenseChange > 20) {
      emoji = '\u{1F534}';
      message = 'Spending up ${expenseChange.toStringAsFixed(0)}% vs last period';
      borderColor = const Color(0xFFEF4444).withValues(alpha: 0.3);
    } else if (savingsRate >= 20) {
      emoji = '\u{1F389}';
      message = 'Great job! You\'re saving ${savingsRate.toStringAsFixed(0)}% this month';
      borderColor = const Color(0xFF10B981).withValues(alpha: 0.3);
    } else if (savingsRate >= 10) {
      emoji = '\u{1F4AA}';
      message = 'Good progress \u2014 you saved ${savingsRate.toStringAsFixed(0)}% this month';
      borderColor = const Color(0xFF3B82F6).withValues(alpha: 0.3);
    } else {
      emoji = '\u{26A0}\u{FE0F}';
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
          border: Border.all(color: borderColor, width: 1),
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
            Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 18.sp),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 18.sp),
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

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: FinancialHealthScoreCard(
            data: FinancialHealthData(
              totalIncome: current.totalIncome,
              totalExpenses: current.totalExpenses,
              incomeChangePercent: analytics.incomeChangePercent,
              expenseChangePercent: analytics.expenseChangePercent,
              budgetItems: budgetItems,
            ),
            onTap: () => Get.toNamed(
              AppRoutes.creditScore,
              arguments: {'userId': _userId},
            ),
          ),
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

    double dailyAverage = 0;
    if (state.expenseTimeSeries != null && state.expenseTimeSeries!.dailyAverage > 0) {
      dailyAverage = state.expenseTimeSeries!.dailyAverage;
    } else if (current.totalExpenses > 0) {
      final elapsed = DateTime.now().difference(state.startDate).inDays.clamp(1, 366);
      dailyAverage = current.totalExpenses / elapsed;
    }

    List<({String name, double amount, double percentage})> topCategories = [];
    if (state.categoryAnalytics != null) {
      topCategories = state.categoryAnalytics!.expenseCategories
          .where((c) => !_isPlatformFee(c.categoryName))
          .map((c) => (
                name: _friendlyCategoryName(c.categoryName),
                amount: c.amount,
                percentage: c.percentage,
              ))
          .toList();
      if (topCategories.length > 3) {
        topCategories = topCategories.sublist(0, 3);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CashFlowInsightsCard(
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
      ),
    );
  }

  Widget _buildFeatureGrid(StatisticsState state) {
    final features = [
      _FeatureItem(
        title: 'Budgets',
        description: 'Manage budgets',
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
        description: 'Track goals',
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

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D3F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPeriod,
          dropdownColor: const Color(0xFF1F1F1F),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFF10B981),
            size: 20.sp,
          ),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          items: timePeriods.map((String period) {
            return DropdownMenuItem<String>(
              value: period,
              child: Text(period),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() => selectedPeriod = newValue);
              context.read<StatisticsCubit>().changePeriod(
                    newValue.toLowerCase(),
                  );
            }
          },
        ),
      ),
    );
  }

  /// Toggle widget to filter data source (LazerVault only vs All Accounts)
  Widget _buildAccountSourceFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D3F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // LazerVault Only option
          GestureDetector(
            onTap: () {
              if (_includeExternalBanks) {
                setState(() => _includeExternalBanks = false);
                context.read<StatisticsCubit>().toggleExternalBanks(false);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: !_includeExternalBanks
                    ? const Color(0xFF10B981)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 14.sp,
                    color: !_includeExternalBanks ? Colors.white : Colors.white60,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Wallet Only',
                    style: GoogleFonts.inter(
                      color: !_includeExternalBanks ? Colors.white : Colors.white60,
                      fontSize: 11.sp,
                      fontWeight: !_includeExternalBanks ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4.w),
          // All Accounts option
          GestureDetector(
            onTap: () {
              if (!_includeExternalBanks) {
                setState(() => _includeExternalBanks = true);
                context.read<StatisticsCubit>().toggleExternalBanks(true);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: _includeExternalBanks
                    ? const Color(0xFF10B981)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 14.sp,
                    color: _includeExternalBanks ? Colors.white : Colors.white60,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'All Accounts',
                    style: GoogleFonts.inter(
                      color: _includeExternalBanks ? Colors.white : Colors.white60,
                      fontSize: 11.sp,
                      fontWeight: _includeExternalBanks ? FontWeight.w600 : FontWeight.w500,
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
          height: 180.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
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
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spending Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See Details',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 120.h,
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
          height: 200.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
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
        height: 240.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Trends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See Details',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
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
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                          );
                        },
                        reservedSize: 28,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          final compactValue = value >= 1000000
                              ? '${(value / 1000000).toStringAsFixed(1)}M'
                              : value >= 1000
                                  ? '${(value / 1000).toStringAsFixed(0)}K'
                                  : '${value.toInt()}';
                          return Text(
                            compactValue,
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                          );
                        },
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
                          width: 10.w,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        BarChartRodData(
                          toY: monthlyPoints[index].expenses,
                          color: Colors.red[300],
                          width: 10.w,
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

  Widget _buildCategoryAnalysisSection(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return const SizedBox.shrink();
    }

    final catAnalytics = state.categoryAnalytics;
    final hasIncome = catAnalytics != null && catAnalytics.incomeCategories.isNotEmpty;
    final hasExpense = catAnalytics != null && catAnalytics.expenseCategories.isNotEmpty;

    if (!hasIncome && !hasExpense) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Category Breakdown'),
        SizedBox(height: 12.h),
        _buildToggleSection(),
        SizedBox(height: 12.h),
        showIncome && hasIncome
            ? _buildIncomeAnalysis(state)
            : (!showIncome && hasExpense ? _buildExpenseAnalysis(state) : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildManagementSection(StatisticsState state) {
    // Only show failed transactions card if available
    final hasFailedTransactions = state is StatisticsLoaded &&
        state.failedTransactions != null &&
        state.failedTransactions!.transactions.isNotEmpty;

    if (!hasFailedTransactions) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Management'),
        SizedBox(height: 12.h),
        _buildFailedTransactionsSection(state),
      ],
    );
  }

  Widget _buildCreditScoreCTA() {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.creditScore,
        arguments: {
          'userId': _userId,
          'showAllSources': _includeExternalBanks,
        },
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.speed_rounded,
                color: const Color(0xFF10B981),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credit Score',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'View your score, insights & tips to improve',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF9CA3AF),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedBanksSection() {
    return BlocBuilder<OpenBankingCubit, OpenBankingState>(
      buildWhen: (prev, curr) =>
          curr is LinkedAccountsLoaded ||
          curr is AccountLinked ||
          curr is AccountUnlinked ||
          curr is BalanceRefreshed ||
          curr is AllAccountsSynced ||
          curr is AccountTransactionsSynced ||
          curr is OpenBankingInitial ||
          curr is OpenBankingError,
      builder: (context, state) {
        final linkedAccounts = context.read<OpenBankingCubit>().linkedAccounts;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: LinkedBanksWidget(
            linkedAccounts: linkedAccounts,
            onRefresh: linkedAccounts.isNotEmpty
                ? () => _syncLinkedAccounts(linkedAccounts)
                : null,
          ),
        );
      },
    );
  }

  Widget _buildFailedTransactionsSection(StatisticsState state) {
    if (state is! StatisticsLoaded || state.failedTransactions == null) {
      return const SizedBox.shrink();
    }
    final transactions = state.failedTransactions!.transactions;
    if (transactions.isEmpty) return const SizedBox.shrink();

    return FailedTransactionsCard(transactions: transactions);
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
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: showIncome
                      ? const Color(0xFF10B981)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Income',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: !showIncome
                      ? const Color(0xFF10B981)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Expenses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
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

    return const SizedBox.shrink();
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
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  CurrencySymbols.formatAmount(totalIncome),
                  style: TextStyle(
                    color: Colors.green[300],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
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
            SizedBox(height: 16.h),
            Column(
              children: categories.map((cat) {
                return _CategoryItem(
                  categoryName: cat.categoryName,
                  amount: cat.amount,
                  total: totalIncome,
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
      // Filter out platform fees from display but keep total (which includes them)
      final displayCategories = catAnalytics.expenseCategories
          .where((c) => !_isPlatformFee(c.categoryName))
          .toList();
      final totalExpenses = catAnalytics.totalExpenses;

      if (displayCategories.isEmpty) return const SizedBox.shrink();

      return GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.statisticsCategoryAnalysis,
          arguments: {'type': 'expense'},
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expense Breakdown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    CurrencySymbols.formatAmount(totalExpenses),
                    style: TextStyle(
                      color: Colors.red[300],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (displayCategories.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: _generateCategoryBreakdownSections(displayCategories, totalExpenses),
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
              Column(
                children: displayCategories.map((cat) {
                  return _CategoryItem(
                    categoryName: cat.categoryName,
                    amount: cat.amount,
                    total: totalExpenses,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  List<PieChartSectionData> _generateCategoryBreakdownSections(
    List<accounts_pb.CategoryBreakdownItem> categories,
    double total,
  ) {
    if (total == 0 || categories.isEmpty) return [];

    return categories.asMap().entries.map((entry) {
      final cat = entry.value;
      final percentage = cat.percentage > 0
          ? cat.percentage.roundToDouble()
          : (cat.amount / total * 100).roundToDouble();
      // Use service category color if available, otherwise fallback to default colors
      final categoryColor = _getCategoryColor(cat.categoryName);
      return PieChartSectionData(
        color: categoryColor,
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
          ...[180.0, 240.0, 160.0].map((h) => Container(
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

// ==================== WIDGET CLASSES ====================

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature});

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

class _CategoryItem extends StatelessWidget {
  final String categoryName;
  final double amount;
  final double total;

  const _CategoryItem({
    required this.categoryName,
    required this.amount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final safeTotal = total > 0 ? total : 1.0;
    final percentage = (amount / safeTotal * 100).toStringAsFixed(1);
    final displayName = _friendlyCategoryName(categoryName);
    final categoryColor = _getCategoryColor(categoryName);
    final categoryIcon = ServiceCategories.getIcon(categoryName);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        categoryIcon,
                        color: categoryColor,
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        displayName,
                        style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 13.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '$percentage%',
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(amount),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          LinearProgressIndicator(
            value: (amount / safeTotal).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
            minHeight: 3.h,
            borderRadius: BorderRadius.circular(2.r),
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
