import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/utils/image_compressor.dart';

/// Result of a bank-scan upload — the public URL that chat-agent-gateway
/// will fetch server-side during OCR extraction.
class BankScanUploadResult {
  final String publicUrl;
  final String storageKey;
  const BankScanUploadResult({
    required this.publicUrl,
    required this.storageKey,
  });
}

/// Thin client around core-gateway's bank-scan upload-url proxy
/// (POST `/api/v1/bank-scan/upload-url`) + the storage-service
/// signed-URL PUT. Mirrors [`ProfilePictureUploadService`] (see
/// `lib/src/features/profile/data/services/profile_picture_upload_service.dart`)
/// but uses the bank-scan keyspace so a future audit query can scope to
/// "bank-scan images for user X" without touching their profile photos.
///
/// Pipeline:
///   1. POST `${httpCore}/v1/bank-scan/upload-url` with Bearer token →
///      `{ upload_url, public_url, key, content_type }`.
///   2. PUT raw image bytes to `upload_url` (signed URL in prod, local
///      dev route otherwise — same handling as insurance docs).
///   3. Return `public_url` so the caller can send it to
///      `/scan/bank-details` on chat-agent-gateway instead of base64.
class BankScanUploadService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _httpTimeout = Duration(seconds: 60);

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  BankScanUploadService({
    required EndpointRegistry endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints,
        _storage = storage ?? const FlutterSecureStorage(),
        _httpClient = httpClient ?? http.Client();

  /// Read a [File] from disk, upload it, return its public URL + key.
  Future<BankScanUploadResult> uploadFromFile(File file) async {
    final bytes = await file.readAsBytes();
    final filename = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'bank-scan.jpg';
    return uploadBytes(
      bytes: bytes,
      filename: filename,
      contentType: contentTypeFor(filename),
    );
  }

  /// Upload raw bytes. Used by image_picker (in-memory XFile) and the
  /// File overload above.
  Future<BankScanUploadResult> uploadBytes({
    required Uint8List bytes,
    required String filename,
    required String contentType,
  }) async {
    final compressed =
        await ImageCompressor.compressForUpload(bytes, contentType: contentType);
    bytes = compressed.bytes;
    contentType = compressed.contentType;
    filename = ImageCompressor.alignedFilename(filename, contentType);

    final accessToken = await _storage.read(key: _accessTokenKey);
    if (accessToken == null || accessToken.isEmpty) {
      throw const BankScanUploadException(
        'You must be signed in to scan account details.',
      );
    }

    // httpCore already ends in `/api/v1` (see EndpointRegistry.httpCore), so the
    // path here is just `/bank-scan/upload-url`. Appending `/v1/...` produced a
    // doubled `/api/v1/v1/bank-scan/upload-url` → HTTP 404 "Could not start scan
    // upload". The core-gateway route is POST /api/v1/bank-scan/upload-url.
    final uploadUrlEndpoint =
        '${_endpoints.httpCore}/bank-scan/upload-url';

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
      throw const BankScanUploadException(
        'Session expired. Please sign in again.',
      );
    }
    if (ticketResp.statusCode < 200 || ticketResp.statusCode >= 300) {
      throw BankScanUploadException(
        _extractMessage(
          ticketResp.body,
          fallback:
              'Could not start scan upload (HTTP ${ticketResp.statusCode}).',
        ),
      );
    }

    final ticket = _parseTicket(ticketResp.body);

    // Step 2: PUT the bytes to the returned upload URL. Same shape as
    // ProfilePictureUploadService — works for both the GCS V4-signed
    // URL (prod) and the local storage-service direct PUT route (dev).
    final putResp = await _httpClient
        .put(
          Uri.parse(ticket.uploadUrl),
          headers: {'Content-Type': ticket.contentType},
          body: bytes,
        )
        .timeout(_httpTimeout);
    if (putResp.statusCode < 200 || putResp.statusCode >= 300) {
      throw BankScanUploadException(
        'Scan image upload failed (HTTP ${putResp.statusCode}). Please try again.',
      );
    }

    return BankScanUploadResult(
      publicUrl: ticket.publicUrl,
      storageKey: ticket.storageKey,
    );
  }

  static _UploadTicket _parseTicket(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const BankScanUploadException(
        'Storage returned an unexpected response.',
      );
    }
    final uploadUrl = (decoded['upload_url'] as String?) ?? '';
    final publicUrl = (decoded['public_url'] as String?) ?? '';
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const BankScanUploadException(
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

  /// Public helper so callers that already have raw bytes + filename in
  /// hand don't have to repeat the same mapping. Mirrors the equivalent
  /// helper on [`ProfilePictureUploadService`] — the storage-proxy
  /// allow-list (jpg/png/webp/heic/gif) is identical for both flows.
  static String contentTypeFor(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.gif')) return 'image/gif';
    // Default to JPEG — image_picker returns .jpg on iOS/Android by
    // default and storage-proxy maps the unknown branch to a 400.
    return 'image/jpeg';
  }
}

class BankScanUploadException implements Exception {
  final String message;
  const BankScanUploadException(this.message);
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
