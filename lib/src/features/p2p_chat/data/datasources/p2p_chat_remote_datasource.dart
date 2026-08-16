import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/src/features/p2p_chat/data/models/p2p_conversation_model.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/connection_birthday_entity.dart';
import 'package:lazervault/src/features/p2p_chat/data/models/p2p_message_model.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';

class P2PChatRemoteDatasource {
  final http.Client _client;
  static const _timeout = Duration(seconds: 15);

  P2PChatRemoteDatasource({http.Client? client})
      : _client = client ?? http.Client();

  void _debugLog(String method, String url, http.Response response) {
    print('P2P_DEBUG [$method $url] status=${response.statusCode} body=${response.body.length > 200 ? response.body.substring(0, 200) : response.body}');
  }

  String get _baseUrl => _resolveHttpBase(
      hostEnv: 'P2P_CHAT_HOST', portEnv: 'P2P_CHAT_PORT', suffix: '/api/v1/chat');

  String get _coreGatewayUrl => _resolveHttpBase(
      hostEnv: 'CORE_GATEWAY_HOST', portEnv: 'CORE_GATEWAY_PORT', suffix: '/api/v1');

  /// Build an HTTP base URL. A dev/local `*_HOST` override uses its own `*_PORT`
  /// (loopback like 8018/7878 → plain http). With NO host override (prod / the
  /// dev tunnel), we MUST follow the tunnel host AND its port together — the old
  /// code kept the tunnel host but defaulted the port to 8018/7878, so prod
  /// dialed `http://api.lazervault.app:8018/…` which the Cloudflare edge never
  /// serves → the request hung and the page span forever.
  String _resolveHttpBase({
    required String hostEnv,
    required String portEnv,
    required String suffix,
  }) {
    final overrideHost = dotenv.env[hostEnv];
    if (overrideHost != null && overrideHost.trim().isNotEmpty) {
      final port = int.tryParse(dotenv.env[portEnv] ?? '') ?? 8018;
      final scheme = port == 443 ? 'https' : 'http';
      final hostPort = port == 443 ? overrideHost : '$overrideHost:$port';
      return '$scheme://$hostPort$suffix';
    }
    // Prod / dev-tunnel: host + port come from the registry TOGETHER (443/https).
    final host = endpointRegistry.grpcHost;
    final port = endpointRegistry.grpcPort;
    final scheme = port == 443 ? 'https' : 'http';
    final hostPort = port == 443 ? host : '$host:$port';
    return '$scheme://$hostPort$suffix';
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
      // Surface the backend's reason (e.g. "cannot create conversation with
      // yourself", "invalid other_user_id") instead of an opaque failure so the
      // cubit can show an actionable message and logs are diagnosable.
      String reason = 'Failed to get/create conversation';
      try {
        final body = _decodeBody(response.body);
        final serverMsg = body['error'];
        if (serverMsg is String && serverMsg.isNotEmpty) reason = serverMsg;
      } catch (_) {}
      throw Exception('$reason (HTTP ${response.statusCode})');
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

  Future<List<ConnectionBirthdayEntity>> listConnectionBirthdays(
      String accessToken,
      {int withinDays = 60}) async {
    final url = '$_baseUrl/connections/birthdays?within_days=$withinDays';
    final response = await _client
        .get(Uri.parse(url), headers: _headers(accessToken))
        .timeout(_timeout);

    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to list connection birthdays');
    }
    final data = _decodeBody(response.body);
    final list = data['birthdays'] as List<dynamic>? ?? [];
    return list
        .map((b) =>
            ConnectionBirthdayEntity.fromJson(b as Map<String, dynamic>))
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

  /// Archive / unarchive a conversation for THIS user only (list declutter).
  Future<void> setArchived(
      String conversationId, bool archived, String accessToken) async {
    final action = archived ? 'archive' : 'unarchive';
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations/$conversationId/$action'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to $action conversation');
    }
  }

  /// Per-user "delete": hides the conversation from this user's lists only. The
  /// conversation + messages + the other user's view remain in the DB.
  Future<void> deleteConversationForMe(
      String conversationId, String accessToken) async {
    final response = await _client
        .delete(
          Uri.parse('$_baseUrl/conversations/$conversationId'),
          headers: _headers(accessToken),
        )
        .timeout(_timeout);

    _checkAuth(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete conversation');
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

  /// Cursor page (newest-first). [before] fetches only messages older than it.
  Future<List<P2PMessageModel>> getMessagesPage(
      String conversationId, String accessToken,
      {int limit = 30, DateTime? before}) async {
    final q = StringBuffer('$_baseUrl/conversations/$conversationId/messages?limit=$limit');
    if (before != null) {
      q.write('&before=${Uri.encodeComponent(before.toUtc().toIso8601String())}');
    }
    final response = await _client
        .get(Uri.parse(q.toString()), headers: _headers(accessToken))
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
      {String? clientMessageId,
      String? mediaUrl,
      String? mediaType,
      String? replyToMessageId,
      bool forwarded = false}) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations/$conversationId/messages'),
          headers: _headers(accessToken),
          body: jsonEncode({
            'content': content,
            if (clientMessageId != null) 'client_message_id': clientMessageId,
            if (mediaUrl != null && mediaUrl.isNotEmpty) 'media_url': mediaUrl,
            if (mediaUrl != null && mediaUrl.isNotEmpty) 'media_type': mediaType,
            if (replyToMessageId != null && replyToMessageId.isNotEmpty)
              'reply_to_message_id': replyToMessageId,
            if (forwarded) 'forwarded': true,
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

  /// Fast AI draft-reply grounded in the conversation history (dedicated
  /// single-LLM endpoint, no agent loop). Returns the drafted reply text.
  Future<String> draftReply(String conversationId, String accessToken,
      {String? targetMessageId}) async {
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations/$conversationId/draft-reply'),
          headers: _headers(accessToken),
          body: jsonEncode({
            if (targetMessageId != null && targetMessageId.isNotEmpty)
              'target_message_id': targetMessageId,
          }),
        )
        .timeout(const Duration(seconds: 30));
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to draft reply');
    }
    final data = _decodeBody(response.body);
    return (data['reply'] ?? '').toString();
  }

  Future<P2PMessageModel> editMessage(String conversationId, String messageId,
      String content, String accessToken) async {
    final response = await _client
        .patch(
          Uri.parse('$_baseUrl/conversations/$conversationId/messages/$messageId'),
          headers: _headers(accessToken),
          body: jsonEncode({'content': content}),
        )
        .timeout(_timeout);

    _checkAuth(response);
    if (response.statusCode == 403) {
      final data = _decodeBody(response.body);
      if (data['code'] == 'EDIT_WINDOW_EXPIRED') {
        throw const HttpException('EDIT_WINDOW_EXPIRED');
      }
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to edit message');
    }
    final data = _decodeBody(response.body);
    return P2PMessageModel.fromJson(data['message'] as Map<String, dynamic>);
  }

  Future<List<P2PReaction>> reactToMessage(String conversationId,
      String messageId, String emoji, String accessToken) async {
    final response = await _client
        .post(
          Uri.parse(
              '$_baseUrl/conversations/$conversationId/messages/$messageId/reactions'),
          headers: _headers(accessToken),
          body: jsonEncode({'emoji': emoji}),
        )
        .timeout(_timeout);

    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to react');
    }
    final data = _decodeBody(response.body);
    final raw = data['reactions'] as List<dynamic>? ?? [];
    return raw
        .map((r) => P2PReaction.fromJson(r as Map<String, dynamic>))
        .toList();
  }

  Future<void> markRead(
      String conversationId, String? messageId, String accessToken) async {
    // message_id is OPTIONAL — omit it for a conversation-level read (the
    // backend zeroes unread_count regardless). Sending an empty/non-UUID id
    // would 400 on the server's uuid.Parse, which is exactly what left
    // transfer-only threads perpetually "unread".
    final response = await _client
        .post(
          Uri.parse('$_baseUrl/conversations/$conversationId/read'),
          headers: _headers(accessToken),
          body: jsonEncode({
            if (messageId != null && messageId.isNotEmpty)
              'message_id': messageId,
          }),
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
