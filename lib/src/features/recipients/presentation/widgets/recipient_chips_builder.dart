import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_filter_chip_card.dart';

/// Callback type for filter changes
typedef OnFilterChanged = void Function(RecipientFilterType filterType);

class RecipientChipsBuilder extends StatefulWidget {
  /// Callback when filter selection changes
  final OnFilterChanged? onFilterChanged;

  /// Currently selected filter type (for controlled mode)
  final RecipientFilterType? selectedFilter;

  const RecipientChipsBuilder({
    super.key,
    this.onFilterChanged,
    this.selectedFilter,
  });

  @override
  State<RecipientChipsBuilder> createState() => _RecipientChipsBuilderState();
}

class _RecipientChipsBuilderState extends State<RecipientChipsBuilder> {
  late RecipientFilterType _selectedFilterType;

  final List<RecipientFilterChip> recipientFilterChips = [
    RecipientFilterChip(text: 'All', filterType: RecipientFilterType.all, isSelected: true),
    RecipientFilterChip(text: 'Recent', filterType: RecipientFilterType.recent, isSelected: false),
    RecipientFilterChip(text: 'Favorites', filterType: RecipientFilterType.favorites, isSelected: false),
    RecipientFilterChip(text: 'Bank', filterType: RecipientFilterType.bank, isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilterType = widget.selectedFilter ?? RecipientFilterType.all;
    _updateChipsSelection();
  }

  @override
  void didUpdateWidget(covariant RecipientChipsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedFilter != null && widget.selectedFilter != _selectedFilterType) {
      _selectedFilterType = widget.selectedFilter!;
      _updateChipsSelection();
    }
  }

  void _updateChipsSelection() {
    for (var chip in recipientFilterChips) {
      chip.isSelected = chip.filterType == _selectedFilterType;
    }
  }

  void _handleToggleSelection(int index) {
    final selectedChip = recipientFilterChips[index];

    setState(() {
      _selectedFilterType = selectedChip.filterType;
      _updateChipsSelection();
    });

    // Notify parent of filter change
    widget.onFilterChanged?.call(selectedChip.filterType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0.h,
      margin: EdgeInsets.symmetric(vertical: 4.0.h),
      child: ListView.builder(
        primary: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: recipientFilterChips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 12.0.w),
            child: RecipientFilterChipCard(
              chip: recipientFilterChips[index],
              onToggle: () => _handleToggleSelection(index),
            ),
          );
        },
      ),
    );
  }
}
