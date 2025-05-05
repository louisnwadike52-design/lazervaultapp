import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/generated/ai_chat.pb.dart';
import '../repositories/i_ai_chat_repository.dart';

class ProcessChatUseCase {
  final IAiChatRepository _repository;

  ProcessChatUseCase(this._repository);

  Future<Either<Failure, ProcessChatResponse>> call({
    required String query,
    required String accessToken,
  }) async {
    // Add any business logic before/after calling repository if needed
    return await _repository.processChat(query: query, accessToken: accessToken);
  }
} 