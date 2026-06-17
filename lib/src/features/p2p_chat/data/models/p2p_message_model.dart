import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';

class P2PMessageModel extends P2PMessageEntity {
  const P2PMessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.messageType,
    super.content,
    super.transferRef,
    super.transferAmount,
    super.transferCurrency,
    super.transferStatus,
    required super.deliveryStatus,
    super.clientMessageId,
    required super.createdAt,
  });

  factory P2PMessageModel.fromJson(Map<String, dynamic> json) {
    return P2PMessageModel(
      id: json['id'] as String? ?? '',
      conversationId: json['conversation_id'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
      messageType: json['message_type'] as String? ?? 'text',
      content: json['content'] as String?,
      transferRef: json['transfer_ref'] as String?,
      transferAmount: json['transfer_amount'] as int?,
      transferCurrency: json['transfer_currency'] as String?,
      transferStatus: json['transfer_status'] as String?,
      deliveryStatus: json['delivery_status'] as String? ?? 'sent',
      clientMessageId: json['client_message_id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'message_type': messageType,
      'content': content,
      'transfer_ref': transferRef,
      'transfer_amount': transferAmount,
      'transfer_currency': transferCurrency,
      'transfer_status': transferStatus,
      'delivery_status': deliveryStatus,
      'client_message_id': clientMessageId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
