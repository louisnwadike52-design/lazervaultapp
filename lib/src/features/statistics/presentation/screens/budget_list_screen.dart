import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/expense_category_helpers.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import '../../../../../core/utils/currency_formatter.dart';

/// Budget List Screen - displays all user budgets
class BudgetListScreen extends StatelessWidget {
  const BudgetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Get.find<BudgetCubit>(),
      child: const BudgetListView(),
    );
  }
}

class BudgetListView extends StatelessWidget {
  const BudgetListView({super.key});

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
          'Budgets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.budgetAIInsights),
            icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
            tooltip: 'Get AI Insights',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<BudgetCubit, BudgetState>(
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
                  if (state is BudgetLoading) {
                    return _LoadingView(message: state.message);
                  }

                  if (state is BudgetsLoaded) {
                    if (state.budgets.isEmpty) {
                      return const _EmptyStateView();
                    }
                    return _BudgetsListView(
                      budgets: state.budgets,
                      totalBudgetAmount: state.totalBudgetAmount,
                      totalSpentAmount: state.totalSpentAmount,
                    );
                  }

                  // Initial state - load budgets
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<BudgetCubit>().loadBudgets();
                  });

                  return const _LoadingView(message: 'Loading budgets...');
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.createBudget),
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _BudgetsListView extends StatelessWidget {
  final List<pb.BudgetMessage> budgets;
  final double totalBudgetAmount;
  final double totalSpentAmount;

  const _BudgetsListView({
    required this.budgets,
    required this.totalBudgetAmount,
    required this.totalSpentAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final overallPercentage = totalBudgetAmount > 0
        ? (totalSpentAmount / totalBudgetAmount * 100)
        : 0.0;

    return RefreshIndicator(
      onRefresh: () => context.read<BudgetCubit>().loadBudgets(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Summary Card
          _SummaryCard(
            totalBudgetAmount: totalBudgetAmount,
            totalSpentAmount: totalSpentAmount,
            overallPercentage: overallPercentage,
          ),
          SizedBox(height: 24.h),

          // Budget List
          ...budgets.map((budget) => _BudgetCard(budget: budget)),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double totalBudgetAmount;
  final double totalSpentAmount;
  final double overallPercentage;

  const _SummaryCard({
    required this.totalBudgetAmount,
    required this.totalSpentAmount,
    required this.overallPercentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
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
              const Text(
                'Total Budget',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(totalBudgetAmount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Progress Ring
          SizedBox(
            height: 120.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                  width: 100.h,
                  child: CircularProgressIndicator(
                    value: overallPercentage / 100,
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFF2D2D2D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      overallPercentage >= 90
                          ? const Color(0xFFEF4444)
                          : overallPercentage >= 70
                              ? const Color(0xFFFB923C)
                              : const Color(0xFF3B82F6),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${overallPercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Used',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spent',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CurrencySymbols.formatAmount(totalSpentAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Remaining',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CurrencySymbols.formatAmount(totalBudgetAmount - totalSpentAmount),
                    style: TextStyle(
                      color: (totalBudgetAmount - totalSpentAmount) >= 0
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  final pb.BudgetMessage budget;

  const _BudgetCard({required this.budget, super.key});

  @override
  Widget build(BuildContext context) {
    final percentage = budget.amount > 0
        ? (budget.spentAmount / budget.amount * 100).clamp(0, 100)
        : 0.0;

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.budgetDetail,
        arguments: {'budgetId': budget.id},
      ),
      child: Container(
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
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ExpenseCategoryHelpers.getCategoryColor(budget.category)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    ExpenseCategoryHelpers.getCategoryIcon(budget.category),
                    color: ExpenseCategoryHelpers.getCategoryColor(budget.category),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        ExpenseCategoryHelpers.getCategoryDisplayName(budget.category),
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ExpenseCategoryHelpers.getStatusColor(budget.status)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    ExpenseCategoryHelpers.getStatusDisplayName(budget.status),
                    style: TextStyle(
                      color: ExpenseCategoryHelpers.getStatusColor(budget.status),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: const Color(0xFF2D2D2D),
                valueColor: AlwaysStoppedAnimation<Color>(
                  percentage >= 90
                      ? const Color(0xFFEF4444)
                      : percentage >= 70
                          ? const Color(0xFFFB923C)
                          : const Color(0xFF3B82F6),
                ),
                minHeight: 6.h,
              ),
            ),
            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${CurrencySymbols.formatAmount(budget.spentAmount)} spent',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${CurrencySymbols.formatAmount(budget.amount)} budget',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStateView extends StatelessWidget {
  const _EmptyStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                size: 48.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 24.h),
            const Text(
              'No Budgets Yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            const Text(
              'Create your first budget to start tracking\nyour spending and reach your financial goals.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed(AppRoutes.createBudget),
              icon: const Icon(Icons.add),
              label: const Text('Create Budget'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String? message;

  const _LoadingView({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF3B82F6),
          ),
          SizedBox(height: 16.h),
          Text(
            message ?? 'Loading...',
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
