import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/connection_birthday_entity.dart';

// Equatable so Bloc de-dupes emissions: a silent refresh that returns identical
// data re-emits an EQUAL P2PConversationsLoaded, which Bloc skips — so returning
// to the list (e.g. from a chat / image viewer) doesn't rebuild the tiles and
// re-fade the avatars ("P2P pills" flicker). The entities are Equatable too, so
// the list comparison is by value, not reference.
sealed class P2PConversationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class P2PConversationsInitial extends P2PConversationsState {}

class P2PConversationsLoading extends P2PConversationsState {}

class P2PConversationsLoaded extends P2PConversationsState {
  final List<P2PConversationEntity> conversations;
  final List<P2PConversationEntity> incomingRequests;
  final int totalUnread;
  final int requestCount;
  final List<ConnectionBirthdayEntity> upcomingBirthdays;

  P2PConversationsLoaded({
    required this.conversations,
    this.incomingRequests = const [],
    this.totalUnread = 0,
    this.requestCount = 0,
    this.upcomingBirthdays = const [],
  });

  @override
  List<Object?> get props =>
      [conversations, incomingRequests, totalUnread, requestCount, upcomingBirthdays];
}

class P2PConversationsError extends P2PConversationsState {
  final String message;
  P2PConversationsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class P2PUserSearchLoading extends P2PConversationsState {}

class P2PUserSearchResults extends P2PConversationsState {
  final List<Map<String, dynamic>> users;
  P2PUserSearchResults({required this.users});

  @override
  List<Object?> get props => [users];
}
