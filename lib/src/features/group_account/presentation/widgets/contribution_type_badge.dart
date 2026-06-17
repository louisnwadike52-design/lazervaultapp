import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/group_entities.dart';

/// Compact pill that labels a contribution as ROSCA or one-time so a
/// glance at the list (or the detail header) tells you which payout
/// semantics apply. Width is intrinsic; the label clips with ellipsis
/// inside a Flexible so the badge never blows out a tight row.
class ContributionTypeBadge extends StatelessWidget {
  final ContributionType type;

  const ContributionTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final isRosca = type == ContributionType.rotatingSavings;
    final color = isRosca
        ? const Color.fromARGB(255, 78, 3, 208)
        : const Color(0xFF10B981);
    final label = isRosca ? 'Rotating Savings' : 'One-time';
    final icon = isRosca ? Icons.sync : Icons.flag_outlined;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12.sp),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
