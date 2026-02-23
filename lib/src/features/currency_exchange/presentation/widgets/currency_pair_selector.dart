import 'package:flutter/material.dart';
import '../../data/currency_data.dart';

class CurrencyPairSelector extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;
  final VoidCallback onSwap;

  const CurrencyPairSelector({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.onFromTap,
    required this.onToTap,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildCurrencyCard(fromCurrency, 'From', onFromTap)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildSwapButton(),
        ),
        Expanded(child: _buildCurrencyCard(toCurrency, 'To', onToTap)),
      ],
    );
  }

  Widget _buildCurrencyCard(String code, String label, VoidCallback onTap) {
    final currency = CurrencyData.getCurrencyByCode(code);
    final countryCode = currency?.countryCode.toLowerCase() ?? '';
    final flag = countryCode.isNotEmpty
        ? countryCode.toUpperCase().codeUnits.map((c) => String.fromCharCode(c + 127397)).join()
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (flag.isNotEmpty) ...[
                  Text(flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF9CA3AF),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              currency?.name ?? code,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwapButton() {
    return GestureDetector(
      onTap: onSwap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.swap_horiz,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
