import 'package:dartz/dartz.dart';
import 'package:lazervault/core/chat/chat_history_page.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/microservice_chat_message_entity.dart';
import '../repositories/microservice_chat_repository.dart';

class LoadDirectChatHistoryUseCase {
  final MicroserviceChatRepository repository;

  LoadDirectChatHistoryUseCase({required this.repository});

  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> call({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  }) {
    return repository.getDirectHistory(
      sourceContext: sourceContext,
      sessionId: sessionId,
      accessToken: accessToken,
      locale: locale,
    );
  }

  /// One page plus the cursor for the next OLDER page.
  ///
  /// [call] above throws the cursor away and leaves the caller to infer "is
  /// there more" from the page length, which cannot tell "the conversation
  /// ends here" from "the server trimmed the page". A paginating caller wants
  /// this one.
  Future<Either<Failure, ChatHistoryPage<MicroserviceChatMessageEntity>>> page({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
    int limit = 30,
    String? before,
  }) {
    return repository.getDirectHistoryPage(
      sourceContext: sourceContext,
      sessionId: sessionId,
      accessToken: accessToken,
      locale: locale,
      limit: limit,
      before: before,
    );
  }
}
