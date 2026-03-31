import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

/// Shared chrome for stock trade flows (carousel step bar, sticky footer).
class TradingCarouselStepBar extends StatelessWidget {
  const TradingCarouselStepBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.accentColor,
    required this.barFillColor,
  });

  final int currentPage;
  final int totalPages;
  final Color accentColor;
  final Color barFillColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      children: [
        Container(
          width: width,
          height: 3.h,
          color: Colors.white.withValues(alpha: 0.08),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width * ((currentPage + 1) / totalPages),
            decoration: BoxDecoration(color: barFillColor),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalPages,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: currentPage == index ? 22.w : 7.w,
              height: 7.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: currentPage == index
                    ? accentColor
                    : Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}

class TradingOrderStepFooter extends StatelessWidget {
  const TradingOrderStepFooter({
    super.key,
    required this.showBack,
    required this.onBack,
    required this.onPrimary,
    required this.primaryLabel,
    required this.primaryBackground,
    required this.primaryForeground,
  });

  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback onPrimary;
  final String primaryLabel;
  final Color primaryBackground;
  final Color primaryForeground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
      decoration: InvestTradingUi.bottomBarDecoration,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (showBack) ...[
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: InvestTradingUi.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              flex: showBack ? 2 : 1,
              child: FilledButton(
                onPressed: onPrimary,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  backgroundColor: primaryBackground,
                  foregroundColor: primaryForeground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  primaryLabel,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom sheet surface + handle for quick trade actions.
Future<T?> showTradingQuickSheet<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(ctx).bottom,
      ),
      child: child,
    ),
  );
}

class TradingQuickSheetChrome extends StatelessWidget {
  const TradingQuickSheetChrome({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    this.accentColor = InvestTradingUi.accent,
  });

  final String title;
  final String subtitle;
  final Widget body;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 16.h),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: InvestTradingUi.surfaceElevated,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title.toUpperCase(),
            style: InvestTradingUi.eyebrow(accentColor),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: InvestTradingUi.textSecondary,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          body,
        ],
      ),
    );
  }
}
