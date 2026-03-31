import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Revolut / eToro–inspired dark trading surfaces (UK fintech baseline).
abstract final class InvestTradingUi {
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceElevated = Color(0xFF1F1F1F);
  static const Color border = Color(0xFF2D2D2D);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color buy = Color(0xFF00C853);
  static const Color sell = Color(0xFFFF5252);
  static const Color accent = Color(0xFF3B82F6);

  static LinearGradient get scaffoldGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF12121A),
          Color(0xFF0A0A0A),
        ],
      );

  static BoxDecoration cardDecoration({Color? color}) => BoxDecoration(
        color: color ?? surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      );

  /// Dense “statement” card (Revolut-style breakdown rows).
  static BoxDecoration statementCardDecoration() => BoxDecoration(
        color: surfaceElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      );

  static InputDecoration tradingInputDecoration({
    String? hintText,
    String? prefixText,
    Color accentColor = accent,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
    );
    return InputDecoration(
      hintText: hintText,
      prefixText: prefixText,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: accentColor, width: 1.5),
      ),
    );
  }

  static TextStyle eyebrow(Color accentColor) => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: accentColor,
      );

  static TextStyle labelMuted() => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0.3,
      );

  /// Sticky bottom bar background (Revolut-style).
  static BoxDecoration bottomBarDecoration = BoxDecoration(
    color: surfaceElevated,
    border: Border(
      top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.45),
        blurRadius: 24,
        offset: const Offset(0, -8),
      ),
    ],
  );

  static Widget buySellBar({
    required VoidCallback onSell,
    required VoidCallback onBuy,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      decoration: bottomBarDecoration,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onSell,
                style: OutlinedButton.styleFrom(
                  foregroundColor: sell,
                  side: const BorderSide(color: sell, width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Sell',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: onBuy,
                style: FilledButton.styleFrom(
                  backgroundColor: buy,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Buy',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
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
