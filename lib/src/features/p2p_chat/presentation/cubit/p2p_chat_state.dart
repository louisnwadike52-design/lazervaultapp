import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';

sealed class P2PChatState {}

class P2PChatInitial extends P2PChatState {}

class P2PChatLoading extends P2PChatState {}

class P2PChatLoaded extends P2PChatState {
  final List<P2PMessageEntity> messages;
  final String conversationId;
  final bool hasMore;
  final bool isLoadingMore;
  final P2PChatConnectionState connectionState;
  final String connectionStatus;
  final String? initiatedBy;
  final bool canSendMessage;
  // Fraud-detection ⚠️ flag for the current viewer (counterparty of a flagged
  // sender). Lets the chat page show the banner even when opened directly.
  final bool safetyWarning;
  final String? safetyWarningReason;
  // The message the composer is currently REPLYING to (null = not replying).
  final P2PMessageEntity? replyingTo;
  // The message currently being EDITED (null = not editing).
  final P2PMessageEntity? editingMessage;
  // Message ids currently flashed by the AI "jump to message" feature (empty =
  // none). The bubble renders a transient highlight while its id is in here.
  final Set<String> highlightedMessageIds;

  P2PChatLoaded({
    required this.messages,
    required this.conversationId,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.connectionState = P2PChatConnectionState.disconnected,
    this.connectionStatus = 'accepted',
    this.initiatedBy,
    this.canSendMessage = true,
    this.safetyWarning = false,
    this.safetyWarningReason,
    this.replyingTo,
    this.editingMessage,
    this.highlightedMessageIds = const {},
  });

  P2PChatLoaded copyWith({
    List<P2PMessageEntity>? messages,
    String? conversationId,
    bool? hasMore,
    bool? isLoadingMore,
    P2PChatConnectionState? connectionState,
    String? connectionStatus,
    String? initiatedBy,
    bool? canSendMessage,
    bool? safetyWarning,
    String? safetyWarningReason,
    P2PMessageEntity? replyingTo,
    bool clearReplyingTo = false,
    P2PMessageEntity? editingMessage,
    bool clearEditingMessage = false,
    Set<String>? highlightedMessageIds,
  }) {
    return P2PChatLoaded(
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      connectionState: connectionState ?? this.connectionState,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      initiatedBy: initiatedBy ?? this.initiatedBy,
      canSendMessage: canSendMessage ?? this.canSendMessage,
      safetyWarning: safetyWarning ?? this.safetyWarning,
      safetyWarningReason: safetyWarningReason ?? this.safetyWarningReason,
      replyingTo: clearReplyingTo ? null : (replyingTo ?? this.replyingTo),
      editingMessage:
          clearEditingMessage ? null : (editingMessage ?? this.editingMessage),
      highlightedMessageIds:
          highlightedMessageIds ?? this.highlightedMessageIds,
    );
  }
}

class P2PChatError extends P2PChatState {
  final String message;
  P2PChatError({required this.message});
}
