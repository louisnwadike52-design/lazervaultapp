import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Visual intent of an auth status sheet.
enum AuthStatusType { success, error }

/// App-standard modal bottom sheet for terminal auth outcomes (password reset
/// done, reset failed, etc.). On-theme with the dark palette + brand purple,
/// consistent across the email/password auth flow. Non-dismissible by default
/// so the user makes an explicit choice via the CTA.
///
/// Returns after the sheet is closed. If [onPrimary] is provided it runs when
/// the primary button is tapped (the sheet closes first); otherwise the sheet
/// just closes.
Future<void> showAuthStatusSheet(
  BuildContext context, {
  required AuthStatusType type,
  required String title,
  required String message,
  String primaryLabel = 'Continue',
  VoidCallback? onPrimary,
  String? secondaryLabel,
  VoidCallback? onSecondary,
  bool dismissible = false,
}) {
  final bool isSuccess = type == AuthStatusType.success;
  final Color accent =
      isSuccess ? const Color(0xFF10B981) : const Color(0xFFEF4444);
  final IconData icon =
      isSuccess ? Icons.check_circle_rounded : Icons.error_rounded;

  return showModalBottomSheet<void>(
    context: context,
    isDismissible: dismissible,
    enableDrag: dismissible,
    backgroundColor: const Color(0xFF1F1F1F),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (sheetCtx) => SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 40.w),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 28.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4834D4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                minimumSize: Size(double.infinity, 48.h),
              ),
              onPressed: () {
                Navigator.of(sheetCtx).pop();
                onPrimary?.call();
              },
              child: Text(
                primaryLabel,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            if (secondaryLabel != null) ...[
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () {
                  Navigator.of(sheetCtx).pop();
                  onSecondary?.call();
                },
                child: Text(
                  secondaryLabel,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
