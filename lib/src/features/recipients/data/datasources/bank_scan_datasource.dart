import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';
import 'package:lazervault/src/features/recipients/data/services/bank_scan_upload_service.dart';

/// Data source for smart OCR scanning via Chat Agent Gateway.
///
/// New 3-step pipeline (replaces the old inline base64 POST):
///   1. Upload the captured/picked image to storage-service via
///      [`BankScanUploadService`] → returns a stable public URL hosted
///      at `${storage}/v1/storage/objects/users/<uid>/bank-scans/<uuid>.<ext>`.
///   2. POST `${CHAT_GATEWAY_URL}/scan/bank-details` with `{image_url}`
///      (NOT base64 — server-side fetch keeps the request body small
///      and lets the OCR retain a stable reference to the source image
///      for replay / audit).
///   3. Parse the [SmartScanResult] response exactly as before.
class BankScanDataSource {
  final Dio dio;
  final SecureStorageService secureStorage;
  final BankScanUploadService uploadService;

  BankScanDataSource({
    required String baseUrl,
    required this.secureStorage,
    required this.uploadService,
  }) : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ));

  Future<void> _updateHeaders() async {
    final token = await secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    dio.options.headers['X-Service-Name'] = 'lazervault-flutter-bank-scan';
    dio.options.headers['X-Request-ID'] =
        ApiHeaders.generateRequestIdWithPrefix('bank-scan');

    final userId = await secureStorage.getUserId();
    if (userId != null && userId.isNotEmpty) {
      dio.options.headers['X-User-Id'] = userId;
    }
  }

  /// Scan a document image for payment details using LLM vision.
  ///
  /// Returns a [SmartScanResult] with classified extraction type and data.
  Future<SmartScanResult> scanBankDetails({
    required File imageFile,
    required String userId,
    String locale = 'en-NG',
    String countryCode = 'NG',
  }) async {
    await _updateHeaders();

    // 3.2: Guard file I/O with specific exception handling. We still
    // read the bytes here (rather than just passing the File path on to
    // BankScanUploadService) so a corrupted / empty file fails with the
    // same friendly error the previous implementation surfaced.
    final List<int> bytes;
    try {
      bytes = await imageFile.readAsBytes();
    } on FileSystemException catch (e) {
      throw BankScanException(
        'Could not read the image file. Please try capturing again. (${e.message})',
      );
    }

    if (bytes.isEmpty) {
      throw BankScanException('Image file is empty. Please capture a new photo.');
    }

    if (bytes.length > 10 * 1024 * 1024) {
      throw BankScanException('Image too large. Please use a smaller image.');
    }

    // Step 1: persist the image via storage-service. The chat-agent-
    // gateway will fetch this URL server-side, so the request to
    // /scan/bank-details stays small (just the URL, not 8MB of base64).
    final filename = imageFile.uri.pathSegments.isNotEmpty
        ? imageFile.uri.pathSegments.last
        : 'bank-scan.jpg';
    final BankScanUploadResult uploadResult;
    try {
      uploadResult = await uploadService.uploadBytes(
        bytes: Uint8List.fromList(bytes),
        filename: filename,
        contentType: BankScanUploadService.contentTypeFor(filename),
      );
    } on BankScanUploadException catch (e) {
      throw BankScanException(e.message);
    } catch (e) {
      throw BankScanException(
        'Could not upload the scan image. Please try again.',
      );
    }

    final accessToken = await secureStorage.getAccessToken() ?? '';

    try {
      final response = await dio.post(
        '/scan/bank-details',
        data: {
          'image_url': uploadResult.publicUrl,
          'storage_key': uploadResult.storageKey,
          'user_id': userId,
          'session_id': DateTime.now().millisecondsSinceEpoch.toString(),
          'access_token': accessToken,
          'locale': locale,
          'country_code': countryCode,
        },
      );

      if (response.statusCode == 200) {
        // 3.1: Safely validate response structure
        final responseData = response.data;
        if (responseData is! Map<String, dynamic>) {
          throw BankScanException(
            'Unexpected server response. Please try again.',
          );
        }

        if (responseData['success'] == true) {
          return SmartScanResult.fromJson(responseData);
        } else {
          final userMessage = responseData['user_message'] as String? ??
              'Could not extract details. Please try again.';
          throw BankScanException(userMessage);
        }
      } else {
        throw BankScanException(
          'Server error (${response.statusCode}). Please try again.',
        );
      }
    } on BankScanException {
      rethrow;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw BankScanException(
          'Request timed out. Please check your connection and try again.',
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        throw BankScanException(
          'Could not connect to the server. Please check your internet connection.',
        );
      }
      throw BankScanException(
        'Network error. Please check your connection and try again.',
      );
    } catch (e) {
      // Catch any other unexpected errors (cast failures, etc.)
      if (e is BankScanException) rethrow;
      throw BankScanException(
        'Something went wrong processing the scan. Please try again.',
      );
    }
  }

  /// Fetch the user's past smart-scan results (newest-first).
  ///
  /// Calls `GET /scan/history` on the same gateway ROOT that
  /// [scanBankDetails] posts to. Returns a (possibly empty) list of
  /// [ScanHistoryItem]; throws [BankScanException] on transport / server
  /// error so the caller can show a retry state.
  ///
  /// Auth is dual-tracked the same way as the live scan: the bearer token
  /// goes on the `Authorization` header (via [_updateHeaders]) AND the
  /// `access_token` query param, mirroring how the gateway scan routes
  /// accept it. `user_id` is sent so the gateway can scope the lookup.
  Future<List<ScanHistoryItem>> getScanHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    await _updateHeaders();

    final userId = await secureStorage.getUserId() ?? '';
    final accessToken = await secureStorage.getAccessToken() ?? '';

    try {
      final response = await dio.get(
        '/scan/history',
        queryParameters: {
          'user_id': userId,
          'access_token': accessToken,
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.statusCode != 200) {
        throw BankScanException(
          'Could not load scan history (${response.statusCode}). Please try again.',
        );
      }

      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        throw BankScanException('Unexpected server response. Please try again.');
      }

      final rawScans = responseData['scans'];
      if (rawScans is! List) {
        // No scans key / null → treat as empty history, not an error.
        return const [];
      }

      final items = <ScanHistoryItem>[];
      for (final raw in rawScans) {
        if (raw is Map<String, dynamic>) {
          final parsed = ScanHistoryItem.tryFromJson(raw);
          if (parsed != null) items.add(parsed);
        }
      }
      return items;
    } on BankScanException {
      rethrow;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw BankScanException(
          'Request timed out. Please check your connection and try again.',
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        throw BankScanException(
          'Could not connect to the server. Please check your internet connection.',
        );
      }
      throw BankScanException(
        'Network error loading scan history. Please try again.',
      );
    } catch (e) {
      if (e is BankScanException) rethrow;
      throw BankScanException(
        'Something went wrong loading scan history. Please try again.',
      );
    }
  }

  void dispose() {
    dio.close();
  }
}

/// A single past smart-scan, as returned by `GET /scan/history`.
///
/// Deliberately lean: the history sheet only needs enough to render a
/// summary row and to re-build a [SmartScanResult] for re-applying. The
/// [data] map is kept raw so [toSmartScanResult] can hand it straight to
/// [SmartScanResult.fromJson] — reusing the exact same field-parsing the
/// live scan uses (account_number, amount_minor, possible_types, …).
class ScanHistoryItem {
  final int id;
  final String? imageUrl;
  final String extractionType;
  final double confidence;
  final Map<String, dynamic> data;
  final DateTime? createdAt;

  const ScanHistoryItem({
    required this.id,
    required this.imageUrl,
    required this.extractionType,
    required this.confidence,
    required this.data,
    required this.createdAt,
  });

  /// Parse one history entry. Returns null only if the row is so malformed
  /// it can't be rendered (no id at all). A missing image_url is fine —
  /// the row is driven by the extracted text, not the image.
  static ScanHistoryItem? tryFromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final int? id = rawId is int
        ? rawId
        : (rawId is num ? rawId.toInt() : int.tryParse(rawId?.toString() ?? ''));
    if (id == null) return null;

    final rawData = json['data'];
    final data = rawData is Map<String, dynamic> ? rawData : <String, dynamic>{};

    final rawConfidence = json['confidence'];
    final confidence = rawConfidence is num
        ? rawConfidence.toDouble()
        : double.tryParse(rawConfidence?.toString() ?? '') ?? 0.0;

    final rawImage = json['image_url'];
    final imageUrl =
        rawImage is String && rawImage.trim().isNotEmpty ? rawImage.trim() : null;

    DateTime? createdAt;
    final rawCreated = json['created_at'];
    if (rawCreated is String && rawCreated.isNotEmpty) {
      createdAt = DateTime.tryParse(rawCreated)?.toLocal();
    }

    return ScanHistoryItem(
      id: id,
      imageUrl: imageUrl,
      extractionType: json['extraction_type']?.toString() ?? 'no_data',
      confidence: confidence.clamp(0.0, 1.0),
      data: data,
      createdAt: createdAt,
    );
  }

  /// Re-hydrate a [SmartScanResult] from this stored scan so a past
  /// extraction can flow through the exact same result-sheet / routing
  /// path the live scan uses. Reuses [SmartScanResult.fromJson] so the
  /// field parsing (amount_minor, possible_types, etc.) stays identical.
  SmartScanResult toSmartScanResult() {
    return SmartScanResult.fromJson({
      'extraction_type': extractionType,
      'confidence': confidence,
      'data': data,
    });
  }
}

/// Result from smart OCR scan — supports 5 extraction types.
class SmartScanResult {
  final String extractionType;
  final double confidence;

  // Bank details
  final String? accountNumber;
  final String? accountName;
  final String? bankName;
  final String? bankCode;
  final String? routingNumber;

  // Internal user
  final String? username;
  final String? displayName;

  // Phone number
  final String? phoneNumber;
  final String? phoneCarrier;

  // Ambiguous
  final List<String> possibleTypes;
  final String? disambiguationHint;

  // Optional pre-fill payload — when the OCR detects an invoice or
  // payment slip with a stated amount or memo, these are non-null and
  // flow into the send-funds amount + reference fields via the route
  // Map. Amount is in MINOR units (kobo / pence) so it round-trips
  // through the InitiateSendFunds amount controller without rounding
  // drift; the OCR side is expected to emit minor units explicitly.
  final int? amountMinor;
  final String? description;

  // Metadata
  final Map<String, double> fieldConfidence;
  final List<String> missingFields;

  SmartScanResult({
    required this.extractionType,
    required this.confidence,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.bankCode,
    this.routingNumber,
    this.username,
    this.displayName,
    this.phoneNumber,
    this.phoneCarrier,
    this.possibleTypes = const [],
    this.disambiguationHint,
    this.amountMinor,
    this.description,
    this.fieldConfidence = const {},
    this.missingFields = const [],
  });

  factory SmartScanResult.fromJson(Map<String, dynamic> json) {
    // Safely extract nested data map
    final rawData = json['data'];
    final data = rawData is Map<String, dynamic> ? rawData : <String, dynamic>{};

    // 4.5: Safely parse field_confidence — skip non-numeric values
    final rawFieldConf = data['field_confidence'];
    final Map<String, double> fieldConfidence = {};
    if (rawFieldConf is Map<String, dynamic>) {
      for (final entry in rawFieldConf.entries) {
        final v = entry.value;
        if (v is num) {
          fieldConfidence[entry.key] = v.toDouble();
        } else if (v is String) {
          final parsed = double.tryParse(v);
          if (parsed != null) fieldConfidence[entry.key] = parsed;
        }
      }
    }

    // Safely parse missing_fields
    final rawMissing = json['missing_fields'];
    final List<String> missingFields = rawMissing is List
        ? rawMissing.map((e) => e.toString()).toList()
        : [];

    // Safely parse possible_types
    final rawPossible = data['possible_types'];
    final List<String> possibleTypes = rawPossible is List
        ? rawPossible.map((e) => e.toString()).toList()
        : [];

    // Safely parse confidence
    final rawConfidence = json['confidence'];
    final confidence = rawConfidence is num
        ? rawConfidence.toDouble()
        : double.tryParse(rawConfidence?.toString() ?? '') ?? 0.0;

    // Optional amount / description (invoice + payment-slip extraction).
    // Servers may emit `amount_minor` directly OR a major-units `amount`
    // field; accept either, prefer minor. A 0 / negative amount is
    // treated as no-prefill so a glitched extract doesn't dump junk into
    // the amount field.
    int? amountMinor;
    final rawAmountMinor = data['amount_minor'] ?? data['amountMinor'];
    if (rawAmountMinor is num && rawAmountMinor > 0) {
      amountMinor = rawAmountMinor.toInt();
    } else {
      final rawAmount = data['amount'];
      if (rawAmount is num && rawAmount > 0) {
        amountMinor = (rawAmount * 100).round();
      } else if (rawAmount is String) {
        final parsed = double.tryParse(rawAmount);
        if (parsed != null && parsed > 0) {
          amountMinor = (parsed * 100).round();
        }
      }
    }
    final rawDescription = data['description'] ?? data['memo'] ?? data['narration'];
    final description = rawDescription is String && rawDescription.trim().isNotEmpty
        ? rawDescription.trim()
        : null;

    return SmartScanResult(
      extractionType: json['extraction_type']?.toString() ?? 'no_data',
      confidence: confidence.clamp(0.0, 1.0),
      accountNumber: data['account_number']?.toString(),
      accountName: data['account_name']?.toString(),
      bankName: data['bank_name']?.toString(),
      bankCode: data['bank_code']?.toString(),
      routingNumber: data['routing_number']?.toString(),
      username: data['username']?.toString(),
      displayName: data['display_name']?.toString(),
      phoneNumber: data['phone_number']?.toString(),
      phoneCarrier: data['phone_carrier']?.toString(),
      possibleTypes: possibleTypes,
      disambiguationHint: data['disambiguation_hint']?.toString(),
      amountMinor: amountMinor,
      description: description,
      fieldConfidence: fieldConfidence,
      missingFields: missingFields,
    );
  }

  /// Whether this result has enough data for the claimed extraction type.
  bool get hasRequiredFields => switch (extractionType) {
        'bank_details' => accountNumber != null && accountNumber!.isNotEmpty,
        'internal_user' => username != null && username!.isNotEmpty,
        'phone_number' => phoneNumber != null && phoneNumber!.isNotEmpty,
        'ambiguous' => possibleTypes.isNotEmpty,
        _ => false,
      };
}

class BankScanException implements Exception {
  final String message;
  BankScanException(this.message);

  @override
  String toString() => message;
}
