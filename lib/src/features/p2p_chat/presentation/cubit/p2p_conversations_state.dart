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

  /// Whether the server holds connections beyond the ones in [conversations].
  ///
  /// The list used to show only the first page of 20 with no way to reach the
  /// rest, because the client parsed the rows and discarded the `total` the
  /// server had always sent alongside them.
  final bool hasMore;

  /// True while a NEXT page is in flight. Distinct from the Loading state,
  /// which blanks the screen — appending to a list the user is already reading
  /// must never do that.
  final bool isLoadingMore;

  /// Server-side count across every page, for "showing 20 of 134".
  final int totalConnections;

  P2PConversationsLoaded({
    required this.conversations,
    this.incomingRequests = const [],
    this.totalUnread = 0,
    this.requestCount = 0,
    this.upcomingBirthdays = const [],
    this.hasMore = false,
    this.isLoadingMore = false,
    this.totalConnections = 0,
  });

  @override
  List<Object?> get props => [
        conversations,
        incomingRequests,
        totalUnread,
        requestCount,
        upcomingBirthdays,
        hasMore,
        isLoadingMore,
        totalConnections,
      ];
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
