import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/microservice_chat_message_entity.dart';
import '../repositories/microservice_chat_repository.dart';

class LoadMicroserviceChatHistoryUseCase {
  final MicroserviceChatRepository repository;

  LoadMicroserviceChatHistoryUseCase({required this.repository});

  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> call({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
  }) {
    return repository.getHistory(
      sourceContext: sourceContext,
      sessionId: sessionId,
      accessToken: accessToken,
    );
  }
}
