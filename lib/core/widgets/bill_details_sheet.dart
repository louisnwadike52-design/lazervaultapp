import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// One row inside the [BillDetailsSheet] body. Use [icon]+[label]+[value]
/// for the standard label/value layout. The optional [accent] override
/// lets a row tint its label colour (e.g. the status row uses green/orange
/// to match the schedule state).
class BillDetailRow {
  final IconData icon;
  final String label;
  final String value;
  final Color? accent;

  const BillDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.accent,
  });
}

/// Optional CTA pinned at the bottom of the sheet (e.g. "Buy Airtime",
/// "Manage schedule"). Pop the sheet first if the action navigates.
class BillDetailAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const BillDetailAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

/// Generic read-only details bottom-sheet shared across the airtime
/// flow. Used by:
///   * Saved Contacts → "View Details" (passes contact metadata)
///   * Auto-Recharge management → tap a schedule (passes schedule
///     metadata + a "Manage" CTA that opens the edit sheet)
///
/// One widget keeps the visual treatment identical regardless of which
/// surface launched it. Callers customise the header (title + subtitle +
/// avatar icon/colour), the body rows, and an optional bottom CTA.
class BillDetailsSheet {
  BillDetailsSheet._();

  static Future<void> show(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData headerIcon,
    required Color headerColor,
    required List<BillDetailRow> rows,
    BillDetailAction? primaryAction,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: headerColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(headerIcon, color: headerColor, size: 28.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null && subtitle.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border:
                    Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < rows.length; i++) ...[
                    _buildRow(rows[i]),
                    if (i != rows.length - 1) SizedBox(height: 12.h),
                  ],
                ],
              ),
            ),
            if (primaryAction != null) ...[
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: primaryAction.onTap,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          headerColor,
                          headerColor.withValues(alpha: 0.7)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(primaryAction.icon,
                            color: Colors.white, size: 22.sp),
                        SizedBox(width: 10.w),
                        Text(
                          primaryAction.label,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 20.h),
          ],
        ),
      ),
    );
  }

  static Widget _buildRow(BillDetailRow row) {
    return Row(
      children: [
        Icon(row.icon,
            color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                row.value,
                style: TextStyle(
                  color: row.accent ?? Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
