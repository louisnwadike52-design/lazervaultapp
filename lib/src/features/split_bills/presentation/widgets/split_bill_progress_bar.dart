import 'package:flutter/material.dart';

class SplitBillProgressBar extends StatelessWidget {
  final int paidCount;
  final int totalParticipants;
  final double paidAmount;
  final double totalAmount;
  final String currency;
  final bool showLabel;

  const SplitBillProgressBar({
    super.key,
    required this.paidCount,
    required this.totalParticipants,
    required this.paidAmount,
    required this.totalAmount,
    required this.currency,
    this.showLabel = true,
  });

  double get progress =>
      totalParticipants > 0 ? paidCount / totalParticipants : 0.0;

  Color get progressColor {
    if (paidCount >= totalParticipants) return const Color(0xFF10B981);
    if (paidCount > 0) return const Color(0xFF3B82F6);
    return const Color(0xFF6B7280);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF2D2D2D),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 6,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 4),
          Text(
            '$paidCount/$totalParticipants paid',
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
