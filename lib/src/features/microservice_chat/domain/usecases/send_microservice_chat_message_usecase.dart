import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/microservice_chat_repository.dart';

class SendMicroserviceChatMessageUseCase {
  final MicroserviceChatRepository repository;

  SendMicroserviceChatMessageUseCase({required this.repository});

  Future<Either<Failure, String>> call({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    String language = 'en',
    String locale = 'en-NG',
  }) {
    return repository.processMessage(
      message: message,
      sessionId: sessionId,
      userId: userId,
      accessToken: accessToken,
      sourceContext: sourceContext,
      language: language,
      locale: locale,
    );
  }
}
