import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/utils/image_compressor.dart';

/// Client-side caps for escrow evidence. Kept in step with the storage proxy's
/// server-side limits so the friendly message shows up before we waste a round
/// trip.
const int kEscrowImageMaxBytes = 8 * 1024 * 1024; // 8 MB
const int kEscrowVideoMaxBytes = 10 * 1024 * 1024; // 10 MB
const int kEscrowVideoMaxSeconds = 60;

/// The outcome of a successful media upload: the public URL persisted on the
/// deal plus the metadata the backend's `addAttachment` needs.
class EscrowMediaUploadResult {
  final String publicUrl;
  final String mediaKind; // 'image' | 'video'
  final String contentType;
  final int sizeBytes;
  final int durationSeconds; // 0 for images
  const EscrowMediaUploadResult({
    required this.publicUrl,
    required this.mediaKind,
    required this.contentType,
    required this.sizeBytes,
    required this.durationSeconds,
  });

  bool get isVideo => mediaKind == 'video';
}

/// Thrown with a warm, human message the user can act on (compress, trim, sign
/// in again). Never contains a dash used as a pause or connector.
class EscrowMediaUploadException implements Exception {
  final String message;
  const EscrowMediaUploadException(this.message);
  @override
  String toString() => message;
}

/// Picks, validates, compresses and uploads escrow evidence media (images and
/// short videos) through core-gateway's storage proxy
/// (POST `/api/v1/escrow/upload-url`) + the signed-URL PUT.
///
/// Ordering is deliberate and MUST NOT be reordered:
///   1. Pick with image_picker.
///   2. Read the real size (and, for video, the real duration).
///   3. Validate the RAW pick first. If it is over a cap we do NOT auto-fix; we
///      throw a friendly exception asking the user to compress or trim it.
///   4. Only once within limits, run our own compression pass as a safety net,
///      then re-check the result is still within the cap.
///   5. Request an upload URL, PUT the bytes, return the public URL + metadata.
class EscrowMediaUploadService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _httpTimeout = Duration(seconds: 120);

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;
  final ImagePicker _picker;

  EscrowMediaUploadService({
    required EndpointRegistry endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
    ImagePicker? picker,
  })  : _endpoints = endpoints,
        _storage = storage ?? const FlutterSecureStorage(),
        _httpClient = httpClient ?? http.Client(),
        _picker = picker ?? ImagePicker();

  /// Pick a photo, validate it is within 8 MB, compress, and upload. Returns
  /// null when the user backs out of the picker.
  Future<EscrowMediaUploadResult?> pickAndUploadImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    final XFile? x = await _picker.pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 90,
    );
    if (x == null) return null;

    // Read the real bytes and validate the RAW pick first (no auto-fix).
    var bytes = await File(x.path).readAsBytes();
    if (bytes.length > kEscrowImageMaxBytes) {
      throw const EscrowMediaUploadException(
        'This photo is a bit too big. Please compress it to under 8 MB and try again.',
      );
    }

    // Safety-net compression pass, then re-check the compressed result.
    final rawName = _basename(x.path, 'escrow-photo.jpg');
    var contentType = imageContentTypeFor(rawName);
    final compressed = await ImageCompressor.compressForUpload(bytes,
        contentType: contentType);
    bytes = compressed.bytes;
    contentType = compressed.contentType;
    final filename = ImageCompressor.alignedFilename(rawName, contentType);
    if (bytes.length > kEscrowImageMaxBytes) {
      throw const EscrowMediaUploadException(
        'This photo is still too big after we tried to shrink it. Please compress it to under 8 MB and try again.',
      );
    }

    return _upload(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      mediaKind: 'image',
      durationSeconds: 0,
    );
  }

  /// Pick a short video, validate it is within 60 seconds and 10 MB, compress,
  /// and upload. Returns null when the user backs out of the picker.
  Future<EscrowMediaUploadResult?> pickAndUploadVideo({
    ImageSource source = ImageSource.gallery,
  }) async {
    final XFile? x = await _picker.pickVideo(
      source: source,
      maxDuration: const Duration(seconds: kEscrowVideoMaxSeconds),
    );
    if (x == null) return null;

    File file = File(x.path);
    int sizeBytes = await file.length();
    int durationSeconds = 0;
    try {
      final info = await VideoCompress.getMediaInfo(file.path);
      final durMs = info.duration;
      if (durMs != null && durMs > 0) durationSeconds = (durMs / 1000).round();
      final fs = info.filesize;
      if (fs != null && fs > 0) sizeBytes = fs;
    } catch (_) {
      // If probing fails we fall back to the raw file length and an unknown
      // duration, which the caps below still guard on size.
    }

    // Validate the RAW pick first (no auto-fix).
    if (durationSeconds > kEscrowVideoMaxSeconds) {
      throw const EscrowMediaUploadException(
        'This video is a little long. Please trim it to 60 seconds or less and try again.',
      );
    }
    if (sizeBytes > kEscrowVideoMaxBytes) {
      throw const EscrowMediaUploadException(
        'This video is a bit too big. Please compress it and try again (up to 60 seconds and 10 MB).',
      );
    }

    // Safety-net compression pass (medium quality, audio kept).
    String contentType = videoContentTypeFor(x.path);
    String filename = _basename(x.path, 'escrow-video.mp4');
    try {
      final out = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.MediumQuality,
        includeAudio: true,
        deleteOrigin: false,
      );
      final outFile = out?.file;
      if (outFile != null && await outFile.exists()) {
        file = outFile;
        contentType = 'video/mp4';
        filename = _basename(outFile.path, 'escrow-video.mp4');
        final durMs = out?.duration;
        if (durMs != null && durMs > 0)
          durationSeconds = (durMs / 1000).round();
      }
    } catch (_) {
      // Compression is best effort; fall back to the original pick.
    }

    final Uint8List bytes = await file.readAsBytes();
    if (bytes.length > kEscrowVideoMaxBytes) {
      throw const EscrowMediaUploadException(
        'This video is still too big after we tried to shrink it. Please compress it and try again (up to 60 seconds and 10 MB).',
      );
    }
    if (durationSeconds > kEscrowVideoMaxSeconds) {
      throw const EscrowMediaUploadException(
        'This video is a little long. Please trim it to 60 seconds or less and try again.',
      );
    }
    // An UNKNOWN duration has to be caught here, before we spend the upload.
    //
    // Both probes above swallow their errors, so a video whose duration we
    // could not read arrives at this point as 0. Zero passes every check in
    // this method (they all test "greater than"), so the bytes used to upload
    // fine and then AddAttachment rejected them server side, where 0 is
    // treated as invalid. The user had already paid for the upload and was
    // then told to trim a video that might be ten seconds long.
    //
    // Failing here costs nothing and says something true.
    if (durationSeconds <= 0) {
      throw const EscrowMediaUploadException(
        'We could not read how long this video is. Please try a different video, or record a new one in the app.',
      );
    }

    return _upload(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      mediaKind: 'video',
      durationSeconds: durationSeconds,
    );
  }

  Future<EscrowMediaUploadResult> _upload({
    required Uint8List bytes,
    required String filename,
    required String contentType,
    required String mediaKind,
    required int durationSeconds,
  }) async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    if (accessToken == null || accessToken.isEmpty) {
      throw const EscrowMediaUploadException(
        'You need to be signed in to upload.',
      );
    }

    // httpCore already ends in `/api/v1`; the route is
    // POST /api/v1/escrow/upload-url (do NOT prepend another /v1).
    final uploadUrlEndpoint = '${_endpoints.httpCore}/escrow/upload-url';

    final ticketResp = await _httpClient
        .post(
          Uri.parse(uploadUrlEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode({
            'filename': filename,
            'content_type': contentType,
          }),
        )
        .timeout(_httpTimeout);

    if (ticketResp.statusCode == 401 || ticketResp.statusCode == 403) {
      throw const EscrowMediaUploadException(
        'Your session expired. Please sign in again.',
      );
    }
    if (ticketResp.statusCode < 200 || ticketResp.statusCode >= 300) {
      throw EscrowMediaUploadException(
        _extractMessage(ticketResp.body,
            fallback: 'We could not start the upload. Please try again.'),
      );
    }

    final ticket = _parseTicket(ticketResp.body);

    // Respect the server's own byte ceiling if it sends one.
    if (ticket.maxBytes > 0 && bytes.length > ticket.maxBytes) {
      throw EscrowMediaUploadException(
        mediaKind == 'video'
            ? 'This video is a bit too big. Please compress it and try again (up to 60 seconds and 10 MB).'
            : 'This photo is a bit too big. Please compress it to under 8 MB and try again.',
      );
    }

    final putResp = await _httpClient
        .put(
          Uri.parse(ticket.uploadUrl),
          headers: {'Content-Type': ticket.contentType},
          body: bytes,
        )
        .timeout(_httpTimeout);
    if (putResp.statusCode < 200 || putResp.statusCode >= 300) {
      throw EscrowMediaUploadException(
        'The upload did not go through (HTTP ${putResp.statusCode}). Please try again.',
      );
    }

    return EscrowMediaUploadResult(
      publicUrl: ticket.publicUrl,
      mediaKind: ticket.mediaKind.isNotEmpty ? ticket.mediaKind : mediaKind,
      contentType: ticket.contentType,
      sizeBytes: bytes.length,
      durationSeconds: durationSeconds,
    );
  }

  static _UploadTicket _parseTicket(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const EscrowMediaUploadException(
        'Storage returned an unexpected response.',
      );
    }
    final uploadUrl = (decoded['upload_url'] as String?) ?? '';
    final publicUrl = (decoded['public_url'] as String?) ?? '';
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const EscrowMediaUploadException(
        'Storage did not return an upload URL.',
      );
    }
    return _UploadTicket(
      uploadUrl: uploadUrl,
      publicUrl: publicUrl,
      contentType:
          (decoded['content_type'] as String?) ?? 'application/octet-stream',
      mediaKind: (decoded['media_kind'] as String?) ?? '',
      maxBytes: (decoded['max_bytes'] as num?)?.toInt() ?? 0,
    );
  }

  static String _extractMessage(String body, {required String fallback}) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        final msg = decoded['message'] ?? decoded['error'];
        if (msg is String && msg.isNotEmpty) return msg;
      }
    } catch (_) {
      // Fall through to fallback.
    }
    return fallback;
  }

  /// Maps a filename to a storage-proxy-accepted image MIME type.
  static String imageContentTypeFor(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }

  /// Maps a filename to a storage-proxy-accepted video MIME type.
  static String videoContentTypeFor(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.mov')) return 'video/quicktime';
    if (lower.endsWith('.webm')) return 'video/webm';
    return 'video/mp4';
  }

  static String _basename(String path, String fallback) {
    final last = path.split('/').last;
    return last.isNotEmpty ? last : fallback;
  }
}

class _UploadTicket {
  final String uploadUrl;
  final String publicUrl;
  final String contentType;
  final String mediaKind;
  final int maxBytes;
  const _UploadTicket({
    required this.uploadUrl,
    required this.publicUrl,
    required this.contentType,
    required this.mediaKind,
    required this.maxBytes,
  });
}
