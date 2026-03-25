import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// Uploads SprayMe session cover images to the lifestyle-gateway.
/// Returns the public URL of the uploaded image.
class SpraymeImageUploadService {
  static const _accessTokenKey = 'access_token';
  static const _maxFileSize = 10 * 1024 * 1024; // 10MB
  static const _uploadTimeout = Duration(seconds: 45);

  static const _allowedExtensions = {'.jpg', '.jpeg', '.png', '.webp', '.gif'};

  final _storage = const FlutterSecureStorage();

  String get _baseUrl {
    final url = dotenv.env['LIFESTYLE_GATEWAY_URL'];
    if (url != null && url.isNotEmpty) return url;
    // LIFESTYLE_GATEWAY_HOST defaults differ per platform:
    // Android emulator: 10.0.2.2, iOS simulator: localhost, real device: actual IP
    final host = dotenv.env['LIFESTYLE_GATEWAY_HOST'] ??
        dotenv.env['PAYMENT_GRPC_HOST'] ??
        (Platform.isAndroid ? '10.0.2.2' : 'localhost');
    final port = dotenv.env['LIFESTYLE_GATEWAY_PORT'] ?? '8088';
    return 'http://$host:$port';
  }

  /// Validates and uploads an image file, returning the hosted URL.
  Future<String> uploadImage(File imageFile) async {
    if (!imageFile.existsSync()) {
      throw const SpraymeImageUploadException(
          'Selected image no longer exists. Please pick again.');
    }

    final fileSize = await imageFile.length();
    if (fileSize == 0) {
      throw const SpraymeImageUploadException(
          'Selected image is empty. Please pick a different image.');
    }
    if (fileSize > _maxFileSize) {
      final sizeMB = (fileSize / (1024 * 1024)).toStringAsFixed(1);
      throw SpraymeImageUploadException(
          'Image is too large ($sizeMB MB). Maximum is 10 MB.');
    }

    final fileName = imageFile.path.split('/').last.toLowerCase();
    final ext = fileName.contains('.') ? '.${fileName.split('.').last}' : '';
    if (ext.isNotEmpty && !_allowedExtensions.contains(ext)) {
      throw const SpraymeImageUploadException(
          'Unsupported image format. Use JPEG, PNG, WebP, or GIF.');
    }

    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const SpraymeImageUploadException(
          'You need to be logged in to upload images.');
    }

    final uri = Uri.parse('$_baseUrl/api/v1/sprayme/upload-cover-image');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    http.StreamedResponse streamedResponse;
    try {
      streamedResponse = await request.send().timeout(_uploadTimeout);
    } on SocketException {
      throw const SpraymeImageUploadException(
          'No internet connection. Please check your network and try again.');
    } on TimeoutException {
      throw const SpraymeImageUploadException(
          'Upload timed out. Please check your connection and try again.');
    } on http.ClientException {
      throw const SpraymeImageUploadException(
          'Could not reach the server. Please try again later.');
    }

    final responseBody = await streamedResponse.stream.bytesToString();

    switch (streamedResponse.statusCode) {
      case 200:
        final data = jsonDecode(responseBody) as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String?;
        if (imageUrl == null || imageUrl.isEmpty) {
          throw const SpraymeImageUploadException(
              'Server returned an empty image URL. Please try again.');
        }
        return imageUrl;

      case 401:
        throw const SpraymeImageUploadException(
            'Session expired. Please log in again.');

      case 413:
        throw const SpraymeImageUploadException(
            'Image is too large. Maximum size is 10 MB.');

      case 400:
        final msg = _parseError(responseBody);
        throw SpraymeImageUploadException(msg);

      case 503:
        throw const SpraymeImageUploadException(
            'Image upload is temporarily unavailable. Please try again later.');

      default:
        final msg = _parseError(responseBody);
        throw SpraymeImageUploadException(msg);
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

class SpraymeImageUploadException implements Exception {
  final String message;
  const SpraymeImageUploadException(this.message);

  @override
  String toString() => message;
}
