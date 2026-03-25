import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// Uploads crowdfund campaign images to the products-gateway.
/// Returns the public URL of the uploaded image.
class CrowdfundImageUploadService {
  static const _accessTokenKey = 'access_token';
  static const _maxFileSize = 10 * 1024 * 1024; // 10MB
  static const _uploadTimeout = Duration(seconds: 45);

  static const _allowedExtensions = {'.jpg', '.jpeg', '.png', '.webp', '.gif'};

  final _storage = const FlutterSecureStorage();

  String get _baseUrl {
    final host = dotenv.env['PRODUCTS_GRPC_HOST'] ?? '10.0.2.2';
    final port = dotenv.env['PRODUCTS_HTTP_PORT'] ?? '8083';
    return 'http://$host:$port';
  }

  /// Validates and uploads an image file, returning the hosted URL.
  ///
  /// Throws [ImageUploadException] with user-friendly messages on failure.
  Future<String> uploadImage(File imageFile) async {
    // 1. Validate file exists
    if (!imageFile.existsSync()) {
      throw const ImageUploadException('Selected image no longer exists. Please pick again.');
    }

    // 2. Validate file size
    final fileSize = await imageFile.length();
    if (fileSize == 0) {
      throw const ImageUploadException('Selected image is empty. Please pick a different image.');
    }
    if (fileSize > _maxFileSize) {
      final sizeMB = (fileSize / (1024 * 1024)).toStringAsFixed(1);
      throw ImageUploadException('Image is too large ($sizeMB MB). Maximum is 10 MB.');
    }

    // 3. Validate file extension
    final fileName = imageFile.path.split('/').last.toLowerCase();
    final ext = fileName.contains('.') ? '.${fileName.split('.').last}' : '';
    if (ext.isNotEmpty && !_allowedExtensions.contains(ext)) {
      throw const ImageUploadException('Unsupported image format. Use JPEG, PNG, WebP, or GIF.');
    }

    // 4. Validate auth token
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const ImageUploadException('You need to be logged in to upload images.');
    }

    // 5. Build and send multipart request
    final uri = Uri.parse('$_baseUrl/api/v1/crowdfunds/upload-image');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    http.StreamedResponse streamedResponse;
    try {
      streamedResponse = await request.send().timeout(_uploadTimeout);
    } on SocketException {
      throw const ImageUploadException('No internet connection. Please check your network and try again.');
    } on TimeoutException {
      throw const ImageUploadException('Upload timed out. Please check your connection and try again.');
    } on http.ClientException {
      throw const ImageUploadException('Could not reach the server. Please try again later.');
    }

    // 6. Parse response
    final responseBody = await streamedResponse.stream.bytesToString();

    switch (streamedResponse.statusCode) {
      case 200:
        final data = jsonDecode(responseBody) as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String?;
        if (imageUrl == null || imageUrl.isEmpty) {
          throw const ImageUploadException('Server returned an empty image URL. Please try again.');
        }
        return imageUrl;

      case 401:
        throw const ImageUploadException('Session expired. Please log in again.');

      case 413:
        throw const ImageUploadException('Image is too large. Maximum size is 10 MB.');

      case 400:
        final msg = _parseError(responseBody);
        throw ImageUploadException(msg);

      case 503:
        throw const ImageUploadException('Image upload is temporarily unavailable. Please try again later.');

      default:
        final msg = _parseError(responseBody);
        throw ImageUploadException(msg);
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

/// Typed exception for image upload failures with user-friendly messages.
class ImageUploadException implements Exception {
  final String message;
  const ImageUploadException(this.message);

  @override
  String toString() => message;
}
