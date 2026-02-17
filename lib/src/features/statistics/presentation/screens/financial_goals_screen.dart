import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:intl/intl.dart';

/// Financial Goals Screen
/// Track and manage financial goals like emergency fund, vacation, car purchase, etc.
class FinancialGoalsScreen extends StatefulWidget {
  const FinancialGoalsScreen({super.key});

  @override
  State<FinancialGoalsScreen> createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetCubit>().loadFinancialGoals();
    });
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
          'Financial Goals',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showCreateGoalDialog(),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
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
          if (state is BudgetCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF10B981)),
            );
          }

          if (state is FinancialGoalsLoaded) {
            return Column(
              children: [
                _buildOverallProgressCard(
                  totalSaved: state.totalSaved,
                  totalTarget: state.totalTarget,
                ),
                Expanded(
                  child: state.goals.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: () => context.read<BudgetCubit>().loadFinancialGoals(),
                          color: const Color(0xFF10B981),
                          backgroundColor: const Color(0xFF1F1F1F),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.all(16.w),
                            itemCount: state.goals.length,
                            itemBuilder: (context, index) {
                              return _GoalCard(
                                goal: state.goals[index],
                                onContribute: () => _contributeToGoal(state.goals[index]),
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          }

          if (state is BudgetError) {
            return _buildErrorState(state.message);
          }

          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF10B981)),
          );
        },
      ),
    );
  }

  Widget _buildOverallProgressCard({
    required double totalSaved,
    required double totalTarget,
  }) {
    final overallProgress = totalTarget > 0 ? (totalSaved / totalTarget * 100) : 0.0;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D9668), Color(0xFF10B981), Color(0xFF34D399)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall Progress',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${overallProgress.toStringAsFixed(0)}%',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      CurrencySymbols.formatAmount(totalSaved),
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Target',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      CurrencySymbols.formatAmount(totalTarget),
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: (overallProgress / 100).clamp(0.0, 1.0),
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.flag, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 40.r),
              ),
              SizedBox(height: 16.h),
              Text(
                'No financial goals yet',
                style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Set goals to stay motivated and on track',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () => _showCreateGoalDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Create Goal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
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
            onPressed: () => context.read<BudgetCubit>().loadFinancialGoals(),
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

  void _showCreateGoalDialog() {
    final nameController = TextEditingController();
    final targetController = TextEditingController();
    final monthlyController = TextEditingController();
    pb.GoalType selectedType = pb.GoalType.GOAL_TYPE_CUSTOM;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: StatefulBuilder(
          builder: (context, setSheetState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  const Text(
                    'Create Financial Goal',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24.h),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Goal Name',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<pb.GoalType>(
                        value: selectedType,
                        dropdownColor: const Color(0xFF2D2D2D),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        items: [
                          pb.GoalType.GOAL_TYPE_EMERGENCY_FUND,
                          pb.GoalType.GOAL_TYPE_VACATION,
                          pb.GoalType.GOAL_TYPE_CAR,
                          pb.GoalType.GOAL_TYPE_HOUSE,
                          pb.GoalType.GOAL_TYPE_EDUCATION,
                          pb.GoalType.GOAL_TYPE_RETIREMENT,
                          pb.GoalType.GOAL_TYPE_WEDDING,
                          pb.GoalType.GOAL_TYPE_DEBT_PAYOFF,
                          pb.GoalType.GOAL_TYPE_CUSTOM,
                        ].map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(_goalTypeLabel(type)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) setSheetState(() => selectedType = value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: targetController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Target Amount',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      prefixText: '${CurrencySymbols.currentSymbol} ',
                      prefixStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: monthlyController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Monthly Contribution',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      prefixText: '${CurrencySymbols.currentSymbol} ',
                      prefixStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        final target = double.tryParse(targetController.text.trim()) ?? 0;
                        final monthly = double.tryParse(monthlyController.text.trim()) ?? 0;

                        if (name.isEmpty || target <= 0) {
                          Get.snackbar('Error', 'Please enter a name and target amount',
                              backgroundColor: const Color(0xFFEF4444));
                          return;
                        }

                        Get.back();
                        context.read<BudgetCubit>().createFinancialGoal(
                          name: name,
                          goalType: selectedType,
                          targetAmount: target,
                          monthlyContribution: monthly,
                          currency: CurrencySymbols.currentCurrency,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: const Text('Create Goal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _contributeToGoal(pb.FinancialGoal goal) {
    final amountController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 24.h),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Text(
              'Contribute to ${goal.name}',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Remaining: ${CurrencySymbols.formatAmount(goal.targetAmount - goal.currentAmount)}',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            SizedBox(height: 24.h),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                prefixText: '${CurrencySymbols.currentSymbol} ',
                prefixStyle: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountController.text.trim()) ?? 0;
                  if (amount <= 0) {
                    Get.snackbar('Error', 'Please enter a valid amount',
                        backgroundColor: const Color(0xFFEF4444));
                    return;
                  }

                  Get.back();
                  context.read<BudgetCubit>().contributeToGoal(
                    goalId: goal.id,
                    amount: amount,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: const Text('Add Contribution', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _goalTypeLabel(pb.GoalType type) {
    switch (type) {
      case pb.GoalType.GOAL_TYPE_EMERGENCY_FUND:
        return 'Emergency Fund';
      case pb.GoalType.GOAL_TYPE_VACATION:
        return 'Vacation';
      case pb.GoalType.GOAL_TYPE_CAR:
        return 'Car';
      case pb.GoalType.GOAL_TYPE_HOUSE:
        return 'House';
      case pb.GoalType.GOAL_TYPE_EDUCATION:
        return 'Education';
      case pb.GoalType.GOAL_TYPE_RETIREMENT:
        return 'Retirement';
      case pb.GoalType.GOAL_TYPE_WEDDING:
        return 'Wedding';
      case pb.GoalType.GOAL_TYPE_DEBT_PAYOFF:
        return 'Debt Payoff';
      case pb.GoalType.GOAL_TYPE_CUSTOM:
        return 'Custom';
      default:
        return 'Other';
    }
  }
}

class _GoalCard extends StatelessWidget {
  final pb.FinancialGoal goal;
  final VoidCallback onContribute;

  const _GoalCard({
    required this.goal,
    required this.onContribute,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = goal.percentageComplete.clamp(0, 100);
    final remaining = goal.targetAmount - goal.currentAmount;

    Color goalColor = const Color(0xFF10B981);
    if (goal.color.isNotEmpty) {
      try {
        goalColor = Color(int.parse(goal.color.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }

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
        boxShadow: [
          BoxShadow(
            color: goalColor.withValues(alpha: 0.1),
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
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: goalColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    _getIconForGoal(goal.icon),
                    color: goalColor,
                    size: 24.r,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _goalTypeLabel(goal.goalType),
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: goalColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _ProgressItem(
                  label: 'Saved',
                  value: CurrencySymbols.formatAmount(goal.currentAmount),
                ),
              ),
              Expanded(
                child: _ProgressItem(
                  label: 'Remaining',
                  value: CurrencySymbols.formatAmount(remaining > 0 ? remaining : 0),
                ),
              ),
              Expanded(
                child: _ProgressItem(
                  label: 'Monthly',
                  value: CurrencySymbols.formatAmount(goal.monthlyContribution),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: (percentage / 100).clamp(0.0, 1.0),
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(goalColor),
              minHeight: 6.h,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (goal.hasTargetDate()) ...[
                Icon(Icons.calendar_today, size: 14.r, color: Colors.grey[500]),
                SizedBox(width: 4.w),
                Text(
                  'Target: ${DateFormat('MMM y').format(goal.targetDate.toDateTime())}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
              const Spacer(),
              if (goal.monthsRemaining > 0) ...[
                Icon(Icons.schedule, size: 14.r, color: Colors.grey[500]),
                SizedBox(width: 4.w),
                Text(
                  '${goal.monthsRemaining} months left',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onContribute,
              icon: const Icon(Icons.add_circle_outline, size: 16),
              label: const Text('Add Money'),
              style: ElevatedButton.styleFrom(
                backgroundColor: goalColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForGoal(String? icon) {
    switch (icon) {
      case 'shield':
        return Icons.shield;
      case 'flight':
        return Icons.flight;
      case 'directions_car':
        return Icons.directions_car;
      case 'home':
        return Icons.home;
      case 'school':
        return Icons.school;
      case 'card_giftcard':
        return Icons.card_giftcard;
      case 'savings':
        return Icons.savings;
      case 'favorite':
        return Icons.favorite;
      default:
        return Icons.flag;
    }
  }

  String _goalTypeLabel(pb.GoalType type) {
    switch (type) {
      case pb.GoalType.GOAL_TYPE_EMERGENCY_FUND:
        return 'Emergency Fund';
      case pb.GoalType.GOAL_TYPE_VACATION:
        return 'Vacation';
      case pb.GoalType.GOAL_TYPE_CAR:
        return 'Car';
      case pb.GoalType.GOAL_TYPE_HOUSE:
        return 'House';
      case pb.GoalType.GOAL_TYPE_EDUCATION:
        return 'Education';
      case pb.GoalType.GOAL_TYPE_RETIREMENT:
        return 'Retirement';
      case pb.GoalType.GOAL_TYPE_WEDDING:
        return 'Wedding';
      case pb.GoalType.GOAL_TYPE_DEBT_PAYOFF:
        return 'Debt Payoff';
      case pb.GoalType.GOAL_TYPE_CUSTOM:
        return 'Custom';
      default:
        return 'Other';
    }
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String value;

  const _ProgressItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11.sp)),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
