import 'package:flutter/material.dart';

/// Enum representing the available filter types for recipients.
///
/// `recurring` replaced the previous `bank` value (which was a no-op
/// duplicate of `all`). When selected, the recipients screen swaps the
/// list contents for the user's active recurring transfers — see
/// `_buildRecurringList()` in `select_recipients.dart`.
///
/// `history` sits beside `recurring` and swaps the list for the user's
/// transfer transaction history (with bank logos for external-bank
/// transfers) — see `_buildHistoryList()` in `select_recipients.dart`.
enum RecipientFilterType {
  all,
  recent,
  favorites,
  recurring,
  history,
}

class RecipientFilterChip {
  final String text;
  final RecipientFilterType filterType;
  bool isSelected;

  RecipientFilterChip({
    required this.text,
    required this.filterType,
    required this.isSelected,
  });
}

class RecipientFilterChipCard extends StatelessWidget {
  final RecipientFilterChip chip;
  final VoidCallback onToggle;

  const RecipientFilterChipCard({
    super.key,
    required this.chip,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Chip(
        label: Text(chip.text),
        backgroundColor: chip.isSelected
            ? const Color(0xFF4E03D0)
            : const Color.fromARGB(255, 238, 239, 241),
        labelStyle: TextStyle(
          color: chip.isSelected ? Colors.white : Colors.grey.shade600,
        ),
        side: BorderSide.none,
      ),
    );
  }
}
