import 'package:flutter/material.dart';

class QuickAmountButtons extends StatelessWidget {
  final String currencyCode;
  final ValueChanged<double> onAmountSelected;
  final double? selectedAmount;

  const QuickAmountButtons({
    super.key,
    required this.currencyCode,
    required this.onAmountSelected,
    this.selectedAmount,
  });

  List<double> get _presets {
    switch (currencyCode) {
      case 'NGN':
        return [5000, 10000, 50000, 100000];
      case 'USD':
      case 'EUR':
      case 'GBP':
        return [50, 100, 500, 1000];
      case 'GHS':
        return [100, 500, 1000, 5000];
      case 'KES':
        return [1000, 5000, 10000, 50000];
      case 'ZAR':
        return [500, 1000, 5000, 10000];
      default:
        return [100, 500, 1000, 5000];
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final k = amount / 1000;
      return k == k.roundToDouble() ? '${k.toInt()}K' : '${k.toStringAsFixed(1)}K';
    }
    return amount.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _presets.map((amount) {
        final isSelected = selectedAmount == amount;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: amount == _presets.last ? 0 : 8,
            ),
            child: GestureDetector(
              onTap: () => onAmountSelected(amount),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Center(
                  child: Text(
                    _formatAmount(amount),
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
