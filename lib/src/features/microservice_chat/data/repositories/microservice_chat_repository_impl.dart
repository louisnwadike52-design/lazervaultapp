import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/http_microservice_chat_datasource.dart';
import '../datasources/http_direct_chat_datasource.dart';
import '../datasources/grpc_direct_chat_datasource.dart';
import '../../domain/entities/chat_response_entity.dart';
import '../../domain/entities/microservice_chat_message_entity.dart';
import '../../domain/repositories/microservice_chat_repository.dart';

class MicroserviceChatRepositoryImpl implements MicroserviceChatRepository {
  final MicroserviceChatDataSource dataSource;
  final GrpcDirectChatDataSource? directDataSource;

  MicroserviceChatRepositoryImpl({
    required this.dataSource,
    this.directDataSource,
  });

  @override
  Future<Either<Failure, String>> processMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    String language = 'en',
    String locale = 'en-NG',
    String? mediaBase64,
    String? mediaType,
    String? mediaMimeType,
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
        mediaBase64: mediaBase64,
        mediaType: mediaType,
        mediaMimeType: mediaMimeType,
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
  Future<Either<Failure, ChatResponseEntity>> processDirectMessage({
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
  }) async {
    try {
      if (directDataSource == null) {
        return Left(ServerFailure(
          message: 'Direct chat datasource not configured',
          statusCode: 500,
        ));
      }

      final request = DirectChatRequest(
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

      final response = await directDataSource!.processDirectChat(request);

      return Right(ChatResponseEntity(
        response: response.response,
        entities: response.entities,
        serviceRoutedTo: response.serviceRoutedTo,
        conversationState: response.conversationState,
      ));
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
          mediaType: msg.mediaMetadata?['type'] as String?,
          mediaUrl: msg.mediaMetadata?['url'] as String?,
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

  @override
  Future<Either<Failure, List<MicroserviceChatMessageEntity>>> getDirectHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
  }) async {
    try {
      if (directDataSource == null) {
        return Left(ServerFailure(
          message: 'Direct chat datasource not configured',
          statusCode: 500,
        ));
      }

      final response = await directDataSource!.getHistory(
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
