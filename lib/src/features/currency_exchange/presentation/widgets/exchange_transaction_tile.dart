import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entity.dart';

class ExchangeTransactionTile extends StatelessWidget {
  final CurrencyTransaction transaction;
  final VoidCallback? onTap;

  const ExchangeTransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.fromCurrency} → ${transaction.toCurrency}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(transaction.createdAt),
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
                  '-${transaction.formattedFromAmount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatusBadge(),
                    if (transaction.toAmount > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '+${transaction.formattedToAmount}',
                        style: const TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final isConversion = transaction.type == TransactionType.exchange;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isConversion
            ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
            : const Color(0xFF8B5CF6).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        isConversion ? Icons.swap_horiz : Icons.send,
        color: isConversion ? const Color(0xFF3B82F6) : const Color(0xFF8B5CF6),
        size: 20,
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    String label;

    switch (transaction.status) {
      case TransactionStatus.completed:
        color = const Color(0xFF10B981);
        label = 'Done';
      case TransactionStatus.pending:
      case TransactionStatus.processing:
        color = const Color(0xFFFB923C);
        label = 'Pending';
      case TransactionStatus.failed:
        color = const Color(0xFFEF4444);
        label = 'Failed';
      case TransactionStatus.cancelled:
        color = const Color(0xFF6B7280);
        label = 'Cancelled';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return DateFormat('MMM d, yyyy').format(date);
  }
}
