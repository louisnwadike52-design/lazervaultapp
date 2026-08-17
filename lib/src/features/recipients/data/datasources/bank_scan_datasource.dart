import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';
import 'package:lazervault/src/features/recipients/data/services/bank_scan_upload_service.dart';
part 'bank_scan_datasource_widgets.dart';


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
    bool lean = false,
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
        // Manual "tap to capture" fallback uses the lean per-service route.
        lean ? '/scan/extract' : '/scan/bank-details',
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
