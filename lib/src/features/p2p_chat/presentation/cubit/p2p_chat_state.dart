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

  P2PChatLoaded({
    required this.messages,
    required this.conversationId,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.connectionState = P2PChatConnectionState.disconnected,
    this.connectionStatus = 'accepted',
    this.initiatedBy,
    this.canSendMessage = true,
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
    );
  }
}

class P2PChatError extends P2PChatState {
  final String message;
  P2PChatError({required this.message});
}
