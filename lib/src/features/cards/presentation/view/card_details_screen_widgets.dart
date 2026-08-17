part of 'card_details_screen.dart';

typedef CardEntity = card_entities.Card;

// ──────────────────────────────────────────────────
// Internal model for action buttons
// ──────────────────────────────────────────────────

class _CardAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _CardAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });
}
