import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// Visual intent of a snackbar — drives its (solid, readable) background colour.
enum AppSnackbarType { error, success, info }

/// App-standard snackbar. `Get.snackbar` defaults to a TRANSPARENT background,
/// which left onboarding messages almost unreadable; this helper always paints
/// a solid, intent-coloured background with white text so every snackbar is
/// legible and consistent across the flow.
void showAppSnackbar(
  String title,
  String message, {
  AppSnackbarType type = AppSnackbarType.info,
  Duration duration = const Duration(seconds: 3),
  TextButton? mainButton,
}) {
  // Belt-and-suspenders: never let raw transport/exception text (e.g. "HTTP
  // connection completed with 502 instead of 200") reach an error snackbar.
  // Only error messages are sanitized — our own success/info copy is left as-is.
  if (type == AppSnackbarType.error) {
    message = sanitizeUserFacingError(message);
  }

  final Color background;
  switch (type) {
    case AppSnackbarType.error:
      background = const Color(0xFFD92D20); // red
      break;
    case AppSnackbarType.success:
      background = const Color(0xFF0E9F6E); // green
      break;
    case AppSnackbarType.info:
      background = const Color(0xFF1F2937); // dark slate
      break;
  }

  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: background,
    colorText: Colors.white,
    margin: EdgeInsets.all(16.w),
    borderRadius: 12.r,
    duration: duration,
    mainButton: mainButton,
    titleText: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 13.5.sp),
    ),
  );
}
