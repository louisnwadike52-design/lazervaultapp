import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Service for connecting SprayMe AI chat to the chat-agent-gateway
/// Provides real AI responses with conversation history persistence
class SprayMeChatService {
  final Dio _dio;
  final SecureStorageService _storage;

  SprayMeChatService({
    Dio? dio,
    required SecureStorageService storage,
  })  : _dio = dio ?? Dio(),
        _storage = storage;

  /// Send a message to the chat-agent-gateway and get AI response
  Future<ChatResponse> sendMessage({
    required String message,
    required String sessionId,
  }) async {
    final token = await _storage.getAccessToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final userId = await _storage.getUserId();
    if (userId == null) {
      throw Exception('User ID not found');
    }

    final host = dotenv.env['CHAT_AGENT_HOST'] ?? dotenv.env['PAYMENT_GRPC_HOST'] ?? '10.0.2.2';
    final port = dotenv.env['CHAT_AGENT_PORT'] ?? '3011';

    final response = await _dio.post(
      'http://$host:$port/chat',
      data: {
        'message': message,
        'session_id': sessionId,
        'user_id': userId,
        'access_token': token,
        'source_context': 'sprayme',
        'locale': 'en-NG',
        'metadata': {
          'feature': 'sprayme_ai_assistant',
        },
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    if (response.statusCode == 200) {
      return ChatResponse.fromJson(response.data);
    }

    throw Exception('Failed to get AI response: ${response.statusCode}');
  }

  /// Get chat history for a session
  Future<List<ChatHistoryMessage>> getHistory({
    required String sessionId,
    int limit = 20,
  }) async {
    final token = await _storage.getAccessToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final userId = await _storage.getUserId();
    if (userId == null) {
      throw Exception('User ID not found');
    }

    final host = dotenv.env['CHAT_AGENT_HOST'] ?? dotenv.env['PAYMENT_GRPC_HOST'] ?? '10.0.2.2';
    final port = dotenv.env['CHAT_AGENT_PORT'] ?? '3011';

    try {
      final response = await _dio.get(
        'http://$host:$port/chat/history',
        queryParameters: {
          'user_id': userId,
          'session_id': sessionId,
          'access_token': token,
          'limit': limit.toString(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['messages'] != null) {
        final messages = response.data['messages'] as List;
        return messages.map((m) => ChatHistoryMessage.fromJson(m)).toList();
      }
    } catch (e) {
      // History fetch failure is non-fatal
      _debugLog('Failed to fetch chat history: $e');
    }

    return [];
  }
}

/// Response from chat-agent-gateway
class ChatResponse {
  final String messageId;
  final String response;
  final String? intent;
  final Map<String, dynamic>? entities;
  final String? conversationState;
  final String serviceRoutedTo;
  final DateTime timestamp;

  ChatResponse({
    required this.messageId,
    required this.response,
    this.intent,
    this.entities,
    this.conversationState,
    required this.serviceRoutedTo,
    required this.timestamp,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      messageId: json['message_id'] as String? ?? '',
      response: json['response'] as String? ?? '',
      intent: json['intent'] as String?,
      entities: json['entities'] as Map<String, dynamic>?,
      conversationState: json['conversation_state'] as String?,
      serviceRoutedTo: json['service_routed_to'] as String? ?? 'unknown',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }
}

/// Chat history message
class ChatHistoryMessage {
  final String id;
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;

  ChatHistoryMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
  });

  factory ChatHistoryMessage.fromJson(Map<String, dynamic> json) {
    return ChatHistoryMessage(
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      content: json['content'] as String? ?? json['message'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }
}

void _debugLog(String message) {
  // ignore: avoid_print
  print('[SprayMeChatService] $message');
}
