/// The modal shown when a payout receiver cannot be assigned, or when an
/// assignment that was accepted is being held.
///
/// WHY A MODAL AND NOT A LINE OF RED TEXT.
///
/// The refusals behind this are rules about whose turn it is — a member may
/// not collect twice while others are still waiting for a first turn. Those
/// are decisions a person has to understand and then act on (assign someone
/// else, or advance the rotation), not validation noise.
///
/// Shown as a small inline error, the previous behaviour, it was missed: the
/// creator saw the sheet close, read "receiver set", and then found the same
/// "Set Receiver" banner still on screen with nothing connecting the two. They
/// assigned again, and again, with no idea what the app was telling them.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shows the blocked-assignment modal.
///
/// [reason] is the server's own user-facing sentence — it already names the
/// member whose turn it is, so it is rendered verbatim rather than replaced
/// with a generic line that would lose the only actionable part.
Future<void> showPayoutAssignmentBlockedDialog(
  BuildContext context, {
  required String reason,
  String title = 'This member cannot take this turn',
  String primaryLabel = 'Pick someone else',
  VoidCallback? onPrimary,
  String? secondaryLabel,
  VoidCallback? onSecondary,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.swap_vert_circle_outlined,
                      color: const Color(0xFFFB923C), size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              reason,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 10.h),
            // The rule, stated once. The server sentence says what is wrong
            // with THIS pick; this says why the rule exists, which is what
            // stops it reading as an arbitrary rejection.
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'A savings circle pays each member once per round. Letting '
                'someone collect a second time would fund it from members who '
                'are still waiting for their first payout.',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  height: 1.45,
                ),
              ),
            ),
            SizedBox(height: 18.h),
            // The way OUT of the deadlock, when there is one.
            //
            // A circle whose rotation and payouts have diverged can refuse
            // every member for a cycle: the slot holder already collected
            // this round, and anyone else is not whose turn it is. Telling
            // someone to "advance the rotation" while offering no way to do
            // it leaves them exactly as stuck as before.
            if (secondaryLabel != null) ...[
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    onSecondary?.call();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side:
                        BorderSide(color: Colors.white.withValues(alpha: 0.18)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text(secondaryLabel,
                      style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Close',
                      style: GoogleFonts.inter(
                          color: Colors.grey[400], fontSize: 13.sp)),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    onPrimary?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text(primaryLabel,
                      style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
