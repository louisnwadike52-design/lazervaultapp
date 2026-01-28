import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Summary card showing total spent, earned, and saved
class WrappedSummaryCard extends StatelessWidget {
  final WrappedSummary summary;
  final int year;

  const WrappedSummaryCard({
    super.key,
    required this.summary,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.summary,
      title: 'Your $year in Numbers',
      subtitle: 'Here\'s how you did this year',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatItem(
            label: 'Total Spent',
            value: '\$${summary.totalSpent.toStringAsFixed(2)}',
            icon: Icons.shopping_bag,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          _StatItem(
            label: 'Total Earned',
            value: '\$${summary.totalEarned.toStringAsFixed(2)}',
            icon: Icons.trending_up,
            color: Colors.greenAccent,
          ),
          const SizedBox(height: 24),
          _StatItem(
            label: 'Total Saved',
            value: '\$${summary.totalSaved.toStringAsFixed(2)}',
            icon: Icons.savings,
            color: Colors.amberAccent,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MiniStat(
                  label: 'Savings Rate',
                  value: '${summary.savingsRate.toStringAsFixed(1)}%',
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                _MiniStat(
                  label: 'Transactions',
                  value: summary.transactionCount.toString(),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                _MiniStat(
                  label: 'Avg. Transaction',
                  value: '\$${summary.averageTransaction.toStringAsFixed(0)}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
