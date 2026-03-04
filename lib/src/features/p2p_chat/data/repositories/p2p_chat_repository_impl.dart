import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/p2p_chat/data/datasources/p2p_chat_remote_datasource.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';

class P2PChatRepositoryImpl implements P2PChatRepository {
  final P2PChatRemoteDatasource _remoteDatasource;
  final SecureStorageService _secureStorage;

  P2PChatRepositoryImpl({
    required P2PChatRemoteDatasource remoteDatasource,
    required SecureStorageService secureStorage,
  })  : _remoteDatasource = remoteDatasource,
        _secureStorage = secureStorage;

  Future<String> _getToken() async {
    final token = await _secureStorage.getAccessToken();
    if (token == null) throw Exception('Not authenticated');
    return token;
  }

  @override
  Future<P2PConversationEntity> getOrCreateConversation(
    String otherUserId, {
    String? otherUserName,
    String? otherUserAvatar,
    String? myName,
    String? myAvatar,
  }) async {
    final token = await _getToken();
    return _remoteDatasource.getOrCreateConversation(
      otherUserId,
      token,
      otherUserName: otherUserName,
      otherUserAvatar: otherUserAvatar,
      myName: myName,
      myAvatar: myAvatar,
    );
  }

  @override
  Future<List<P2PConversationEntity>> listConversations(
      {int page = 1, int limit = 20}) async {
    final token = await _getToken();
    return _remoteDatasource.listConversations(token,
        page: page, limit: limit);
  }

  @override
  Future<List<P2PConversationEntity>> listConnections(
      {int page = 1, int limit = 20}) async {
    final token = await _getToken();
    return _remoteDatasource.listConnections(token,
        page: page, limit: limit);
  }

  @override
  Future<List<P2PConversationEntity>> listIncomingRequests(
      {int page = 1, int limit = 20}) async {
    final token = await _getToken();
    return _remoteDatasource.listIncomingRequests(token,
        page: page, limit: limit);
  }

  @override
  Future<void> acceptRequest(String conversationId) async {
    final token = await _getToken();
    return _remoteDatasource.acceptRequest(conversationId, token);
  }

  @override
  Future<void> declineRequest(String conversationId) async {
    final token = await _getToken();
    return _remoteDatasource.declineRequest(conversationId, token);
  }

  @override
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    final token = await _getToken();
    return _remoteDatasource.searchUsers(query, token);
  }

  @override
  Future<List<P2PMessageEntity>> getMessages(String conversationId,
      {int page = 1, int limit = 50}) async {
    final token = await _getToken();
    return _remoteDatasource.getMessages(conversationId, token,
        page: page, limit: limit);
  }

  @override
  Future<P2PMessageEntity> sendMessage(String conversationId, String content,
      {String? clientMessageId}) async {
    final token = await _getToken();
    return _remoteDatasource.sendMessage(conversationId, content, token,
        clientMessageId: clientMessageId);
  }

  @override
  Future<void> markRead(String conversationId, String messageId) async {
    final token = await _getToken();
    return _remoteDatasource.markRead(conversationId, messageId, token);
  }

  @override
  Future<int> getUnreadCount() async {
    final token = await _getToken();
    return _remoteDatasource.getUnreadCount(token);
  }
}
