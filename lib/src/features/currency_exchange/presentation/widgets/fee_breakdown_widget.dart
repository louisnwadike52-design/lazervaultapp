import 'package:flutter/material.dart';
import '../../domain/repositories/i_exchange_repository.dart';

class FeeBreakdownWidget extends StatelessWidget {
  final ExchangeRate rate;
  final double amount;
  final double convertedAmount;
  final bool showFees;

  const FeeBreakdownWidget({
    super.key,
    required this.rate,
    required this.amount,
    required this.convertedAmount,
    this.showFees = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          _buildRow(
            'Exchange rate',
            rate.formatForDisplay(),
          ),
          if (showFees && rate.fees > 0) ...[
            const SizedBox(height: 12),
            _buildRow(
              'Service fee',
              '${rate.fees.toStringAsFixed(2)} ${rate.fromCurrency}',
            ),
          ],
          const SizedBox(height: 12),
          const Divider(color: Color(0xFF2D2D2D), height: 1),
          const SizedBox(height: 12),
          _buildRow(
            'You send',
            '${amount.toStringAsFixed(2)} ${rate.fromCurrency}',
            isBold: true,
          ),
          const SizedBox(height: 8),
          _buildRow(
            'They receive',
            '${convertedAmount.toStringAsFixed(2)} ${rate.toCurrency}',
            isBold: true,
            valueColor: const Color(0xFF10B981),
          ),
          if (showFees && rate.fees > 0) ...[
            const SizedBox(height: 8),
            _buildRow(
              'Total cost',
              '${rate.calculateTotalCost(amount).toStringAsFixed(2)} ${rate.fromCurrency}',
              isBold: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: isBold ? 14 : 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
