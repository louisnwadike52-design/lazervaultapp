import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/secure_storage_defaults.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

import 'fcy_prefill.dart';

/// Client for the foreign-currency (USD/GBP/EUR/CAD) virtual-account flow:
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
      : _storage = storage ?? kAppSecureStorage,
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
      supportedCurrencies: _currencyList(d['supportedCurrencies']),
      activatableCurrencies: _currencyList(d['activatableCurrencies']),
      gatedCurrencies: _currencyList(d['gatedCurrencies']),
      currencyGated: d['currencyGated'] == true,
      provider: (d['provider'] ?? '').toString(),
    );
  }

  /// What the form does NOT have to ask for.
  ///
  /// Called ONCE when the flow opens, never on the status poll — this reaches
  /// through to banking-service for a verified identity, and doing that every few
  /// seconds to redraw a form would be wasteful for data that cannot change while
  /// the user is filling it in.
  ///
  /// NEVER THROWS. A prefill is a convenience: if it is unavailable the form must
  /// still open and simply ask for everything, which is exactly what
  /// [FcyPrefill.none] produces. Throwing here would turn a missing nicety into a
  /// blocked flow.
  Future<FcyPrefill> prefill(String currency) async {
    try {
      final token = await _token();
      final res = await _client
          .get(
            Uri.parse(
                '${endpointRegistry.httpCore}/accounts/fcy/prefill?currency=$currency'),
            headers: _headers(token),
          )
          .timeout(_timeout);
      if (res.statusCode < 200 || res.statusCode >= 300) {
        return FcyPrefill.none;
      }
      final d = jsonDecode(res.body);
      if (d is! Map<String, dynamic>) return FcyPrefill.none;
      return FcyPrefill.fromJson(d);
    } catch (_) {
      // Deliberately swallowed — see the note above.
      return FcyPrefill.none;
    }
  }

  /// Submit the full FCY KYC package. Throws with the backend's precise
  /// missing-field message on incompleteness.
  Future<FCYSubmitResult> submit(Map<String, dynamic> body) async {
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
    final requestId =
        (d['requestId'] ?? d['request_id'] ?? '').toString().trim();
    final status = (d['status'] ?? '').toString().trim().toLowerCase();
    return FCYSubmitResult(
      message: (d['message'] ?? 'Your account request is being processed.')
          .toString(),
      // QUEUED is signalled structurally — an empty request id with status
      // 'creating' means the package was saved and validated but the provider would
      // not accept it yet. Read this way and not by looking for a keyword in the
      // message, which breaks the moment anyone rewords the copy.
      queued: requestId.isEmpty && status == 'creating',
      requestId: requestId,
      status: status,
    );
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

  static List<String> _currencyList(Object? raw) => ((raw as List?) ?? const [])
      .map((e) => e.toString().trim().toUpperCase())
      .where((e) => e.isNotEmpty)
      .toList(growable: false);

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

  /// Every currency a usable provider can issue RIGHT NOW, from the server.
  ///
  /// The app used to hardcode {USD, GBP, EUR, CAD}. Fincra issues ten, so a
  /// user on a GHS or KES wallet was never offered activation for a currency
  /// the active provider supports — and a hardcoded list cannot follow a
  /// provider switch, because the set belongs to the provider, not to us.
  ///
  /// Empty when the server is older or the read failed; callers fall back
  /// rather than showing nothing.
  final List<String> supportedCurrencies;

  /// The subset of [supportedCurrencies] a request would actually be ACCEPTED
  /// for right now.
  ///
  /// The two sets answer different questions and in production they disagree:
  /// the provider's catalogue lists ten currencies, but its account-level
  /// entitlement refuses USD, GBP, EUR and CAD outright while GHS, KES, XAF,
  /// TZS, RWF and UGX are open. The app was offering the KYC wizard for exactly
  /// the four that are blocked, so every package it collected could only be
  /// queued, and never offered the six that work.
  ///
  /// Empty when the server is older than this field; callers then fall back to
  /// [supportedCurrencies], which is the behaviour that existed before.
  final List<String> activatableCurrencies;

  /// The complement — declared by the provider, refused at the account level.
  /// Carried so a screen can say "not open yet" about a named currency instead
  /// of silently omitting it, which reads as a bug to someone who knows the
  /// feature exists.
  final List<String> gatedCurrencies;

  /// Whether the currency THIS status was read for is one of the gated ones.
  final bool currencyGated;

  /// Which rail would issue this currency ("fincra", "nomba", …), or empty
  /// when none would. Lets a screen name the provider instead of assuming one.
  final String provider;

  const FCYStatus({
    required this.status,
    required this.message,
    required this.accountNumber,
    required this.bankName,
    required this.accountName,
    required this.routingDetailsJson,
    this.supportedCurrencies = const [],
    this.activatableCurrencies = const [],
    this.gatedCurrencies = const [],
    this.currencyGated = false,
    this.provider = '',
  });
}

class FCYAccountException implements Exception {
  final String message;
  const FCYAccountException(this.message);
  @override
  String toString() => message;
}

/// Outcome of an FCY submission.
///
/// [queued] distinguishes "saved but the provider would not take it yet" from
/// "accepted and under review". The two need opposite copy: a queued applicant did
/// nothing wrong and must not be sent back to re-edit a correct form, so the
/// distinction is carried as a field rather than inferred from the message text.
class FCYSubmitResult {
  const FCYSubmitResult({
    required this.message,
    required this.queued,
    this.requestId = '',
    this.status = '',
  });

  final String message;
  final bool queued;
  final String requestId;
  final String status;
}
