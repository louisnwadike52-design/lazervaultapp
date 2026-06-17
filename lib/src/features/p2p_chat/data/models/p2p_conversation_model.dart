import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';

class P2PConversationModel extends P2PConversationEntity {
  const P2PConversationModel({
    required super.id,
    required super.participant1Id,
    required super.participant2Id,
    super.lastMessagePreview,
    super.lastMessageAt,
    required super.createdAt,
    super.unreadCount,
    required super.otherUserId,
    super.otherUserName,
    super.otherUserAvatar,
    super.connectionStatus,
    super.initiatedBy,
  });

  factory P2PConversationModel.fromJson(Map<String, dynamic> json) {
    return P2PConversationModel(
      id: json['id'] as String,
      participant1Id: json['participant1_id'] as String? ?? '',
      participant2Id: json['participant2_id'] as String? ?? '',
      lastMessagePreview: json['last_message_preview'] as String?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      unreadCount: json['unread_count'] as int? ?? 0,
      otherUserId: json['other_user_id'] as String? ?? '',
      otherUserName: json['other_user_name'] as String?,
      otherUserAvatar: json['other_user_avatar'] as String?,
      connectionStatus: json['connection_status'] as String? ?? 'accepted',
      initiatedBy: json['initiated_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant1_id': participant1Id,
      'participant2_id': participant2Id,
      'last_message_preview': lastMessagePreview,
      'last_message_at': lastMessageAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'unread_count': unreadCount,
      'other_user_id': otherUserId,
      'connection_status': connectionStatus,
      'initiated_by': initiatedBy,
    };
  }
}
