import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized success view shown when a transaction PIN is created / updated /
/// changed (Settings PIN flow, channel PIN setup, etc). One widget keeps the
/// "PIN updated" confirmation consistent across every PIN flow.
///
/// Renders a green check badge + title + subtitle on the app's dark surface.
/// Callers supply the copy (e.g. "PIN Updated" / "Use your new PIN for your
/// next transaction.").
class PinSuccessView extends StatelessWidget {
  final String title;
  final String subtitle;

  const PinSuccessView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  static const Color _successGreen = Color(0xFF10B981);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('pin-success'),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 84.w,
            height: 84.w,
            decoration: BoxDecoration(
              color: _successGreen.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded,
                color: _successGreen, size: 44),
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: _textPrimary,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: _textSecondary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
