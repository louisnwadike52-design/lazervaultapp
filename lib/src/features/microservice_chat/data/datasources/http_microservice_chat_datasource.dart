import 'package:dio/dio.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

// Define models
class ChatRequest {
  final String message;
  final String sessionId;
  final String userId;
  final String accessToken;
  final String sourceContext;
  final String language;
  final Map<String, dynamic> metadata;

  ChatRequest({
    required this.message,
    required this.sessionId,
    required this.userId,
    required this.accessToken,
    required this.sourceContext,
    this.language = 'en',
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'session_id': sessionId,
      'user_id': userId,
      'access_token': accessToken,
      'source_context': sourceContext,
      'language': language,
      'metadata': metadata,
    };
  }
}

class ChatResponse {
  final String response;
  final Map<String, dynamic> metadata;

  ChatResponse({required this.response, required this.metadata});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      response: json['response'] as String? ?? '',
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
}

class ChatHistoryResponse {
  final List<ChatHistoryMessage> history;
  final int totalCount;
  final String sessionId;

  ChatHistoryResponse({
    required this.history,
    required this.totalCount,
    required this.sessionId,
  });

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) {
    final historyList = (json['history'] as List<dynamic>?) ?? [];
    return ChatHistoryResponse(
      history: historyList
          .map((e) => ChatHistoryMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['total_count'] as int? ?? 0,
      sessionId: json['session_id'] as String? ?? '',
    );
  }
}

class ChatHistoryMessage {
  final String role;
  final String content;
  final String service;
  final String sourceContext;
  final String timestamp;

  ChatHistoryMessage({
    required this.role,
    required this.content,
    required this.service,
    required this.sourceContext,
    required this.timestamp,
  });

  factory ChatHistoryMessage.fromJson(Map<String, dynamic> json) {
    return ChatHistoryMessage(
      role: json['role'] as String? ?? '',
      content: json['content'] as String? ?? '',
      service: json['service'] as String? ?? '',
      sourceContext: json['source_context'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
    );
  }
}

abstract class MicroserviceChatDataSource {
  Future<ChatResponse> processChat(ChatRequest request);
  Future<void> sendTypingIndicator(String sessionId, bool isTyping);
  Future<ChatHistoryResponse> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
  });
}

class HttpMicroserviceChatDataSource implements MicroserviceChatDataSource {
  final Dio dio;
  final GrpcCallOptionsHelper callOptionsHelper;
  final String baseUrl;

  HttpMicroserviceChatDataSource({
    required this.dio,
    required this.callOptionsHelper,
    this.baseUrl = 'http://localhost:3011', // Chat Agent Gateway
  });

  @override
  Future<ChatResponse> processChat(ChatRequest request) async {
    try {
      final options = await callOptionsHelper.withAuth();

      final response = await dio.post(
        '$baseUrl/chat',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...options.metadata,
          },
        ),
      );

      if (response.statusCode == 200) {
        return ChatResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to process chat: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error processing chat: $e');
    }
  }

  @override
  Future<ChatHistoryResponse> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
  }) async {
    try {
      final options = await callOptionsHelper.withAuth();

      final response = await dio.get(
        '$baseUrl/chat/history',
        queryParameters: {
          'user_id': '', // Will be extracted from token on backend
          'session_id': sessionId,
          'source_context': sourceContext,
          'access_token': accessToken,
          'limit': 50,
          'offset': 0,
        },
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
    // Optional: Implement typing indicator via WebSocket
    // For now, this is a no-op as typing indicators are handled locally
  }
}
