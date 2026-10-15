import 'package:dartz/dartz.dart';
import 'package:lazervault/core/chat/chat_history_page.dart';
import 'package:lazervault/core/error/failure.dart';
// Import the gRPC response type
import 'package:lazervault/src/generated/ai_chat.pb.dart';
// Import the new domain entity
import '../entities/ai_chat_message_entity.dart';

abstract class IAiChatRepository {
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
  });

  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory({
    required String accessToken,
    String? sessionId,
    String? sourceContext,
    int? limit,
    int? offset,
  });

  /// One page of history, with the cursor for the next OLDER page.
  ///
  /// [before] is the previous page's `nextBefore`. Prefer it over [offset]:
  /// a cursor cannot be shifted by a message arriving mid-scroll, which is
  /// what made offset pagination silently drop a message out of the middle of
  /// a conversation.
  Future<Either<Failure, ChatHistoryPage<ChatMessageEntity>>>
      getChatHistoryPage({
    required String accessToken,
    String? sessionId,
    String? sourceContext,
    int? limit,
    int? offset,
    String? before,
  });
  // Add other methods if needed (e.g., clear chat history on backend?)

  /// Record a thumbs up/down on one stored answer. `rating` is 'up', 'down',
  /// or '' to clear.
  Future<void> rateAnswer({required int messageId, required String rating});
}
