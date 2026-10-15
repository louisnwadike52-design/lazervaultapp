import 'package:dartz/dartz.dart';
import 'package:lazervault/core/chat/chat_history_page.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/chat_response_entity.dart';
import '../entities/microservice_chat_message_entity.dart';

abstract class MicroserviceChatRepository {
  Future<Either<Failure, ChatResponseEntity>> processMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    String language,
    String locale,
    String? mediaBase64,
    String? mediaType,
    String? mediaMimeType,
  });

  /// Direct chat path with entity round-tripping (Go Chat Proxy Gateway).
  Future<Either<Failure, ChatResponseEntity>> processDirectMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    required Map<String, dynamic> entities,
    String accountId,
    String userCountry,
    String currency,
    String language,
    String locale,
    String responseStyleInstruction,
  });

  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  });

  /// Get history from the direct chat path (Go Chat Proxy Gateway).
  Future<Either<Failure, List<MicroserviceChatMessageEntity>>>
      getDirectHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  });

  /// One page of history, with the cursor for the next OLDER page.
  ///
  /// The per-service chat had no pagination at all: the datasources hardcoded
  /// `limit: 50, offset: 0`, so a conversation longer than 50 messages showed
  /// only one page and the rest was unreachable from the UI. Worse, the Go
  /// gateway ordered its page `created_at ASC`, so that one page was the
  /// OLDEST fifty — the recent messages could not be reached at all.
  Future<Either<Failure, ChatHistoryPage<MicroserviceChatMessageEntity>>>
      getHistoryPage({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
    int limit,
    String? before,
  });

  /// [getHistoryPage] for the direct chat path (Go Chat Proxy Gateway).
  Future<Either<Failure, ChatHistoryPage<MicroserviceChatMessageEntity>>>
      getDirectHistoryPage({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
    int limit,
    String? before,
  });
}
