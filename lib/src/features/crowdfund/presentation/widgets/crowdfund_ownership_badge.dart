import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The "Yours" pill, shared by every listing that shows campaigns.
///
/// It used to be a private method on CrowdfundCard, which is why only Browse
/// All had it. Brand purple with a person glyph so it reads at a glance and
/// stays distinct from the status colours (green active / green verified).
class CrowdfundOwnershipBadge extends StatelessWidget {
  const CrowdfundOwnershipBadge({super.key, this.compact = false});

  /// Dense rails (the dashboard's trending row) have no room for the word.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 5.w : 8.w,
        vertical: compact ? 2.h : 4.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4E03D0).withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_outline,
              color: const Color(0xFF8B5CF6), size: compact ? 10.sp : 12.sp),
          SizedBox(width: 3.w),
          Text(
            'Yours',
            style: TextStyle(
              color: const Color(0xFF8B5CF6),
              fontSize: compact ? 9.sp : 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
