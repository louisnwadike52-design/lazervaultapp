import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';

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

  void _loadInsights() {
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
        spendingData.add({
          'category': cat.categoryName,
          'amount': cat.amount,
          'percentage': totalExpenses > 0 ? (cat.amount / totalExpenses * 100).round() : 0,
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

    // Use sensible defaults if no real data yet
    if (monthlyIncome == 0) monthlyIncome = 500000;
    if (spendingData.isEmpty) {
      spendingData = [
        {'category': 'General', 'amount': 0, 'percentage': 0},
      ];
    }

    context.read<BudgetCubit>().loadAIInsights(
      monthlyIncome: monthlyIncome,
      spendingData: spendingData,
      activeBudgets: activeBudgets,
      goals: ['Save more', 'Reduce spending'],
      riskTolerance: 'moderate',
      currency: CurrencySymbols.currentCurrency,
      monthsOfData: 3,
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
            border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.2)),
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
              border: Border.all(color: const Color(0xFF2D2D2D).withValues(alpha: 0.5)),
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
        border: Border.all(color: const Color(0xFF2D2D2D).withValues(alpha: 0.5)),
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

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF10B981)),
          SizedBox(height: 16),
          Text(
            'Analyzing your spending patterns...',
            style: TextStyle(color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
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
