import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Overlay widget for account cards that need re-authorization.
///
/// Renders an orange-bordered card with a "Re-link" button that triggers
/// the reauthorization flow via Mono Connect.
class ReauthRequiredOverlay extends StatelessWidget {
  final String bankName;
  final String accountName;
  final VoidCallback onReauthorize;

  const ReauthRequiredOverlay({
    super.key,
    required this.bankName,
    required this.accountName,
    required this.onReauthorize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFB923C),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Warning icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.link_off_rounded,
              color: const Color(0xFFFB923C),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),

          // Account info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  bankName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Re-link required',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Re-link button
          GestureDetector(
            onTap: onReauthorize,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'Re-link',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
