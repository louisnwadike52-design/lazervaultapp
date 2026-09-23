import 'package:dartz/dartz.dart';
import 'chat_widget_metadata_hydration.dart';
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

        // Same hydration the direct path uses. Previously these two mappers each had
        // their own copy and drifted: this one grew pin_prompt and receipt_card while
        // the direct one kept only the legacy receipt, so per-service chats silently
        // lost both widgets on reload.
        metadata = hydrateChatWidgetMetadata(
          storedMetadata: msg.metadata,
          entities: entities,
        );

        final isUser = msg.role == 'user';
        final mediaType = msg.mediaMetadata?['type'] as String?;
        final mediaUrl = msg.mediaMetadata?['url'] as String?;
        var transcript = msg.mediaMetadata?['transcript'] as String?;

        // Re-render media history just like when it was sent: voice → a playable
        // bubble labelled "Sent a voice note" (the persisted content IS the
        // transcript, which rides inside the player); image → caption or
        // "Sent an image". Plain text stays as-is (PIN-masked for the user).
        String displayText = isUser ? maskIfPin(msg.content) : msg.content;
        if (mediaType == 'voice') {
          transcript ??= msg.content.isNotEmpty ? msg.content : null;
          displayText = 'Sent a voice note';
        } else if (mediaType == 'image') {
          displayText = msg.content.isNotEmpty
              ? (isUser ? maskIfPin(msg.content) : msg.content)
              : 'Sent an image';
        }

        return MicroserviceChatMessageEntity(
          text: displayText,
          isUser: isUser,
          timestamp: DateTime.tryParse(msg.timestamp) ?? DateTime.now(),
          serviceRoutedTo: msg.service.isNotEmpty ? msg.service : null,
          mediaType: mediaType,
          mediaUrl: mediaUrl,
          transcript: transcript,
          metadata: metadata,
        );
      }).toList();

      // A PIN prompt stays in the transcript and is stamped with its outcome, so a
      // completed transfer still shows the card the user approved. Only the latest one
      // remains interactive.
      markSupersededPinPrompts<MicroserviceChatMessageEntity>(
        messages,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );

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

        // Hydrate EVERY renderable widget, not just the legacy receipt.
        //
        // This path used to carry `receipt_data` alone, so a service chat (bills hub and
        // every other service bottom sheet) lost its confirm-transfer card and its V2
        // receipt the moment the user left and came back. The session path hydrated
        // both. One shared function now, because two mappers that must agree and are
        // written separately will diverge again.
        metadata = hydrateChatWidgetMetadata(
          storedMetadata: msg.metadata,
          entities: entities,
        );

        final isUser = msg.role == 'user';
        final mediaType = msg.mediaMetadata?['type'] as String?;
        final mediaUrl = msg.mediaMetadata?['url'] as String?;
        var transcript = msg.mediaMetadata?['transcript'] as String?;

        // Re-render media history just like when it was sent: voice → a playable
        // bubble labelled "Sent a voice note" (the persisted content IS the
        // transcript, which rides inside the player); image → caption or
        // "Sent an image". Plain text stays as-is (PIN-masked for the user).
        String displayText = isUser ? maskIfPin(msg.content) : msg.content;
        if (mediaType == 'voice') {
          transcript ??= msg.content.isNotEmpty ? msg.content : null;
          displayText = 'Sent a voice note';
        } else if (mediaType == 'image') {
          displayText = msg.content.isNotEmpty
              ? (isUser ? maskIfPin(msg.content) : msg.content)
              : 'Sent an image';
        }

        return MicroserviceChatMessageEntity(
          text: displayText,
          isUser: isUser,
          timestamp: DateTime.tryParse(msg.timestamp) ?? DateTime.now(),
          serviceRoutedTo: msg.service.isNotEmpty ? msg.service : null,
          mediaType: mediaType,
          mediaUrl: mediaUrl,
          transcript: transcript,
          metadata: metadata,
        );
      }).toList();

      // A PIN prompt stays in the transcript — it is part of what happened — but an
      // older one must not stay INTERACTIVE, or the auto-opener could raise a secure pad
      // for a transfer already settled. Stamped with its outcome and rendered read-only.
      markSupersededPinPrompts<MicroserviceChatMessageEntity>(
        messages,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );

      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}
