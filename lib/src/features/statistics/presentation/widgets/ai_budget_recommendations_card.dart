import 'package:flutter/material.dart';
import '../../../../generated/statistics.pb.dart';

/// AI-powered budget recommendations card widget
/// Displays AI-generated budget suggestions based on income and goals
class AIBudgetRecommendationsCard extends StatelessWidget {
  final GetAIBudgetingRecommendationsResponse? recommendations;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRefresh;
  final Function(BudgetRecommendation)? onApplyRecommendation;

  const AIBudgetRecommendationsCard({
    super.key,
    this.recommendations,
    this.isLoading = false,
    this.error,
    this.onRefresh,
    this.onApplyRecommendation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          if (isLoading) _buildLoading(),
          if (error != null) _buildError(context),
          if (recommendations != null && error == null && !isLoading) ...[
            _buildSummary(context),
            if (recommendations!.budgetRecommendations.isNotEmpty)
              _buildRecommendations(context),
            _buildTotalSavings(context),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet, color: Colors.purple.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'AI Budget Recommendations',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          if (onRefresh != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: isLoading ? null : onRefresh,
              tooltip: 'Refresh recommendations',
            ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Generating budget recommendations...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                error!,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    if (recommendations!.summary.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.shade700,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          recommendations!.summary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  Widget _buildRecommendations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Budgets',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...recommendations!.budgetRecommendations.map(
            (rec) => _buildRecommendationItem(context, rec),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(BuildContext context, BudgetRecommendation recommendation) {
    // Calculate priority based on difference amount
    final priority = _calculatePriority(recommendation.difference);
    final priorityColor = _getPriorityColor(priority);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: priorityColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getCategoryName(recommendation.category),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${recommendation.recommendedAmount.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: priorityColor,
                        ),
                  ),
                  if (recommendation.difference.abs() > 0)
                    Text(
                      'Save \$${recommendation.difference.abs().toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recommendation.reasoning,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (onApplyRecommendation != null) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => onApplyRecommendation!(recommendation),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Apply Budget'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: priorityColor),
                  foregroundColor: priorityColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTotalSavings(BuildContext context) {
    final totalSavings = recommendations!.budgetRecommendations
        .fold<double>(0, (sum, rec) => sum + rec.difference.abs());

    if (totalSavings <= 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.savings, color: Colors.green.shade700),
                const SizedBox(width: 12),
                Text(
                  'Total Potential Savings',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Text(
              '\$${totalSavings.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _calculatePriority(double difference) {
    final absAmount = difference.abs();
    if (absAmount >= 200) {
      return 'high';
    } else if (absAmount >= 100) {
      return 'medium';
    } else {
      return 'low';
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getCategoryName(ExpenseCategory category) {
    return category.name.replaceAll('EXPENSE_CATEGORY_', '').replaceAll('_', ' ');
  }
}
