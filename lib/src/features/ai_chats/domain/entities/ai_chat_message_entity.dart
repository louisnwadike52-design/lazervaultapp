import 'package:equatable/equatable.dart';

enum ChatMessageType { text, confirmation, actionCard, image }

class ActionButtonEntity extends Equatable {
  final String label;
  final String actionType;
  final String payload;
  final String? icon;

  const ActionButtonEntity({
    required this.label,
    required this.actionType,
    required this.payload,
    this.icon,
  });

  @override
  List<Object?> get props => [label, actionType, payload, icon];
}

class ConfirmationDataEntity extends Equatable {
  final String actionType;
  final String amount;
  final String currency;
  final String recipientName;
  final String? recipientId;
  final String? description;
  final Map<String, String>? extra;

  const ConfirmationDataEntity({
    required this.actionType,
    required this.amount,
    required this.currency,
    required this.recipientName,
    this.recipientId,
    this.description,
    this.extra,
  });

  @override
  List<Object?> get props => [actionType, amount, currency, recipientName, recipientId, description];
}

class ChatMessageEntity extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final ChatMessageType type;
  final String? intent;
  final Map<String, String>? entities;
  final bool requiresConfirmation;
  final List<ActionButtonEntity>? actionButtons;
  final ConfirmationDataEntity? confirmationData;
  final String? conversationState;
  final String? sessionId;
  final String? mediaType;
  final String? mediaUrl;
  final String? localMediaPath;
  final int? audioDurationMs;
  final String? mime;
  final String? transcript;
  final Map<String, dynamic>? receiptData;
  // ReceiptCard payload(s) (chat_services_shared/receipt_protocol.py). A single
  // dict for one receipt, or a LIST of dicts for a batch transfer — drives the
  // ChatReceiptCardV2 / ChatReceiptCardV2List so batch receipts render in the
  // per-service chat the same way the general chat renders them.
  final dynamic receiptCard;
  // PinPromptIntent payload (chat_services_shared/pin_prompt.py) — drives the
  // inline ChatPinPromptCard so a chat-driven money move collects the PIN in
  // the chat thread instead of telling the user to open a screen.
  final Map<String, dynamic>? pinPrompt;

  const ChatMessageEntity({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.type = ChatMessageType.text,
    this.intent,
    this.entities,
    this.requiresConfirmation = false,
    this.actionButtons,
    this.confirmationData,
    this.conversationState,
    this.sessionId,
    this.mediaType,
    this.mediaUrl,
    this.localMediaPath,
    this.audioDurationMs,
    this.mime,
    this.transcript,
    this.receiptData,
    this.receiptCard,
    this.pinPrompt,
  });

  ChatMessageEntity copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    ChatMessageType? type,
    String? intent,
    Map<String, String>? entities,
    bool? requiresConfirmation,
    List<ActionButtonEntity>? actionButtons,
    ConfirmationDataEntity? confirmationData,
    String? conversationState,
    String? sessionId,
    String? mediaType,
    String? mediaUrl,
    String? localMediaPath,
    int? audioDurationMs,
    String? mime,
    String? transcript,
    Map<String, dynamic>? receiptData,
    dynamic receiptCard,
    Map<String, dynamic>? pinPrompt,
  }) {
    return ChatMessageEntity(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      intent: intent ?? this.intent,
      entities: entities ?? this.entities,
      requiresConfirmation: requiresConfirmation ?? this.requiresConfirmation,
      actionButtons: actionButtons ?? this.actionButtons,
      confirmationData: confirmationData ?? this.confirmationData,
      conversationState: conversationState ?? this.conversationState,
      sessionId: sessionId ?? this.sessionId,
      mediaType: mediaType ?? this.mediaType,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      localMediaPath: localMediaPath ?? this.localMediaPath,
      audioDurationMs: audioDurationMs ?? this.audioDurationMs,
      mime: mime ?? this.mime,
      transcript: transcript ?? this.transcript,
      receiptData: receiptData ?? this.receiptData,
      receiptCard: receiptCard ?? this.receiptCard,
      pinPrompt: pinPrompt ?? this.pinPrompt,
    );
  }

  @override
  List<Object?> get props => [
        text,
        isUser,
        timestamp,
        type,
        intent,
        requiresConfirmation,
        conversationState,
        sessionId,
        mediaType,
        localMediaPath,
        receiptData,
        receiptCard,
        pinPrompt,
      ];
}
