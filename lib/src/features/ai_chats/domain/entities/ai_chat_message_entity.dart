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
      ];
}
