part of 'create_policy_cubit.dart';

/// Holds the bytes + metadata for a file the user has selected but not
/// yet uploaded. Lives on the cubit only — flushed when the purchase
/// saga starts. Never persisted.
///
/// `resolvedUrls` and `inflightPut` are populated once
/// `stagePendingFile` has called the backend's
/// GetInsuranceDocumentUploadURL RPC and kicked off the background
/// PUT. Both are null while the resolver is in flight (the field's
/// form_data value is `__pending_upload__` during that window).
class _PendingFileUpload {
  final List<int> bytes;
  final String filename;
  final String contentType;
  InsuranceDocumentUploadURL? resolvedUrls;
  // Future tracking the in-flight PUT to the upload URL. Stays null
  // until startBackgroundPut() is called by the cubit once the URL
  // resolver returns. The purchase saga awaits this so MyCover never
  // fetches the public URL before the PUT lands.
  Future<void>? inflightPut;

  _PendingFileUpload({
    required this.bytes,
    required this.filename,
    required this.contentType,
    this.resolvedUrls,
    this.inflightPut,
  });

  /// Best-effort sniff of file kind for the preview UI. Anything starting
  /// with `image/` renders as an Image.memory; otherwise we show a
  /// document icon + filename.
  bool get isImage => contentType.startsWith('image/');

  /// Returns a copy with the resolved URL pair attached. The caller
  /// then calls `startBackgroundPut` to begin the actual upload.
  _PendingFileUpload withResolvedURL(InsuranceDocumentUploadURL urls) {
    return _PendingFileUpload(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      resolvedUrls: urls,
      inflightPut: inflightPut,
    );
  }

  /// Begins the actual PUT to the upload URL. Idempotent — calling
  /// twice keeps the first in-flight future.
  void startBackgroundPut(InsuranceRepository repository) {
    final urls = resolvedUrls;
    if (urls == null || inflightPut != null) return;
    inflightPut = _putBytes(urls.uploadUrl, bytes, contentType);
  }
}

/// Public read-only view of a staged file. Returned by
/// [CreatePolicyCubit.stagedFile] so the form widget can render the
/// preview thumbnail + full-screen viewer without touching the
/// private `_PendingFileUpload` class.
class StagedInsuranceFile {
  final List<int> bytes;
  final String filename;
  final String contentType;
  final bool isImage;

  const StagedInsuranceFile._({
    required this.bytes,
    required this.filename,
    required this.contentType,
    required this.isImage,
  });
}
