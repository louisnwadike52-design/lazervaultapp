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

abstract class MicroserviceChatDataSource {
  Future<ChatResponse> processChat(ChatRequest request);
  Future<void> sendTypingIndicator(String sessionId, bool isTyping);
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
  Future<void> sendTypingIndicator(String sessionId, bool isTyping) async {
    // Optional: Implement typing indicator via WebSocket
    // For now, this is a no-op as typing indicators are handled locally
  }
}
