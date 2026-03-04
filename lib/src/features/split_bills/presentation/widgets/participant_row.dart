import 'package:flutter/material.dart';
import '../../domain/entities/split_bill_entity.dart';

class ParticipantRow extends StatelessWidget {
  final SplitBillParticipantEntity participant;
  final String currency;

  const ParticipantRow({
    super.key,
    required this.participant,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF2D2D2D),
            child: Text(
              _initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participant.displayName.isNotEmpty
                      ? participant.displayName
                      : '@${participant.username}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (participant.displayName.isNotEmpty)
                  Text(
                    '@${participant.username}',
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
                participant.formattedAmount(currency),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              _buildStatusBadge(),
            ],
          ),
        ],
      ),
    );
  }

  String get _initials {
    if (participant.displayName.isNotEmpty) {
      final parts = participant.displayName
          .split(' ')
          .where((p) => p.isNotEmpty)
          .toList();
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      if (parts.isNotEmpty) {
        return parts[0][0].toUpperCase();
      }
    }
    if (participant.username.isNotEmpty) {
      return participant.username[0].toUpperCase();
    }
    return '?';
  }

  Widget _buildStatusBadge() {
    final (icon, color, label) = switch (participant.status) {
      SplitBillParticipantStatus.pending => (
          Icons.schedule,
          const Color(0xFFFB923C),
          'Pending',
        ),
      SplitBillParticipantStatus.paid => (
          Icons.check_circle,
          const Color(0xFF10B981),
          'Paid',
        ),
      SplitBillParticipantStatus.declined => (
          Icons.cancel,
          const Color(0xFFEF4444),
          'Declined',
        ),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}
