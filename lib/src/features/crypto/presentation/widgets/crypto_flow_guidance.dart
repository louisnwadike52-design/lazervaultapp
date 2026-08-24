import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Compact guidance banner for the crypto buy/sell/swap/send surfaces — one
/// short sentence telling the user what will happen with their money before
/// they commit (where funds come from, where they land, and what to watch).
/// Deliberately quiet (single line, muted colors) so it guides without
/// competing with amounts and CTAs.
class CryptoFlowGuidance extends StatelessWidget {
  const CryptoFlowGuidance({super.key, required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF7C3AED).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? Icons.info_outline,
              size: 15.sp, color: const Color(0xFF9F7AEA)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                height: 1.35,
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
