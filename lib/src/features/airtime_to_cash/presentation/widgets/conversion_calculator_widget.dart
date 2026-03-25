import 'package:flutter/material.dart';
import '../../domain/entities/network_rate.dart';

class ConversionCalculatorWidget extends StatelessWidget {
  final double amount;
  final NetworkRate rate;

  const ConversionCalculatorWidget({
    super.key,
    required this.amount,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final estimatedCash = rate.estimateCash(amount);
    final isValid = rate.isAmountValid(amount) && estimatedCash > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Conversion Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // You send row
          _buildAmountRow(
            label: 'You send',
            amount: '\u20A6${amount.toStringAsFixed(2)} airtime',
            icon: Icons.phone_android,
            color: const Color(0xFF3B82F6),
          ),

          // Arrow indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_downward_rounded,
                  color: Color(0xFF9CA3AF),
                  size: 18,
                ),
              ),
            ),
          ),

          // You get row
          _buildAmountRow(
            label: 'You get',
            amount: isValid
                ? '\u20A6${estimatedCash.toStringAsFixed(2)} cash'
                : '--',
            icon: Icons.account_balance_wallet,
            color: const Color(0xFF10B981),
          ),

          const SizedBox(height: 16),
          Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
          const SizedBox(height: 12),

          // Rate and fee details
          _buildDetailRow('Rate', rate.ratePercentage),
          const SizedBox(height: 6),
          _buildDetailRow('Fee', rate.formattedFee),
          const SizedBox(height: 6),
          _buildDetailRow(
            'Net amount',
            isValid
                ? '\u20A6${estimatedCash.toStringAsFixed(2)}'
                : '--',
            isHighlighted: true,
          ),

          // Validation warning
          if (amount > 0 && !rate.isAmountValid(amount)) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFFB923C),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Amount must be between ${rate.formattedMinAmount} and ${rate.formattedMaxAmount}',
                      style: const TextStyle(
                        color: Color(0xFFFB923C),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountRow({
    required String label,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isHighlighted ? const Color(0xFF10B981) : Colors.white,
            fontSize: 13,
            fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
