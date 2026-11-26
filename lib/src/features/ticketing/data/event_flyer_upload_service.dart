import 'dart:convert';
import 'package:lazervault/core/services/access_token_shape.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_defaults.dart';
import 'package:lazervault/core/utils/image_compressor.dart';

/// Result of an event-flyer upload — the public URL stored on the event.
class EventFlyerUploadResult {
  final String publicUrl;
  final String storageKey;
  const EventFlyerUploadResult({
    required this.publicUrl,
    required this.storageKey,
  });
}

/// Uploads the ONE hero image a ticketed event is advertised with.
///
/// Same two-step pipeline as every other image in the app — ask core-gateway
/// for a scoped upload URL, PUT the bytes to it — against the `event-flyer`
/// keyspace, which lands the object at
/// `users/<uid>/event-flyers/<uuid>.<ext>`.
///
/// The app never talks to storage-service directly (that needs a service
/// identity the app does not have), and the storage KEY is chosen server-side
/// from the JWT, so an upload cannot be aimed at another user's prefix. Which
/// EVENT the resulting URL ends up on is decided by financial-products when it
/// is submitted, so an upload on its own grants nothing and cannot re-flyer
/// somebody else's event.
///
/// ONE HERO IMAGE, not escrow's six-photo evidence rail: a flyer is how an
/// event is recognised in a list, and a gallery would turn a card into a
/// carousel.
///
/// EVERY UPLOAD GETS A FRESH KEY server-side. Object GETs are unauthenticated
/// and edge-cached for hours, so replacing a flyer by overwriting its key
/// would keep serving the old one long after the organiser changed it.
class EventFlyerUploadService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _httpTimeout = Duration(seconds: 45);

  /// Admin-tunable, shared with the other media uploads. A ceiling in a
  /// constant means a release — and a store review — to change a number an
  /// operator should be able to turn.
  static int get _maxMb => FeatureFlags.mediaMaxImageMb;

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  EventFlyerUploadService({
    EndpointRegistry? endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints ?? EndpointRegistry.instance,
        _storage = storage ?? kAppSecureStorage,
        _httpClient = httpClient ?? http.Client();

  Future<EventFlyerUploadResult> uploadFromFile(File file) async {
    if (!file.existsSync()) {
      throw const EventFlyerUploadException(
        'That image is no longer on your device. Pick it again.',
      );
    }
    final bytes = await file.readAsBytes();
    final name = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'flyer.jpg';
    return uploadBytes(bytes: bytes, filename: name);
  }

  Future<EventFlyerUploadResult> uploadBytes({
    required Uint8List bytes,
    required String filename,
    String? contentType,
  }) async {
    if (bytes.isEmpty) {
      throw const EventFlyerUploadException('That image is empty.');
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
      throw EventFlyerUploadException(
        'That image is too large ($mb MB). The limit is $_maxMb MB.',
      );
    }

    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const EventFlyerUploadException(
        'You need to be signed in to upload an image.',
      );
    }

    // httpCore already ends in /api/v1.
    final ticketUri =
        Uri.parse('${_endpoints.httpCore}/event-flyer/upload-url');
    final ticketResp = await _httpClient
        .post(
          ticketUri,
          headers: {
            'Content-Type': 'application/json',
            ...authHeader(token),
          },
          body: jsonEncode({'filename': name, 'content_type': type}),
        )
        .timeout(_httpTimeout);

    if (ticketResp.statusCode == 401 || ticketResp.statusCode == 403) {
      throw const EventFlyerUploadException(
        'Your session expired. Sign in again.',
      );
    }
    if (ticketResp.statusCode < 200 || ticketResp.statusCode >= 300) {
      throw EventFlyerUploadException(
        _extractMessage(
          ticketResp.body,
          fallback: "Couldn't start the upload. Please try again.",
        ),
      );
    }

    final decoded = jsonDecode(ticketResp.body);
    if (decoded is! Map<String, dynamic>) {
      throw const EventFlyerUploadException(
        'Storage returned an unexpected response.',
      );
    }
    final uploadUrl = (decoded['upload_url'] as String?) ?? '';
    final publicUrl = (decoded['public_url'] as String?) ?? '';
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const EventFlyerUploadException(
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
      throw EventFlyerUploadException(
        'The upload failed (HTTP ${putResp.statusCode}). Please try again.',
      );
    }

    return EventFlyerUploadResult(
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

class EventFlyerUploadException implements Exception {
  final String message;
  const EventFlyerUploadException(this.message);
  @override
  String toString() => message;
}
