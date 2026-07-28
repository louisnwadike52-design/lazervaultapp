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

        // PIN-prompt history hydration. The chat-agent-gateway saves
        // `metadata.pin_prompt` alongside `metadata.receipt_data`, but
        // the prior history mapper ignored it — so a PIN flow
        // interrupted by an app restart never re-opened on resume.
        // Stash the raw payload here; a second pass below keeps it
        // only on the LATEST assistant turn (PIN prompts are
        // single-use, so re-emitting on an older message would re-open
        // a modal for a transaction the user already settled).
        final pinPromptFromMetadata = msg.metadata?['pin_prompt'];
        if (pinPromptFromMetadata is Map<String, dynamic>) {
          metadata = (metadata ?? <String, dynamic>{})
            ..['pin_prompt'] = pinPromptFromMetadata;
        }

        // ReceiptCard V2 history hydration (single dict or batch list) so
        // reloaded history renders batch receipts the same as when live.
        final receiptCardFromMetadata = msg.metadata?['receipt_card'];
        if (receiptCardFromMetadata is Map || receiptCardFromMetadata is List) {
          metadata = (metadata ?? <String, dynamic>{})
            ..['receipt_card'] = receiptCardFromMetadata;
        }

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

      // Second pass: PIN prompts are single-use. Strip pin_prompt from
      // every assistant message EXCEPT the most recent one so the
      // bottom sheet only re-appears when the prompt was the last
      // thing the agent said (i.e. genuinely interrupted by an app
      // restart). Receipt cards stay on every message — they're
      // history artifacts, not active CTAs.
      int latestBotIdx = -1;
      for (var i = messages.length - 1; i >= 0; i--) {
        if (!messages[i].isUser) {
          latestBotIdx = i;
          break;
        }
      }
      for (var i = 0; i < messages.length; i++) {
        if (i == latestBotIdx) continue;
        final meta = messages[i].metadata;
        if (meta != null && meta.containsKey('pin_prompt')) {
          meta.remove('pin_prompt');
        }
      }

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

      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}
