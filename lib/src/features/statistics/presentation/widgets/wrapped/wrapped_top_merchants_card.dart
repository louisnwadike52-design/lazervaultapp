import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Card showing top merchants/places
class WrappedTopMerchantsCard extends StatelessWidget {
  final List<WrappedMerchantRanking> merchants;

  const WrappedTopMerchantsCard({
    super.key,
    required this.merchants,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.merchants,
      title: 'Your Favorite Spots',
      subtitle: 'Where you spent the most',
      child: ListView.builder(
        itemCount: merchants.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final merchant = merchants[index];
          return _MerchantItem(
            merchant: merchant,
            isFirst: index == 0,
          );
        },
      ),
    );
  }
}

class _MerchantItem extends StatelessWidget {
  final WrappedMerchantRanking merchant;
  final bool isFirst;

  const _MerchantItem({
    required this.merchant,
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                merchant.emoji.isEmpty ? '${merchant.rank}' : merchant.emoji,
                style: TextStyle(
                  fontSize: merchant.emoji.isEmpty ? 18 : 24,
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
                  merchant.merchantName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${merchant.visitCount} visits',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    if (merchant.category.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          merchant.category,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${merchant.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${merchant.percentage.toStringAsFixed(1)}%',
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
