import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/statistics.pb.dart';

/// AI Budget Recommendations Card Widget
/// Displays AI-generated budget recommendations
class AIBudgetRecommendationsCard extends StatelessWidget {
  final GetAIBudgetingRecommendationsResponse? recommendations;
  final bool isLoading;
  final String? error;
  final VoidCallback onRefresh;
  final Function(dynamic)? onApplyRecommendation;

  const AIBudgetRecommendationsCard({
    super.key,
    this.recommendations,
    required this.isLoading,
    this.error,
    required this.onRefresh,
    this.onApplyRecommendation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet, color: Color(0xFF8B5CF6)),
                SizedBox(width: 12.w),
                const Text(
                  'AI Budget Recommendations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (!isLoading)
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: onRefresh,
                    tooltip: 'Refresh',
                  ),
              ],
            ),
            SizedBox(height: 16.h),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (error != null)
              Text('Error: $error', style: const TextStyle(color: Colors.red))
            else if (recommendations == null)
              const Text('No recommendations available. Tap refresh to generate.')
            else
              _buildRecommendationsContent(recommendations!),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsContent(GetAIBudgetingRecommendationsResponse recs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (recs.summary.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(recs.summary, style: const TextStyle(fontSize: 14, height: 1.5)),
          ),
        if (recs.recommendedSavingsRate > 0)
          Card(
            color: const Color(0xFFEEF2FF),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  const Icon(Icons.savings, color: Color(0xFF10B981)),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recommended Savings Rate', style: TextStyle(fontSize: 12)),
                        Text('${recs.recommendedSavingsRate.toStringAsFixed(1)}%',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (recs.budgetRecommendations.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text('Budget Recommendations:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...recs.budgetRecommendations.take(5).map((rec) => Card(
            margin: EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(rec.categoryName.isNotEmpty ? rec.categoryName : rec.category.name),
              subtitle: Text('Current: \$${rec.currentAmount.toStringAsFixed(0)} → Recommended: \$${rec.recommendedAmount.toStringAsFixed(0)}'),
              trailing: onApplyRecommendation != null
                  ? IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () => onApplyRecommendation!(rec),
                      tooltip: 'Apply Recommendation',
                    )
                  : null,
            ),
          )),
        ],
        if (recs.rationale.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ExpansionTile(
            title: const Text('Why these recommendations?'),
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(recs.rationale, style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
