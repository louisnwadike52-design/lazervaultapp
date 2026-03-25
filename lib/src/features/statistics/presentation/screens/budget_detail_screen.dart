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

/// Budget Detail Screen
class BudgetDetailScreen extends StatefulWidget {
  const BudgetDetailScreen({super.key});

  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {
  late final String? budgetId;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    budgetId = args?['budgetId'] as String?;

    if (budgetId == null) {
      // Invalid navigation — go back on next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Get.back();
      });
      return;
    }

    // Only load if we don't already have budgets in state
    final currentState = context.read<BudgetCubit>().state;
    if (currentState is! BudgetsLoaded) {
      context.read<BudgetCubit>().loadBudgets();
    }
  }

  pb.BudgetMessage? _findBudget(BudgetState state) {
    if (state is! BudgetsLoaded || state.budgets.isEmpty || budgetId == null) {
      return null;
    }
    try {
      return state.budgets.firstWhere((b) => b.id == budgetId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (budgetId == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF10B981))),
      );
    }

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
          'Budget Details',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF1F1F1F),
            onSelected: (value) {
              if (value == 'edit') {
                final budget = _findBudget(context.read<BudgetCubit>().state);
                if (budget != null) {
                  Get.toNamed(AppRoutes.createBudget, arguments: {'budget': budget});
                }
              } else if (value == 'delete') {
                _showDeleteDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit Budget')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Budget', style: TextStyle(color: Color(0xFFEF4444))),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {
          if (state is BudgetDeleted) {
            Get.back(); // Navigate back after successful delete
            Get.snackbar(
              'Deleted',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else if (state is BudgetUpdated) {
            Get.snackbar(
              'Updated',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else if (state is BudgetError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            // Retry loading
            context.read<BudgetCubit>().loadBudgets();
          }
        },
        builder: (context, state) {
          if (state is BudgetLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF10B981)),
                  SizedBox(height: 16.h),
                  Text(
                    state.message ?? 'Loading...',
                    style: const TextStyle(color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            );
          }

          final budget = _findBudget(state);
          if (budget != null) {
            return _BudgetDetailView(budget: budget);
          }

          // Budget not found — may have been deleted or not yet loaded
          if (state is BudgetsLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48.sp, color: const Color(0xFF9CA3AF)),
                  SizedBox(height: 16.h),
                  const Text(
                    'Budget not found',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  const Text(
                    'This budget may have been deleted.',
                    style: TextStyle(color: Color(0xFF9CA3AF)),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF10B981)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.budgetAIInsights),
        backgroundColor: const Color(0xFF10B981),
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text('AI Insights', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    if (_isDeleting) return;
    Get.defaultDialog(
      title: 'Delete Budget',
      middleText: 'Are you sure you want to delete this budget? This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF9CA3AF),
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        _isDeleting = true;
        Get.back(); // Close dialog
        context.read<BudgetCubit>().deleteBudget(budgetId!);
      },
    );
  }
}

class _BudgetDetailView extends StatelessWidget {
  final pb.BudgetMessage budget;

  const _BudgetDetailView({required this.budget, super.key});

  @override
  Widget build(BuildContext context) {
    final percentage = budget.amount > 0
        ? (budget.spentAmount / budget.amount * 100).clamp(0, 100)
        : 0.0;
    final remaining = budget.amount - budget.spentAmount;

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        // Hero Section with Circular Progress
        SizedBox(
          height: 250.h,
          child: Center(
            child: SizedBox(
              height: 180.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 160.h,
                    width: 160.h,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 12,
                      backgroundColor: const Color(0xFF1F1F1F),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percentage >= 90
                            ? const Color(0xFFEF4444)
                            : percentage >= 70
                                ? const Color(0xFFFB923C)
                                : const Color(0xFF10B981),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        budget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: percentage >= 90
                              ? const Color(0xFFEF4444)
                              : percentage >= 70
                                  ? const Color(0xFFFB923C)
                                  : const Color(0xFF10B981),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Used',
                        style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Stats Row
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(label: 'Spent', value: CurrencySymbols.formatAmount(budget.spentAmount)),
              _StatItem(label: 'Remaining', value: CurrencySymbols.formatAmount(remaining)),
              _StatItem(label: 'Daily Avg', value: CurrencySymbols.formatAmount(budget.spentAmount / 30)),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Category & Period
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              _DetailRow(
                  label: 'Category',
                  value: ExpenseCategoryHelpers.getCategoryDisplayName(budget.category)),
              _DetailRow(
                  label: 'Period',
                  value: ExpenseCategoryHelpers.getPeriodDisplayName(budget.period)),
              _DetailRow(
                  label: 'Status',
                  value: ExpenseCategoryHelpers.getStatusDisplayName(budget.status)),
              _DetailRow(
                  label: 'Enforcement',
                  value: budget.enforcementMode == pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_STRICT
                      ? 'Strict (blocks transactions)'
                      : 'Flexible (warns only)'),
              _DetailRow(label: 'Alerts', value: budget.enableAlerts ? 'Enabled' : 'Disabled'),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Projection
        if (percentage >= 70)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: percentage >= 90
                    ? const Color(0xFFEF4444).withValues(alpha: 0.1)
                    : const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        percentage >= 90 ? Icons.warning : Icons.info_outline,
                        color: percentage >= 90 ? const Color(0xFFEF4444) : const Color(0xFFFB923C),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          percentage >= 90
                              ? 'Budget will be exceeded'
                              : 'Approaching budget limit',
                          style: TextStyle(
                            color: percentage >= 90 ? const Color(0xFFEF4444) : const Color(0xFFFB923C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'At your current spending rate, you will exceed this budget by the end of the period.',
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.h),
        Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF))),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
