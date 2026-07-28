import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

class AnalyticsPeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final ValueChanged<String> onPeriodChanged;

  const AnalyticsPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  static const _periods = [
    ('week', 'Week'),
    ('month', 'Month'),
    ('quarter', 'Quarter'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: _periods.map((p) {
          final isSelected = p.$1 == selectedPeriod;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onPeriodChanged(p.$1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? InvoiceThemeColors.primaryPurple
                      : InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? InvoiceThemeColors.primaryPurple
                        : InvoiceThemeColors.borderColor,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: InvoiceThemeColors.primaryPurple
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  p.$2,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : InvoiceThemeColors.textGray400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
