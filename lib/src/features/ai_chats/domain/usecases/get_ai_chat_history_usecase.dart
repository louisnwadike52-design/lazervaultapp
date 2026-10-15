import 'package:dartz/dartz.dart';
import 'package:lazervault/core/chat/chat_history_page.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/ai_chats/domain/entities/ai_chat_message_entity.dart';
import '../repositories/i_ai_chat_repository.dart';

class GetAIChatHistoryUseCase {
  final IAiChatRepository _repository;

  GetAIChatHistoryUseCase(this._repository);

  Future<Either<Failure, List<ChatMessageEntity>>> call({
    required String accessToken,
    String? sessionId,
    String? sourceContext,
    int? limit,
    int? offset,
  }) async {
    return await _repository.getChatHistory(
      accessToken: accessToken,
      sessionId: sessionId,
      sourceContext: sourceContext,
      limit: limit,
      offset: offset,
    );
  }

  /// One page plus the cursor for the next OLDER page.
  ///
  /// The paginating caller wants this one: [call] above throws the cursor away
  /// and leaves the caller to infer "is there more" from the page length,
  /// which cannot tell "the conversation ends here" from "the server trimmed
  /// the page".
  Future<Either<Failure, ChatHistoryPage<ChatMessageEntity>>> page({
    required String accessToken,
    String? sessionId,
    String? sourceContext,
    int? limit,
    int? offset,
    String? before,
  }) {
    return _repository.getChatHistoryPage(
      accessToken: accessToken,
      sessionId: sessionId,
      sourceContext: sourceContext,
      limit: limit,
      offset: offset,
      before: before,
    );
  }

  /// Report how useful an assistant answer was.
  ///
  /// Lives on the history use case because a rating is a fact ABOUT a stored
  /// message, not a new turn in the conversation — it belongs with the thing
  /// that reads them, not with the thing that sends them.
  Future<void> rateAnswer({
    required int messageId,
    required String rating,
  }) {
    return _repository.rateAnswer(messageId: messageId, rating: rating);
  }
}
