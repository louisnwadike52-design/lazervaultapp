part of 'financial_goals_screen.dart';

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

    Color goalColor = InvoiceThemeColors.primaryPurple;
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
