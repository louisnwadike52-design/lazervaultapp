import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_response_entity.dart';
import '../repositories/microservice_chat_repository.dart';

class SendDirectChatMessageUseCase {
  final MicroserviceChatRepository repository;

  SendDirectChatMessageUseCase({required this.repository});

  Future<Either<Failure, ChatResponseEntity>> call({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    required Map<String, dynamic> entities,
    String accountId = '',
    String userCountry = '',
    String currency = '',
    String language = 'en',
    String locale = 'en-NG',
    String responseStyleInstruction = '',
  }) {
    return repository.processDirectMessage(
      message: message,
      sessionId: sessionId,
      userId: userId,
      accessToken: accessToken,
      sourceContext: sourceContext,
      entities: entities,
      accountId: accountId,
      userCountry: userCountry,
      currency: currency,
      language: language,
      locale: locale,
      responseStyleInstruction: responseStyleInstruction,
    );
  }
}
