import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Data source for OCR bank details scanning via Chat Agent Gateway.
class BankScanDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  BankScanDataSource({
    required String baseUrl,
  })  : storage = const FlutterSecureStorage(),
        dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ));

  Future<void> _updateAuthHeaders() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Scan a document image for bank details using OCR.
  ///
  /// [imageFile] - The captured image file
  /// [userId] - Current user ID
  /// [locale] - Locale for currency determination (e.g. "en-NG")
  ///
  /// Returns extracted bank details with confidence scores.
  Future<BankScanResult> scanBankDetails({
    required File imageFile,
    required String userId,
    String locale = 'en-NG',
  }) async {
    await _updateAuthHeaders();

    // Read and compress image to base64
    final bytes = await imageFile.readAsBytes();

    // Reject if over 10MB
    if (bytes.length > 10 * 1024 * 1024) {
      throw BankScanException('Image too large. Please use a smaller image.');
    }

    final base64Image = base64Encode(bytes);

    try {
      final response = await dio.post(
        '/scan/bank-details',
        data: {
          'image_base64': base64Image,
          'user_id': userId,
          'locale': locale,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['success'] == true && data['extracted_data'] != null) {
          return BankScanResult.fromJson(
            data['extracted_data'] as Map<String, dynamic>,
            sessionId: data['session_id'] as String?,
          );
        } else {
          final errorCode = data['error'] as String? ?? 'UNKNOWN';
          final userMessage = data['user_message'] as String? ??
              'Could not extract bank details. Please try again.';

          if (errorCode == 'LOW_CONFIDENCE') {
            throw BankScanLowConfidenceException(userMessage);
          }
          throw BankScanException(userMessage);
        }
      } else {
        throw BankScanException(
          'Server error (${response.statusCode}). Please try again.',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw BankScanException(
          'Request timed out. Please check your connection and try again.',
        );
      }
      throw BankScanException(
        'Network error. Please check your connection and try again.',
      );
    }
  }

  void dispose() {
    dio.close();
  }
}

/// Result from OCR bank details scan.
class BankScanResult {
  final String accountNumber;
  final String? accountName;
  final String bankName;
  final String? bankCode;
  final String? routingNumber;
  final double confidenceScore;
  final Map<String, double> fieldConfidence;
  final String accountType;
  final String transferMethod;
  final bool requiresLinking;
  final String? sessionId;

  BankScanResult({
    required this.accountNumber,
    this.accountName,
    required this.bankName,
    this.bankCode,
    this.routingNumber,
    required this.confidenceScore,
    required this.fieldConfidence,
    required this.accountType,
    required this.transferMethod,
    this.requiresLinking = false,
    this.sessionId,
  });

  factory BankScanResult.fromJson(
    Map<String, dynamic> json, {
    String? sessionId,
  }) {
    final rawFieldConf = json['field_confidence'] as Map<String, dynamic>? ?? {};
    final fieldConfidence = rawFieldConf.map(
      (k, v) => MapEntry(k, (v as num).toDouble()),
    );

    return BankScanResult(
      accountNumber: json['account_number'] as String? ?? '',
      accountName: json['account_name'] as String?,
      bankName: json['bank_name'] as String? ?? '',
      bankCode: json['bank_code'] as String?,
      routingNumber: json['routing_number'] as String?,
      confidenceScore: (json['confidence_score'] as num?)?.toDouble() ?? 0.0,
      fieldConfidence: fieldConfidence,
      accountType: json['account_type'] as String? ?? 'external',
      transferMethod: json['transfer_method'] as String? ?? 'mono_direct_debit',
      requiresLinking: json['requires_linking'] as bool? ?? false,
      sessionId: sessionId,
    );
  }
}

class BankScanException implements Exception {
  final String message;
  BankScanException(this.message);

  @override
  String toString() => message;
}

class BankScanLowConfidenceException extends BankScanException {
  BankScanLowConfidenceException(super.message);
}
