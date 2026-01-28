import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Card showing spending trends over the period
class WrappedTrendsCard extends StatelessWidget {
  final WrappedTrends trends;

  const WrappedTrendsCard({
    super.key,
    required this.trends,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.trends,
      title: 'Your Spending Trends',
      subtitle: trends.spendingTrendDescription,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: _TrendChart(monthlyTrends: trends.monthlyTrends),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _TrendSection(
                  title: 'Improving',
                  icon: Icons.trending_down,
                  iconColor: Colors.greenAccent,
                  items: trends.improvingCategories,
                  emptyMessage: 'Keep an eye out!',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _TrendSection(
                  title: 'Watch Out',
                  icon: Icons.trending_up,
                  iconColor: Colors.orangeAccent,
                  items: trends.watchCategories,
                  emptyMessage: 'All good!',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  final List<WrappedMonthlyTrend> monthlyTrends;

  const _TrendChart({required this.monthlyTrends});

  @override
  Widget build(BuildContext context) {
    if (monthlyTrends.isEmpty) {
      return const Center(
        child: Text(
          'No trend data available',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    final maxAmount = monthlyTrends.fold<double>(
      0,
      (max, trend) => trend.amount > max ? trend.amount : max,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthlyTrends.map((trend) {
                final height = maxAmount > 0 ? (trend.amount / maxAmount) : 0.0;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: height.clamp(0.1, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: monthlyTrends.map((trend) {
              return Expanded(
                child: Text(
                  trend.monthLabel,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TrendSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> items;
  final String emptyMessage;

  const _TrendSection({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            )
          else
            ...items.take(3).map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                item,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )),
        ],
      ),
    );
  }
}
