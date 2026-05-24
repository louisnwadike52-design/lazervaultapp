// Pre-constructed upload + public URL pair returned by the backend's
// GetInsuranceDocumentUploadURL RPC. The Flutter purchase flow stamps
// `publicUrl` into form_data the moment this resolves, then PUTs the
// bytes to `uploadUrl` in the background. By the time MyCover (and
// its downstream insurer) fetches `publicUrl`, the bytes have landed.

class InsuranceDocumentUploadURL {
  final String uploadUrl;
  final String publicUrl;
  final String storageKey;
  final int expiresAt;

  const InsuranceDocumentUploadURL({
    required this.uploadUrl,
    required this.publicUrl,
    required this.storageKey,
    required this.expiresAt,
  });
}
