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
    int? mediaDurationMs,
    Map<String, dynamic>? extraMetadata,
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
        mediaDurationMs: mediaDurationMs,
        extraMetadata: extraMetadata,
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

        // Pass pin_prompt through the same channel so the cubit can surface the
        // inline ChatPinPromptCard (mirrors receipt_data; the gateway surfaces
        // pin_prompt top-level like receipt_data).
        final pinPrompt = response['pin_prompt'];
        if (pinPrompt != null && pinPrompt is Map) {
          protoResponse.entities['_pin_prompt'] = jsonEncode(pinPrompt);
        }

        // Pass receipt_card (single dict OR a list for a batch transfer)
        // through the same channel so the cubit can surface ChatReceiptCardV2 /
        // ChatReceiptCardV2List — this is what makes batch receipts render in
        // the per-service chat.
        final receiptCard = response['receipt_card'];
        if (receiptCard != null && (receiptCard is Map || receiptCard is List)) {
          protoResponse.entities['_receipt_card'] = jsonEncode(receiptCard);
        }

        // Pass through other entities if present
        final entities = response['entities'];
        if (entities != null && entities is Map) {
          for (final entry in entities.entries) {
            if (entry.key != '_receipt_data' &&
                entry.key != '_pin_prompt' &&
                entry.key != '_receipt_card') {
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
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _dataSource.getChatHistory(
        sessionId: sessionId,
        sourceContext: sourceContext,
        limit: limit,
        offset: offset,
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
              final content = (entry['content'] ?? entry['query'] ?? '').toString();
              final role = entry['role'] ?? 'user';

              // Parse metadata once (stored as a Map or a JSON string in history).
              final rawMetadata = entry['metadata'];
              Map<String, dynamic>? parsedMetadata;
              if (rawMetadata is Map) {
                parsedMetadata = Map<String, dynamic>.from(rawMetadata);
              } else if (rawMetadata is String && rawMetadata.isNotEmpty) {
                try {
                  parsedMetadata = jsonDecode(rawMetadata) as Map<String, dynamic>;
                } catch (_) {
                  parsedMetadata = null;
                }
              }

              // Receipt cards (assistant turns).
              Map<String, dynamic>? receiptData;
              if (role == 'assistant' &&
                  parsedMetadata != null &&
                  parsedMetadata.containsKey('receipt_data')) {
                final rd = parsedMetadata['receipt_data'];
                if (rd is Map) {
                  receiptData = Map<String, dynamic>.from(rd);
                } else if (rd is String) {
                  try {
                    receiptData = jsonDecode(rd) as Map<String, dynamic>;
                  } catch (_) {}
                }
              }

              // V2 receipt card(s) — single dict or a list (batch). Rebuilt so
              // reloaded history renders batch receipts the same as live.
              dynamic receiptCard;
              if (role == 'assistant' &&
                  parsedMetadata != null &&
                  parsedMetadata.containsKey('receipt_card')) {
                final rc = parsedMetadata['receipt_card'];
                if (rc is Map || rc is List) {
                  receiptCard = rc;
                } else if (rc is String && rc.isNotEmpty) {
                  try {
                    receiptCard = jsonDecode(rc);
                  } catch (_) {}
                }
              }

              // Media (image / voice) — re-render reloaded history as an image
              // preview or a playable voice note instead of plain text. The
              // gateway persists this under metadata.media {type,url,transcript}.
              String? mediaType;
              String? mediaUrl;
              String? transcript;
              int? mediaDurationMs;
              String? mediaMime;
              if (parsedMetadata != null && parsedMetadata['media'] is Map) {
                final media =
                    Map<String, dynamic>.from(parsedMetadata['media'] as Map);
                mediaType = media['type'] as String?;
                mediaUrl = media['url'] as String?;
                transcript = media['transcript'] as String?;
                mediaMime = media['mime'] as String?;
                // duration_ms may arrive as int, double, or numeric string.
                final rawDuration = media['duration_ms'];
                if (rawDuration is int) {
                  mediaDurationMs = rawDuration;
                } else if (rawDuration is double) {
                  mediaDurationMs = rawDuration.round();
                } else if (rawDuration is String && rawDuration.isNotEmpty) {
                  mediaDurationMs =
                      int.tryParse(rawDuration) ?? double.tryParse(rawDuration)?.round();
                }
              }

              // Match the live display (see AIChatCubit.sendMediaMessage): voice
              // shows "Sent a voice note" with the transcript inside the player;
              // image shows the caption or "Sent an image". The persisted voice
              // `content` IS the transcript, so route it into [transcript].
              String displayText = content;
              if (mediaType == 'voice') {
                transcript ??= content.isNotEmpty ? content : null;
                displayText = 'Sent a voice note';
              } else if (mediaType == 'image') {
                displayText = content.isNotEmpty ? content : 'Sent an image';
              }

              chatEntities.add(ChatMessageEntity(
                text: displayText,
                isUser: role == 'user',
                timestamp: timestamp,
                receiptData: receiptData,
                receiptCard: receiptCard,
                mediaType: mediaType,
                mediaUrl: mediaUrl,
                audioDurationMs: mediaDurationMs,
                mime: mediaMime,
                transcript: transcript,
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