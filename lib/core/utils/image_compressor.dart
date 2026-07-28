import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Result of a compression pass: the (possibly re-encoded) bytes plus the
/// content-type they should now be uploaded with. When compression is skipped
/// or fails, [bytes] is the original input and [contentType] is unchanged.
class CompressedImage {
  final Uint8List bytes;
  final String contentType;
  const CompressedImage({required this.bytes, required this.contentType});
}

/// Shrinks images to a sane upload size WITHOUT visible quality loss, applied
/// at every storage-upload chokepoint so we never push a multi-megabyte
/// camera-original into storage.
///
/// Policy:
///   * Downscaled so the SHORTER edge is ~[maxEdge] (default 2000px) — this is
///     how `flutter_image_compress` interprets minWidth/minHeight: it scales
///     proportionally and never upscales, so small images are left as-is and
///     only oversized camera originals shrink. 2000px is deliberately generous
///     so detail (document text, faces) survives.
///   * JPEG re-encoded at quality 90 (visually lossless for photographs).
///   * PNG kept as PNG so screenshots / graphics with sharp edges or
///     transparency stay lossless (only downscaled if oversized).
///   * GIF (animation), SVG, and unknown types are passed through untouched —
///     re-encoding would break them.
///   * Any failure returns the ORIGINAL bytes (never blocks an upload).
class ImageCompressor {
  static Future<CompressedImage> compressForUpload(
    Uint8List input, {
    required String contentType,
    int maxEdge = 2000,
    int jpegQuality = 90,
  }) async {
    final ct = contentType.toLowerCase();

    // Only images are compressible — audio (voice notes), PDFs, and anything
    // non-image passes straight through. Also skip formats we must not
    // re-encode (animated GIF, SVG).
    if (!ct.startsWith('image/') || ct.contains('gif') || ct.contains('svg')) {
      return CompressedImage(bytes: input, contentType: contentType);
    }

    // Choose the output format: keep PNG lossless; everything else (jpeg, heic,
    // webp, unknown-but-image) normalises to JPEG at high quality.
    final bool keepPng = ct.contains('png');
    final format = keepPng ? CompressFormat.png : CompressFormat.jpeg;
    final outContentType = keepPng ? 'image/png' : 'image/jpeg';

    try {
      final out = await FlutterImageCompress.compressWithList(
        input,
        minWidth: maxEdge,
        minHeight: maxEdge,
        quality: keepPng ? 100 : jpegQuality,
        format: format,
        keepExif: false, // strip camera/location metadata (privacy + size)
      );
      // Guard: only accept the result when it actually shrank the payload.
      // For already-small images the encoder can round-trip LARGER — in that
      // case keep the original bytes and their original content-type.
      if (out.isNotEmpty && out.length < input.length) {
        return CompressedImage(bytes: out, contentType: outContentType);
      }
      return CompressedImage(bytes: input, contentType: contentType);
    } catch (e) {
      debugPrint('[ImageCompressor] compression skipped: $e');
      return CompressedImage(bytes: input, contentType: contentType);
    }
  }

  /// Rewrite [filename]'s extension to match [contentType] (e.g. a PNG that was
  /// re-encoded to JPEG becomes `*.jpg`) so the storage key/extension and the
  /// uploaded Content-Type agree. Non-image types keep their original name.
  static String alignedFilename(String filename, String contentType) {
    final ext = switch (contentType.toLowerCase()) {
      'image/jpeg' => 'jpg',
      'image/png' => 'png',
      'image/webp' => 'webp',
      'image/heic' => 'heic',
      _ => null,
    };
    if (ext == null) return filename;
    final dot = filename.lastIndexOf('.');
    final base = dot > 0 ? filename.substring(0, dot) : filename;
    return '$base.$ext';
  }
}
