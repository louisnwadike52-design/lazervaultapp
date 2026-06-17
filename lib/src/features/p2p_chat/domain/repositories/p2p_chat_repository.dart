import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';

abstract class P2PChatRepository {
  Future<P2PConversationEntity> getOrCreateConversation(
    String otherUserId, {
    String? otherUserName,
    String? otherUserAvatar,
    String? myName,
    String? myAvatar,
    bool isSavedRecipient = false,
  });
  Future<List<P2PConversationEntity>> listConversations({int page = 1, int limit = 20});
  Future<List<P2PConversationEntity>> listConnections({int page = 1, int limit = 20});
  Future<List<P2PConversationEntity>> listIncomingRequests({int page = 1, int limit = 20});
  Future<void> acceptRequest(String conversationId);
  Future<void> declineRequest(String conversationId);
  Future<List<Map<String, dynamic>>> searchUsers(String query);
  Future<List<P2PMessageEntity>> getMessages(String conversationId, {int page = 1, int limit = 50});
  Future<P2PMessageEntity> sendMessage(String conversationId, String content, {String? clientMessageId});
  Future<void> markRead(String conversationId, String messageId);
  Future<int> getUnreadCount();
}
