import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/statistics.pb.dart';
import '../../../../generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;
import '../../../statistics/data/statistics_repository.dart';
import '../../cubit/statistics_cubit.dart';
import '../../cubit/statistics_state.dart';

/// Widget displaying a list of expenses
class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is! StatisticsLoaded) {
          return const Center(
            child: Text('No data available'),
          );
        }

        final expenses = state.expenses;

        if (expenses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No expenses yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the + button to add your first expense',
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
            await context.read<StatisticsCubit>().loadExpenses();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: expenses.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return _ExpenseCard(expense: expense);
            },
          ),
        );
      },
    );
  }
}

/// Card widget for displaying a single expense
class _ExpenseCard extends StatelessWidget {
  final ExpenseMessage expense;

  const _ExpenseCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _showExpenseDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Category icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(expense.category).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getCategoryIcon(expense.category),
                      color: _getCategoryColor(expense.category),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Expense info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getCategoryName(expense.category),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (expense.description.isNotEmpty)
                          Text(
                            expense.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),

                  // Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${expense.currency} ${expense.amount.toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                      Text(
                        _formatDate(expense.transactionDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (expense.merchant.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.store, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      expense.merchant,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],

              if (expense.isRecurring) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.repeat, size: 12, color: Colors.blue[700]),
                      const SizedBox(width: 4),
                      Text(
                        'Recurring',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showExpenseDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ExpenseDetailsSheet(expense: expense),
    );
  }

  String _formatDate(timestamp_pb.Timestamp timestamp) {
    final date = StatisticsRepository.fromProtoTimestamp(timestamp);
    return '${date.month}/${date.day}/${date.year}';
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return Icons.restaurant;
      case ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return Icons.directions_car;
      case ExpenseCategory.EXPENSE_CATEGORY_SHOPPING:
        return Icons.shopping_bag;
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return Icons.movie;
      case ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES:
        return Icons.receipt;
      case ExpenseCategory.EXPENSE_CATEGORY_HEALTHCARE:
        return Icons.medical_services;
      case ExpenseCategory.EXPENSE_CATEGORY_EDUCATION:
        return Icons.school;
      case ExpenseCategory.EXPENSE_CATEGORY_TRAVEL:
        return Icons.flight;
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return Icons.local_grocery_store;
      case ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE:
        return Icons.home;
      case ExpenseCategory.EXPENSE_CATEGORY_INSURANCE:
        return Icons.security;
      case ExpenseCategory.EXPENSE_CATEGORY_INVESTMENTS:
        return Icons.trending_up;
      case ExpenseCategory.EXPENSE_CATEGORY_GIFTS_DONATIONS:
        return Icons.card_giftcard;
      case ExpenseCategory.EXPENSE_CATEGORY_PERSONAL_CARE:
        return Icons.spa;
      case ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS:
        return Icons.subscriptions;
      default:
        return Icons.payment;
    }
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return Colors.orange;
      case ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return Colors.blue;
      case ExpenseCategory.EXPENSE_CATEGORY_SHOPPING:
        return Colors.purple;
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return Colors.pink;
      case ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES:
        return Colors.red;
      case ExpenseCategory.EXPENSE_CATEGORY_HEALTHCARE:
        return Colors.green;
      case ExpenseCategory.EXPENSE_CATEGORY_EDUCATION:
        return Colors.indigo;
      case ExpenseCategory.EXPENSE_CATEGORY_TRAVEL:
        return Colors.teal;
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return Colors.lightGreen;
      case ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE:
        return Colors.brown;
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
      case ExpenseCategory.EXPENSE_CATEGORY_SHOPPING:
        return 'Shopping';
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return 'Entertainment';
      case ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES:
        return 'Bills & Utilities';
      case ExpenseCategory.EXPENSE_CATEGORY_HEALTHCARE:
        return 'Healthcare';
      case ExpenseCategory.EXPENSE_CATEGORY_EDUCATION:
        return 'Education';
      case ExpenseCategory.EXPENSE_CATEGORY_TRAVEL:
        return 'Travel';
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return 'Groceries';
      case ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE:
        return 'Rent/Mortgage';
      case ExpenseCategory.EXPENSE_CATEGORY_INSURANCE:
        return 'Insurance';
      case ExpenseCategory.EXPENSE_CATEGORY_INVESTMENTS:
        return 'Investments';
      case ExpenseCategory.EXPENSE_CATEGORY_GIFTS_DONATIONS:
        return 'Gifts & Donations';
      case ExpenseCategory.EXPENSE_CATEGORY_PERSONAL_CARE:
        return 'Personal Care';
      case ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS:
        return 'Subscriptions';
      default:
        return 'Other';
    }
  }
}

/// Bottom sheet showing expense details
class _ExpenseDetailsSheet extends StatelessWidget {
  final ExpenseMessage expense;

  const _ExpenseDetailsSheet({required this.expense});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
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
                'Expense Details',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _DetailRow(
                icon: Icons.attach_money,
                label: 'Amount',
                value: '${expense.currency} ${expense.amount.toStringAsFixed(2)}',
              ),
              _DetailRow(
                icon: Icons.category,
                label: 'Category',
                value: _getCategoryName(expense.category),
              ),
              if (expense.description.isNotEmpty)
                _DetailRow(
                  icon: Icons.description,
                  label: 'Description',
                  value: expense.description,
                ),
              if (expense.merchant.isNotEmpty)
                _DetailRow(
                  icon: Icons.store,
                  label: 'Merchant',
                  value: expense.merchant,
                ),
              _DetailRow(
                icon: Icons.calendar_today,
                label: 'Date',
                value: _formatFullDate(expense.transactionDate),
              ),
              if (expense.notes.isNotEmpty)
                _DetailRow(
                  icon: Icons.note,
                  label: 'Notes',
                  value: expense.notes,
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

  String _getCategoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return 'Food & Dining';
      case ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return 'Transportation';
      case ExpenseCategory.EXPENSE_CATEGORY_SHOPPING:
        return 'Shopping';
      case ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return 'Entertainment';
      case ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES:
        return 'Bills & Utilities';
      case ExpenseCategory.EXPENSE_CATEGORY_HEALTHCARE:
        return 'Healthcare';
      case ExpenseCategory.EXPENSE_CATEGORY_EDUCATION:
        return 'Education';
      case ExpenseCategory.EXPENSE_CATEGORY_TRAVEL:
        return 'Travel';
      case ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return 'Groceries';
      case ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE:
        return 'Rent/Mortgage';
      case ExpenseCategory.EXPENSE_CATEGORY_INSURANCE:
        return 'Insurance';
      case ExpenseCategory.EXPENSE_CATEGORY_INVESTMENTS:
        return 'Investments';
      case ExpenseCategory.EXPENSE_CATEGORY_GIFTS_DONATIONS:
        return 'Gifts & Donations';
      case ExpenseCategory.EXPENSE_CATEGORY_PERSONAL_CARE:
        return 'Personal Care';
      case ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS:
        return 'Subscriptions';
      default:
        return 'Other';
    }
  }

  String _formatFullDate(timestamp_pb.Timestamp timestamp) {
    final date = StatisticsRepository.fromProtoTimestamp(timestamp);
    return '${date.month}/${date.day}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Expense'),
        content: const Text('Are you sure you want to delete this expense?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
              context.read<StatisticsCubit>().deleteExpense(expense.id);
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

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
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
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
