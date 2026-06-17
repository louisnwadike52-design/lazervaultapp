import 'package:flutter/material.dart';

/// Renders a horizontal row of tappable quick-action chips emitted by the
/// Bills Hub chat agent on its first assistant turn (when no bill operation
/// is in progress).
///
/// Source: `chat-products-service` populates `metadata.quick_actions` via the
/// `emit_bills_hub_quick_actions` tool when `source_context='bills'`. The
/// chat content widget passes those labels in; tapping sends the label back
/// as the user's next message.
class QuickActionChips extends StatelessWidget {
  /// The chip labels (e.g. ["Pay electricity", "Buy airtime", ...]).
  final List<String> actions;

  /// Invoked with the chip label when the user taps one. The chat cubit
  /// should send this string as the next user message.
  final void Function(String label) onTap;

  const QuickActionChips({
    super.key,
    required this.actions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: actions.map((label) {
          return _Chip(
            label: label,
            onTap: () => onTap(label),
          );
        }).toList(growable: false),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _Chip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.4)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
