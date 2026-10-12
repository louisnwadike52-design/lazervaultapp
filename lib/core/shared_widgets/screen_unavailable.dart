import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// What a screen shows when it cannot render: a way out, never an empty box.
///
/// WHY THIS EXISTS
/// ---------------
/// Several screens guarded their "I have no data to draw" case with
///
/// ```dart
/// return const Scaffold(backgroundColor: Color(0xFF0A0A0A),
///                       body: SizedBox.shrink());
/// ```
///
/// which is a black rectangle with no app bar, no back button and no text. It
/// was meant as a one-frame placeholder while a `post-frame` callback in
/// `initState` routed the user home, and for that single frame it is fine.
///
/// It stops being fine the moment the condition becomes true any LATER than
/// initState, because then nothing redirects: the redirect is wired to the
/// first frame only. The user is left on a dark, empty screen with no gesture
/// that does anything — reported after closing the share sheet on an Auto-Save
/// receipt. A blank screen is also the one failure state that tells the user
/// nothing at all, so it is worth never shipping even when it should be
/// unreachable.
///
/// This widget keeps the same role (it still renders instantly, and the
/// redirect still runs) but is honest and always escapable.
class ScreenUnavailable extends StatelessWidget {
  const ScreenUnavailable({
    super.key,
    this.title = 'This page is no longer available',
    this.message =
        'We could not find the details for this screen. Go back and open it '
            'again.',
    this.actionLabel = 'Go back',
    this.onAction,
    this.backgroundColor = const Color(0xFF0A0A0A),
    this.onLight = false,
  });

  final String title;
  final String message;
  final String actionLabel;

  /// Defaults to popping, falling back to the previous route only when there
  /// is one — a screen reached by a redirect may be the only one on the stack,
  /// and a dead button is the problem this widget exists to remove.
  final VoidCallback? onAction;

  final Color backgroundColor;

  /// Flip the palette for the light-themed flows (bills, send funds) so the
  /// text is readable on their background rather than black on black.
  final bool onLight;

  void _defaultAction() {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    } else {
      Get.until((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fg = onLight ? const Color(0xFF111827) : Colors.white;
    final muted = onLight ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.inbox_outlined, size: 44.sp, color: muted),
                SizedBox(height: 14.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: fg,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: muted,
                    fontSize: 13.sp,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAction ?? _defaultAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      actionLabel,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
