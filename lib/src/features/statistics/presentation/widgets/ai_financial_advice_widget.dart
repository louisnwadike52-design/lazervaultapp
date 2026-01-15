import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/statistics.pb.dart';

/// AI Financial Advice Widget
/// Displays AI-generated financial advice and allows asking questions
class AIFinancialAdviceWidget extends StatelessWidget {
  final GetAIFinancialAdviceResponse? advice;
  final bool isLoading;
  final String? error;
  final Function(String, List<String>)? onAskQuestion;

  const AIFinancialAdviceWidget({
    super.key,
    this.advice,
    required this.isLoading,
    this.error,
    this.onAskQuestion,
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
                const Icon(Icons.support_agent, color: Color(0xFF4E03D0)),
                SizedBox(width: 12.w),
                const Expanded(
                  child: Text(
                    'AI Financial Advisor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (error != null)
              Text('Error: $error', style: const TextStyle(color: Colors.red))
            else if (advice == null) ...[
              const Text('Get personalized financial advice:'),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _topicChip(label: 'Savings', icon: Icons.savings),
                  _topicChip(label: 'Investments', icon: Icons.trending_up),
                  _topicChip(label: 'Debt', icon: Icons.account_balance),
                  _topicChip(label: 'Retirement', icon: Icons.beach_access),
                ],
              ),
              SizedBox(height: 16.h),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Ask a question',
                  hintText: 'e.g., How can I save more money?',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (query) {
                  if (onAskQuestion != null) {
                    onAskQuestion!(query, ['all']);
                  }
                },
              ),
            ] else
              _buildAdviceContent(advice!),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceContent(GetAIFinancialAdviceResponse advice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (advice.query.isNotEmpty)
          Text(advice.query, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        Text(advice.advice, style: const TextStyle(fontSize: 14, height: 1.5)),
        if (advice.actionSteps.isNotEmpty) ...[
          SizedBox(height: 12.h),
          const Text('Action Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          ...advice.actionSteps.asMap().entries.map((entry) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${entry.key + 1}. ', style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(entry.value.description)),
              ],
            ),
          )),
        ],
        if (advice.disclaimer.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ExpansionTile(
            title: const Text('Disclaimer'),
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(advice.disclaimer, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _topicChip({required String label, required IconData icon}) {
    return GestureDetector(
      onTap: () {
        // Handle topic selection
      },
      child: Chip(
        avatar: Icon(icon, size: 18),
        label: Text(label),
      ),
    );
  }
}
