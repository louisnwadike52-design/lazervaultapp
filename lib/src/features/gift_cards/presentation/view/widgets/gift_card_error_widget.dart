import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Maps raw backend/gRPC error messages to user-friendly messages.
String friendlyGiftCardError(String raw) {
  if (raw.contains('UNAVAILABLE') ||
      raw.contains('connect') ||
      raw.contains('connection')) {
    return 'Unable to connect to server. Please check your internet connection and try again.';
  }
  if (raw.contains('DEADLINE_EXCEEDED') || raw.contains('timeout')) {
    return 'Request timed out. Please try again.';
  }
  if (raw.contains('UNAUTHENTICATED') || raw.contains('authentication')) {
    return 'Your session has expired. Please log in again.';
  }
  if (raw.contains('PERMISSION_DENIED')) {
    return 'You don\'t have permission for this action.';
  }
  if (raw.contains('NOT_FOUND')) {
    return 'The requested item was not found.';
  }
  if (raw.contains('INTERNAL') || raw.contains('internal')) {
    return 'Something went wrong on our end. Please try again later.';
  }
  return 'Something went wrong. Please try again.';
}

/// Returns true if the raw error message indicates a connection/network issue.
bool isConnectionError(String raw) {
  return raw.contains('UNAVAILABLE') ||
      raw.contains('connect') ||
      raw.contains('connection') ||
      raw.contains('DEADLINE_EXCEEDED') ||
      raw.contains('timeout');
}

/// A reusable error widget for gift card screens.
///
/// Shows an icon, friendly message, and a "Try Again" button.
class GiftCardErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData icon;
  final bool connectionError;

  const GiftCardErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.icon = Icons.error_outline,
    this.connectionError = false,
  });

  /// Convenience factory that auto-maps raw error to friendly text.
  factory GiftCardErrorWidget.fromRaw({
    Key? key,
    required String rawMessage,
    required VoidCallback onRetry,
  }) {
    return GiftCardErrorWidget(
      key: key,
      message: friendlyGiftCardError(rawMessage),
      onRetry: onRetry,
      connectionError: isConnectionError(rawMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = connectionError
        ? const Color(0xFFFB923C)
        : const Color(0xFFEF4444);
    final effectiveIcon = connectionError ? Icons.wifi_off_rounded : icon;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: effectiveColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                effectiveIcon,
                color: effectiveColor,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 160.w,
              height: 44.h,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Try Again',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A scrollable error widget that can be used in place of a ListView body.
/// Supports pull-to-refresh when wrapped in RefreshIndicator.
class GiftCardErrorList extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool connectionError;

  const GiftCardErrorList({
    super.key,
    required this.message,
    required this.onRetry,
    this.connectionError = false,
  });

  factory GiftCardErrorList.fromRaw({
    Key? key,
    required String rawMessage,
    required VoidCallback onRetry,
  }) {
    return GiftCardErrorList(
      key: key,
      message: friendlyGiftCardError(rawMessage),
      onRetry: onRetry,
      connectionError: isConnectionError(rawMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = connectionError
        ? const Color(0xFFFB923C)
        : const Color(0xFFEF4444);
    final effectiveIcon =
        connectionError ? Icons.wifi_off_rounded : Icons.error_outline;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: effectiveColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  effectiveIcon,
                  size: 32.sp,
                  color: effectiveColor,
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 160.w,
                height: 44.h,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Try Again',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
