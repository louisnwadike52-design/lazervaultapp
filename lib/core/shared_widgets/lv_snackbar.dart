import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// A utility class for displaying custom snackbars in the app
class LVSnackbar {
  /// Show a success snackbar with the given title and message
  static void showSuccess({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: position ?? SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      isDismissible: true,
      duration: duration ?? const Duration(seconds: 3),
      margin: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }

  /// Show an error snackbar with the given title and message
  static void showError({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: position ?? SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      isDismissible: true,
      duration: duration ?? const Duration(seconds: 3),
      margin: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }

  /// Show an info snackbar with the given title and message
  static void showInfo({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: position ?? SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      isDismissible: true,
      duration: duration ?? const Duration(seconds: 3),
      margin: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }

  /// Show a warning snackbar with the given title and message
  static void showWarning({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: position ?? SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
      isDismissible: true,
      duration: duration ?? const Duration(seconds: 3),
      margin: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      icon: Icon(
        Icons.warning_amber,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }
} 