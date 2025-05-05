import 'package:flutter/material.dart';

class RecipientFilterChip {
  final String text;
  bool isSelected;

  RecipientFilterChip({
    required this.text,
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
            ? Colors.blue
            : const Color.fromARGB(255, 238, 239, 241),
        labelStyle: TextStyle(
          color: chip.isSelected ? Colors.white : Colors.grey.shade600,
        ),
        side: BorderSide.none,
      ),
    );
  }
}
