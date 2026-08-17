part of 'document_upload_error_handler.dart';

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
