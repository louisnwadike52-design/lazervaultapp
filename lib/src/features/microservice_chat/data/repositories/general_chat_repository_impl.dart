import 'package:dartz/dartz.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/src/features/microservice_chat/data/datasources/http_general_chat_datasource.dart';

/// Repository for Enhanced Chat Gateway with LLM-based intent classification
///
/// Provides access to:
/// - Intent classification results
/// - Conversation state management
/// - Service switching detection
/// - Multi-service conversation support
abstract class GeneralChatRepository {
  /// Send message through enhanced gateway
  /// Returns GeneralChatResponse with intent classification and conversation state
  Future<Either<Failure, GeneralChatResponse>> sendMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    String sourceContext = 'general',
    String language = 'en',
    Map<String, dynamic> metadata = const {},
  });

  /// Clear conversation state from Redis
  Future<Either<Failure, bool>> clearConversation(String sessionId);

  /// Get current conversation state from Redis
  Future<Either<Failure, ConversationState?>> getConversationState(String sessionId);

  /// Get list of available services from gateway
  Future<Either<Failure, List<String>>> getAvailableServices();
}

class GeneralChatRepositoryImpl implements GeneralChatRepository {
  final GeneralChatDataSource dataSource;

  GeneralChatRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, GeneralChatResponse>> sendMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    String sourceContext = 'general',
    String language = 'en',
    Map<String, dynamic> metadata = const {},
  }) async {
    try {
      final request = GeneralChatRequest(
        message: message,
        sessionId: sessionId,
        userId: userId,
        accessToken: accessToken,
        sourceContext: sourceContext,
        language: language,
        metadata: metadata,
      );

      final response = await dataSource.processChat(request);
      return Right(response);
    } on ChatGatewayException catch (e) {
      return Left(APIFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    } on Exception catch (e) {
      return Left(APIFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> clearConversation(String sessionId) async {
    try {
      final result = await dataSource.clearConversation(sessionId);
      return Right(result);
    } on Exception catch (e) {
      return Left(APIFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ConversationState?>> getConversationState(String sessionId) async {
    try {
      final result = await dataSource.getConversationState(sessionId);
      return Right(result);
    } on Exception catch (e) {
      return Left(APIFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAvailableServices() async {
    try {
      final result = await dataSource.getAvailableServices();
      return Right(result);
    } on Exception catch (e) {
      return Left(APIFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}
