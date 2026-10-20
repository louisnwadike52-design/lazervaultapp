import 'package:flutter/material.dart';
import '../cubit/exchange_state.dart';

class ExchangeModeToggle extends StatelessWidget {
  final ExchangeMode selectedMode;
  final ValueChanged<ExchangeMode> onModeChanged;

  /// Whether the "Send Abroad" tab is offered. Admin-controlled via
  /// FeatureFlags.exchangeSendAbroadVisible.
  ///
  /// With one mode left there is nothing to toggle between, so the whole
  /// control is omitted rather than rendered as a single full-width pill that
  /// looks like a button and does nothing when tapped.
  final bool showSendAbroad;

  const ExchangeModeToggle({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
    this.showSendAbroad = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showSendAbroad) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTab(
            label: 'Convert',
            icon: Icons.swap_horiz,
            mode: ExchangeMode.convert,
          ),
          _buildTab(
            label: 'Send Abroad',
            icon: Icons.send,
            mode: ExchangeMode.sendAbroad,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required IconData icon,
    required ExchangeMode mode,
  }) {
    final isSelected = selectedMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () => onModeChanged(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4E03D0) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
