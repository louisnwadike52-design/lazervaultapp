import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_filter_chip_card.dart';

class RecipientChipsBuilder extends StatefulWidget {
  final List<RecipientModel> recipients;

  const RecipientChipsBuilder({
    super.key,
    required this.recipients,
  });

  @override
  State<RecipientChipsBuilder> createState() => _RecipientChipsBuilderState();
}

class _RecipientChipsBuilderState extends State<RecipientChipsBuilder> {
  int selectedFilterIndex = 0;

  final List<RecipientFilterChip> recipientFilterChips = [
    RecipientFilterChip(text: 'All', isSelected: true),
    RecipientFilterChip(text: 'Recent', isSelected: false),
    RecipientFilterChip(text: 'Favorite', isSelected: false),
    RecipientFilterChip(text: 'Bank', isSelected: false),
  ];

  void _handleToggleSelection(int index) {
    setState(() {
      selectedFilterIndex = index;

      for (var chip in recipientFilterChips) {
        chip.isSelected = index == recipientFilterChips.indexOf(chip);
      }
    });
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
