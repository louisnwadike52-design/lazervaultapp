import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as stats_pb;

/// Budget AI Insights Screen
class BudgetAIInsightsScreen extends StatefulWidget {
  const BudgetAIInsightsScreen({super.key});

  @override
  State<BudgetAIInsightsScreen> createState() => _BudgetAIInsightsScreenState();
}

class _BudgetAIInsightsScreenState extends State<BudgetAIInsightsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInsights();
    });
  }

  void _loadInsights() async {
    // Pull real data from StatisticsCubit for income/spending analysis
    double monthlyIncome = 0;
    List<Map<String, dynamic>> spendingData = [];
    final statisticsCubit = context.read<StatisticsCubit>();
    final statsState = statisticsCubit.state;

    if (statsState is StatisticsLoaded && statsState.financialAnalytics != null) {
      final analytics = statsState.financialAnalytics!;
      if (analytics.hasCurrentPeriod()) {
        monthlyIncome = analytics.currentPeriod.totalIncome;
      }
    }

    if (statsState is StatisticsLoaded && statsState.categoryAnalytics != null) {
      final catAnalytics = statsState.categoryAnalytics!;
      final totalExpenses = catAnalytics.totalExpenses;
      for (final cat in catAnalytics.expenseCategories) {
        // Include sub-category breakdowns so AI can give granular advice
        final subCats = cat.subCategories.map((sub) => {
          'name': sub.name,
          'amount': sub.amount,
          'transaction_count': sub.transactionCount,
          'percentage': cat.amount > 0 ? (sub.amount / cat.amount * 100).round() : 0,
        }).toList();

        spendingData.add({
          'category': cat.categoryName,
          'amount': cat.amount,
          'percentage': totalExpenses > 0 ? (cat.amount / totalExpenses * 100).round() : 0,
          'transaction_count': cat.transactionCount,
          if (subCats.isNotEmpty) 'sub_categories': subCats,
        });
      }
    }

    // Pull active budgets from BudgetCubit if previously loaded
    List<Map<String, dynamic>> activeBudgets = [];
    final budgetState = context.read<BudgetCubit>().state;
    if (budgetState is BudgetsLoaded) {
      for (final budget in budgetState.budgets) {
        activeBudgets.add({
          'name': budget.name,
          'category': budget.category.name,
          'budget_amount': budget.amount,
          'spent_amount': budget.spentAmount,
          'remaining': budget.amount - budget.spentAmount,
          'percentage_used': budget.amount > 0
              ? (budget.spentAmount / budget.amount * 100).round()
              : 0,
        });
      }
    }

    // Fetch financial goals, upcoming bills, and budget alerts directly
    // from the repository (since the cubit can only hold one state at a time)
    List<Map<String, dynamic>> financialGoals = [];
    List<Map<String, dynamic>> upcomingBills = [];
    List<Map<String, dynamic>> budgetAlerts = [];

    try {
      final budgetRepo = serviceLocator<BudgetRepository>();
      final results = await Future.wait([
        budgetRepo.getFinancialGoals(),
        budgetRepo.getUpcomingBills(daysAhead: 30),
        budgetRepo.getBudgetAlerts(unreadOnly: false, limit: 20),
      ]);

      // Financial goals
      final goalsResponse = results[0] as stats_pb.GetFinancialGoalsResponse;
      for (final goal in goalsResponse.goalsList.goals) {
        financialGoals.add({
          'name': goal.name,
          'goal_type': goal.goalType.name,
          'target_amount': goal.targetAmount,
          'current_amount': goal.currentAmount,
          'monthly_contribution': goal.monthlyContribution,
          'percentage_complete': goal.percentageComplete,
          'months_remaining': goal.monthsRemaining,
        });
      }

      // Upcoming bills
      final billsResponse = results[1] as stats_pb.GetUpcomingBillsResponse;
      for (final bill in billsResponse.billsList.bills) {
        upcomingBills.add({
          'name': bill.name,
          'amount': bill.amount,
          'days_until_due': bill.daysUntilDue,
          'recurrence_pattern': bill.recurrencePattern,
          'auto_pay_enabled': bill.autoPayEnabled,
        });
      }

      // Budget alerts
      final alertsResponse = results[2] as stats_pb.GetBudgetAlertsResponse;
      for (final alert in alertsResponse.alerts) {
        budgetAlerts.add({
          'budget_name': alert.budgetName,
          'alert_type': alert.alertType.name,
          'message': alert.message,
          'current_spent': alert.currentSpent,
          'budget_limit': alert.budgetLimit,
          'percentage_used': alert.percentageUsed,
        });
      }
    } catch (_) {
      // Non-critical — proceed with empty lists if fetch fails
    }

    // Build goal name list for legacy field
    final goalNames = financialGoals.isNotEmpty
        ? financialGoals.map((g) => g['name'] as String).toList()
        : ['Save more', 'Reduce spending'];

    // Use sensible defaults if no real data yet
    if (monthlyIncome == 0) monthlyIncome = 500000;
    if (spendingData.isEmpty) {
      spendingData = [
        {'category': 'General', 'amount': 0, 'percentage': 0},
      ];
    }

    // Extract failed/reversed transactions for AI analysis
    List<Map<String, dynamic>> failedTransactions = [];
    if (statsState is StatisticsLoaded && statsState.failedTransactions != null) {
      for (final tx in statsState.failedTransactions!.transactions) {
        failedTransactions.add({
          'reference': tx.reference,
          'amount': tx.amount,
          'category': tx.category,
          'description': tx.description,
          'status': tx.status,
          'date': tx.createdAt,
        });
      }
    }

    if (!mounted) return;

    context.read<BudgetCubit>().loadAIInsights(
      monthlyIncome: monthlyIncome,
      spendingData: spendingData,
      activeBudgets: activeBudgets,
      goals: goalNames,
      riskTolerance: 'moderate',
      currency: CurrencySymbols.currentCurrency,
      monthsOfData: 3,
      financialGoals: financialGoals,
      upcomingBills: upcomingBills,
      budgetAlerts: budgetAlerts,
      failedTransactions: failedTransactions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'AI Budget Insights',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {
          if (state is BudgetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BudgetAIInsightsLoading) {
            return const _LoadingView();
          }

          if (state is BudgetAIInsightsLoaded) {
            return _InsightsView(insights: state.insights);
          }

          if (state is BudgetAIInsightsError) {
            return _ErrorView(
              message: state.message,
              onRetry: _loadInsights,
            );
          }

          return const _LoadingView();
        },
      ),
    );
  }
}

class _InsightsView extends StatelessWidget {
  final BudgetAIInsightsData insights;

  const _InsightsView({required this.insights});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        // Summary Card
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0D9668), Color(0xFF10B981), Color(0xFF34D399)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
                  SizedBox(width: 12.w),
                  const Expanded(
                    child: Text(
                      'AI Analysis',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                insights.summary,
                style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Recommended Savings Rate
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              const Text(
                'Recommended Savings Rate',
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              ),
              SizedBox(height: 8.h),
              Text(
                '${insights.recommendedSavingsRate.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Risk Level & Spending Patterns
        if (insights.riskLevel.isNotEmpty || insights.spendingPatterns.isNotEmpty) ...[
          Row(
            children: [
              Container(width: 3, height: 20, decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Spending Patterns',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (insights.riskLevel.isNotEmpty) ...[
                  Row(
                    children: [
                      const Icon(Icons.shield, color: Color(0xFF10B981), size: 18),
                      SizedBox(width: 8.w),
                      const Text('Risk Level', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          insights.riskLevel[0].toUpperCase() + insights.riskLevel.substring(1),
                          style: const TextStyle(color: Color(0xFF10B981), fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  if (insights.spendingPatterns.isNotEmpty) SizedBox(height: 12.h),
                ],
                ...insights.spendingPatterns.entries.map((entry) {
                  final label = entry.key.replaceAll('_', ' ');
                  final displayLabel = label[0].toUpperCase() + label.substring(1);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.insights, color: Color(0xFF34D399), size: 16),
                        SizedBox(width: 8.w),
                        Text('$displayLabel: ', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                        Expanded(
                          child: Text(
                            entry.value.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],

        // Category Deep-Dive Insights
        if (insights.categoryInsights.isNotEmpty) ...[
          Row(
            children: [
              Container(width: 3, height: 20, decoration: BoxDecoration(color: const Color(0xFF8B5CF6), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Category Deep Dive',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insights.categoryInsights.map((ci) => _CategoryInsightCard(insight: ci)),
          SizedBox(height: 24.h),
        ],

        // Budget Recommendations
        if (insights.budgetRecommendations.isNotEmpty) ...[
          Row(
            children: [
              Container(width: 3, height: 20, decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Budget Recommendations',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insights.budgetRecommendations.map((rec) => _RecommendationCard(rec: rec)),
          SizedBox(height: 24.h),
        ],

        // Savings Opportunities
        if (insights.savingsOpportunities.isNotEmpty) ...[
          Row(
            children: [
              Container(width: 3, height: 20, decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Savings Opportunities',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insights.savingsOpportunities.map((opportunity) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: const Icon(Icons.lightbulb, color: Color(0xFFFB923C), size: 20),
                  ),
                  Expanded(
                    child: Text(
                      opportunity,
                      style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 32.h),
        ],

        // Apply Button
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
          child: const Text('Apply Recommendations', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// ── Category Insight Card ──────────────────────────────────────────

class _CategoryInsightCard extends StatefulWidget {
  final CategoryInsightData insight;

  const _CategoryInsightCard({required this.insight});

  @override
  State<_CategoryInsightCard> createState() => _CategoryInsightCardState();
}

class _CategoryInsightCardState extends State<_CategoryInsightCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final ci = widget.insight;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — always visible, tappable to expand
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.category, color: const Color(0xFF8B5CF6), size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ci.categoryName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        if (ci.subCategories.isNotEmpty)
                          Text(
                            '${ci.subCategories.length} sub-categories',
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF9CA3AF),
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),

          // Analysis — always visible
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              ci.analysis,
              style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 13.sp, height: 1.5),
            ),
          ),
          SizedBox(height: 12.h),

          // Expanded: sub-categories + action items
          if (_expanded) ...[
            // Sub-categories
            if (ci.subCategories.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Sub-Category Breakdown',
                  style: TextStyle(color: const Color(0xFF8B5CF6), fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8.h),
              ...ci.subCategories.map((sub) => _SubCategoryRow(sub: sub)),
            ],

            // Action Items
            if (ci.actionItems.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Action Items',
                  style: TextStyle(color: const Color(0xFF10B981), fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8.h),
              ...ci.actionItems.map((item) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 16.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}

class _SubCategoryRow extends StatelessWidget {
  final SubCategoryInsightData sub;

  const _SubCategoryRow({required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.r),
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
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      sub.name,
                      style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (sub.amount > 0)
                  Text(
                    CurrencySymbols.formatAmount(sub.amount),
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
            if (sub.insight.isNotEmpty) ...[
              SizedBox(height: 4.h),
              Text(
                sub.insight,
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp, height: 1.4),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Existing cards ─────────────────────────────────────────────────

class _RecommendationCard extends StatelessWidget {
  final BudgetRecommendationData rec;

  const _RecommendationCard({required this.rec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rec.categoryName,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: rec.difference <= 0 ? const Color(0xFF10B981).withValues(alpha: 0.2) : const Color(0xFFEF4444).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  rec.difference <= 0 ? 'Within Budget' : 'Over Budget',
                  style: TextStyle(
                    color: rec.difference <= 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _StatLine(label: 'Current', value: CurrencySymbols.formatAmount(rec.currentAmount)),
              ),
              Expanded(
                child: _StatLine(label: 'Recommended', value: CurrencySymbols.formatAmount(rec.recommendedAmount)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            rec.reasoning,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  final String label;
  final String value;

  const _StatLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ── Enhanced Loading View ──────────────────────────────────────────

class _LoadingView extends StatefulWidget {
  const _LoadingView();

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _progressController;
  int _messageIndex = 0;

  static const _messages = [
    'Analyzing your spending patterns...',
    'Reviewing category breakdowns...',
    'Evaluating sub-category trends...',
    'Comparing with recommended budgets...',
    'Generating savings opportunities...',
    'Building personalized insights...',
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..forward();

    // Cycle through messages
    _cycleMessages();
  }

  void _cycleMessages() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _messages.length;
        });
        _cycleMessages();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          // Animated AI icon
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF8B5CF6).withValues(alpha: 0.3 + _pulseController.value * 0.2),
                      const Color(0xFF10B981).withValues(alpha: 0.1 + _pulseController.value * 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: Color.lerp(
                    const Color(0xFF8B5CF6),
                    const Color(0xFF10B981),
                    _pulseController.value,
                  ),
                  size: 48.sp,
                ),
              );
            },
          ),
          SizedBox(height: 32.h),

          // Title
          Text(
            'AI is analyzing your finances',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),

          // Rotating subtitle
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              _messages[_messageIndex],
              key: ValueKey<int>(_messageIndex),
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32.h),

          // Progress bar
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: _progressController.value * 0.9,
                      backgroundColor: const Color(0xFF2D2D2D),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                      minHeight: 6.h,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${(_progressController.value * 90).toInt()}%',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 40.h),

          // Shimmer cards
          ..._buildShimmerCards(),
        ],
      ),
    );
  }

  List<Widget> _buildShimmerCards() {
    return List.generate(3, (index) {
      return AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final opacity = 0.03 + _pulseController.value * 0.04;
          return Container(
            height: 80.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: opacity),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 14.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: opacity),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 10.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: opacity * 0.7),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF9CA3AF)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
