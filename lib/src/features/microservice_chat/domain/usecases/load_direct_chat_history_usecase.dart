import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
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
}
