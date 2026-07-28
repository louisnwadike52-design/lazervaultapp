import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';

class P2PMessageModel extends P2PMessageEntity {
  const P2PMessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.messageType,
    super.content,
    super.mediaUrl,
    super.mediaType,
    super.localMediaPath,
    super.transferRef,
    super.transferAmount,
    super.transferCurrency,
    super.transferStatus,
    required super.deliveryStatus,
    super.clientMessageId,
    required super.createdAt,
    super.replyToMessageId,
    super.replyToContent,
    super.replyToSenderId,
    super.editedAt,
    super.reactions,
    super.forwarded,
  });

  factory P2PMessageModel.fromJson(Map<String, dynamic> json) {
    final rawReactions = json['reactions'];
    final reactions = <P2PReaction>[];
    if (rawReactions is List) {
      for (final r in rawReactions) {
        if (r is Map<String, dynamic>) reactions.add(P2PReaction.fromJson(r));
      }
    }
    return P2PMessageModel(
      id: json['id'] as String? ?? '',
      conversationId: json['conversation_id'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
      messageType: json['message_type'] as String? ?? 'text',
      content: json['content'] as String?,
      mediaUrl: json['media_url'] as String?,
      mediaType: json['media_type'] as String?,
      transferRef: json['transfer_ref'] as String?,
      transferAmount: json['transfer_amount'] as int?,
      transferCurrency: json['transfer_currency'] as String?,
      transferStatus: json['transfer_status'] as String?,
      deliveryStatus: json['delivery_status'] as String? ?? 'sent',
      clientMessageId: json['client_message_id'] as String?,
      // Server timestamps are UTC (RFC3339). Normalize to LOCAL at the parse
      // boundary so every render (HH:mm bubble, date separators, day-grouping)
      // shows the user's own timezone AND matches the optimistic DateTime.now()
      // (local) bubble — otherwise a just-sent message shows local time then
      // "jumps" to UTC after reload. .toLocal() preserves the absolute instant.
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String).toLocal()
          : DateTime.now(),
      replyToMessageId: json['reply_to_message_id'] as String?,
      replyToContent: json['reply_to_content'] as String?,
      replyToSenderId: json['reply_to_sender_id'] as String?,
      editedAt: json['edited_at'] != null
          ? DateTime.tryParse(json['edited_at'] as String)?.toLocal()
          : null,
      reactions: reactions,
      forwarded: json['forwarded'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'message_type': messageType,
      'content': content,
      'media_url': mediaUrl,
      'media_type': mediaType,
      'transfer_ref': transferRef,
      'transfer_amount': transferAmount,
      'transfer_currency': transferCurrency,
      'transfer_status': transferStatus,
      'delivery_status': deliveryStatus,
      'client_message_id': clientMessageId,
      'created_at': createdAt.toIso8601String(),
      'reply_to_message_id': replyToMessageId,
      'reply_to_content': replyToContent,
      'reply_to_sender_id': replyToSenderId,
      'edited_at': editedAt?.toIso8601String(),
      'reactions': reactions.map((r) => r.toJson()).toList(),
    };
  }
}
