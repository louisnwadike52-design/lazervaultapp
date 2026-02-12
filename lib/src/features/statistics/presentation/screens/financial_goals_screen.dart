import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:intl/intl.dart';

/// Financial Goals Screen
/// Track and manage financial goals like emergency fund, vacation, car purchase, etc.
class FinancialGoalsScreen extends StatefulWidget {
  const FinancialGoalsScreen({super.key});

  @override
  State<FinancialGoalsScreen> createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {
  final List<FinancialGoal> _goals = [];

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  void _loadGoals() {
    // TODO: Load from backend
    setState(() {
      _goals.addAll([
        FinancialGoal(
          id: '1',
          name: 'Emergency Fund',
          goalType: 'Emergency Fund',
          targetAmount: 1000000,
          currentAmount: 450000,
          monthlyContribution: 50000,
          currency: 'NGN',
          targetDate: DateTime.now().add(const Duration(days: 330)),
          status: 'in_progress',
          icon: 'shield',
          color: '#3B82F6',
        ),
        FinancialGoal(
          id: '2',
          name: 'Vacation to Dubai',
          goalType: 'Vacation',
          targetAmount: 500000,
          currentAmount: 200000,
          monthlyContribution: 25000,
          currency: 'NGN',
          targetDate: DateTime.now().add(const Duration(days: 365)),
          status: 'in_progress',
          icon: 'flight',
          color: '#10B981',
        ),
        FinancialGoal(
          id: '3',
          name: 'New Car',
          goalType: 'Car',
          targetAmount: 5000000,
          currentAmount: 1500000,
          monthlyContribution: 100000,
          currency: 'NGN',
          targetDate: DateTime.now().add(const Duration(days: 720)),
          status: 'in_progress',
          icon: 'directions_car',
          color: '#F59E0B',
        ),
      ]);
    });
  }

  double get totalTarget => _goals.fold(0, (sum, g) => sum + g.targetAmount);
  double get totalSaved => _goals.fold(0, (sum, g) => sum + g.currentAmount);
  double get overallProgress => totalTarget > 0 ? (totalSaved / totalTarget * 100) : 0;

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
      body: Column(
        children: [
          _buildOverallProgressCard(),
          Expanded(
            child: _goals.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: _goals.length,
                    itemBuilder: (context, index) {
                      return _GoalCard(
                        goal: _goals[index],
                        onContribute: () => _contributeToGoal(_goals[index]),
                        onEdit: () => _editGoal(_goals[index]),
                        onDelete: () => _deleteGoal(_goals[index].id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallProgressCard() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
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
              value: overallProgress / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag, color: Colors.grey[600], size: 64.r),
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
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateGoalDialog() {
    Get.toNamed('/statistics/financial-goals/create');
  }

  void _contributeToGoal(FinancialGoal goal) {
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
            SizedBox(height: 24.h),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                prefixText: '₦ ',
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                labelText: 'Note (optional)',
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  // TODO: Process contribution
                  Get.snackbar(
                    'Success',
                    'Contribution added successfully',
                    backgroundColor: const Color(0xFF10B981),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
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

  void _editGoal(FinancialGoal goal) {
    Get.toNamed('/statistics/financial-goals/create', arguments: {'goalId': goal.id});
  }

  void _deleteGoal(String id) {
    Get.defaultDialog(
      title: 'Delete Goal',
      middleText: 'Are you sure you want to delete this goal? All progress will be lost.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF9CA3AF),
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        setState(() {
          _goals.removeWhere((g) => g.id == id);
        });
        Get.back();
        Get.snackbar('Deleted', 'Goal deleted successfully', backgroundColor: const Color(0xFF10B981));
      },
    );
  }
}

class _GoalCard extends StatelessWidget {
  final FinancialGoal goal;
  final VoidCallback onContribute;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _GoalCard({
    required this.goal,
    required this.onContribute,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = goal.targetAmount > 0
        ? (goal.currentAmount / goal.targetAmount * 100).clamp(0, 100)
        : 0.0;
    final remaining = goal.targetAmount - goal.currentAmount;
    final remainingMonths = goal.targetDate.difference(DateTime.now()).inDays ~/ 30;

    Color goalColor = const Color(0xFF3B82F6);
    try {
      goalColor = Color(int.parse(goal.color.replaceFirst('#', '0xFF')));
    } catch (e) {
      // Use default color if parsing fails
    }

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
                      goal.goalType,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  value: CurrencySymbols.formatAmount(remaining),
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
              value: percentage / 100,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(goalColor),
              minHeight: 6.h,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14.r, color: Colors.grey[500]),
              SizedBox(width: 4.w),
              Text(
                'Target: ${DateFormat('MMM y').format(goal.targetDate)}',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const Spacer(),
              if (remainingMonths > 0) ...[
                Icon(Icons.schedule, size: 14.r, color: Colors.grey[500]),
                SizedBox(width: 4.w),
                Text(
                  '$remainingMonths months left',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
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
              SizedBox(width: 8.w),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 18),
                color: Colors.grey[400],
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline, size: 18),
                color: Colors.grey[400],
              ),
            ],
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
      default:
        return Icons.flag;
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

/// Financial Goal Model
class FinancialGoal {
  final String id;
  final String name;
  final String goalType;
  final double targetAmount;
  final double currentAmount;
  final double monthlyContribution;
  final String currency;
  final DateTime targetDate;
  final String status;
  final String icon;
  final String color;

  FinancialGoal({
    required this.id,
    required this.name,
    required this.goalType,
    required this.targetAmount,
    required this.currentAmount,
    required this.monthlyContribution,
    required this.currency,
    required this.targetDate,
    required this.status,
    required this.icon,
    required this.color,
  });
}
