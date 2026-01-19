import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/account_verification_result.dart';

/// Custom exceptions for account verification.
class AccountNotFoundException implements Exception {
  final String message;
  AccountNotFoundException([this.message = 'Account not found']);

  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException([this.message = 'Rate limit exceeded']);

  @override
  String toString() => message;
}

class VerificationException implements Exception {
  final String message;
  final String? errorCode;

  VerificationException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error']);

  @override
  String toString() => message;
}

/// Remote data source for recipient account verification.
///
/// Connects to the Chat Agent Gateway to verify bank account details
/// using Paystack API.
abstract class RecipientVerificationRemoteDataSource {
  /// Verify a bank account and fetch account holder name.
  Future<AccountVerificationResult> verifyAccount({
    required String bankCode,
    required String accountNumber,
    String country = 'NG',
  });

  /// Get list of supported banks.
  Future<List<Map<String, String>>> getSupportedBanks({
    String country = 'NG',
  });

  /// Dispose resources.
  void dispose();
}

class RecipientVerificationRemoteDataSourceImpl
    implements RecipientVerificationRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;
  final String baseUrl;

  RecipientVerificationRemoteDataSourceImpl({
    required this.baseUrl,
    String? authToken,
  })  : storage = const FlutterSecureStorage(),
        dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    if (authToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
    }

    // Add interceptor for logging (optional, useful for debugging)
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => print('[HTTP] $obj'),
    ));
  }

  /// Update authorization headers with current auth token.
  Future<void> _updateAuthHeaders() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  @override
  Future<AccountVerificationResult> verifyAccount({
    required String bankCode,
    required String accountNumber,
    String country = 'NG',
  }) async {
    await _updateAuthHeaders();

    try {
      final response = await dio.post(
        '/api/v1/recipients/verify-account',
        data: {
          'bank_code': bankCode,
          'account_number': accountNumber,
          'country': country,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['success'] == true && data['data'] != null) {
          return AccountVerificationResult.fromJson(
            data['data'] as Map<String, dynamic>,
          );
        } else if (data['error'] != null) {
          final error = data['error'] as Map<String, dynamic>;
          throw VerificationException(
            error['user_message'] as String? ?? 'Verification failed',
            error['code'] as String?,
          );
        } else {
          throw VerificationException('Invalid response format');
        }
      } else {
        throw VerificationException(
          'HTTP ${response.statusCode}: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      // Handle specific HTTP errors
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final data = e.response!.data;

        if (statusCode == 404) {
          // Account not found
          throw AccountNotFoundException(
            data is Map && data['error'] != null
                ? data['error']['user_message'] ??
                    'Account not found. Please check the account number.'
                : 'Account not found. Please check the account number.',
          );
        } else if (statusCode == 429) {
          // Rate limit exceeded
          throw RateLimitException(
            data is Map && data['error'] != null
                ? data['error']['user_message'] ??
                    'Too many attempts. Please wait a minute.'
                : 'Too many attempts. Please wait a minute.',
          );
        } else if (statusCode == 400) {
          // Invalid request
          final errorMessage = data is Map && data['error'] != null
              ? data['error']['user_message'] ?? 'Invalid request'
              : 'Invalid request';
          throw VerificationException(errorMessage, 'INVALID_REQUEST');
        } else if (statusCode! >= 500) {
          // Server error
          throw VerificationException(
            'Server error. Please try again later.',
            'SERVER_ERROR',
          );
        } else {
          throw VerificationException(
            'Verification failed (${e.response!.statusCode})',
          );
        }
      } else {
        // Network errors
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          throw NetworkException(
            'Request timeout. Please check your connection and try again.',
          );
        } else if (e.type == DioExceptionType.connectionError ||
            e.error is SocketException) {
          throw NetworkException(
            'No internet connection. Please check your connection.',
          );
        } else if (e.type == DioExceptionType.cancel) {
          throw VerificationException('Request cancelled', 'CANCELLED');
        } else {
          throw NetworkException('Network error: ${e.message}');
        }
      }
    } catch (e) {
      // Catch any other unexpected errors
      if (e is AccountNotFoundException ||
          e is RateLimitException ||
          e is VerificationException ||
          e is NetworkException) {
        rethrow;
      }
      throw VerificationException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Map<String, String>>> getSupportedBanks({
    String country = 'NG',
  }) async {
    await _updateAuthHeaders();

    try {
      final response = await dio.get(
        '/api/v1/recipients/banks',
        queryParameters: {'country': country},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['success'] == true && data['data'] != null) {
          final banksList = data['data'] as List;
          return banksList
              .map((bank) => Map<String, String>.from(bank as Map))
              .toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Failed to fetch banks (${e.response!.statusCode})',
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Request timeout. Please try again.');
      } else if (e.error is SocketException) {
        throw NetworkException('No internet connection.');
      } else {
        throw NetworkException('Network error: ${e.message}');
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Close the Dio client.
  void dispose() {
    dio.close();
  }
}
