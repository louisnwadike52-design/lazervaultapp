import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/http_microservice_chat_datasource.dart';
import '../../domain/entities/microservice_chat_message_entity.dart';
import '../../domain/repositories/microservice_chat_repository.dart';

class MicroserviceChatRepositoryImpl implements MicroserviceChatRepository {
  final MicroserviceChatDataSource dataSource;

  MicroserviceChatRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, String>> processMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    String language = 'en',
    String locale = 'en-NG',
  }) async {
    try {
      final request = ChatRequest(
        message: message,
        sessionId: sessionId,
        userId: userId,
        accessToken: accessToken,
        sourceContext: sourceContext,
        language: language,
        locale: locale,
      );

      final response = await dataSource.processChat(request);

      return Right(response.response);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  }) async {
    try {
      final response = await dataSource.getHistory(
        sourceContext: sourceContext,
        sessionId: sessionId,
        accessToken: accessToken,
        locale: locale,
      );

      final messages = response.history.map((msg) {
        return MicroserviceChatMessageEntity(
          text: msg.content,
          isUser: msg.role == 'user',
          timestamp: DateTime.tryParse(msg.timestamp) ?? DateTime.now(),
          serviceRoutedTo: msg.service.isNotEmpty ? msg.service : null,
        );
      }).toList();

      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}
