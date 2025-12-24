import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/statistics.pb.dart';
import '../../cubit/statistics_cubit.dart';
import '../../cubit/statistics_state.dart';

/// Widget displaying analytics dashboard with spending insights
class AnalyticsDashboardWidget extends StatelessWidget {
  const AnalyticsDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is! StatisticsLoaded) {
          return const Center(
            child: Text('No data available'),
          );
        }

        final analytics = state.analytics;
        final categoryBreakdown = state.categoryBreakdown;

        if (analytics == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No analytics available',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start adding expenses to see analytics',
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
            await context.read<StatisticsCubit>().loadAnalytics();
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Summary cards
              _SummaryCard(
                title: 'Total Spent',
                amount: analytics.totalSpent,
                icon: Icons.shopping_cart,
                color: Colors.red,
              ),
              const SizedBox(height: 12),
              _SummaryCard(
                title: 'Total Budget',
                amount: analytics.totalBudget,
                icon: Icons.account_balance_wallet,
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              _SummaryCard(
                title: 'Remaining',
                amount: analytics.remainingBudget,
                icon: Icons.savings,
                color: analytics.remainingBudget >= 0 ? Colors.green : Colors.red,
              ),

              const SizedBox(height: 24),
              Text(
                'Spending by Category',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Category breakdown
              if (categoryBreakdown.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('No category data available'),
                  ),
                )
              else
                ...categoryBreakdown.map((category) {
                  return _CategoryBreakdownCard(category: category);
                }).toList(),

              const SizedBox(height: 16),

              // Budget health indicator
              _BudgetHealthCard(analytics: analytics),
            ],
          ),
        );
      },
    );
  }
}

/// Summary card widget
class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category breakdown card
class _CategoryBreakdownCard extends StatelessWidget {
  final CategorySpending category;

  const _CategoryBreakdownCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getCategoryIcon(category.category),
                  color: _getCategoryColor(category.category),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category.categoryName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${category.amount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor(category.category),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: category.percentage / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getCategoryColor(category.category),
                    ),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${category.percentage.toStringAsFixed(1)}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      case ExpenseCategory.EXPENSE_CATEGORY_INSURANCE:
        return Colors.cyan;
      case ExpenseCategory.EXPENSE_CATEGORY_INVESTMENTS:
        return Colors.deepPurple;
      case ExpenseCategory.EXPENSE_CATEGORY_GIFTS_DONATIONS:
        return Colors.pinkAccent;
      case ExpenseCategory.EXPENSE_CATEGORY_PERSONAL_CARE:
        return Colors.amber;
      case ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS:
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }
}

/// Budget health indicator card
class _BudgetHealthCard extends StatelessWidget {
  final SpendingAnalytics analytics;

  const _BudgetHealthCard({required this.analytics});

  @override
  Widget build(BuildContext context) {
    final percentage = analytics.totalBudget > 0
        ? (analytics.totalSpent / analytics.totalBudget) * 100
        : 0.0;

    final healthInfo = _getHealthInfo(percentage);

    return Card(
      elevation: 2,
      color: healthInfo['color'].withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  healthInfo['icon'],
                  color: healthInfo['color'],
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budget Health',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        healthInfo['status'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: healthInfo['color'],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(healthInfo['color']),
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 8),
            Text(
              healthInfo['message'],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HealthStat(
                  label: 'Budget Used',
                  value: '${percentage.toStringAsFixed(1)}%',
                ),
                _HealthStat(
                  label: 'Period',
                  value: analytics.period,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getHealthInfo(double percentage) {
    if (percentage >= 100) {
      return {
        'status': 'Over Budget',
        'color': Colors.red,
        'icon': Icons.error,
        'message': 'You have exceeded your budget. Consider reviewing your expenses.',
      };
    } else if (percentage >= 80) {
      return {
        'status': 'Near Limit',
        'color': Colors.orange,
        'icon': Icons.warning,
        'message': 'You\'re approaching your budget limit. Be mindful of spending.',
      };
    } else if (percentage >= 60) {
      return {
        'status': 'On Track',
        'color': Colors.yellow[700],
        'icon': Icons.trending_up,
        'message': 'You\'re using your budget at a healthy pace.',
      };
    } else {
      return {
        'status': 'Excellent',
        'color': Colors.green,
        'icon': Icons.check_circle,
        'message': 'Great job! You\'re well within your budget.',
      };
    }
  }
}

/// Health stat widget
class _HealthStat extends StatelessWidget {
  final String label;
  final String value;

  const _HealthStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
