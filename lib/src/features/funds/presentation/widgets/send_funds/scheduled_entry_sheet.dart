import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/presentation/view/scheduled_transfers_list_screen.dart';

/// Entry chooser for the SendFunds "Scheduled" quick action.
///
/// One-time scheduled transfers and recurring rules are DIFFERENT server
/// objects (a `status:"scheduled"` core-payments row fired once by asynq
/// vs a recurring rule that spawns transfers on a cadence), so the quick
/// action offers both destinations instead of guessing — previously it
/// jumped straight to recurring and one-time scheduled transfers were
/// unreachable from here.
class ScheduledEntrySheet {
  ScheduledEntrySheet._();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 14.h),
            Text('Upcoming payments',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 4.h),
            Text('Choose what you want to manage',
                style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.5))),
            SizedBox(height: 8.h),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C5CFF).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.schedule_send_rounded,
                    color: const Color(0xFF7C5CFF), size: 20.sp),
              ),
              title: Text('Scheduled payments',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text('One-time transfers waiting to fire',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp)),
              trailing: Icon(Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.4)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                Get.to(() => const ScheduledTransfersListScreen());
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.event_repeat_rounded,
                    color: const Color(0xFF3B82F6), size: 20.sp),
              ),
              title: Text('Recurring payments',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              subtitle: Text('Repeating transfers — daily, weekly or monthly',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp)),
              trailing: Icon(Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.4)),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                Get.toNamed(AppRoutes.recurringTransfers);
              },
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
