import 'package:dartz/dartz.dart';
import 'package:lazervault/core/utils/pin_mask_utils.dart';
import 'package:lazervault/src/core/errors/failures.dart';
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
  Future<Either<Failure, ChatResponseEntity>> processMessage({
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

      // Build entities map with receipt_data if present (transient, not round-tripped)
      final entities = <String, dynamic>{};
      if (response.receiptData != null) {
        entities['_receipt_data'] = response.receiptData;
      }

      return Right(ChatResponseEntity(
        response: response.response,
        entities: entities,
      ));
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
        // Extract receipt_data from metadata (new location) or entities (legacy)
        // Scrub sensitive keys as defense-in-depth (should already be removed server-side)
        Map<String, dynamic>? metadata;
        final entities = msg.entities;
        entities?.remove('transaction_pin');

        // New: receipt_data is stored in metadata field
        final receiptDataFromMetadata = msg.metadata?['receipt_data'];
        // Legacy: also check entities._receipt_data for backward compatibility
        final receiptDataFromEntities = entities?['_receipt_data'];

        if (receiptDataFromMetadata is Map<String, dynamic>) {
          metadata = {'receipt_data': receiptDataFromMetadata};
        } else if (receiptDataFromEntities is Map<String, dynamic>) {
          metadata = {'receipt_data': receiptDataFromEntities};
        }

        final isUser = msg.role == 'user';
        return MicroserviceChatMessageEntity(
          text: isUser ? maskIfPin(msg.content) : msg.content,
          isUser: isUser,
          timestamp: DateTime.tryParse(msg.timestamp) ?? DateTime.now(),
          serviceRoutedTo: msg.service.isNotEmpty ? msg.service : null,
          mediaType: msg.mediaMetadata?['type'] as String?,
          mediaUrl: msg.mediaMetadata?['url'] as String?,
          metadata: metadata,
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
        // Extract receipt_data from metadata (new location) or entities (legacy)
        // Scrub sensitive keys as defense-in-depth
        Map<String, dynamic>? metadata;
        final entities = msg.entities;
        entities?.remove('transaction_pin');

        // New: receipt_data is stored in metadata field
        final receiptDataFromMetadata = msg.metadata?['receipt_data'];
        // Legacy: also check entities._receipt_data for backward compatibility
        final receiptDataFromEntities = entities?['_receipt_data'];

        if (receiptDataFromMetadata is Map<String, dynamic>) {
          metadata = {'receipt_data': receiptDataFromMetadata};
        } else if (receiptDataFromEntities is Map<String, dynamic>) {
          metadata = {'receipt_data': receiptDataFromEntities};
        }

        final isUser = msg.role == 'user';
        return MicroserviceChatMessageEntity(
          text: isUser ? maskIfPin(msg.content) : msg.content,
          isUser: isUser,
          timestamp: DateTime.tryParse(msg.timestamp) ?? DateTime.now(),
          serviceRoutedTo: msg.service.isNotEmpty ? msg.service : null,
          metadata: metadata,
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
