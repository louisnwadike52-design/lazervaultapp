part of 'p2p_chat_websocket_service.dart';

/// Typing event from another user
class P2PTypingEvent {
  final String conversationId;
  final String userId;
  final bool isTyping;

  const P2PTypingEvent({
    required this.conversationId,
    required this.userId,
    required this.isTyping,
  });
}

/// Read receipt from another user
class P2PReadReceiptEvent {
  final String conversationId;
  final String userId;
  final String messageId;

  const P2PReadReceiptEvent({
    required this.conversationId,
    required this.userId,
    required this.messageId,
  });
}

/// Delivery status update for a sent message
class P2PDeliveryUpdate {
  final String messageId;
  final String status;

  const P2PDeliveryUpdate({required this.messageId, required this.status});
}

/// Message sent confirmation from the server
class P2PMessageSentConfirmation {
  final String messageId;
  final String clientMessageId;
  final String conversationId;
  final String createdAt;

  const P2PMessageSentConfirmation({
    required this.messageId,
    required this.clientMessageId,
    required this.conversationId,
    required this.createdAt,
  });
}

/// A message's reactions changed (message_id + full reaction list).
class P2PReactionEvent {
  final String conversationId;
  final String messageId;
  final List<P2PReaction> reactions;
  const P2PReactionEvent({
    required this.conversationId,
    required this.messageId,
    required this.reactions,
  });
}

/// An ephemeral floating-emoji burst from the other party.
class P2PEmojiStreamEvent {
  final String conversationId;
  final String emoji;
  final String senderId;
  const P2PEmojiStreamEvent({
    required this.conversationId,
    required this.emoji,
    required this.senderId,
  });
}

/// Connection state for P2P chat WebSocket
enum P2PChatConnectionState { disconnected, connected, reconnecting, error }
