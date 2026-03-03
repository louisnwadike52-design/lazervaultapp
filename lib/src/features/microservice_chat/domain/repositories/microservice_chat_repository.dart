import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_response_entity.dart';
import '../entities/microservice_chat_message_entity.dart';

abstract class MicroserviceChatRepository {
  Future<Either<Failure, String>> processMessage({
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
  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> getDirectHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  });
}
