import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/src/features/p2p_chat/data/models/p2p_conversation_model.dart';
import 'package:lazervault/src/features/p2p_chat/data/models/p2p_message_model.dart';

class P2PChatRemoteDatasource {
  final http.Client _client;
  static const _timeout = Duration(seconds: 15);

  P2PChatRemoteDatasource({http.Client? client})
      : _client = client ?? http.Client();

  void _debugLog(String method, String url, http.Response response) {
    print('P2P_DEBUG [$method $url] status=${response.statusCode} body=${response.body.length > 200 ? response.body.substring(0, 200) : response.body}');
  }

  String get _baseUrl {
    final host = dotenv.env['P2P_CHAT_HOST'] ?? '10.0.2.2';
    final port = dotenv.env['P2P_CHAT_PORT'] ?? '8018';
    return 'http://$host:$port/api/v1/chat';
  }

  String get _coreGatewayUrl {
    final host = dotenv.env['CORE_GATEWAY_HOST'] ?? '10.0.2.2';
    final port = dotenv.env['CORE_GATEWAY_PORT'] ?? '7878';
    return 'http://$host:$port/api/v1';
  }

  Map<String, String> _headers(String accessToken) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

  Future<P2PConversationModel> getOrCreateConversation(
    String otherUserId,
    String accessToken, {
    String? otherUserName,
    String? otherUserAvatar,
    String? myName,
    String? myAvatar,
    bool isSavedRecipient = false,
  }) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations'),
          headers: _headers(accessToken),
          body: jsonEncode({
            'other_user_id': otherUserId,
            if (otherUserName != null) 'other_user_name': otherUserName,
            if (otherUserAvatar != null) 'other_user_avatar': otherUserAvatar,
            if (myName != null) 'my_name': myName,
            if (myAvatar != null) 'my_avatar': myAvatar,
            if (isSavedRecipient) 'is_saved_recipient': true,
          }),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to get/create conversation');
    }

    final data = _decodeBody(response.body);
    return P2PConversationModel.fromJson(
        data['conversation'] as Map<String, dynamic>);
  }

  Future<List<P2PConversationModel>> listConversations(String accessToken,
      {int page = 1, int limit = 20}) async {
    final response = await _client
        .get(
          Uri.parse('$_baseUrl/conversations?page=$page&limit=$limit'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to list conversations');
    }

    final data = _decodeBody(response.body);
    final conversations = data['conversations'] as List<dynamic>? ?? [];
    return conversations
        .map((c) => P2PConversationModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  Future<List<P2PConversationModel>> listConnections(String accessToken,
      {int page = 1, int limit = 20}) async {
    final url = '$_baseUrl/connections?page=$page&limit=$limit';
    print('P2P_DEBUG listConnections: url=$url token_len=${accessToken.length} token_prefix=${accessToken.substring(0, accessToken.length > 30 ? 30 : accessToken.length)}');
    final response = await _client
        .get(
          Uri.parse(url),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _debugLog('GET', url, response);
    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to list connections');
    }

    final data = _decodeBody(response.body);
    final conversations = data['conversations'] as List<dynamic>? ?? [];
    return conversations
        .map((c) => P2PConversationModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  Future<List<P2PConversationModel>> listIncomingRequests(String accessToken,
      {int page = 1, int limit = 20}) async {
    final response = await _client
        .get(
          Uri.parse('$_baseUrl/requests?page=$page&limit=$limit'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to list requests');
    }

    final data = _decodeBody(response.body);
    final conversations = data['conversations'] as List<dynamic>? ?? [];
    return conversations
        .map((c) => P2PConversationModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  Future<void> acceptRequest(String conversationId, String accessToken) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/requests/$conversationId/accept'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to accept request');
    }
  }

  Future<void> declineRequest(
      String conversationId, String accessToken) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/requests/$conversationId/decline'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to decline request');
    }
  }

  Future<List<Map<String, dynamic>>> searchUsers(
      String query, String accessToken) async {
    final response = await _client
        .get(
          Uri.parse(
              '$_coreGatewayUrl/auth/search/users?query=${Uri.encodeComponent(query)}'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to search users');
    }

    final data = _decodeBody(response.body);
    final users = data['users'] as List<dynamic>? ?? [];
    return users.cast<Map<String, dynamic>>();
  }

  Future<List<P2PMessageModel>> getMessages(
      String conversationId, String accessToken,
      {int page = 1, int limit = 50}) async {
    final response = await _client
        .get(
          Uri.parse(
              '$_baseUrl/conversations/$conversationId/messages?page=$page&limit=$limit'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to get messages');
    }

    final data = _decodeBody(response.body);
    final messages = data['messages'] as List<dynamic>? ?? [];
    return messages
        .map((m) => P2PMessageModel.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<P2PMessageModel> sendMessage(
      String conversationId, String content, String accessToken,
      {String? clientMessageId}) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations/$conversationId/messages'),
          headers: _headers(accessToken),
          body: jsonEncode({
            'content': content,
            if (clientMessageId != null) 'client_message_id': clientMessageId,
          }),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode == 403) {
      final data = _decodeBody(response.body);
      if (data['code'] == 'CONNECTION_PENDING') {
        throw const HttpException('CONNECTION_PENDING');
      }
    }

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to send message');
    }

    final data = _decodeBody(response.body);
    return P2PMessageModel.fromJson(data['message'] as Map<String, dynamic>);
  }

  Future<void> markRead(
      String conversationId, String messageId, String accessToken) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations/$conversationId/read'),
          headers: _headers(accessToken),
          body: jsonEncode({'message_id': messageId}),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to mark read');
    }
  }

  Future<int> getUnreadCount(String accessToken) async {
    final response = await _client
        .get(
          Uri.parse('$_baseUrl/unread'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to get unread count');
    }

    final data = _decodeBody(response.body);
    return data['unread_count'] as int? ?? 0;
  }

  /// Decode JSON body with error handling.
  Map<String, dynamic> _decodeBody(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } on FormatException {
      throw Exception('Invalid server response');
    }
  }

  /// Check for 401 and throw a specific error so callers can handle token refresh.
  void _checkAuth(http.Response response) {
    if (response.statusCode == 401) {
      throw const HttpException('Unauthorized');
    }
  }
}
