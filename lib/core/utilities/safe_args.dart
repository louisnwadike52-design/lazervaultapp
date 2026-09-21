import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Typed, crash-proof access to `Get.arguments`.
///
/// A route can be entered without the arguments its screen expects — deep
/// link, push-notification resolver, state restoration, or a plain coding
/// mistake — and a bare `Get.arguments as Map<String, dynamic>` then throws
/// in initState/build, which release mode renders as a dead grey screen.
/// `safeArgs` returns null instead so the screen can bail gracefully.
T? safeArgs<T>() {
  final args = Get.arguments;
  return args is T ? args : null;
}

/// Standard bail-out for a screen whose required arguments are missing:
/// after the first frame, pop back and tell the user what happened. Call
/// from initState/build when [safeArgs] returned null; the caller must
/// still render SOMETHING for the intervening frame (an empty Scaffold).
void popMissingArgs(String screenName) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (Get.isSnackbarOpen) return;
    // The very situations that bring us here — a deep link or a push
    // notification opened from cold — can make this screen the ONLY route on
    // the stack. `Get.back()` there pops the app down to nothing, trading a
    // grey screen for a black one. Land the user on the dashboard instead.
    final canPop = Get.key.currentState?.canPop() ?? false;
    if (canPop) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
    }
    Get.snackbar(
      'Something went wrong',
      'We couldn\'t open $screenName. Please try again.',
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  });
}
