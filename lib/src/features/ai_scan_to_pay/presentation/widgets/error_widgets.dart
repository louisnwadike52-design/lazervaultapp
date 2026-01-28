import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/exceptions/scan_exceptions.dart';

/// Error dialog for displaying scan errors with retry option
class ScanErrorDialog extends StatelessWidget {
  final ScanException exception;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  const ScanErrorDialog({
    Key? key,
    required this.exception,
    this.onRetry,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: _getErrorColor().withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getErrorIcon(),
                size: 32.r,
                color: _getErrorColor(),
              ),
            ),

            SizedBox(height: 16.h),

            // Error title
            Text(
              _getErrorTitle(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),

            SizedBox(height: 8.h),

            // Error message
            Text(
              exception.getUserMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
                height: 1.5,
              ),
            ),

            SizedBox(height: 24.h),

            // Action buttons
            Row(
              children: [
                if (onCancel != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6B7280),
                        side: const BorderSide(color: Color(0xFFD1D5DB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (onCancel != null && exception.canRetry && onRetry != null)
                  SizedBox(width: 12.w),
                if (exception.canRetry && onRetry != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (!exception.canRetry || onRetry == null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onCancel ?? () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getErrorColor() {
    if (exception is OCRException) {
      return const Color(0xFFF59E0B); // Amber for OCR issues
    } else if (exception is NetworkException) {
      return const Color(0xFFEF4444); // Red for network issues
    } else if (exception is PaymentException) {
      return const Color(0xFFEF4444); // Red for payment issues
    } else if (exception is ValidationException) {
      return const Color(0xFFF59E0B); // Amber for validation issues
    } else if (exception is AuthenticationException) {
      return const Color(0xFFEF4444); // Red for auth issues
    } else if (exception is RateLimitException) {
      return const Color(0xFFF59E0B); // Amber for rate limit
    }
    return const Color(0xFFEF4444); // Default red
  }

  IconData _getErrorIcon() {
    if (exception is OCRException) {
      return Icons.image_not_supported_outlined;
    } else if (exception is NetworkException) {
      return Icons.wifi_off_outlined;
    } else if (exception is PaymentException) {
      return Icons.error_outline;
    } else if (exception is ValidationException) {
      return Icons.warning_amber_outlined;
    } else if (exception is AuthenticationException) {
      return Icons.lock_outline;
    } else if (exception is RateLimitException) {
      return Icons.timer_outlined;
    }
    return Icons.error_outline;
  }

  String _getErrorTitle() {
    if (exception is OCRException) {
      return 'Scan Failed';
    } else if (exception is NetworkException) {
      return 'Connection Error';
    } else if (exception is PaymentException) {
      return 'Payment Failed';
    } else if (exception is ValidationException) {
      return 'Invalid Input';
    } else if (exception is AuthenticationException) {
      return 'Authentication Required';
    } else if (exception is RateLimitException) {
      return 'Too Many Attempts';
    }
    return 'Error';
  }
}

/// Low confidence warning banner
class LowConfidenceWarning extends StatelessWidget {
  final double confidenceScore;
  final VoidCallback? onRetake;

  const LowConfidenceWarning({
    Key? key,
    required this.confidenceScore,
    this.onRetake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVeryLow = confidenceScore < 0.4;
    final isMedium = confidenceScore >= 0.4 && confidenceScore < 0.6;
    final isLow = confidenceScore >= 0.6 && confidenceScore < 0.8;

    if (!isVeryLow && !isMedium && !isLow) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isVeryLow
            ? const Color(0xFFEF4444).withValues(alpha: 0.1)
            : const Color(0xFFF59E0B).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isVeryLow ? const Color(0xFFEF4444) : const Color(0xFFF59E0B),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 24.r,
                color: isVeryLow
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFF59E0B),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  isVeryLow
                      ? 'Very Low Confidence'
                      : isMedium
                          ? 'Medium Confidence'
                          : 'Low Confidence',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isVeryLow
                        ? const Color(0xFFEF4444)
                        : const Color(0xFFF59E0B),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            isVeryLow
                ? 'We couldn\'t read the details clearly. Please retake the photo with better lighting.'
                : 'Some details may be incorrect. Please verify all fields before proceeding.',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          if (onRetake != null) ...[
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onRetake,
                icon: Icon(Icons.camera_alt_outlined, size: 18.r),
                label: Text(
                  'Retake Photo',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isVeryLow
                      ? const Color(0xFFEF4444)
                      : const Color(0xFFF59E0B),
                  side: BorderSide(
                    color: isVeryLow
                        ? const Color(0xFFEF4444)
                        : const Color(0xFFF59E0B),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Error snackbar helper
class ScanErrorSnackbar {
  static void show(
    BuildContext context, {
    required ScanException exception,
    VoidCallback? onRetry,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            _getErrorIcon(exception),
            color: Colors.white,
            size: 20.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              exception.getUserMessage(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: _getErrorColor(exception),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      duration: const Duration(seconds: 4),
      action: exception.canRetry && onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: onRetry,
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static IconData _getErrorIcon(ScanException exception) {
    if (exception is OCRException) {
      return Icons.image_not_supported_outlined;
    } else if (exception is NetworkException) {
      return Icons.wifi_off_outlined;
    } else if (exception is PaymentException) {
      return Icons.error_outline;
    } else if (exception is ValidationException) {
      return Icons.warning_amber_outlined;
    }
    return Icons.error_outline;
  }

  static Color _getErrorColor(ScanException exception) {
    if (exception is OCRException || exception is ValidationException) {
      return const Color(0xFFF59E0B); // Amber
    }
    return const Color(0xFFEF4444); // Red
  }
}

/// Field-level error indicator
class FieldErrorIndicator extends StatelessWidget {
  final String errorMessage;
  final IconData? icon;

  const FieldErrorIndicator({
    Key? key,
    required this.errorMessage,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.error_outline,
            size: 16.r,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              errorMessage,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFFEF4444),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Loading overlay with error recovery
class ErrorRecoveryOverlay extends StatelessWidget {
  final ScanException exception;
  final VoidCallback onRetry;
  final VoidCallback onCancel;

  const ErrorRecoveryOverlay({
    Key? key,
    required this.exception,
    required this.onRetry,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48.r,
                color: const Color(0xFFEF4444),
              ),
              SizedBox(height: 16.h),
              Text(
                'Something went wrong',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111827),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                exception.getUserMessage(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6B7280),
                        side: const BorderSide(color: Color(0xFFD1D5DB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
