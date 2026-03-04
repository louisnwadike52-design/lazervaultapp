import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';

class P2PConversationsCubit extends Cubit<P2PConversationsState> {
  final P2PChatRepository _repository;

  P2PConversationsCubit({required P2PChatRepository repository})
      : _repository = repository,
        super(P2PConversationsInitial());

  Future<void> loadConversations() async {
    _safeEmit(P2PConversationsLoading());

    // Fetch all three independently so partial failure doesn't lose everything
    List conversations = [];
    List requests = [];
    int unread = 0;
    int failCount = 0;
    String? lastError;

    try {
      // Use listConversations (all conversations) instead of listConnections (accepted only)
      // so pending outgoing connections also appear in the list
      conversations = await _repository.listConversations();
    } catch (e) {
      failCount++;
      lastError = _classifyError(e);
      debugPrint('P2PConversationsCubit: listConversations failed: $e');
    }

    try {
      requests = await _repository.listIncomingRequests();
    } catch (e) {
      failCount++;
      lastError = _classifyError(e);
      debugPrint('P2PConversationsCubit: listIncomingRequests failed: $e');
    }

    try {
      unread = await _repository.getUnreadCount();
    } catch (e) {
      debugPrint('P2PConversationsCubit: getUnreadCount failed: $e');
    }

    // If both data calls failed, show error
    if (failCount >= 2) {
      _safeEmit(P2PConversationsError(
        message: lastError ?? 'Failed to load connections',
      ));
      return;
    }

    _safeEmit(P2PConversationsLoaded(
      conversations: conversations.cast(),
      incomingRequests: requests.cast(),
      totalUnread: unread,
      requestCount: requests.length,
    ));
  }

  Future<void> refresh() async {
    await loadConversations();
  }

  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      await loadConversations();
      return;
    }

    _safeEmit(P2PUserSearchLoading());

    try {
      final users = await _repository.searchUsers(query);
      _safeEmit(P2PUserSearchResults(users: users));
    } catch (e) {
      debugPrint('P2PConversationsCubit: searchUsers failed: $e');
      _safeEmit(P2PConversationsError(message: 'Search failed'));
    }
  }

  Future<void> acceptRequest(String conversationId) async {
    final previousState = state;
    try {
      await _repository.acceptRequest(conversationId);
      await loadConversations();
    } catch (e) {
      if (previousState is P2PConversationsLoaded) {
        _safeEmit(previousState);
      }
      _safeEmit(P2PConversationsError(message: 'Failed to accept request'));
    }
  }

  Future<void> declineRequest(String conversationId) async {
    final previousState = state;
    try {
      await _repository.declineRequest(conversationId);
      await loadConversations();
    } catch (e) {
      if (previousState is P2PConversationsLoaded) {
        _safeEmit(previousState);
      }
      _safeEmit(P2PConversationsError(message: 'Failed to decline request'));
    }
  }

  String _classifyError(Object e) {
    if (e is HttpException && e.message == 'Unauthorized') {
      return 'Session expired. Please log in again.';
    }
    if (e.toString().contains('Not authenticated')) {
      return 'Not authenticated. Please log in.';
    }
    if (e.toString().contains('SocketException') ||
        e.toString().contains('Connection refused')) {
      return 'Cannot reach chat server. Check your connection.';
    }
    if (e.toString().contains('TimeoutException')) {
      return 'Request timed out. Try again.';
    }
    return 'Failed to load connections';
  }

  void _safeEmit(P2PConversationsState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }
}
