import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/ai_chats/domain/entities/ai_chat_message_entity.dart';
import '../repositories/i_ai_chat_repository.dart';

class GetAIChatHistoryUseCase {
  final IAiChatRepository _repository;

  GetAIChatHistoryUseCase(this._repository);

  Future<Either<Failure, List<ChatMessageEntity>>> call({
    required String accessToken,
    String? sessionId,
  }) async {
    return await _repository.getChatHistory(
      accessToken: accessToken,
      sessionId: sessionId,
    );
  }
} 