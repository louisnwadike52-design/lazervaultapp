import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/http_microservice_chat_datasource.dart';
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
  }) async {
    try {
      final request = ChatRequest(
        message: message,
        sessionId: sessionId,
        userId: userId,
        accessToken: accessToken,
        sourceContext: sourceContext,
        language: language,
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
}
