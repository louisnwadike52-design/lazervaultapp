import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Client for the foreign-currency (USD/GBP/EUR) virtual-account flow:
///
///   GET  /api/v1/accounts/fcy/status?currency=USD
///   POST /api/v1/accounts/fcy/request        (the full KYC package)
///   POST /api/v1/fcy-document/upload-url     (storage proxy: image or PDF)
///
/// The backend validates the package for COMPLETENESS against Fincra's
/// documented contract and returns the missing field names — nothing is
/// guessed or defaulted server-side, so the form must collect everything.
class FCYAccountService {
  FCYAccountService({FlutterSecureStorage? storage, http.Client? client})
      : _storage = storage ?? const FlutterSecureStorage(),
        _client = client ?? http.Client();

  final FlutterSecureStorage _storage;
  final http.Client _client;
  static const _timeout = Duration(seconds: 45);

  Future<String> _token() async {
    final t = await _storage.read(key: 'access_token');
    if (t == null || t.isEmpty) {
      throw const FCYAccountException('You need to be signed in.');
    }
    return t;
  }

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  /// Provisioning state: none | creating | active | failed (+ details).
  Future<FCYStatus> status(String currency) async {
    final token = await _token();
    final res = await _client
        .get(
          Uri.parse(
              '${endpointRegistry.httpCore}/accounts/fcy/status?currency=$currency'),
          headers: _headers(token),
        )
        .timeout(_timeout);
    if (res.statusCode == 503) {
      throw const FCYAccountException(
          'International accounts are not available yet. Please check back soon.');
    }
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw FCYAccountException(_message(res.body,
          fallback: 'We could not check your account status.'));
    }
    final d = jsonDecode(res.body) as Map<String, dynamic>;
    return FCYStatus(
      status: (d['status'] ?? 'none').toString(),
      message: (d['message'] ?? '').toString(),
      accountNumber: (d['accountNumber'] ?? '').toString(),
      bankName: (d['bankName'] ?? '').toString(),
      accountName: (d['accountName'] ?? '').toString(),
      routingDetailsJson: (d['routingDetailsJson'] ?? '').toString(),
    );
  }

  /// Submit the full FCY KYC package. Throws with the backend's precise
  /// missing-field message on incompleteness.
  Future<String> submit(Map<String, dynamic> body) async {
    final token = await _token();
    final res = await _client
        .post(
          Uri.parse('${endpointRegistry.httpCore}/accounts/fcy/request'),
          headers: _headers(token),
          body: jsonEncode(body),
        )
        .timeout(_timeout);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw FCYAccountException(_message(res.body,
          fallback: 'We could not submit your request. Please try again.'));
    }
    final d = jsonDecode(res.body) as Map<String, dynamic>;
    return (d['message'] ?? 'Your account request is being processed.')
        .toString();
  }

  /// Pick a document (image or PDF) and upload it via the fcy-document
  /// storage proxy. Returns the public URL Fincra will fetch, or null when
  /// the user backs out of the picker.
  Future<String?> pickAndUploadDocument() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png', 'webp', 'heic'],
      withData: false,
    );
    if (picked == null || picked.files.isEmpty) return null;
    final f = picked.files.first;
    final path = f.path;
    if (path == null) {
      throw const FCYAccountException('We could not read that file.');
    }
    final bytes = await File(path).readAsBytes();
    if (bytes.length > 8 * 1024 * 1024) {
      throw const FCYAccountException(
          'This document is a bit too big. Please keep it under 8 MB.');
    }
    final name = f.name;
    final contentType = name.toLowerCase().endsWith('.pdf')
        ? 'application/pdf'
        : _imageContentType(name);

    final token = await _token();
    final ticketRes = await _client
        .post(
          Uri.parse('${endpointRegistry.httpCore}/fcy-document/upload-url'),
          headers: _headers(token),
          body: jsonEncode({'filename': name, 'content_type': contentType}),
        )
        .timeout(_timeout);
    if (ticketRes.statusCode < 200 || ticketRes.statusCode >= 300) {
      throw FCYAccountException(_message(ticketRes.body,
          fallback: 'We could not start the upload. Please try again.'));
    }
    final ticket = jsonDecode(ticketRes.body) as Map<String, dynamic>;
    final uploadUrl = (ticket['upload_url'] ?? '').toString();
    final publicUrl = (ticket['public_url'] ?? '').toString();
    if (uploadUrl.isEmpty || publicUrl.isEmpty) {
      throw const FCYAccountException('Storage did not return an upload URL.');
    }
    final putRes = await _client
        .put(Uri.parse(uploadUrl),
            headers: {'Content-Type': contentType}, body: bytes)
        .timeout(const Duration(seconds: 120));
    if (putRes.statusCode < 200 || putRes.statusCode >= 300) {
      throw FCYAccountException(
          'The upload did not go through (HTTP ${putRes.statusCode}).');
    }
    return publicUrl;
  }

  static String _imageContentType(String name) {
    final n = name.toLowerCase();
    if (n.endsWith('.png')) return 'image/png';
    if (n.endsWith('.webp')) return 'image/webp';
    if (n.endsWith('.heic')) return 'image/heic';
    return 'image/jpeg';
  }

  static String _message(String body, {required String fallback}) {
    try {
      final d = jsonDecode(body);
      if (d is Map<String, dynamic>) {
        final m = d['message'] ?? d['error'];
        if (m is String && m.isNotEmpty) return m;
      }
    } catch (_) {}
    return fallback;
  }
}

class FCYStatus {
  final String status; // none | creating | active | failed
  final String message;
  final String accountNumber;
  final String bankName;
  final String accountName;
  final String routingDetailsJson;
  const FCYStatus({
    required this.status,
    required this.message,
    required this.accountNumber,
    required this.bankName,
    required this.accountName,
    required this.routingDetailsJson,
  });
}

class FCYAccountException implements Exception {
  final String message;
  const FCYAccountException(this.message);
  @override
  String toString() => message;
}
