import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// "This service is temporarily unavailable", admin-driven.
///
/// A MODAL rather than a snackbar, deliberately. A snackbar vanishes while the
/// user is still reading it and carries no acknowledgement, so someone who
/// taps a service twice sees a flicker and concludes the app is broken. An
/// outage is a statement the user has to receive and dismiss.
///
/// The copy is admin-supplied: an operator who takes a service down can say
/// WHY and roughly for how long, which is the difference between "this app is
/// broken" and "they are working on it". When no message is configured the
/// caller passes a neutral default rather than leaving the body blank.
///
/// Deliberately has no retry action. The gate is a deliberate admin decision,
/// not a transient error, so a "Try again" button would simply re-show this
/// same modal and teach the user the button does nothing.
Future<void> showServiceUnavailableModal(
  BuildContext context, {
  required String serviceName,
  required String message,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 18.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Container(
                height: 54.w,
                width: 54.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.construction_rounded,
                    color: const Color(0xFFF59E0B), size: 26.sp),
              ),
              SizedBox(height: 14.h),
              Text(
                '$serviceName is unavailable',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: 13.sp,
                  height: 1.45,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B45C9),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text('Got it',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
