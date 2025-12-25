import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class AutoSaveSortDropdown extends StatelessWidget {
  final RuleSortOption selectedOption;
  final Function(RuleSortOption) onChanged;

  const AutoSaveSortDropdown({
    Key? key,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  String _getLabelForOption(RuleSortOption option) {
    switch (option) {
      case RuleSortOption.dateCreatedDesc:
        return 'Newest First';
      case RuleSortOption.dateCreatedAsc:
        return 'Oldest First';
      case RuleSortOption.nameAsc:
        return 'Name (A-Z)';
      case RuleSortOption.nameDesc:
        return 'Name (Z-A)';
      case RuleSortOption.totalSavedDesc:
        return 'Highest Saved';
      case RuleSortOption.totalSavedAsc:
        return 'Lowest Saved';
      case RuleSortOption.statusActive:
        return 'Active First';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RuleSortOption>(
          value: selectedOption,
          dropdownColor: const Color(0xFF1F1F1F),
          icon:
              Icon(Icons.arrow_drop_down, color: Colors.white, size: 20.sp),
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
          items: RuleSortOption.values.map((option) {
            return DropdownMenuItem<RuleSortOption>(
              value: option,
              child: Text(_getLabelForOption(option)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}
