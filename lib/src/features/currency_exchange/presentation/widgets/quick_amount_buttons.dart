import 'package:flutter/material.dart';

class QuickAmountButtons extends StatelessWidget {
  final String currencyCode;
  final ValueChanged<double> onAmountSelected;
  final double? selectedAmount;

  /// The most the user can convert out of [currencyCode] right now.
  ///
  /// Null hides MAX entirely — an unknown balance must not be offered as a
  /// number, and a MAX that overshoots is worse than no MAX: it fails at the
  /// ledger after the user has picked currencies, fetched a rate and reached
  /// the PIN step.
  final double? maxAmount;

  const QuickAmountButtons({
    super.key,
    required this.currencyCode,
    required this.onAmountSelected,
    this.selectedAmount,
    this.maxAmount,
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
      return k == k.roundToDouble()
          ? '${k.toInt()}K'
          : '${k.toStringAsFixed(1)}K';
    }
    return amount.toInt().toString();
  }

  /// Presets the user could not afford are pointless: tapping one only
  /// produces the insufficient-funds refusal. Dropped rather than disabled,
  /// so the row stays a row of things that work.
  List<double> _affordablePresets() {
    final max = maxAmount;
    if (max == null || max <= 0) return _presets;
    final affordable = _presets.where((a) => a <= max).toList();
    return affordable.isEmpty ? const <double>[] : affordable;
  }

  @override
  Widget build(BuildContext context) {
    final presets = _affordablePresets();
    final showMax = maxAmount != null && maxAmount! > 0;
    if (presets.isEmpty && !showMax) return const SizedBox.shrink();

    return Row(
      children: [
        ...presets.map((amount) {
          final isSelected = selectedAmount == amount;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: (amount == presets.last && !showMax) ? 0 : 8,
              ),
              child: GestureDetector(
                onTap: () => onAmountSelected(amount),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4E03D0).withValues(alpha: 0.15)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4E03D0)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _formatAmount(amount),
                      style: TextStyle(
                        color:
                            isSelected ? const Color(0xFF4E03D0) : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        if (showMax)
          Expanded(
            child: GestureDetector(
              onTap: () => onAmountSelected(maxAmount!),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  // Filled rather than outlined, like the grid's navigation
                  // tile: MAX is a control that computes a value, not another
                  // preset sitting in the same list.
                  color: selectedAmount == maxAmount
                      ? const Color(0xFF4E03D0)
                      : const Color(0xFF4E03D0).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF4E03D0)),
                ),
                child: Center(
                  child: Text(
                    'MAX',
                    style: TextStyle(
                      color: selectedAmount == maxAmount
                          ? Colors.white
                          : const Color(0xFF9B6BFF),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
