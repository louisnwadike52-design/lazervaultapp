import 'package:dio/dio.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'grpc_ai_chat_service.dart'; // Import the interface from gRPC file

/// HTTP Data Source for AI Chat - calls Chat Agent Gateway directly
/// Bypasses Core Gateway to reduce load and follows proper microservice architecture
class HttpAiChatDataSource implements IAiChatDataSource {
  final Dio _dio;
  final SecureStorageService _secureStorageService;
  final AccountManager? _accountManager;
  final LocaleManager? _localeManager;

  HttpAiChatDataSource({
    required Dio dio,
    required SecureStorageService secureStorageService,
    AccountManager? accountManager,
    LocaleManager? localeManager,
  })  : _dio = dio,
        _secureStorageService = secureStorageService,
        _accountManager = accountManager,
        _localeManager = localeManager {
    _configureDio();
  }

  void _configureDio() {
    // Store the baseUrl before modifying options
    final originalBaseUrl = _dio.options.baseUrl;
    print('AI Chat: Original BaseUrl: $originalBaseUrl');

    // Update existing options instead of replacing them
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    _dio.options.headers['Content-Type'] = 'application/json';

    // Explicitly preserve the baseUrl (in case it was lost)
    if (originalBaseUrl != null && originalBaseUrl.isNotEmpty) {
      _dio.options.baseUrl = originalBaseUrl;
    }

    print('AI Chat: BaseUrl after config: ${_dio.options.baseUrl}');

    // Add auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _secureStorageService.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // Add account context headers
        final accountId = _accountManager?.activeAccountId;
        if (accountId != null && accountId.isNotEmpty) {
          options.headers['X-Account-Id'] = accountId;
        }

        final country = _localeManager?.currentCountry;
        if (country != null && country.isNotEmpty) {
          options.headers['X-User-Country'] = country;
        }

        final currency = _localeManager?.currentCurrency;
        if (currency != null && currency.isNotEmpty) {
          options.headers['X-Currency'] = currency;
        }

        return handler.next(options);
      },
      onError: (error, handler) {
        // Log error for debugging
        print('AI Chat HTTP Error: ${error.message}');
        print('AI Chat Error Type: ${error.type}');
        print('AI Chat Request Path: ${error.requestOptions.uri}');
        if (error.response != null) {
          print('Response status: ${error.response?.statusCode}');
          print('Response data: ${error.response?.data}');
        }
        if (error.error != null) {
          print('Inner error: ${error.error}');
        }
        return handler.next(error);
      },
    ));
  }

  @override
  Future<dynamic> processChat({
    required String query,
    String? sessionId,
    String? sourceContext,
    String? language,
  }) async {
    try {
      // Get user context
      final userId = await _secureStorageService.getUserId() ?? '';
      final accountId = _accountManager?.activeAccountId ?? '';
      final country = _localeManager?.currentCountry ?? '';
      final currency = _localeManager?.currentCurrency ?? '';
      final accessToken = await _secureStorageService.getAccessToken() ?? '';

      // Debug logging
      print('AI Chat Request - User ID: $userId, Has Token: ${accessToken.isNotEmpty}');

      // Build request body matching Chat Agent Gateway's ChatMessage model
      final requestBody = {
        'message': query,
        'session_id': sessionId ?? _generateSessionId(),
        'user_id': userId,
        'access_token': accessToken,
        'source_context': sourceContext ?? 'dashboard',
        'language': language ?? 'en',
        'account_id': accountId,
        'user_country': country,
        'currency': currency,
      };

      print('AI Chat Request Body: ${requestBody.keys}');

      final response = await _dio.post(
        '/chat',
        data: requestBody,
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Chat service returned error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Enhanced error logging
      print('AI Chat DioException - Type: ${e.type}, Message: ${e.message}');
      if (e.response != null) {
        print('AI Chat Response - Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
        throw Exception('Chat service error: ${e.response?.data['detail'] ?? e.message}');
      }
      throw Exception('Failed to connect to chat service: ${e.message}');
    }
  }

  @override
  Future<dynamic> getChatHistory({String? sessionId, String? sourceContext}) async {
    try {
      final userId = await _secureStorageService.getUserId() ?? '';
      // Use provided sessionId — don't generate random ones (breaks persistence)
      final effectiveSessionId = sessionId ?? '';
      final token = await _secureStorageService.getAccessToken() ?? '';

      final queryParams = <String, dynamic>{
        'user_id': userId,
        'access_token': token,
        'limit': 50,
        'offset': 0,
      };

      // Only include session_id if provided (backend treats empty as "all")
      if (effectiveSessionId.isNotEmpty) {
        queryParams['session_id'] = effectiveSessionId;
      }

      // Include source_context for filtering
      if (sourceContext != null && sourceContext.isNotEmpty) {
        queryParams['source_context'] = sourceContext;
      }

      final response = await _dio.get(
        '/chat/history',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to get chat history: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat history: ${e.message}');
    }
  }

  String _generateSessionId() {
    return 'chat_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
}
