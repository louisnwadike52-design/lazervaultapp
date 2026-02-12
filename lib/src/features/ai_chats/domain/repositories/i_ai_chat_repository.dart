import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
// Import the gRPC response type
import 'package:lazervault/src/generated/ai_chat.pb.dart';
// Import the new domain entity
import '../entities/ai_chat_message_entity.dart';

abstract class IAiChatRepository {
  Future<Either<Failure, ProcessChatResponse>> processChat({
    required String query,
    required String accessToken,
    String? sessionId,
    String? sourceContext,
    String? language,
  });

  // Update return type to use ChatMessageEntity
  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory({
    required String accessToken,
    String? sessionId,
  });
  // Add other methods if needed (e.g., clear chat history on backend?)
} 