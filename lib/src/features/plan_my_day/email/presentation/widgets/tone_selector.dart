import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/email_palette.dart';

/// A small wrap of selectable tone chips for the AI reply composer.
class ToneSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const ToneSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const List<({String value, String label})> _tones = [
    (value: 'professional', label: 'Professional'),
    (value: 'friendly', label: 'Friendly'),
    (value: 'concise', label: 'Concise'),
    (value: 'formal', label: 'Formal'),
    (value: 'warm', label: 'Warm'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _tones.map((t) {
        final isSelected = selected == t.value;
        return GestureDetector(
          onTap: () => onChanged(t.value),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: isSelected ? EmailPalette.accent : EmailPalette.background,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: isSelected ? EmailPalette.accent : EmailPalette.divider,
              ),
            ),
            child: Text(
              t.label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : EmailPalette.textSecondary,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
