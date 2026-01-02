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
                }),

              const SizedBox(height: 16),

              // Budget health indicator
              _BudgetHealthCard(analytics: analytics),

              const SizedBox(height: 32),

              // Comprehensive Financial Summary (Manual + Tracked)
              if (state.comprehensiveSummary != null) ...[
                Text(
                  'Comprehensive Financial Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Combines manual entries + automatic tracking',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 16),
                _ComprehensiveSummaryCard(summary: state.comprehensiveSummary!),
                const SizedBox(height: 24),
              ],

              // Tracked Transactions Section
              Text(
                'Automatic Transaction Tracking',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Automatically tracked from transfers, deposits, withdrawals, payments, etc.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),

              // Tracked Income and Expenditure Cards
              _TrackedTransactionsSummary(
                trackedIncome: state.trackedIncome,
                trackedExpenditure: state.trackedExpenditure,
              ),

              const SizedBox(height: 24),

              // Tracked Income Breakdown
              if (state.trackedIncomeBreakdown.isNotEmpty) ...[
                Text(
                  'Tracked Income by Source',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ...state.trackedIncomeBreakdown.entries.map((entry) {
                  return _TrackedBreakdownCard(
                    label: _formatSourceType(entry.key),
                    amount: entry.value,
                    color: Colors.green,
                  );
                }),
                const SizedBox(height: 16),
              ],

              // Tracked Expenditure Breakdown
              if (state.trackedExpenditureBreakdown.isNotEmpty) ...[
                Text(
                  'Tracked Expenditure by Type',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ...state.trackedExpenditureBreakdown.entries.map((entry) {
                  return _TrackedBreakdownCard(
                    label: _formatExpenseType(entry.key),
                    amount: entry.value,
                    color: Colors.red,
                  );
                }),
              ],
            ],
          ),
        );
      },
    );
  }

  String _formatSourceType(String type) {
    return type.split('_').map((word) =>
      word[0].toUpperCase() + word.substring(1).toLowerCase()
    ).join(' ');
  }

  String _formatExpenseType(String type) {
    return type.split('_').map((word) =>
      word[0].toUpperCase() + word.substring(1).toLowerCase()
    ).join(' ');
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

/// Comprehensive Financial Summary Card
class _ComprehensiveSummaryCard extends StatelessWidget {
  final ComprehensiveFinancialSummary summary;

  const _ComprehensiveSummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final netIncomeColor = summary.netIncome >= 0 ? Colors.green : Colors.red;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period info
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  _formatPeriod(summary.period),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Income section
            _FinancialDataRow(
              label: 'Total Income',
              manualAmount: summary.income.manualIncome,
              trackedAmount: summary.income.trackedIncome,
              totalAmount: summary.income.totalIncome,
              color: Colors.green,
            ),
            const SizedBox(height: 12),

            // Expenditure section
            _FinancialDataRow(
              label: 'Total Expenditure',
              manualAmount: summary.expenditure.manualExpenses,
              trackedAmount: summary.expenditure.trackedExpenditure,
              totalAmount: summary.expenditure.totalExpenditure,
              color: Colors.red,
            ),
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // Net income
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Net Income',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${summary.netIncome.toStringAsFixed(2)}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: netIncomeColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Savings rate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Savings Rate',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${summary.savingsRate.toStringAsFixed(1)}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPeriod(ComprehensivePeriod period) {
    final startDate = DateTime.fromMillisecondsSinceEpoch(
      period.startDate.seconds.toInt() * 1000,
    );
    final endDate = DateTime.fromMillisecondsSinceEpoch(
      period.endDate.seconds.toInt() * 1000,
    );

    return '${_formatDate(startDate)} - ${_formatDate(endDate)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Financial data row showing manual, tracked, and total amounts
class _FinancialDataRow extends StatelessWidget {
  final String label;
  final double manualAmount;
  final double trackedAmount;
  final double totalAmount;
  final Color color;

  const _FinancialDataRow({
    required this.label,
    required this.manualAmount,
    required this.trackedAmount,
    required this.totalAmount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Manual:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              '\$${manualAmount.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tracked:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              '\$${trackedAmount.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Tracked transactions summary widget
class _TrackedTransactionsSummary extends StatelessWidget {
  final double trackedIncome;
  final double trackedExpenditure;

  const _TrackedTransactionsSummary({
    required this.trackedIncome,
    required this.trackedExpenditure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryCard(
          title: 'Tracked Income',
          amount: trackedIncome,
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        const SizedBox(height: 12),
        _SummaryCard(
          title: 'Tracked Expenditure',
          amount: trackedExpenditure,
          icon: Icons.trending_down,
          color: Colors.red,
        ),
      ],
    );
  }
}

/// Tracked breakdown card widget
class _TrackedBreakdownCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _TrackedBreakdownCard({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
