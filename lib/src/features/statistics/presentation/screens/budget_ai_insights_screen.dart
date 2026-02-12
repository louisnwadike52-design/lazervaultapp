import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';

/// Budget AI Insights Screen
class BudgetAIInsightsScreen extends StatelessWidget {
  const BudgetAIInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Get.find<BudgetCubit>(),
      child: const BudgetAIInsightsView(),
    );
  }
}

class BudgetAIInsightsView extends StatefulWidget {
  const BudgetAIInsightsView({super.key});

  @override
  State<BudgetAIInsightsView> createState() => _BudgetAIInsightsViewState();
}

class _BudgetAIInsightsViewState extends State<BudgetAIInsightsView> {
  @override
  void initState() {
    super.initState();
    _loadInsights();
  }

  void _loadInsights() {
    // TODO: Get actual data from app state
    context.read<BudgetCubit>().loadAIInsights(
      monthlyIncome: 500000, // Example: 500k NGN
      spendingData: [
        {'category': 'Food', 'amount': 50000, 'percentage': 30},
        {'category': 'Transport', 'amount': 30000, 'percentage': 18},
        {'category': 'Bills', 'amount': 40000, 'percentage': 24},
      ],
      activeBudgets: [],
      goals: ['Save more', 'Reduce debt'],
      riskTolerance: 'moderate',
      currency: 'NGN',
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
            return _ErrorView(message: state.message);
          }

          return const _LoadingView();
        },
      ),
    );
  }
}

class _InsightsView extends StatelessWidget {
  final BudgetAIInsightsData insights;

  const _InsightsView({required this.insights, super.key});

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
              colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
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
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
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

        // Budget Recommendations
        const Text(
          'Budget Recommendations',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        ...insights.budgetRecommendations.map((rec) => _RecommendationCard(rec: rec)),
        SizedBox(height: 24.h),

        // Savings Opportunities
        const Text(
          'Savings Opportunities',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        ...insights.savingsOpportunities.asMap().entries.map((entry) {
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
                    entry.value,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 32.h),

        // Apply Button
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
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

  const _RecommendationCard({required this.rec, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
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
                child: _StatLine(label: 'Current', value: '₦${rec.currentAmount.toStringAsFixed(0)}'),
              ),
              Expanded(
                child: _StatLine(label: 'Recommended', value: '₦${rec.recommendedAmount.toStringAsFixed(0)}'),
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

  const _StatLine({required this.label, required this.value, super.key});

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
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF3B82F6)),
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

  const _ErrorView({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
          SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Color(0xFF9CA3AF)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
