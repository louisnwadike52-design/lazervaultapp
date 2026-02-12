import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeriodSelectorChip extends StatelessWidget {
  final String selectedPeriod;
  final ValueChanged<String> onPeriodChanged;

  const PeriodSelectorChip({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  static const _periods = [
    ('today', 'Today'),
    ('week', 'Week'),
    ('month', 'Month'),
    ('quarter', 'Quarter'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _periods.map((period) {
        final isSelected = selectedPeriod == period.$1;
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: () => onPeriodChanged(period.$1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Text(
                period.$2,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
