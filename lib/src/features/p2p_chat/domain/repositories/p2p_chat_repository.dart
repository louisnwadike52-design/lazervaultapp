import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/connection_birthday_entity.dart';

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
  Future<List<ConnectionBirthdayEntity>> listConnectionBirthdays({int withinDays = 60});
  Future<List<P2PConversationEntity>> listIncomingRequests({int page = 1, int limit = 20});
  Future<void> acceptRequest(String conversationId);
  Future<void> declineRequest(String conversationId);
  // Per-user list organisation. setArchived toggles this user's archive flag;
  // deleteConversationForMe hides it from this user's lists only (DB row stays).
  Future<void> setArchived(String conversationId, bool archived);
  Future<void> deleteConversationForMe(String conversationId);
  Future<List<Map<String, dynamic>>> searchUsers(String query);
  Future<List<P2PMessageEntity>> getMessages(String conversationId, {int page = 1, int limit = 50});
  /// Cursor pagination (newest-first). [before] loads only messages older than
  /// that timestamp — used for "scroll up to load older" so the initial open is
  /// one small page and the server isn't hammered.
  Future<List<P2PMessageEntity>> getMessagesPage(String conversationId, {int limit = 30, DateTime? before});
  Future<P2PMessageEntity> sendMessage(String conversationId, String content, {String? clientMessageId, String? mediaUrl, String? mediaType, String? replyToMessageId, bool forwarded});
  /// Fast AI draft-reply grounded in the conversation history. When
  /// [targetMessageId] is set, replies specifically to that message using the
  /// prior history as context. Returns the draft.
  Future<String> draftReply(String conversationId, {String? targetMessageId});
  /// Edit a text message's content (allowed within 1 hour of sending).
  Future<P2PMessageEntity> editMessage(String conversationId, String messageId, String content);
  /// Toggle a WhatsApp-style single-per-user reaction; returns the new list.
  Future<List<P2PReaction>> reactToMessage(String conversationId, String messageId, String emoji);
  /// Mark a conversation read. [messageId] is OPTIONAL: pass the last inbound
  /// real (UUID) message id to also advance the read pointer + flip delivery
  /// receipts; omit it (transfer-only threads have no UUID inbound message) to
  /// mark read at the conversation level — the backend zeroes unread_count
  /// either way.
  Future<void> markRead(String conversationId, [String? messageId]);
  Future<int> getUnreadCount();
}
