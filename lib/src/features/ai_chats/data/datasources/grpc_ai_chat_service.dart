import 'package:grpc/grpc.dart';
// Assuming your generated proto files are in a 'pb' directory relative to lib
// Adjust the import path based on your actual project structure
import 'package:lazervault/src/generated/ai_chat.pbgrpc.dart'; 

// Define an abstract class for the data source
abstract class IAiChatDataSource {
  Future<ProcessChatResponse> processChat({required String query, required String accessToken});
  Future<GetAIChatHistoryResponse> getChatHistory({required String accessToken});
}

// Implementation using gRPC
class GrpcAiChatDataSource implements IAiChatDataSource {
  final AIChatServiceClient _client;

  // Accept the client via constructor (injected by GetIt)
  GrpcAiChatDataSource({required AIChatServiceClient client}) : _client = client;

  CallOptions _getAuthOptions(String accessToken) =>
      CallOptions(metadata: {'authorization': 'Bearer $accessToken'});

  @override
  Future<ProcessChatResponse> processChat({required String query, required String accessToken}) async {
    final request = ProcessChatRequest()..query = query;
    try {
      print("Sending ProcessChat request with query: $query and token: $accessToken");
      final response = await _client.processChat(
        request,
        options: _getAuthOptions(accessToken), // Pass options with token
      );
       print("Received ProcessChat response: ${response.success} - ${response.msg}");
      return response;
    } on GrpcError catch (e) {
      print('gRPC Error calling ProcessChat: $e');
      // Let the repository handle mapping to Failure
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to communicate with AI service'}'); 
    } catch (e) {
      print('Unexpected error calling ProcessChat: $e');
      throw Exception('An unexpected error occurred calling AI service.');
    }
  }

  @override
  Future<GetAIChatHistoryResponse> getChatHistory({required String accessToken}) async {
    final request = GetAIChatHistoryRequest(); // Empty request
    try {
      print("Sending GetAIChatHistory request with token: $accessToken");
      final response = await _client.getAIChatHistory(
        request,
        options: _getAuthOptions(accessToken),
      );
      print("Received GetAIChatHistory response with ${response.history.length} entries.");
      return response;
    } on GrpcError catch (e) {
      print('gRPC Error calling GetAIChatHistory: $e');
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get chat history'}'); 
    } catch (e) {
      print('Unexpected error calling GetAIChatHistory: $e');
      throw Exception('An unexpected error occurred fetching chat history.');
    }
  }

  // Remove channel management, GetIt handles client lifecycle
  // Future<void> shutdown() async {
  //   await _channel.shutdown();
  // }
} 