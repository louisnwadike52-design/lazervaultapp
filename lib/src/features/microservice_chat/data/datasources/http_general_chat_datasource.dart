import 'package:dio/dio.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

// ========== REQUEST MODELS ==========
class GeneralChatRequest {
  final String message;
  final String sessionId;
  final String userId;
  final String accessToken;
  final String sourceContext;
  final String language;
  final String locale;
  final Map<String, dynamic> metadata;
  final String? mediaBase64;
  final String? mediaType; // 'image' | 'voice'
  final String? mediaMimeType;

  GeneralChatRequest({
    required this.message,
    required this.sessionId,
    required this.userId,
    required this.accessToken,
    this.sourceContext = 'general',
    this.language = 'en',
    this.locale = 'en-NG',
    this.metadata = const {},
    this.mediaBase64,
    this.mediaType,
    this.mediaMimeType,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'session_id': sessionId,
      'user_id': userId,
      'access_token': accessToken,
      'source_context': sourceContext,
      'language': language,
      'locale': locale,
      if (metadata.isNotEmpty) 'metadata': metadata,
      if (mediaBase64 != null && mediaBase64!.isNotEmpty) 'media_base64': mediaBase64,
      if (mediaType != null && mediaType!.isNotEmpty) 'media_type': mediaType,
      if (mediaMimeType != null && mediaMimeType!.isNotEmpty) 'media_mime_type': mediaMimeType,
    };
  }
}

// ========== RESPONSE MODELS (Enhanced Gateway) ==========

/// Intent classification from LLM-based routing
class IntentClassification {
  final String service;
  final double confidence;
  final String reasoning;
  final String suggestedAction;

  IntentClassification({
    required this.service,
    required this.confidence,
    required this.reasoning,
    required this.suggestedAction,
  });

  factory IntentClassification.fromJson(Map<String, dynamic> json) {
    return IntentClassification(
      service: json['service'] as String? ?? 'general',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      reasoning: json['reasoning'] as String? ?? '',
      suggestedAction: json['suggested_action'] as String? ?? '',
    );
  }
}

/// Conversation state from Redis
class ConversationState {
  final int messageCount;
  final String? currentService;
  final List<String> keyEntities;

  ConversationState({
    required this.messageCount,
    this.currentService,
    this.keyEntities = const [],
  });

  factory ConversationState.fromJson(Map<String, dynamic> json) {
    return ConversationState(
      messageCount: json['message_count'] as int? ?? 0,
      currentService: json['current_service'] as String?,
      keyEntities: (json['key_entities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

/// Enhanced chat response with intent classification and conversation state
class GeneralChatResponse {
  final String response;
  final String serviceRoutedTo;
  final IntentClassification intentClassification;
  final ConversationState conversationState;
  final bool? shouldSwitchService;
  final String? previousService;
  final String timestamp;
  final Map<String, dynamic>? receiptData;

  GeneralChatResponse({
    required this.response,
    required this.serviceRoutedTo,
    required this.intentClassification,
    required this.conversationState,
    this.shouldSwitchService,
    this.previousService,
    required this.timestamp,
    this.receiptData,
  });

  factory GeneralChatResponse.fromJson(Map<String, dynamic> json) {
    return GeneralChatResponse(
      response: json['response'] as String? ?? '',
      serviceRoutedTo: json['service_routed_to'] as String? ?? 'gateway',
      intentClassification: IntentClassification.fromJson(
        json['intent_classification'] as Map<String, dynamic>? ?? {},
      ),
      conversationState: ConversationState.fromJson(
        json['conversation_state'] as Map<String, dynamic>? ?? {},
      ),
      shouldSwitchService: json['should_switch_service'] as bool?,
      previousService: json['previous_service'] as String?,
      timestamp: json['timestamp'] as String? ?? '',
      receiptData: json['receipt_data'] as Map<String, dynamic>?,
    );
  }
}

// ========== DATA SOURCE INTERFACE ==========
abstract class GeneralChatDataSource {
  Future<GeneralChatResponse> processChat(GeneralChatRequest request);
  Future<bool> clearConversation(String sessionId);
  Future<ConversationState?> getConversationState(String sessionId);
  Future<List<String>> getAvailableServices();
}

// ========== IMPLEMENTATION WITH PRODUCTION ENHANCEMENTS ==========
class HttpGeneralChatDataSource implements GeneralChatDataSource {
  final Dio dio;
  final GrpcCallOptionsHelper callOptionsHelper;
  final String baseUrl;

  // Production configuration — optimized for poor network (Nigeria 2G/3G)
  static const Duration _connectionTimeout = Duration(seconds: 30);
  static const Duration _receiveTimeout = Duration(seconds: 60);
  static const Duration _sendTimeout = Duration(seconds: 30);
  // Media messages get extended timeouts (set per-request in processChat)
  static const Duration _mediaSendTimeout = Duration(seconds: 120);
  static const Duration _mediaReceiveTimeout = Duration(seconds: 90);
  // Retries: only for text messages. Media messages are NOT retried
  // (re-uploading 10MB base64 over 2G wastes time and will likely fail again).
  static const int _maxRetries = 1;
  static const Duration _retryDelay = Duration(milliseconds: 500);

  HttpGeneralChatDataSource({
    required this.dio,
    required this.callOptionsHelper,
    required this.baseUrl,
  }) {
    _configureDio();
  }

  void _configureDio() {
    dio.options = BaseOptions(
      connectTimeout: _connectionTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptor for retry logic (text messages only)
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          // Never retry media messages — re-uploading large payloads over
          // slow networks wastes time and will likely fail for the same reason.
          final isMedia = error.requestOptions.extra['has_media'] == true;
          if (!isMedia && _shouldRetry(error)) {
            final retryCount = error.requestOptions.extra['retry_count'] ?? 0;
            if (retryCount < _maxRetries) {
              error.requestOptions.extra['retry_count'] = retryCount + 1;
              await Future.delayed(_retryDelay * (retryCount + 1));
              try {
                final response = await dio.fetch(error.requestOptions);
                handler.resolve(response);
                return;
              } catch (e) {
                // Retry failed, continue with error
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  bool _shouldRetry(DioException error) {
    // Only retry on connection-level errors and 5xx, NOT on timeouts
    // (a timed-out request already consumed the full timeout budget).
    return error.type == DioExceptionType.connectionError ||
        (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500 &&
            error.response!.statusCode! < 600);
  }

  @override
  Future<GeneralChatResponse> processChat(GeneralChatRequest request) async {
    try {
      final callOptions = await callOptionsHelper.withAuth();

      // Media messages need longer timeouts:
      // - sendTimeout: uploading large base64 over 2G/3G can be slow
      // - receiveTimeout: server processes GCS upload + Whisper/Vision + agent
      final hasMedia = request.mediaBase64 != null && request.mediaBase64!.isNotEmpty;

      final response = await dio.post(
        '$baseUrl/chat',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...callOptions.metadata,
          },
          sendTimeout: hasMedia ? _mediaSendTimeout : null,
          receiveTimeout: hasMedia ? _mediaReceiveTimeout : null,
          extra: {'has_media': hasMedia},
        ),
      );

      if (response.statusCode == 200) {
        return GeneralChatResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ChatGatewayException(
          'Failed to process chat: ${response.statusMessage}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout) {
        throw ChatGatewayException(
          'Upload timed out. Your connection may be too slow — try a smaller file or better network.',
          statusCode: 408,
        );
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ChatGatewayException(
          'Connection timeout. Please check your internet connection.',
          statusCode: 408,
        );
      }
      if (e.response?.statusCode == 401) {
        throw ChatGatewayException(
          'Authentication failed. Please login again.',
          statusCode: 401,
        );
      }
      if (e.response?.statusCode == 404) {
        throw ChatGatewayException(
          'Chat gateway service not found. Please contact support.',
          statusCode: 404,
        );
      }
      throw ChatGatewayException(
        'Network error: ${e.message}',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      if (e is ChatGatewayException) rethrow;
      throw ChatGatewayException(
        'Error processing chat: $e',
        statusCode: null,
      );
    }
  }

  @override
  Future<bool> clearConversation(String sessionId) async {
    try {
      final callOptions = await callOptionsHelper.withAuth();

      final response = await dio.delete(
        '$baseUrl/conversation/$sessionId',
        options: Options(headers: callOptions.metadata),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ConversationState?> getConversationState(String sessionId) async {
    try {
      final callOptions = await callOptionsHelper.withAuth();

      final response = await dio.get(
        '$baseUrl/conversation/$sessionId',
        options: Options(headers: callOptions.metadata),
      );

      if (response.statusCode == 200) {
        return ConversationState.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<String>> getAvailableServices() async {
    try {
      final response = await dio.get('$baseUrl/services');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final services = data['services'] as List<dynamic>;
        return services.map((e) => e['name'] as String).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

// ========== EXCEPTIONS ==========
class ChatGatewayException implements Exception {
  final String message;
  final int? statusCode;

  ChatGatewayException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
