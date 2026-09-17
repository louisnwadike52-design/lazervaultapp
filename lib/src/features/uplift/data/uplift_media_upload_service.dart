import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/secure_storage_defaults.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Uploads Uplift media (fund cover/gallery, application pitch images,
/// milestone evidence) to the products-gateway, which streams them to
/// storage-service and returns a public URL. Mirrors
/// CrowdfundImageUploadService but targets the /uplifts upload route.
class UpliftMediaUploadService {
  static const _accessTokenKey = 'access_token';
  static const _maxFileSize = 10 * 1024 * 1024; // 10MB
  static const _uploadTimeout = Duration(seconds: 45);
  static const _allowedExtensions = {'.jpg', '.jpeg', '.png', '.webp', '.gif'};

  /// Applications may attach DOCUMENTS as well as images. The apply screen has
  /// always offered "images/documents", but this service accepted images only,
  /// so a business could not attach the business plan, financials or CAC
  /// certificate an investor actually decides on. The gateway accepts PDF on
  /// the /uplifts route specifically (it still rejects them for crowdfund
  /// covers, which render what they store).
  static const _allowedDocumentExtensions = {'.pdf'};

  /// Founder pitch video. Matches what the gateway sniffs for on the
  /// /uplifts route — MP4/MOV via the ftyp box, WebM via EBML.
  static const _allowedVideoExtensions = {'.mp4', '.mov', '.m4v', '.webm'};

  /// Video gets its own ceiling. 10MB suits an image or a PDF deck; even a
  /// minute of phone footage clears it.
  ///
  /// 64MB, matching the gateway. NOT 100MB: prod uploads traverse the
  /// Cloudflare tunnel, which caps request bodies at 100MB on our plan, so a
  /// limit set at the edge value fails with Cloudflare's error page rather than
  /// ours. Checked client-side too so the user is told BEFORE spending the
  /// upload on mobile data.
  static const _maxVideoSize = 64 * 1024 * 1024; // 64MB

  /// Longer than the image timeout for the obvious reason: a 100MB upload on a
  /// Nigerian mobile connection does not finish in 45 seconds, and timing out
  /// mid-pitch would look like a failure the user caused.
  static const _videoUploadTimeout = Duration(minutes: 10);

  final _storage = kAppSecureStorage;

  String get _baseUrl {
    final override = dotenv.env['PRODUCTS_BASE_URL']?.trim();
    if (override != null && override.isNotEmpty) {
      final uri = Uri.tryParse(override);
      if (uri != null &&
          (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.host.isNotEmpty) {
        final port = uri.hasPort ? ':${uri.port}' : '';
        return '${uri.scheme}://${uri.host}$port';
      }
    }
    // With NO dev override (prod) follow the tunnel host+port together (443 →
    // https, no explicit port). The old code kept the tunnel host but forced port
    // 8083, so prod hit https://api.lazervault.app:8083 which the edge never
    // serves → uploads failed.
    final ep = endpointRegistry.resolveServiceHostPort(
      overrideHost:
          dotenv.env['PRODUCTS_HTTP_HOST'] ?? dotenv.env['PRODUCTS_GRPC_HOST'],
      overridePort: int.tryParse(dotenv.env['PRODUCTS_HTTP_PORT'] ??
          dotenv.env['PRODUCTS_WS_PORT'] ??
          ''),
      devPort: 8083,
    );
    if (ep.port == 443) return 'https://${ep.host}';
    final scheme = _isLoopback(ep.host) ? 'http' : 'https';
    return '$scheme://${ep.host}:${ep.port}';
  }

  static bool _isLoopback(String host) =>
      host == 'localhost' ||
      host == '127.0.0.1' ||
      host == '10.0.2.2' ||
      host.startsWith('192.168.') ||
      host.startsWith('10.') ||
      host == '::1';

  /// Validates + uploads a file, returning the hosted public URL.
  /// Throws [UpliftUploadException] with a user-friendly message on failure.
  ///
  /// [allowDocuments] widens the accepted set to include PDFs — used by the
  /// application flow, where a business plan or financials matter more than a
  /// photo. Cover/gallery images leave it false so a PDF can never end up where
  /// the UI expects something renderable.
  Future<String> uploadImage(File imageFile,
      {bool allowDocuments = false}) async {
    if (!imageFile.existsSync()) {
      throw const UpliftUploadException(
          'Selected image no longer exists. Please pick again.');
    }
    final fileSize = await imageFile.length();
    if (fileSize == 0) {
      throw const UpliftUploadException(
          'Selected image is empty. Please pick a different image.');
    }
    if (fileSize > _maxFileSize) {
      final sizeMB = (fileSize / (1024 * 1024)).toStringAsFixed(1);
      throw UpliftUploadException(
          'Image is too large ($sizeMB MB). Maximum is 10 MB.');
    }
    final fileName = imageFile.path.split('/').last.toLowerCase();
    final ext = fileName.contains('.') ? '.${fileName.split('.').last}' : '';
    final accepted = allowDocuments
        ? {..._allowedExtensions, ..._allowedDocumentExtensions}
        : _allowedExtensions;
    if (ext.isNotEmpty && !accepted.contains(ext)) {
      throw UpliftUploadException(allowDocuments
          ? 'Unsupported file. Use JPEG, PNG, WebP, GIF, or PDF.'
          : 'Unsupported image format. Use JPEG, PNG, WebP, or GIF.');
    }
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const UpliftUploadException(
          'You need to be logged in to upload images.');
    }

    final uri = Uri.parse('$_baseUrl/api/v1/uplifts/upload-image');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    http.StreamedResponse res;
    try {
      res = await request.send().timeout(_uploadTimeout);
    } on SocketException {
      throw const UpliftUploadException(
          'No internet connection. Please check your network and try again.');
    } on TimeoutException {
      throw const UpliftUploadException(
          'Upload timed out. Please check your connection and try again.');
    } on http.ClientException {
      throw const UpliftUploadException(
          'Could not reach the server. Please try again later.');
    }

    final body = await res.stream.bytesToString();
    switch (res.statusCode) {
      case 200:
      case 202:
        final data = jsonDecode(body) as Map<String, dynamic>;
        final url = data['image_url'] as String?;
        if (url == null || url.isEmpty) {
          throw const UpliftUploadException(
              'Server returned an empty image URL. Please try again.');
        }
        return url;
      case 401:
        throw const UpliftUploadException(
            'Session expired. Please log in again.');
      case 413:
        throw const UpliftUploadException(
            'Image is too large. Maximum size is 10 MB.');
      case 503:
        throw const UpliftUploadException(
            'Image upload is temporarily unavailable. Please try again later.');
      default:
        throw UpliftUploadException(_parseError(body));
    }
  }

  /// Upload a founder pitch video.
  ///
  /// Shares the gateway route with images — the server sniffs the type from
  /// magic bytes, so one endpoint handles all three kinds. What differs is the
  /// ceiling and the timeout, which is why this is not just uploadImage with a
  /// flag: a 45-second timeout on a 100MB upload would report a failure the
  /// user did not cause.
  Future<String> uploadVideo(File videoFile) async {
    if (!videoFile.existsSync()) {
      throw const UpliftUploadException(
          'Selected video no longer exists. Please pick again.');
    }
    final fileSize = await videoFile.length();
    if (fileSize > _maxVideoSize) {
      final sizeMB = (fileSize / (1024 * 1024)).toStringAsFixed(0);
      throw UpliftUploadException(
          'Video is too large ($sizeMB MB). Maximum is 64 MB — try a shorter clip.');
    }
    if (fileSize < 8) {
      throw const UpliftUploadException('That video file is empty.');
    }

    final fileName = videoFile.path.split('/').last.toLowerCase();
    final ext = fileName.contains('.') ? '.${fileName.split('.').last}' : '';
    if (ext.isNotEmpty && !_allowedVideoExtensions.contains(ext)) {
      throw const UpliftUploadException(
          'Unsupported video format. Use MP4, MOV or WebM.');
    }

    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const UpliftUploadException(
          'You need to be logged in to upload a video.');
    }

    final uri = Uri.parse('$_baseUrl/api/v1/uplifts/upload-image');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      // Field name stays `image`: it is what the gateway reads, and renaming it
      // here would 400 on a route that is otherwise working.
      ..files.add(await http.MultipartFile.fromPath('image', videoFile.path));

    http.StreamedResponse res;
    try {
      res = await request.send().timeout(_videoUploadTimeout);
    } on SocketException {
      throw const UpliftUploadException(
          'No internet connection. Please check your network and try again.');
    } on TimeoutException {
      throw const UpliftUploadException(
          'The video upload timed out. Try a shorter clip or a stronger connection.');
    } on http.ClientException {
      throw const UpliftUploadException(
          'Could not reach the server. Please try again later.');
    }

    final body = await res.stream.bytesToString();
    switch (res.statusCode) {
      case 200:
      case 202:
        final data = jsonDecode(body) as Map<String, dynamic>;
        final url = data['image_url'] as String?;
        if (url == null || url.isEmpty) {
          throw const UpliftUploadException(
              'Server returned an empty video URL. Please try again.');
        }
        return url;
      case 401:
        throw const UpliftUploadException(
            'Session expired. Please log in again.');
      case 413:
        throw const UpliftUploadException(
            'Video is too large. Maximum is 64 MB — try a shorter clip.');
      case 503:
        throw const UpliftUploadException(
            'Video upload is temporarily unavailable. Please try again later.');
      default:
        throw UpliftUploadException(_parseError(body));
    }
  }

  String _parseError(String body) {
    try {
      final data = jsonDecode(body) as Map<String, dynamic>;
      return data['error'] as String? ?? 'Upload failed. Please try again.';
    } catch (_) {
      return 'Upload failed. Please try again.';
    }
  }
}

class UpliftUploadException implements Exception {
  final String message;
  const UpliftUploadException(this.message);
  @override
  String toString() => message;
}
