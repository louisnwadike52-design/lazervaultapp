import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';

/// The last conversation list + incoming requests the server gave us, kept
/// across cubit lifetimes AND app launches so Financial Connections paints
/// its first frame from the last answer instead of a spinner.
///
/// Raw server rows are stored (before the self-conversation filter and the
/// pending-read adjustments); the cubit re-applies those on hydrate exactly
/// as it does on a fresh fetch, so the painted list is identical to what a
/// fetch would have produced from the same rows.
class P2PConversationsPageStore {
  P2PConversationsPageStore._();

  static final SessionPageStore<P2PConversationEntity> conversations =
      SessionPageStore<P2PConversationEntity>(
    'p2p_conversations',
    toJson: encode,
    fromJson: decode,
  );

  static final SessionPageStore<P2PConversationEntity> incomingRequests =
      SessionPageStore<P2PConversationEntity>(
    'p2p_incoming_requests',
    toJson: encode,
    fromJson: decode,
  );

  /// Both lists for [userId], from memory or disk. Null when there is nothing
  /// remembered for this user — a genuine cold start.
  static Future<
      ({
        List<P2PConversationEntity> conversations,
        List<P2PConversationEntity> requests
      })?> hydrate(String userId) async {
    if (userId.isEmpty) return null;
    final convos = await conversations.hydrate(userId: userId);
    if (convos == null) return null;
    final requests = await incomingRequests.hydrate(userId: userId) ?? const [];
    return (conversations: convos, requests: requests);
  }

  static void put(
    String userId, {
    required List<P2PConversationEntity> conversations,
    required List<P2PConversationEntity> requests,
  }) {
    if (userId.isEmpty) return;
    P2PConversationsPageStore.conversations.put(conversations, userId: userId);
    incomingRequests.put(requests, userId: userId);
  }

  static void clear() {
    conversations.clear();
    incomingRequests.clear();
  }

  /// Full-fidelity codec. [P2PConversationModel.toJson] drops the display
  /// fields (name, avatar, archive flag) because it is a request payload; a
  /// painted tile needs them, so this one keeps every entity field.
  static Map<String, dynamic> encode(P2PConversationEntity c) => {
        'id': c.id,
        'participant1_id': c.participant1Id,
        'participant2_id': c.participant2Id,
        'last_message_preview': c.lastMessagePreview,
        'last_message_at': c.lastMessageAt?.toIso8601String(),
        'created_at': c.createdAt.toIso8601String(),
        'unread_count': c.unreadCount,
        'other_user_id': c.otherUserId,
        'other_user_name': c.otherUserName,
        'other_user_avatar': c.otherUserAvatar,
        'connection_status': c.connectionStatus,
        'initiated_by': c.initiatedBy,
        'safety_warning': c.safetyWarning,
        'safety_warning_level': c.safetyWarningLevel,
        'safety_warning_reason': c.safetyWarningReason,
        'is_archived': c.isArchived,
      };

  static P2PConversationEntity decode(Map<String, dynamic> j) =>
      P2PConversationEntity(
        id: j['id'] as String? ?? '',
        participant1Id: j['participant1_id'] as String? ?? '',
        participant2Id: j['participant2_id'] as String? ?? '',
        lastMessagePreview: j['last_message_preview'] as String?,
        lastMessageAt: _date(j['last_message_at']),
        createdAt: _date(j['created_at']) ?? DateTime.now(),
        unreadCount: (j['unread_count'] as num?)?.toInt() ?? 0,
        otherUserId: j['other_user_id'] as String? ?? '',
        otherUserName: j['other_user_name'] as String?,
        otherUserAvatar: j['other_user_avatar'] as String?,
        connectionStatus: j['connection_status'] as String? ?? 'accepted',
        initiatedBy: j['initiated_by'] as String?,
        safetyWarning: j['safety_warning'] == true,
        safetyWarningLevel: j['safety_warning_level'] as String?,
        safetyWarningReason: j['safety_warning_reason'] as String?,
        isArchived: j['is_archived'] == true,
      );

  static DateTime? _date(Object? v) =>
      v is String ? DateTime.tryParse(v)?.toLocal() : null;
}
