import 'package:flutter/material.dart';
import '../../domain/entities/split_bill_entity.dart';
import 'split_bill_progress_bar.dart';

class SplitBillCard extends StatelessWidget {
  final SplitBillEntity bill;
  final bool isIncoming;
  final String? currentUserId;
  final VoidCallback onTap;

  const SplitBillCard({
    super.key,
    required this.bill,
    required this.isIncoming,
    this.currentUserId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final myParticipant = currentUserId != null
        ? bill.participantForUser(currentUserId!)
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  child: const Icon(
                    Icons.receipt_long,
                    size: 18,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bill.description.isNotEmpty
                            ? bill.description
                            : 'Split Bill',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        isIncoming
                            ? 'From @${bill.creatorUsername}'
                            : 'Created by you',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isIncoming && myParticipant != null
                          ? myParticipant.formattedAmount(bill.currency)
                          : bill.formattedTotal,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isIncoming)
                      const Text(
                        'Your share',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            SplitBillProgressBar(
              paidCount: bill.paidCount,
              totalParticipants: bill.totalParticipants,
              paidAmount: bill.paidAmount,
              totalAmount: bill.totalAmount - bill.creatorShare,
              currency: bill.currency,
            ),
            if (isIncoming && myParticipant != null) ...[
              const SizedBox(height: 8),
              _buildMyStatusBadge(myParticipant),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMyStatusBadge(SplitBillParticipantEntity participant) {
    final (color, label) = switch (participant.status) {
      SplitBillParticipantStatus.pending => (
          const Color(0xFFFB923C),
          'Awaiting your payment',
        ),
      SplitBillParticipantStatus.paid => (
          const Color(0xFF10B981),
          'You have paid',
        ),
      SplitBillParticipantStatus.declined => (
          const Color(0xFFEF4444),
          'You declined',
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
