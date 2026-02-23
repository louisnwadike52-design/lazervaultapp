import 'package:dartz/dartz.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/src/features/microservice_chat/data/datasources/http_general_chat_datasource.dart';
import 'package:lazervault/src/features/microservice_chat/data/repositories/general_chat_repository_impl.dart';

/// Use case for sending messages through Enhanced Chat Gateway
///
/// Returns GeneralChatResponse with:
/// - Intent classification from LLM
/// - Conversation state from Redis
/// - Service switching detection
/// - Routing metadata
abstract class SendGeneralChatMessageUseCase {
  Future<Either<Failure, GeneralChatResponse>> call({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    String sourceContext = 'general',
    String language = 'en',
    String locale = 'en-NG',
    Map<String, dynamic> metadata = const {},
  });
}

class SendGeneralChatMessageUseCaseImpl implements SendGeneralChatMessageUseCase {
  final GeneralChatRepository repository;

  SendGeneralChatMessageUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, GeneralChatResponse>> call({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    String sourceContext = 'general',
    String language = 'en',
    String locale = 'en-NG',
    Map<String, dynamic> metadata = const {},
  }) async {
    return await repository.sendMessage(
      message: message,
      sessionId: sessionId,
      userId: userId,
      accessToken: accessToken,
      sourceContext: sourceContext,
      language: language,
      locale: locale,
      metadata: metadata,
    );
  }
}
