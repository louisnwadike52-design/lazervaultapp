import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/statistics.pb.dart';

/// AI Insights Card Widget
/// Displays AI-generated spending insights
class AIInsightsCard extends StatelessWidget {
  final GetAISpendingInsightsResponse? insights;
  final bool isLoading;
  final String? error;
  final VoidCallback onRefresh;

  const AIInsightsCard({
    super.key,
    this.insights,
    required this.isLoading,
    this.error,
    required this.onRefresh,
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
                const Icon(Icons.psychology, color: Color(0xFF6366F1)),
                SizedBox(width: 12.w),
                const Text(
                  'AI Spending Insights',
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
            else if (insights == null)
              const Text('No insights available. Tap refresh to generate.')
            else
              _buildInsightsContent(insights!),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsContent(GetAISpendingInsightsResponse insights) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (insights.summary.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              insights.summary,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        if (insights.insights.isNotEmpty) ...[
          const Text('Key Insights:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          ...insights.insights.take(3).map((insight) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(insight.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                      if (insight.description.isNotEmpty)
                        Text(insight.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
        if (insights.recommendations.isNotEmpty) ...[
          SizedBox(height: 12.h),
          const Text('Recommendations:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          ...insights.recommendations.take(3).map((rec) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.recommend, size: 16, color: Colors.green),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rec.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                      if (rec.description.isNotEmpty)
                        Text(rec.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      if (rec.potentialSavings > 0)
                        Text('Save: \$${rec.potentialSavings.toStringAsFixed(2)}/mo',
                            style: const TextStyle(fontSize: 12, color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ],
    );
  }
}
