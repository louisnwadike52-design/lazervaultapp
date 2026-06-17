import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// A utility class for displaying custom snackbars in the app
class LVSnackbar {
  /// Show an error snackbar for a RAW caught error, mapped to a safe,
  /// user-friendly line via [friendlyError] — never the raw gRPC/HTTP text.
  /// Prefer this over [showError] at catch sites:
  ///   } catch (e) { LVSnackbar.showErrorFor(e, context: 'load your transfers'); }
  /// For load failures that own the whole screen, prefer an inline
  /// `AppErrorView` instead of a snackbar.
  static void showErrorFor(
    Object? error, {
    String? context,
    String title = 'Something went wrong',
    Duration? duration,
    SnackPosition? position,
  }) {
    showError(
      title: title,
      message: friendlyError(error, context: context),
      duration: duration,
      position: position,
    );
  }
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
      backgroundColor: Colors.green.withValues(alpha: 0.8),
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
      backgroundColor: Colors.red.withValues(alpha: 0.8),
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
      backgroundColor: Colors.blue.withValues(alpha: 0.8),
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
      backgroundColor: Colors.orange.withValues(alpha: 0.8),
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