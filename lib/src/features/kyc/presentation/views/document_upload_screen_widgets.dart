part of 'document_upload_screen.dart';

/// Result of uploading a document to GCS via presigned URL
class _GCSUploadResult {
  final String storageKey;
  final String objectUrl;

  const _GCSUploadResult({
    required this.storageKey,
    required this.objectUrl,
  });
}
