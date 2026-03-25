import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Categorized transfer error types for appropriate UI treatment.
enum TransferErrorType {
  insufficientBalance,
  dailyLimitExceeded,
  rateLimitExceeded,
  accountRestricted,
  lockContention,
  networkError,
  providerError,
  serviceUnavailable,
  generic,
}

/// Data class holding parsed error info for the bottom sheet.
class TransferErrorInfo {
  final TransferErrorType type;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const TransferErrorInfo({
    required this.type,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

/// Parses a backend error message into a structured [TransferErrorInfo].
TransferErrorInfo parseTransferError(String errorMessage, {VoidCallback? onRetry}) {
  final lower = errorMessage.toLowerCase();

  if (lower.contains('insufficient') || (lower.contains('balance') && !lower.contains('restrict'))) {
    return TransferErrorInfo(
      type: TransferErrorType.insufficientBalance,
      title: 'Insufficient Funds',
      message: 'Your account does not have enough available balance for this transfer. '
          'Please add funds or reduce the amount.',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: const Color(0xFFEF4444),
      iconBgColor: const Color(0xFFEF4444),
    );
  }

  if (lower.contains('daily') && (lower.contains('limit') || lower.contains('exceeded'))) {
    return TransferErrorInfo(
      type: TransferErrorType.dailyLimitExceeded,
      title: 'Daily Limit Reached',
      message: 'You have reached your daily transfer limit. '
          'Your limit resets at midnight. Upgrade your account tier for higher limits.',
      actionLabel: 'View Limits',
      icon: Icons.timer_outlined,
      iconColor: const Color(0xFFFB923C),
      iconBgColor: const Color(0xFFFB923C),
    );
  }

  if (lower.contains('rate limit') || lower.contains('too many') || lower.contains('try again later')) {
    return TransferErrorInfo(
      type: TransferErrorType.rateLimitExceeded,
      title: 'Too Many Requests',
      message: 'You have made too many transfers in a short time. '
          'Please wait a moment before trying again.',
      actionLabel: 'Try Again',
      onAction: onRetry,
      icon: Icons.speed_outlined,
      iconColor: const Color(0xFFFB923C),
      iconBgColor: const Color(0xFFFB923C),
    );
  }

  if (lower.contains('frozen') || lower.contains('suspended') || lower.contains('restricted') || lower.contains('locked')) {
    return TransferErrorInfo(
      type: TransferErrorType.accountRestricted,
      title: 'Account Restricted',
      message: 'Your account is currently restricted and cannot perform transfers. '
          'Please contact support for assistance.',
      actionLabel: 'Contact Support',
      icon: Icons.lock_outline,
      iconColor: const Color(0xFFEF4444),
      iconBgColor: const Color(0xFFEF4444),
    );
  }

  if (lower.contains('another transfer') || lower.contains('in progress') || lower.contains('resource busy')) {
    return TransferErrorInfo(
      type: TransferErrorType.lockContention,
      title: 'Transfer In Progress',
      message: 'Another transfer from this account is still being processed. '
          'Please wait a few seconds and try again.',
      actionLabel: 'Try Again',
      onAction: onRetry,
      icon: Icons.hourglass_top_rounded,
      iconColor: const Color(0xFFFB923C),
      iconBgColor: const Color(0xFFFB923C),
    );
  }

  if (lower.contains('network') || lower.contains('connection') || lower.contains('timeout')) {
    return TransferErrorInfo(
      type: TransferErrorType.networkError,
      title: 'Connection Error',
      message: 'Unable to reach the server. Please check your internet connection and try again.',
      actionLabel: 'Retry',
      onAction: onRetry,
      icon: Icons.wifi_off_rounded,
      iconColor: const Color(0xFFFB923C),
      iconBgColor: const Color(0xFFFB923C),
    );
  }

  if (lower.contains('provider') || lower.contains('flutterwave') || lower.contains('authorization key')) {
    return TransferErrorInfo(
      type: TransferErrorType.providerError,
      title: 'Payment Provider Error',
      message: 'The payment provider is temporarily unable to process your request. '
          'Your funds have not been debited. Please try again later.',
      actionLabel: 'Try Again Later',
      onAction: onRetry,
      icon: Icons.cloud_off_outlined,
      iconColor: const Color(0xFFFB923C),
      iconBgColor: const Color(0xFFFB923C),
    );
  }

  if (lower.contains('unavailable') || lower.contains('grpc')) {
    return TransferErrorInfo(
      type: TransferErrorType.serviceUnavailable,
      title: 'Service Unavailable',
      message: 'The service is temporarily unavailable. Please try again in a few moments.',
      actionLabel: 'Retry',
      onAction: onRetry,
      icon: Icons.cloud_off_outlined,
      iconColor: const Color(0xFFFB923C),
      iconBgColor: const Color(0xFFFB923C),
    );
  }

  return TransferErrorInfo(
    type: TransferErrorType.generic,
    title: 'Transfer Failed',
    message: errorMessage.length > 200 ? '${errorMessage.substring(0, 200)}...' : errorMessage,
    actionLabel: onRetry != null ? 'Try Again' : null,
    onAction: onRetry,
    icon: Icons.error_outline,
    iconColor: const Color(0xFFEF4444),
    iconBgColor: const Color(0xFFEF4444),
  );
}

/// Shows a financial-grade error bottom sheet for transfer failures.
///
/// Use this instead of snackbars for errors that require user attention
/// (daily limits, insufficient funds, account restrictions, lock contention).
void showTransferErrorBottomSheet(
  BuildContext context,
  String errorMessage, {
  VoidCallback? onRetry,
  VoidCallback? onDismiss,
}) {
  final info = parseTransferError(errorMessage, onRetry: onRetry);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => TransferErrorBottomSheet(
      info: info,
      onDismiss: onDismiss,
    ),
  );
}

/// Bottom sheet widget for transfer errors.
/// Follows the same design language as [KYCUpgradeModal].
class TransferErrorBottomSheet extends StatelessWidget {
  final TransferErrorInfo info;
  final VoidCallback? onDismiss;

  const TransferErrorBottomSheet({
    super.key,
    required this.info,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Icon
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: info.iconBgColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              info.icon,
              color: info.iconColor,
              size: 32.w,
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            info.title,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),

          // Message
          Text(
            info.message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),

          // Primary action button (if available)
          if (info.actionLabel != null) ...[
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  info.onAction?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  info.actionLabel!,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],

          // Dismiss button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDismiss?.call();
              },
              child: Text(
                info.actionLabel != null ? 'Dismiss' : 'OK',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
