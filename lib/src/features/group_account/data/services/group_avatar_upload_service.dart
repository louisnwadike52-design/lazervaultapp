import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_defaults.dart';
import 'package:lazervault/core/utils/image_compressor.dart';

/// Result of a group / contribution avatar upload — the public URL that
/// gets stored on the row.
class GroupAvatarUploadResult {
  final String publicUrl;
  final String storageKey;
  const GroupAvatarUploadResult({
    required this.publicUrl,
    required this.storageKey,
  });
}

/// Uploads a group or contribution avatar.
///
/// Same two-step pipeline as every other image in the app — ask
/// core-gateway for a scoped upload URL, PUT the bytes to it — against the
/// `group-avatar` keyspace, which lands the object at
/// `users/<uid>/group-avatars/<uuid>.<ext>`.
///
/// The app never talks to storage-service directly (it requires a service
/// identity the app does not have), and the storage KEY is chosen
/// server-side from the JWT, so an upload cannot be aimed at someone else's
/// prefix. Which group or contribution the resulting URL ends up on is
/// decided by group-accounts when it is submitted — an upload on its own
/// grants nothing.
class GroupAvatarUploadService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _httpTimeout = Duration(seconds: 45);

  /// Admin-tunable, shared with the other media uploads. A ceiling in a
  /// constant means a release — and a store review — to change a number an
  /// operator should be able to turn.
  static int get _maxMb => FeatureFlags.mediaMaxImageMb;

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  GroupAvatarUploadService({
    EndpointRegistry? endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints ?? EndpointRegistry.instance,
        _storage = storage ?? kAppSecureStorage,
        _httpClient = httpClient ?? http.Client();

  Future<GroupAvatarUploadResult> uploadFromFile(File file) async {
    if (!file.existsSync()) {
      throw const GroupAvatarUploadException(
        'That image is no longer on your device. Pick it again.',
      );
    }
    final bytes = await file.readAsBytes();
    final name = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'avatar.jpg';
    return uploadBytes(bytes: bytes, filename: name);
  }

  Future<GroupAvatarUploadResult> uploadBytes({
    required Uint8List bytes,
    required String filename,
    String? contentType,
  }) async {
    if (bytes.isEmpty) {
      throw const GroupAvatarUploadException('That image is empty.');
    }

    var type = contentType ?? _guessContentType(filename);
    // Compressed BEFORE the size check, because the check should be about
    // what we are going to send rather than what came off the camera — a
    // 12MP photo is over any sane ceiling and perfectly fine once resized.
    final compressed =
        await ImageCompressor.compressForUpload(bytes, contentType: type);
    var payload = compressed.bytes;
    type = compressed.contentType;
    final name = ImageCompressor.alignedFilename(filename, type);

    final maxBytes = _maxMb * 1024 * 1024;
    if (payload.length > maxBytes) {
      final mb = (payload.length / (1024 * 1024)).toStringAsFixed(1);
      throw GroupAvatarUploadException(
        'That image is too large ($mb MB). The limit is $_maxMb MB.',
      );
    }

    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const GroupAvatarUploadException(
        'You need to be signed in to upload an image.',
      );
    }

    // httpCore already ends in /api/v1.
    final ticketUri =
        Uri.parse('${_endpoints.httpCore}/group-avatar/upload-url');
    final ticketResp = await _httpClient
        .post(
          ticketUri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({'filename': name, 'content_type': type}),
        )
        .timeout(_httpTimeout);

    if (ticketResp.statusCode == 401 || ticketResp.statusCode == 403) {
      throw const GroupAvatarUploadException(
        'Your session expired. Sign in again.',
      );
    }
    if (ticketResp.statusCode < 200 || ticketResp.statusCode >= 300) {
      throw GroupAvatarUploadException(
        _extractMessage(
          ticketResp.body,
          fallback: "Couldn't start the upload. Please try again.",
        ),
      );
    }

    final decoded = jsonDecode(ticketResp.body);
    if (decoded is! Map<String, dynamic>) {
      throw const GroupAvatarUploadException(
        'Storage returned an unexpected response.',
      );
    }
    final uploadUrl = (decoded['upload_url'] as String?) ?? '';
    final publicUrl = (decoded['public_url'] as String?) ?? '';
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const GroupAvatarUploadException(
        'Storage did not return an upload URL.',
      );
    }

    final putResp = await _httpClient
        .put(
          Uri.parse(uploadUrl),
          headers: {
            'Content-Type': (decoded['content_type'] as String?) ?? type,
          },
          body: payload,
        )
        .timeout(_httpTimeout);
    if (putResp.statusCode < 200 || putResp.statusCode >= 300) {
      throw GroupAvatarUploadException(
        'The upload failed (HTTP ${putResp.statusCode}). Please try again.',
      );
    }

    return GroupAvatarUploadResult(
      publicUrl: publicUrl,
      storageKey: (decoded['key'] as String?) ?? '',
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
      // Fall through.
    }
    return fallback;
  }

  static String _guessContentType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.gif')) return 'image/gif';
    // image_picker returns .jpg by default.
    return 'image/jpeg';
  }
}

class GroupAvatarUploadException implements Exception {
  final String message;
  const GroupAvatarUploadException(this.message);
  @override
  String toString() => message;
}
