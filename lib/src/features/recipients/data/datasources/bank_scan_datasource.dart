import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';

/// Data source for smart OCR scanning via Chat Agent Gateway.
class BankScanDataSource {
  final Dio dio;
  final SecureStorageService secureStorage;

  BankScanDataSource({
    required String baseUrl,
    required this.secureStorage,
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

    // 3.2: Guard file I/O with specific exception handling
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

    final base64Image = base64Encode(bytes);
    final accessToken = await secureStorage.getAccessToken() ?? '';

    try {
      final response = await dio.post(
        '/scan/bank-details',
        data: {
          'image_base64': base64Image,
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

  void dispose() {
    dio.close();
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
