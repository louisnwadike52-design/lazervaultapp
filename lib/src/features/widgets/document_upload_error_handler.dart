import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Error type for document-related failures
enum DocumentErrorType {
  blur,
  glare,
  dark,
  corners,
  faceNotDetected,
  faceMultiple,
  documentMismatch,
  expired,
  network,
  server,
  unknown,
}

/// Error details for document upload
class DocumentErrorDetails {
  final DocumentErrorType type;
  final String title;
  final String message;
  final List<String> tips;
  final bool canRetry;
  final bool canUseManualEntry;

  const DocumentErrorDetails({
    required this.type,
    required this.title,
    required this.message,
    required this.tips,
    this.canRetry = true,
    this.canUseManualEntry = false,
  });
}

/// Widget for displaying document upload errors with helpful tips and actions
class DocumentUploadErrorHandler extends StatelessWidget {
  final String? errorMessage;
  final DocumentErrorType? errorType;
  final VoidCallback onRetry;
  final VoidCallback onManualEntry;
  final VoidCallback onContactSupport;
  final bool isLoading;

  const DocumentUploadErrorHandler({
    super.key,
    this.errorMessage,
    this.errorType,
    required this.onRetry,
    required this.onManualEntry,
    required this.onContactSupport,
    this.isLoading = false,
  });

  /// Parse error type from error message
  static DocumentErrorType parseErrorType(String? error) {
    if (error == null) return DocumentErrorType.unknown;

    final lowerError = error.toLowerCase();

    if (lowerError.contains('blur') || lowerError.contains('focus')) {
      return DocumentErrorType.blur;
    }
    if (lowerError.contains('glare') || lowerError.contains('reflection')) {
      return DocumentErrorType.glare;
    }
    if (lowerError.contains('dark') || lowerError.contains('light')) {
      return DocumentErrorType.dark;
    }
    if (lowerError.contains('corner') || lowerError.contains('edge')) {
      return DocumentErrorType.corners;
    }
    if (lowerError.contains('face') && lowerError.contains('not')) {
      return DocumentErrorType.faceNotDetected;
    }
    if (lowerError.contains('face') && lowerError.contains('multiple')) {
      return DocumentErrorType.faceMultiple;
    }
    if (lowerError.contains('mismatch') || lowerError.contains('match')) {
      return DocumentErrorType.documentMismatch;
    }
    if (lowerError.contains('expire')) {
      return DocumentErrorType.expired;
    }
    if (lowerError.contains('network') || lowerError.contains('connection')) {
      return DocumentErrorType.network;
    }
    if (lowerError.contains('server') || lowerError.contains('500')) {
      return DocumentErrorType.server;
    }

    return DocumentErrorType.unknown;
  }

  /// Get error details based on error type
  DocumentErrorDetails getErrorDetails() {
    final type = errorType ?? parseErrorType(errorMessage);

    switch (type) {
      case DocumentErrorType.blur:
        return const DocumentErrorDetails(
          type: DocumentErrorType.blur,
          title: 'Image is Blurry',
          message: 'The image appears to be out of focus. Please retake with a steady hand.',
          tips: [
            'Hold your phone steady with both hands',
            'Tap the screen to focus before capturing',
            'Keep the phone at least 30cm away from the document',
            'Ensure good lighting to help autofocus',
          ],
          canRetry: true,
        );

      case DocumentErrorType.glare:
        return const DocumentErrorDetails(
          type: DocumentErrorType.glare,
          title: 'Glare Detected',
          message: 'There\'s too much glare or reflection on the document.',
          tips: [
            'Move away from direct light sources',
            'Tilt the document slightly to reduce reflections',
            'Avoid using flash',
            'Capture near a window with indirect natural light',
          ],
          canRetry: true,
        );

      case DocumentErrorType.dark:
        return const DocumentErrorDetails(
          type: DocumentErrorType.dark,
          title: 'Image is Too Dark',
          message: 'The image is too dark to read. Please retake in better lighting.',
          tips: [
            'Move to a well-lit area',
            'Use natural light from a window',
            'Avoid shadows falling on the document',
            'Ensure the background is darker than the document',
          ],
          canRetry: true,
        );

      case DocumentErrorType.corners:
        return const DocumentErrorDetails(
          type: DocumentErrorType.corners,
          title: 'Corners Not Visible',
          message: 'Please ensure all corners of the document are visible.',
          tips: [
            'Position the camera so the entire document fits',
            'Hold the phone parallel to the document',
            'Ensure no parts of the document are cut off',
            'Leave some empty space around the document edges',
          ],
          canRetry: true,
        );

      case DocumentErrorType.faceNotDetected:
        return const DocumentErrorDetails(
          type: DocumentErrorType.faceNotDetected,
          title: 'No Face Detected',
          message: 'We couldn\'t detect a face in the image.',
          tips: [
            'Make sure your entire face is visible',
            'Remove hats, masks, or face coverings',
            'Face the camera directly',
            'Ensure good lighting on your face',
          ],
          canRetry: true,
        );

      case DocumentErrorType.faceMultiple:
        return const DocumentErrorDetails(
          type: DocumentErrorType.faceMultiple,
          title: 'Multiple Faces Detected',
          message: 'Please take the photo alone. Multiple people were detected.',
          tips: [
            'Take the photo by yourself',
            'Ensure no one else is in the frame',
            'Use a plain background',
          ],
          canRetry: true,
        );

      case DocumentErrorType.documentMismatch:
        return const DocumentErrorDetails(
          type: DocumentErrorType.documentMismatch,
          title: 'Document Type Mismatch',
          message: 'The document doesn\'t match the selected type.',
          tips: [
            'Verify you selected the correct document type',
            'Ensure you\'re uploading the correct document',
            'Check that the document is valid and not expired',
            'Consider selecting a different document type',
          ],
          canRetry: true,
          canUseManualEntry: true,
        );

      case DocumentErrorType.expired:
        return const DocumentErrorDetails(
          type: DocumentErrorType.expired,
          title: 'Document Expired',
          message: 'This document has expired. Please use a valid document.',
          tips: [
            'Check the expiration date on your document',
            'Use a document that hasn\'t expired',
            'Some documents must be valid for at least 6 months',
          ],
          canRetry: true,
          canUseManualEntry: true,
        );

      case DocumentErrorType.network:
        return const DocumentErrorDetails(
          type: DocumentErrorType.network,
          title: 'Network Error',
          message: 'Please check your internet connection and try again.',
          tips: [
            'Check your WiFi or mobile data connection',
            'Try switching between WiFi and mobile data',
            'Move to an area with better signal',
            'Close other apps that might be using bandwidth',
          ],
          canRetry: true,
        );

      case DocumentErrorType.server:
        return const DocumentErrorDetails(
          type: DocumentErrorType.server,
          title: 'Server Error',
          message: 'Our servers are experiencing issues. Please try again.',
          tips: [
            'Wait a moment and try again',
            'If the problem persists, contact support',
            'Your data is safe and won\'t be lost',
          ],
          canRetry: true,
        );

      case DocumentErrorType.unknown:
        return DocumentErrorDetails(
          type: DocumentErrorType.unknown,
          title: 'Upload Failed',
          message: errorMessage ?? 'An error occurred while processing your document.',
          tips: [
            'Please try again',
            'If the problem persists, try manual entry',
            'Contact support if you continue to have issues',
          ],
          canRetry: true,
          canUseManualEntry: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = getErrorDetails();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Error icon and title
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: _getErrorColor(details.type).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getErrorIcon(details.type),
                  color: _getErrorColor(details.type),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      details.message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Tips section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 18.sp,
                      color: Colors.orange.shade700,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Tips to fix this:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                ...details.tips.map((tip) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4.h),
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              tip,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Action buttons
          Row(
            children: [
              if (details.canUseManualEntry) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onManualEntry,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    icon: Icon(Icons.edit, size: 18.sp),
                    label: Text(
                      'Manual Entry',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
              ],
              Expanded(
                flex: details.canUseManualEntry ? 1 : 2,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: isLoading
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(Icons.refresh, size: 18.sp),
                  label: Text(
                    isLoading ? 'Retrying...' : 'Try Again',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),

          // Contact support link
          if (!details.canRetry)
            Center(
              child: TextButton.icon(
                onPressed: onContactSupport,
                icon: Icon(Icons.support_agent, size: 16.sp),
                label: Text(
                  'Contact Support',
                  style: TextStyle(fontSize: 13.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getErrorColor(DocumentErrorType type) {
    switch (type) {
      case DocumentErrorType.blur:
      case DocumentErrorType.dark:
      case DocumentErrorType.corners:
        return Colors.orange;
      case DocumentErrorType.glare:
        return Colors.amber;
      case DocumentErrorType.faceNotDetected:
      case DocumentErrorType.faceMultiple:
      case DocumentErrorType.documentMismatch:
      case DocumentErrorType.expired:
        return Colors.red;
      case DocumentErrorType.network:
      case DocumentErrorType.server:
        return Colors.purple;
      case DocumentErrorType.unknown:
        return Colors.grey;
    }
  }

  IconData _getErrorIcon(DocumentErrorType type) {
    switch (type) {
      case DocumentErrorType.blur:
        return Icons.blur_on;
      case DocumentErrorType.glare:
        return Icons.highlight;
      case DocumentErrorType.dark:
        return Icons.dark_mode;
      case DocumentErrorType.corners:
        return Icons.crop_free;
      case DocumentErrorType.faceNotDetected:
      case DocumentErrorType.faceMultiple:
        return Icons.face_retouching_off;
      case DocumentErrorType.documentMismatch:
        return Icons.document_scanner;
      case DocumentErrorType.expired:
        return Icons.event_busy;
      case DocumentErrorType.network:
        return Icons.wifi_off;
      case DocumentErrorType.server:
        return Icons.cloud_off;
      case DocumentErrorType.unknown:
        return Icons.error_outline;
    }
  }
}

/// Bottom sheet for showing document upload errors
class DocumentUploadErrorSheet extends StatelessWidget {
  final String? errorMessage;
  final DocumentErrorType? errorType;
  final VoidCallback onRetry;
  final VoidCallback onManualEntry;
  final VoidCallback onContactSupport;
  final bool isLoading;

  const DocumentUploadErrorSheet({
    super.key,
    this.errorMessage,
    this.errorType,
    required this.onRetry,
    required this.onManualEntry,
    required this.onContactSupport,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Error content
          DocumentUploadErrorHandler(
            errorMessage: errorMessage,
            errorType: errorType,
            onRetry: () {
              Get.back();
              onRetry();
            },
            onManualEntry: () {
              Get.back();
              onManualEntry();
            },
            onContactSupport: () {
              Get.back();
              onContactSupport();
            },
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  /// Show the error bottom sheet
  static Future<void> show({
    required String? errorMessage,
    DocumentErrorType? errorType,
    required VoidCallback? onRetry,
    required VoidCallback? onManualEntry,
    required VoidCallback? onContactSupport,
    bool isLoading = false,
  }) async {
    // Provide default no-op callbacks if not provided
    final retryCallback = onRetry ?? () {};
    final manualEntryCallback = onManualEntry ?? () {};
    final supportCallback = onContactSupport ?? () {};
    await Get.bottomSheet(
      DocumentUploadErrorSheet(
        errorMessage: errorMessage,
        errorType: errorType,
        onRetry: retryCallback,
        onManualEntry: manualEntryCallback,
        onContactSupport: supportCallback,
        isLoading: isLoading,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

/// Snackbar for quick error notifications
class DocumentErrorSnackbar {
  static void show({
    required String? errorMessage,
    DocumentErrorType? errorType,
    VoidCallback? onRetry,
    VoidCallback? onManualEntry,
  }) {
    final type = errorType ?? DocumentUploadErrorHandler.parseErrorType(errorMessage);

    final details = DocumentUploadErrorHandler(
      errorMessage: errorMessage,
      errorType: type,
      onRetry: () {},
      onManualEntry: () {},
      onContactSupport: () {},
    ).getErrorDetails();

    Get.snackbar(
      _getTitle(type),
      details.message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: _getBackgroundColor(type),
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: Icon(_getIcon(type), color: Colors.white),
      duration: const Duration(seconds: 4),
      mainButton: onRetry != null
          ? TextButton(
              onPressed: onRetry,
              child: const Text(
                'RETRY',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }

  static String _getTitle(DocumentErrorType type) {
    switch (type) {
      case DocumentErrorType.blur:
        return 'Blurry Image';
      case DocumentErrorType.glare:
        return 'Glare Detected';
      case DocumentErrorType.dark:
        return 'Dark Image';
      case DocumentErrorType.corners:
        return 'Corners Not Visible';
      case DocumentErrorType.faceNotDetected:
        return 'No Face Detected';
      case DocumentErrorType.faceMultiple:
        return 'Multiple Faces';
      case DocumentErrorType.documentMismatch:
        return 'Document Mismatch';
      case DocumentErrorType.expired:
        return 'Document Expired';
      case DocumentErrorType.network:
        return 'Network Error';
      case DocumentErrorType.server:
        return 'Server Error';
      case DocumentErrorType.unknown:
        return 'Upload Failed';
    }
  }

  static Color _getBackgroundColor(DocumentErrorType type) {
    switch (type) {
      case DocumentErrorType.blur:
      case DocumentErrorType.dark:
      case DocumentErrorType.corners:
        return Colors.orange;
      case DocumentErrorType.glare:
        return Colors.amber.shade700;
      case DocumentErrorType.faceNotDetected:
      case DocumentErrorType.faceMultiple:
      case DocumentErrorType.documentMismatch:
      case DocumentErrorType.expired:
        return Colors.red;
      case DocumentErrorType.network:
      case DocumentErrorType.server:
        return Colors.purple;
      case DocumentErrorType.unknown:
        return Colors.grey;
    }
  }

  static IconData _getIcon(DocumentErrorType type) {
    switch (type) {
      case DocumentErrorType.blur:
        return Icons.blur_on;
      case DocumentErrorType.glare:
        return Icons.highlight;
      case DocumentErrorType.dark:
        return Icons.dark_mode;
      case DocumentErrorType.corners:
        return Icons.crop_free;
      case DocumentErrorType.faceNotDetected:
      case DocumentErrorType.faceMultiple:
        return Icons.face_retouching_off;
      case DocumentErrorType.documentMismatch:
        return Icons.document_scanner;
      case DocumentErrorType.expired:
        return Icons.event_busy;
      case DocumentErrorType.network:
        return Icons.wifi_off;
      case DocumentErrorType.server:
        return Icons.cloud_off;
      case DocumentErrorType.unknown:
        return Icons.error_outline;
    }
  }
}
