import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/ai_chat.pbgrpc.dart';

abstract class IAiChatDataSource {
  Future<dynamic> processChat({
    required String query,
    String? sessionId,
    String? sourceContext,
    String? language,
  });
  Future<dynamic> getChatHistory({String? sessionId, String? sourceContext});
}

class GrpcAiChatDataSource implements IAiChatDataSource {
  final AIChatServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  GrpcAiChatDataSource({
    required AIChatServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  }) : _client = client,
       _callOptionsHelper = callOptionsHelper;

  @override
  Future<ProcessChatResponse> processChat({
    required String query,
    String? sessionId,
    String? sourceContext,
    String? language,
  }) async {
    final request = ProcessChatRequest()..query = query;
    if (sessionId != null) request.sessionId = sessionId;
    if (sourceContext != null) request.sourceContext = sourceContext;
    if (language != null) request.language = language;

    // Populate account context fields explicitly (also sent via gRPC metadata)
    final accountId = _callOptionsHelper.accountManager?.activeAccountId;
    if (accountId != null && accountId.isNotEmpty) {
      request.accountId = accountId;
    }
    final country = _callOptionsHelper.localeManager?.currentCountry;
    if (country != null && country.isNotEmpty) {
      request.userCountry = country;
    }
    final currency = _callOptionsHelper.localeManager?.currentCurrency;
    if (currency != null && currency.isNotEmpty) {
      request.currency = currency;
    }

    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.processChat(
        request,
        options: callOptions,
      );
      return response;
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to communicate with AI service'}');
    } catch (e) {
      throw Exception('An unexpected error occurred calling AI service.');
    }
  }

  @override
  Future<GetAIChatHistoryResponse> getChatHistory({String? sessionId, String? sourceContext}) async {
    final request = GetAIChatHistoryRequest();
    // Note: Session ID is tracked server-side, so we don't need to send it for gRPC
    // The server extracts the user ID from the JWT token
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getAIChatHistory(
        request,
        options: callOptions,
      );
      return response;
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get chat history'}');
    } catch (e) {
      throw Exception('An unexpected error occurred fetching chat history.');
    }
  }
}
