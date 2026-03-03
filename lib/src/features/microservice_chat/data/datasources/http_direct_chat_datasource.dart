import 'package:dio/dio.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'http_microservice_chat_datasource.dart';

/// Request model for direct chat via Go Chat Proxy Gateway.
/// Includes entity round-tripping and user context fields.
class DirectChatRequest {
  final String message;
  final String sessionId;
  final String userId;
  final String accessToken;
  final String sourceContext;
  final String language;
  final String locale;
  final String accountId;
  final String userCountry;
  final String currency;
  final Map<String, dynamic> entities;
  final String responseStyleInstruction;

  DirectChatRequest({
    required this.message,
    required this.sessionId,
    required this.userId,
    required this.accessToken,
    required this.sourceContext,
    this.language = 'en',
    this.locale = 'en-NG',
    this.accountId = '',
    this.userCountry = '',
    this.currency = '',
    this.entities = const {},
    this.responseStyleInstruction = '',
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
      'account_id': accountId,
      'user_country': userCountry,
      'currency': currency,
      'entities': entities,
      'response_style_instruction': responseStyleInstruction,
    };
  }
}

/// Response model from Go Chat Proxy Gateway.
/// Includes round-tripped entities for multi-turn conversations.
class DirectChatResponse {
  final String response;
  final String serviceRoutedTo;
  final String sessionId;
  final Map<String, dynamic> entities;
  final String conversationState;

  DirectChatResponse({
    required this.response,
    required this.serviceRoutedTo,
    required this.sessionId,
    required this.entities,
    required this.conversationState,
  });

  factory DirectChatResponse.fromJson(Map<String, dynamic> json) {
    return DirectChatResponse(
      response: json['response'] as String? ?? '',
      serviceRoutedTo: json['service_routed_to'] as String? ?? '',
      sessionId: json['session_id'] as String? ?? '',
      entities: (json['entities'] as Map<String, dynamic>?) ?? {},
      conversationState: json['conversation_state'] as String? ?? 'IDLE',
    );
  }
}

/// Datasource that calls the Go Chat Proxy Gateway directly.
/// Used for Quick Service chat icons — bypasses Python gateway intent classification.
class HttpDirectChatDataSource implements MicroserviceChatDataSource {
  final Dio dio;
  final GrpcCallOptionsHelper callOptionsHelper;
  final String baseUrl;

  HttpDirectChatDataSource({
    required this.dio,
    required this.callOptionsHelper,
    this.baseUrl = 'http://localhost:8092', // Go Chat Proxy Gateway
  });

  /// Send a direct chat message with entity round-tripping.
  Future<DirectChatResponse> processDirectChat(DirectChatRequest request) async {
    try {
      final options = await callOptionsHelper.withAuth();

      final response = await dio.post(
        '$baseUrl/api/v1/chat/direct',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...options.metadata,
          },
        ),
      );

      if (response.statusCode == 200) {
        return DirectChatResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to process direct chat: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error processing direct chat: $e');
    }
  }

  /// Implements MicroserviceChatDataSource.processChat for backward compatibility.
  /// Wraps the direct call, ignoring entities (use processDirectChat for entity support).
  @override
  Future<ChatResponse> processChat(ChatRequest request) async {
    final directReq = DirectChatRequest(
      message: request.message,
      sessionId: request.sessionId,
      userId: request.userId,
      accessToken: request.accessToken,
      sourceContext: request.sourceContext,
      language: request.language,
      locale: request.locale,
    );

    final directResp = await processDirectChat(directReq);

    return ChatResponse(
      response: directResp.response,
      metadata: {'entities': directResp.entities},
    );
  }

  @override
  Future<ChatHistoryResponse> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  }) async {
    try {
      final options = await callOptionsHelper.withAuth();

      final queryParams = <String, dynamic>{
        'session_id': sessionId,
        'source_context': sourceContext,
        'limit': 50,
        'offset': 0,
      };

      if (locale != null && locale.isNotEmpty) {
        queryParams['locale'] = locale;
      }

      final response = await dio.get(
        '$baseUrl/api/v1/chat/direct/history',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...options.metadata,
          },
        ),
      );

      if (response.statusCode == 200) {
        return ChatHistoryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get history: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching history: $e');
    }
  }

  @override
  Future<void> sendTypingIndicator(String sessionId, bool isTyping) async {
    // No-op for direct chat
  }
}
