import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/generated/ai_chat.pb.dart';
import '../../domain/repositories/i_ai_chat_repository.dart';
import '../datasources/grpc_ai_chat_service.dart'; // Assuming interface is defined here
import '../../domain/entities/ai_chat_message_entity.dart';

class AiChatRepositoryImpl implements IAiChatRepository {
  final IAiChatDataSource _dataSource;

  AiChatRepositoryImpl({required IAiChatDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<Failure, ProcessChatResponse>> processChat({
    required String query,
    required String accessToken
  }) async {
    try {
      final response = await _dataSource.processChat(query: query);
      // Optional: Check response.success here if needed, but often handled in Cubit/UI
      return Right(response);
    } catch (e) {
      // Catch exceptions from the data source and map to Failure
      print('Caught error in AiChatRepositoryImpl: $e');
      return Left(Failure(message: e.toString(), statusCode: 500)); // Adjust status code if possible
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory({
    required String accessToken
  }) async {
    try {
      final response = await _dataSource.getChatHistory();
      // Map proto entries to ChatMessageEntity
      final chatEntities = response.history.expand((entry) {
        // Convert timestamp string (assuming RFC3339) to DateTime
        // Handle potential parsing errors
        DateTime timestamp; 
        try {
          timestamp = DateTime.parse(entry.timestamp).toLocal();
        } catch(_) {
          timestamp = DateTime.now(); // Fallback timestamp
        }

        return [
          // User Query
          ChatMessageEntity(
             text: entry.query,
             isUser: true, 
             timestamp: timestamp, // Use parsed or fallback timestamp
             // image: null // Assuming history doesn't store images
          ),
          // AI Response
          ChatMessageEntity(
             text: entry.response,
             isUser: false,
             timestamp: timestamp.add(const Duration(seconds: 1)), // Add slight delay for sorting
             // image: null
          ),
        ];
      }).toList();

      // Sort by timestamp (important if mapping added delays)
      chatEntities.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      return Right(chatEntities);
    } catch (e) {
      print('Caught error in AiChatRepositoryImpl getChatHistory: $e');
      return Left(Failure(message: e.toString(), statusCode: 500)); 
    }
  }
} 