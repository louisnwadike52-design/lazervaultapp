import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

/// Horizontal scrollable pill tabs (Revolut invest / asset detail pattern).
class InvestRevolutSegmentPills extends StatelessWidget {
  const InvestRevolutSegmentPills({
    super.key,
    required this.labels,
    required this.onChanged,
    this.selectedIndex,
  });

  final List<String> labels;

  /// Selected pill; `null` = no selection (e.g. main Invest landing shortcuts).
  final int? selectedIndex;
  final ValueChanged<int> onChanged;

  static const Color _pillSelected = Color(0xFF2C2C2E);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: labels.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, i) {
          final selected =
              selectedIndex != null && i == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: selected ? _pillSelected : Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Center(
                child: Text(
                  labels[i],
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? InvestTradingUi.textPrimary
                        : InvestTradingUi.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
