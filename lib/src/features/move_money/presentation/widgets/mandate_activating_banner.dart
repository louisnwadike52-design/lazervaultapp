import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/mandate_entity.dart';

/// Persistent banner shown when a source account's mandate is activating
/// (e.g., e-mandate awaiting 24-hour bank authorization).
///
/// Shows status info and offers a "Use one-time authorization" fallback.
class MandateActivatingBanner extends StatelessWidget {
  final MandateEntity mandate;
  final String bankName;
  final VoidCallback? onUseOneTime;

  const MandateActivatingBanner({
    super.key,
    required this.mandate,
    required this.bankName,
    this.onUseOneTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status row
          Row(
            children: [
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFFB923C),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Auto-debit activating for $bankName',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Description
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: Text(
              'This may take up to 24 hours. You can still transfer using one-time authorization.',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ),

          // One-time auth button
          if (onUseOneTime != null) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: GestureDetector(
                onTap: onUseOneTime,
                child: Text(
                  'Use one-time authorization instead',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
