import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/statistics.pb.dart';
import '../../../../generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;
import '../../../statistics/data/statistics_repository.dart';
import '../../cubit/statistics_cubit.dart';
import '../../cubit/statistics_state.dart';

/// Widget displaying a list of budgets with progress indicators
class BudgetListWidget extends StatelessWidget {
  const BudgetListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is! StatisticsLoaded) {
          return const Center(
            child: Text('No data available'),
          );
        }

        final budgets = state.budgets;
        final budgetProgress = state.budgetProgress;

        if (budgets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No budgets yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the + button to create your first budget',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await context.read<StatisticsCubit>().loadBudgets();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: budgets.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final budget = budgets[index];
              final progress = budgetProgress.firstWhere(
                (p) => p.budgetId == budget.id,
                orElse: () => BudgetProgressItem(),
              );
              return _BudgetCard(budget: budget, progress: progress);
            },
          ),
        );
      },
    );
  }
}

/// Card widget for displaying a single budget
class _BudgetCard extends StatelessWidget {
  final BudgetMessage budget;
  final BudgetProgressItem progress;

  const _BudgetCard({
    required this.budget,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentageUsed = progress.hasPercentageUsed() ? progress.percentageUsed : 0.0;
    final spent = progress.hasSpentAmount() ? progress.spentAmount : 0.0;
    final remaining = budget.amount - spent;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _showBudgetDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budget.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getPeriodName(budget.period),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _StatusChip(status: budget.status),
                ],
              ),
              const SizedBox(height: 16),

              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Spent: ${budget.currency} ${spent.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        '${percentageUsed.toStringAsFixed(1)}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percentageUsed / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getProgressColor(percentageUsed),
                    ),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Remaining: ${budget.currency} ${remaining.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: remaining >= 0 ? Colors.green[700] : Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Budget: ${budget.currency} ${budget.amount.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),

              if (budget.category != ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED) ...[
                const SizedBox(height: 12),
                Chip(
                  avatar: Icon(
                    _getCategoryIcon(budget.category),
                    size: 16,
                  ),
                  label: Text(_getCategoryName(budget.category)),
                  backgroundColor: _getCategoryColor(budget.category).withOpacity(0.1),
                ),
              ],

            ],
          ),
        ),
      ),
    );
  }

  void _showBudgetDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _BudgetDetailsSheet(budget: budget, progress: progress),
    );
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 100) return Colors.red;
    if (percentage >= 80) return Colors.orange;
    if (percentage >= 60) return Colors.yellow[700]!;
    return Colors.green;
  }

  String _getPeriodName(BudgetPeriod period) {
    switch (period) {
      case BudgetPeriod.BUDGET_PERIOD_DAILY:
        return 'Daily';
      case BudgetPeriod.BUDGET_PERIOD_WEEKLY:
        return 'Weekly';
      case BudgetPeriod.BUDGET_PERIOD_MONTHLY:
        return 'Monthly';
      case BudgetPeriod.BUDGET_PERIOD_QUARTERLY:
        return 'Quarterly';
      case BudgetPeriod.BUDGET_PERIOD_YEARLY:
        return 'Yearly';
      case BudgetPeriod.BUDGET_PERIOD_CUSTOM:
        return 'Custom';
      default:
        return 'Unknown';
    }
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return Icons.restaurant;
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return Icons.local_grocery_store;
      case ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return Icons.directions_car;
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return Icons.movie;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return Colors.orange;
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return Colors.lightGreen;
      case ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return Colors.blue;
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  String _getCategoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return 'Food & Dining';
      case ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return 'Transportation';
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return 'Groceries';
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return 'Entertainment';
      default:
        return 'Other';
    }
  }
}

/// Status chip widget
class _StatusChip extends StatelessWidget {
  final BudgetStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusInfo['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusInfo['color']),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusInfo['icon'],
            size: 16,
            color: statusInfo['color'],
          ),
          const SizedBox(width: 4),
          Text(
            statusInfo['label'],
            style: TextStyle(
              color: statusInfo['color'],
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo(BudgetStatus status) {
    switch (status) {
      case BudgetStatus.BUDGET_STATUS_ACTIVE:
        return {'label': 'Active', 'color': Colors.green, 'icon': Icons.check_circle};
      case BudgetStatus.BUDGET_STATUS_EXCEEDED:
        return {'label': 'Exceeded', 'color': Colors.red, 'icon': Icons.error};
      case BudgetStatus.BUDGET_STATUS_NEAR_LIMIT:
        return {'label': 'Near Limit', 'color': Colors.orange, 'icon': Icons.warning};
      case BudgetStatus.BUDGET_STATUS_INACTIVE:
        return {'label': 'Inactive', 'color': Colors.grey, 'icon': Icons.pause_circle};
      case BudgetStatus.BUDGET_STATUS_COMPLETED:
        return {'label': 'Completed', 'color': Colors.blue, 'icon': Icons.done_all};
      default:
        return {'label': 'Unknown', 'color': Colors.grey, 'icon': Icons.help};
    }
  }
}

/// Bottom sheet showing budget details
class _BudgetDetailsSheet extends StatelessWidget {
  final BudgetMessage budget;
  final BudgetProgressItem progress;

  const _BudgetDetailsSheet({
    required this.budget,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spent = progress.hasSpentAmount() ? progress.spentAmount : 0.0;
    final remaining = budget.amount - spent;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                budget.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _DetailRow(
                icon: Icons.attach_money,
                label: 'Budget Amount',
                value: '${budget.currency} ${budget.amount.toStringAsFixed(2)}',
              ),
              _DetailRow(
                icon: Icons.shopping_cart,
                label: 'Spent',
                value: '${budget.currency} ${spent.toStringAsFixed(2)}',
              ),
              _DetailRow(
                icon: Icons.account_balance,
                label: 'Remaining',
                value: '${budget.currency} ${remaining.toStringAsFixed(2)}',
                valueColor: remaining >= 0 ? Colors.green : Colors.red,
              ),
              _DetailRow(
                icon: Icons.calendar_view_month,
                label: 'Period',
                value: _getPeriodName(budget.period),
              ),
              _DetailRow(
                icon: Icons.date_range,
                label: 'Start Date',
                value: _formatDate(budget.startDate),
              ),
              _DetailRow(
                icon: Icons.event,
                label: 'End Date',
                value: _formatDate(budget.endDate),
              ),
              if (budget.hasAlertThreshold())
                _DetailRow(
                  icon: Icons.notifications,
                  label: 'Alert Threshold',
                  value: '${budget.alertThreshold.toStringAsFixed(0)}%',
                ),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Navigate to edit screen
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _confirmDelete(context);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getPeriodName(BudgetPeriod period) {
    switch (period) {
      case BudgetPeriod.BUDGET_PERIOD_DAILY:
        return 'Daily';
      case BudgetPeriod.BUDGET_PERIOD_WEEKLY:
        return 'Weekly';
      case BudgetPeriod.BUDGET_PERIOD_MONTHLY:
        return 'Monthly';
      case BudgetPeriod.BUDGET_PERIOD_QUARTERLY:
        return 'Quarterly';
      case BudgetPeriod.BUDGET_PERIOD_YEARLY:
        return 'Yearly';
      case BudgetPeriod.BUDGET_PERIOD_CUSTOM:
        return 'Custom';
      default:
        return 'Unknown';
    }
  }

  String _formatDate(timestamp_pb.Timestamp timestamp) {
    final date = StatisticsRepository.fromProtoTimestamp(timestamp);
    return '${date.month}/${date.day}/${date.year}';
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Budget'),
        content: const Text('Are you sure you want to delete this budget?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
              context.read<StatisticsCubit>().deleteBudget(budget.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying a detail row
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: valueColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
