import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Card showing top spending categories
class WrappedTopCategoriesCard extends StatelessWidget {
  final List<WrappedCategoryRanking> categories;

  const WrappedTopCategoriesCard({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.categories,
      title: 'Your Top Categories',
      subtitle: 'Where your money went',
      child: ListView.builder(
        itemCount: categories.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryItem(
            category: category,
            isFirst: index == 0,
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final WrappedCategoryRanking category;
  final bool isFirst;

  const _CategoryItem({
    required this.category,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isFirst ? 0.3 : 0.15),
        borderRadius: BorderRadius.circular(16),
        border: isFirst
            ? Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                category.emoji.isEmpty ? '#${category.rank}' : category.emoji,
                style: TextStyle(
                  fontSize: category.emoji.isEmpty ? 14 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.categoryName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${category.transactionCount} transactions',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _TrendBadge(
                      trend: category.trend,
                      percentage: category.trendPercentage,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${category.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${category.percentage.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  final String trend;
  final double percentage;

  const _TrendBadge({
    required this.trend,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final isUp = trend == 'up';
    final isDown = trend == 'down';

    if (!isUp && !isDown) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isUp ? Colors.red.withValues(alpha: 0.3) : Colors.green.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward : Icons.arrow_downward,
            size: 12,
            color: isUp ? Colors.red.shade100 : Colors.green.shade100,
          ),
          const SizedBox(width: 2),
          Text(
            '${percentage.abs().toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 10,
              color: isUp ? Colors.red.shade100 : Colors.green.shade100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
