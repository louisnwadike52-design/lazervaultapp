import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/utils/image_compressor.dart';

/// Result of an invoice image (logo) upload — the public URL persisted on the
/// invoice's sender/receiver block and rendered later with `Image.network`.
class InvoiceImageUploadResult {
  final String publicUrl;
  final String storageKey;
  const InvoiceImageUploadResult({
    required this.publicUrl,
    required this.storageKey,
  });
}

/// Canonical invoice-logo upload via core-gateway's storage proxy
/// (POST `/api/v1/invoice/upload-url`) + the storage-service signed-URL PUT.
/// This is a near-copy of [ProfilePictureUploadService] pointed at the
/// `invoice` keyspace, so invoice logos use the SAME proven presigned pipeline
/// as profile pictures, chat media and insurance documents (no bespoke path).
///
/// Pipeline:
///   1. POST `${httpCore}/invoice/upload-url` with Bearer token →
///      `{ upload_url, public_url, key, content_type }`.
///   2. PUT raw image bytes to `upload_url` (GCS V4-signed in prod, local
///      dev route otherwise).
///   3. Return `public_url` for the caller to store on the invoice.
class InvoiceImageUploadService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _httpTimeout = Duration(seconds: 60);

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  InvoiceImageUploadService({
    required EndpointRegistry endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints,
        _storage = storage ?? const FlutterSecureStorage(),
        _httpClient = httpClient ?? http.Client();

  /// Read a [File] from disk, upload it, return its public URL.
  Future<InvoiceImageUploadResult> uploadFromFile(File file) async {
    final bytes = await file.readAsBytes();
    final filename = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'invoice-logo.jpg';
    return uploadBytes(
      bytes: bytes,
      filename: filename,
      contentType: contentTypeFor(filename),
    );
  }

  /// Upload raw bytes (used by image_picker's in-memory XFile too).
  Future<InvoiceImageUploadResult> uploadBytes({
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
      throw const InvoiceImageUploadException(
        'You must be signed in to upload an invoice logo.',
      );
    }

    // httpCore already ends in `/api/v1`; the route is
    // POST /api/v1/invoice/upload-url (do NOT prepend another /v1).
    final uploadUrlEndpoint = '${_endpoints.httpCore}/invoice/upload-url';

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
      throw const InvoiceImageUploadException(
        'Session expired. Please sign in again.',
      );
    }
    if (ticketResp.statusCode < 200 || ticketResp.statusCode >= 300) {
      throw InvoiceImageUploadException(
        _extractMessage(ticketResp.body,
            fallback:
                'Could not start upload (HTTP ${ticketResp.statusCode}).'),
      );
    }

    final ticket = _parseTicket(ticketResp.body);

    // Step 2: PUT the bytes to the returned upload URL (signed or local).
    final putResp = await _httpClient
        .put(
          Uri.parse(ticket.uploadUrl),
          headers: {'Content-Type': ticket.contentType},
          body: bytes,
        )
        .timeout(_httpTimeout);
    if (putResp.statusCode < 200 || putResp.statusCode >= 300) {
      throw InvoiceImageUploadException(
        'Upload failed (HTTP ${putResp.statusCode}). Please try again.',
      );
    }

    return InvoiceImageUploadResult(
      publicUrl: ticket.publicUrl,
      storageKey: ticket.storageKey,
    );
  }

  static _UploadTicket _parseTicket(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const InvoiceImageUploadException(
        'Storage returned an unexpected response.',
      );
    }
    final uploadUrl = (decoded['upload_url'] as String?) ?? '';
    final publicUrl = (decoded['public_url'] as String?) ?? '';
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const InvoiceImageUploadException(
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

  /// Maps a filename to a storage-proxy-accepted image MIME type.
  static String contentTypeFor(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }
}

class InvoiceImageUploadException implements Exception {
  final String message;
  const InvoiceImageUploadException(this.message);
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
