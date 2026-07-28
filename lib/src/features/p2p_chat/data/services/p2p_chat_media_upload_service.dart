import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/utils/image_compressor.dart';

/// Result of a P2P chat-media upload — the public URL persisted on the
/// message (`media_url`).
class P2PChatMediaUploadResult {
  final String publicUrl;
  final String storageKey;
  const P2PChatMediaUploadResult({
    required this.publicUrl,
    required this.storageKey,
  });
}

/// Thin client around core-gateway's chat-media upload-url proxy
/// (POST `/api/v1/chat-media/upload-url`) + the storage-service signed-URL
/// PUT. Mirrors [`ProfilePictureUploadService`] / `BankScanUploadService`
/// exactly — same two-step pipeline — but scoped to the `chat-media`
/// keyspace, which (unlike the image-only keyspaces) also accepts the
/// audio MIME types used by voice notes.
///
/// Pipeline:
///   1. POST `${httpCore}/chat-media/upload-url` with Bearer token →
///      `{ upload_url, public_url, key, content_type }`.
///   2. PUT raw bytes to `upload_url` (GCS V4-signed URL in prod, local
///      storage-service route in dev — same handling everywhere).
///   3. Return `public_url` so the caller can attach it as `media_url`.
class P2PChatMediaUploadService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _httpTimeout = Duration(seconds: 60);

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  P2PChatMediaUploadService({
    EndpointRegistry? endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints ?? EndpointRegistry.instance,
        _storage = storage ?? const FlutterSecureStorage(),
        _httpClient = httpClient ?? http.Client();

  /// Read a [File] from disk, upload it, return its public URL.
  Future<P2PChatMediaUploadResult> uploadFromFile(
    File file, {
    String? contentType,
  }) async {
    final bytes = await file.readAsBytes();
    final filename = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'chat-media';
    return uploadBytes(
      bytes: bytes,
      filename: filename,
      contentType: contentType ?? _guessContentType(filename),
    );
  }

  /// Upload raw bytes for a chat image or voice note.
  Future<P2PChatMediaUploadResult> uploadBytes({
    required Uint8List bytes,
    required String filename,
    required String contentType,
  }) async {
    // Never upload an empty payload — a silently-failed voice capture would
    // otherwise produce a broken 0-byte "voice note".
    if (bytes.isEmpty) {
      throw const P2PChatMediaUploadException(
        'Nothing to upload — the file is empty.',
      );
    }

    // Compress images before upload (voice notes / non-images pass through
    // untouched — the compressor is a no-op for audio content types).
    final compressed =
        await ImageCompressor.compressForUpload(bytes, contentType: contentType);
    bytes = compressed.bytes;
    contentType = compressed.contentType;
    filename = ImageCompressor.alignedFilename(filename, contentType);

    final accessToken = await _storage.read(key: _accessTokenKey);
    if (accessToken == null || accessToken.isEmpty) {
      throw const P2PChatMediaUploadException(
        'You must be signed in to share media.',
      );
    }

    // httpCore already ends in `/api/v1`; the gateway route is
    // POST /api/v1/chat-media/upload-url.
    final uploadUrlEndpoint = '${_endpoints.httpCore}/chat-media/upload-url';

    // Step 1: ask core-gateway for a scoped upload URL.
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
      throw const P2PChatMediaUploadException(
        'Session expired. Please sign in again.',
      );
    }
    if (ticketResp.statusCode < 200 || ticketResp.statusCode >= 300) {
      throw P2PChatMediaUploadException(
        _extractMessage(ticketResp.body,
            fallback:
                'Could not start upload (HTTP ${ticketResp.statusCode}).'),
      );
    }

    final ticket = _parseTicket(ticketResp.body);

    // Step 2: PUT the bytes to the returned upload URL.
    final putResp = await _httpClient
        .put(
          Uri.parse(ticket.uploadUrl),
          headers: {'Content-Type': ticket.contentType},
          body: bytes,
        )
        .timeout(_httpTimeout);
    if (putResp.statusCode < 200 || putResp.statusCode >= 300) {
      throw P2PChatMediaUploadException(
        'Upload failed (HTTP ${putResp.statusCode}). Please try again.',
      );
    }

    return P2PChatMediaUploadResult(
      publicUrl: ticket.publicUrl,
      storageKey: ticket.storageKey,
    );
  }

  static _UploadTicket _parseTicket(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const P2PChatMediaUploadException(
        'Storage returned an unexpected response.',
      );
    }
    final uploadUrl = (decoded['upload_url'] as String?) ?? '';
    final publicUrl = (decoded['public_url'] as String?) ?? '';
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const P2PChatMediaUploadException(
        'Storage did not return an upload URL.',
      );
    }
    return _UploadTicket(
      uploadUrl: uploadUrl,
      publicUrl: publicUrl,
      storageKey: (decoded['key'] as String?) ?? '',
      contentType:
          (decoded['content_type'] as String?) ?? 'application/octet-stream',
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

  static String _guessContentType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.m4a')) return 'audio/mp4';
    if (lower.endsWith('.aac')) return 'audio/aac';
    if (lower.endsWith('.mp3')) return 'audio/mpeg';
    // Default to JPEG — image_picker returns .jpg by default.
    return 'image/jpeg';
  }
}

class P2PChatMediaUploadException implements Exception {
  final String message;
  const P2PChatMediaUploadException(this.message);
  @override
  String toString() => message;
}

class _UploadTicket {
  final String uploadUrl;
  final String publicUrl;
  final String storageKey;
  final String contentType;
  const _UploadTicket({
    required this.uploadUrl,
    required this.publicUrl,
    required this.storageKey,
    required this.contentType,
  });
}
