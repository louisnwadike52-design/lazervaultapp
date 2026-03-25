import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/generated/ai_chat.pb.dart';
import '../../domain/repositories/i_ai_chat_repository.dart';
import '../datasources/grpc_ai_chat_service.dart';
import '../../domain/entities/ai_chat_message_entity.dart';

class AiChatRepositoryImpl implements IAiChatRepository {
  final IAiChatDataSource _dataSource;

  AiChatRepositoryImpl({required IAiChatDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<Failure, ProcessChatResponse>> processChat({
    required String query,
    required String accessToken,
    String? sessionId,
    String? sourceContext,
    String? language,
    String? mediaBase64,
    String? mediaType,
    String? mediaMimeType,
  }) async {
    try {
      final response = await _dataSource.processChat(
        query: query,
        sessionId: sessionId,
        sourceContext: sourceContext,
        language: language,
        mediaBase64: mediaBase64,
        mediaType: mediaType,
        mediaMimeType: mediaMimeType,
      );

      // Handle both gRPC proto response and HTTP JSON response
      if (response is ProcessChatResponse) {
        return Right(response);
      } else if (response is Map<String, dynamic>) {
        // Convert HTTP JSON response to ProcessChatResponse proto
        final protoResponse = ProcessChatResponse()
          ..response = response['response'] ?? response['message'] ?? 'No response'
          ..sessionId = response['session_id'] ?? sessionId ?? ''
          ..success = !(response['error'] != null);

        // Pass receipt_data through proto entities map as JSON-encoded string
        final receiptData = response['receipt_data'];
        if (receiptData != null && receiptData is Map) {
          protoResponse.entities['_receipt_data'] = jsonEncode(receiptData);
        }

        // Pass through other entities if present
        final entities = response['entities'];
        if (entities != null && entities is Map) {
          for (final entry in entities.entries) {
            if (entry.key != '_receipt_data') {
              protoResponse.entities[entry.key.toString()] = entry.value?.toString() ?? '';
            }
          }
        }

        // Pass intent and conversation state
        if (response['intent'] != null) {
          protoResponse.intent = response['intent'].toString();
        }
        if (response['conversation_state'] != null) {
          protoResponse.conversationState = response['conversation_state'].toString();
        }

        return Right(protoResponse);
      }

      return Left(Failure(message: 'Unknown response format', statusCode: 500));
    } catch (e) {
      return Left(Failure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory({
    required String accessToken,
    String? sessionId,
    String? sourceContext,
  }) async {
    try {
      final response = await _dataSource.getChatHistory(
        sessionId: sessionId,
        sourceContext: sourceContext,
      );

      // Handle both gRPC proto response and HTTP JSON response
      if (response is GetAIChatHistoryResponse) {
        // Map proto entries to ChatMessageEntity
        final chatEntities = response.history.expand((entry) {
          DateTime timestamp;
          try {
            timestamp = DateTime.parse(entry.timestamp).toLocal();
          } catch (_) {
            timestamp = DateTime.now();
          }

          return [
            ChatMessageEntity(
              text: entry.query,
              isUser: true,
              timestamp: timestamp,
            ),
            ChatMessageEntity(
              text: entry.response,
              isUser: false,
              timestamp: timestamp.add(const Duration(seconds: 1)),
            ),
          ];
        }).toList();

        chatEntities.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Right(chatEntities);
      } else if (response is Map<String, dynamic>) {
        // Handle HTTP JSON response
        final history = response['history'] as List<dynamic>? ?? [];
        final chatEntities = <ChatMessageEntity>[];

        for (var entry in history) {
          if (entry is Map<String, dynamic>) {
            final timestampStr = entry['timestamp'] ?? DateTime.now().toIso8601String();
            DateTime timestamp;
            try {
              timestamp = DateTime.parse(timestampStr).toLocal();
            } catch (_) {
              timestamp = DateTime.now();
            }

            // Add user message if present
            if (entry['query'] != null || entry['content'] != null) {
              final content = entry['content'] ?? entry['query'] ?? '';
              final role = entry['role'] ?? 'user';

              // Extract receipt_data from metadata for assistant messages
              Map<String, dynamic>? receiptData;
              if (role == 'assistant') {
                final metadata = entry['metadata'];
                if (metadata is Map && metadata.containsKey('receipt_data')) {
                  final rd = metadata['receipt_data'];
                  if (rd is Map) {
                    receiptData = Map<String, dynamic>.from(rd);
                  } else if (rd is String) {
                    try {
                      receiptData = jsonDecode(rd) as Map<String, dynamic>;
                    } catch (_) {}
                  }
                }
              }

              chatEntities.add(ChatMessageEntity(
                text: content.toString(),
                isUser: role == 'user',
                timestamp: timestamp,
                receiptData: receiptData,
              ));
            }
          }
        }

        chatEntities.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Right(chatEntities);
      }

      return Right(<ChatMessageEntity>[]);
    } catch (e) {
      return Left(Failure(message: e.toString(), statusCode: 500));
    }
  }
} 