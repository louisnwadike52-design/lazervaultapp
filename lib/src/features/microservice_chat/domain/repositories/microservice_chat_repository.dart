import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
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
  });

  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  });
}
