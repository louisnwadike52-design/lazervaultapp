import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// A single action row inside [BillHistoryActionsSheet].
class BillHistoryAction {
  final IconData icon;
  final Color color;
  final String label;

  /// Optional trailing widget shown at the end of the row (e.g. a "Saved"
  /// badge or edit icon).
  final Widget? trailing;

  /// Optional secondary line under [label]. Used for inline context like
  /// the existing nickname on a "Saved/Edit Contact" row so the user
  /// knows what they'd be editing without opening the destination first.
  final String? subtitle;
  final VoidCallback onTap;

  const BillHistoryAction({
    required this.icon,
    required this.color,
    required this.label,
    this.trailing,
    this.subtitle,
    required this.onTap,
  });
}

/// Shared bottom-sheet for bill-type transaction history actions.
///
/// Uses the clean "icon + label" list pattern (no colored containers, no
/// borders, no chevrons) matching the original `DataHistoryActionsSheet`.
class BillHistoryActionsSheet {
  BillHistoryActionsSheet._();

  /// Show the actions bottom sheet.
  ///
  /// [title] — primary identifier (phone number, meter number, etc.)
  /// [subtitle] — secondary info (amount + status)
  /// [actions] — ordered list of action rows
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<BillHistoryAction> actions,
  }) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              // Title
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              // Subtitle
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 16.h),
              // Action rows
              ...actions.map(_actionItem),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  static Widget _actionItem(BillHistoryAction action) {
    return InkWell(
      onTap: action.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(action.icon, color: action.color, size: 22.sp),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    action.label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (action.subtitle != null &&
                      action.subtitle!.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      action.subtitle!,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (action.trailing != null) action.trailing!,
          ],
        ),
      ),
    );
  }
}
