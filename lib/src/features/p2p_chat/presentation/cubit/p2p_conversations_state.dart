import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';

sealed class P2PConversationsState {}

class P2PConversationsInitial extends P2PConversationsState {}

class P2PConversationsLoading extends P2PConversationsState {}

class P2PConversationsLoaded extends P2PConversationsState {
  final List<P2PConversationEntity> conversations;
  final List<P2PConversationEntity> incomingRequests;
  final int totalUnread;
  final int requestCount;

  P2PConversationsLoaded({
    required this.conversations,
    this.incomingRequests = const [],
    this.totalUnread = 0,
    this.requestCount = 0,
  });
}

class P2PConversationsError extends P2PConversationsState {
  final String message;
  P2PConversationsError({required this.message});
}

class P2PUserSearchLoading extends P2PConversationsState {}

class P2PUserSearchResults extends P2PConversationsState {
  final List<Map<String, dynamic>> users;
  P2PUserSearchResults({required this.users});
}
