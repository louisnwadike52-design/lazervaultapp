import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';

class P2PConversationsCubit extends Cubit<P2PConversationsState> {
  final P2PChatRepository _repository;
  // Shared singleton WS + secure storage let the badge update in REALTIME while
  // no chat page is open (previously it only refreshed on manual reload).
  final P2PChatWebSocketService? _wsService;
  final SecureStorageService? _secureStorage;

  String? _currentUserId;
  String? _openConversationId; // set by P2PChatCubit while a chat is on screen
  StreamSubscription? _msgSub;
  StreamSubscription? _acceptSub;
  StreamSubscription? _typingSub;

  /// Conversation ids where the OTHER participant is currently typing. Exposed
  /// as a ValueNotifier (not Bloc state) so the connections list can show a
  /// "typing…" indicator per row in realtime without churning the whole list
  /// state on every keystroke event. Fed by the shared WS `typingStream` (the
  /// backend broadcasts typing to the peer regardless of which screen they're
  /// on), auto-cleared after a short idle so a missed "stopped" event can't pin
  /// the indicator on.
  final ValueNotifier<Set<String>> typingConversations =
      ValueNotifier<Set<String>>(const {});
  final Set<String> _typingConvIds = {};
  final Map<String, Timer> _typingTimers = {};

  P2PConversationsCubit({
    required P2PChatRepository repository,
    P2PChatWebSocketService? wsService,
    SecureStorageService? secureStorage,
  })  : _repository = repository,
        _wsService = wsService,
        _secureStorage = secureStorage,
        super(P2PConversationsInitial()) {
    _initRealtime();
  }

  // Monotonic token so a slow/stale loadConversations() response (e.g. one
  // issued BEFORE a markRead committed) can never overwrite a newer one — the
  // root cause of the unread badge reverting to its old value after opening a chat.
  int _loadSeq = 0;

  /// Set by P2PChatCubit on open/close so a live message for the conversation
  /// the user is already viewing doesn't double-bump the badge (that chat marks
  /// it read itself).
  void setOpenConversation(String? conversationId) {
    _openConversationId = conversationId;
  }

  /// Global realtime badge: ensure the shared WS is connected and bump the app
  /// badge the instant a message arrives for a conversation that ISN'T open.
  Future<void> _initRealtime() async {
    final ws = _wsService;
    if (ws == null) return;
    try {
      _currentUserId = await _secureStorage?.getUserId();
    } catch (_) {}
    try {
      if (!ws.isConnected) {
        final token = await _secureStorage?.getAccessToken();
        if (token != null && token.isNotEmpty) await ws.connect(token);
      }
    } catch (_) {}
    _msgSub = ws.messageStream.listen((m) {
      if (m.senderId == _currentUserId) return; // my own echo
      if (m.conversationId == _openConversationId) return; // open chat handles it
      _bumpBadge(m.conversationId);
    });
    // A newly accepted/created connection should refresh the requests badge.
    _acceptSub =
        ws.connectionAcceptedStream.listen((_) => loadConversations(silent: true));
    // Peer typing → show "typing…" on that conversation's row in the list.
    _typingSub = ws.typingStream.listen((t) {
      if (t.userId == _currentUserId) return; // ignore my own typing echo
      _onPeerTyping(t.conversationId, t.isTyping);
    });
  }

  /// Update the per-conversation typing indicator from a WS typing event.
  void _onPeerTyping(String conversationId, bool isTyping) {
    _typingTimers.remove(conversationId)?.cancel();
    if (isTyping) {
      _typingConvIds.add(conversationId);
      // Self-heal: if the "stopped typing" frame never arrives, drop it after a
      // short idle so the indicator can't stick on forever.
      _typingTimers[conversationId] = Timer(const Duration(seconds: 5), () {
        _typingConvIds.remove(conversationId);
        _typingTimers.remove(conversationId);
        _publishTyping();
      });
    } else {
      _typingConvIds.remove(conversationId);
    }
    _publishTyping();
  }

  void _publishTyping() {
    if (isClosed) return;
    typingConversations.value = Set<String>.unmodifiable(_typingConvIds);
  }

  /// Re-sync to the CURRENT session before a load. This cubit is a lazy
  /// singleton that survives logout, and the shared WS `connect()` early-returns
  /// when already connected — so after logout→login as a DIFFERENT user we must
  /// (a) refresh the signed-in user id (else the self-conversation filter and
  /// the "my own echo" guard use the previous user's id) and (b) reconnect the
  /// realtime WS with the CURRENT token (logout disconnects it, so this rebinds
  /// it to the new user instead of leaking the previous user's events).
  Future<void> _syncSession() async {
    try {
      final uid = await _secureStorage?.getUserId();
      if (uid != null && uid.isNotEmpty) _currentUserId = uid;
    } catch (_) {}
    final ws = _wsService;
    if (ws != null && !ws.isConnected) {
      try {
        final token = await _secureStorage?.getAccessToken();
        if (token != null && token.isNotEmpty) await ws.connect(token);
      } catch (_) {}
    }
  }

  void _bumpBadge(String conversationId) {
    final s = state;
    if (s is! P2PConversationsLoaded) {
      loadConversations(); // not populated yet — fetch the real numbers
      return;
    }
    final idx = s.conversations.indexWhere((c) => c.id == conversationId);
    // Not in the active list → either a brand-new conversation or a per-user
    // HIDDEN (deleted) one. Reload silently so the aggregate matches the server
    // (which excludes archived + hidden) instead of a blind +1 that would pin a
    // phantom badge for a deleted chat.
    if (idx < 0) {
      loadConversations(silent: true);
      return;
    }
    // Archived chats are decluttered — their unread lives under the Archived
    // pill and must not bump the app-wide badge.
    if (s.conversations[idx].isArchived) return;
    _safeEmit(P2PConversationsLoaded(
      conversations: s.conversations,
      incomingRequests: s.incomingRequests,
      totalUnread: s.totalUnread + 1,
      requestCount: s.requestCount,
    ));
  }

  /// Optimistically remove a just-opened conversation's unread from the app
  /// badge immediately, so the badge drops the instant the user taps in (the
  /// awaited markRead + sequenced refresh then reconcile the exact number).
  void markConversationReadLocally(String conversationId) {
    final s = state;
    if (s is! P2PConversationsLoaded) {
      // List not populated yet (opened from the recipient-tile icon). Remember
      // it so the next load zeroes it instead of showing the stale server count.
      _pendingReads.add(conversationId);
      return;
    }
    int n = 0;
    // Rebuild the conversations list zeroing the just-opened conversation's
    // per-tile unreadCount, so the badge on that tile drops on the next frame
    // (the tile renders from conversation.unreadCount). Previously this only
    // adjusted the aggregate totalUnread, leaving the per-tile badge stale until
    // the awaited markRead + refetch round-trip completed.
    bool wasArchived = false;
    final updated = <P2PConversationEntity>[];
    for (final c in s.conversations) {
      if (c.id == conversationId && c.unreadCount > 0) {
        n = c.unreadCount;
        wasArchived = c.isArchived;
        updated.add(c.copyWith(unreadCount: 0));
      } else {
        updated.add(c);
      }
    }
    if (n <= 0) return;
    // Archived chats' unread is excluded from the aggregate badge, so opening
    // one must NOT decrement totalUnread (only clear its per-tile count).
    final int delta = wasArchived ? 0 : n;
    _safeEmit(P2PConversationsLoaded(
      conversations: updated,
      incomingRequests: s.incomingRequests,
      totalUnread: (s.totalUnread - delta).clamp(0, 1 << 30),
      requestCount: s.requestCount,
    ));
  }

  /// Conversations the user opened before the list was populated (opened
  /// straight from the recipient-tile icon while the singleton was still
  /// Initial). Their unread is zeroed on the next [loadConversations] so the
  /// badge doesn't bounce back to the server's (about-to-be-zeroed) value.
  final Set<String> _pendingReads = {};

  /// Load the conversations list + unread badge.
  ///
  /// [silent]: when the list is already loaded (a refresh — return-from-chat,
  /// badge tap, realtime nudge) do NOT flash the full-screen loading state;
  /// keep the current data on screen and swap it in place once the fetch
  /// completes. Only the very first (cold) load shows the spinner.
  Future<void> loadConversations({bool silent = false}) async {
    final seq = ++_loadSeq;
    // Re-bind to the current session first (refresh user id + reconnect the
    // realtime WS as the current user). Done up-front so it still runs even if
    // every fetch below fails, and so the self-filter uses the right id.
    await _syncSession();
    // Keep the current list visible on refreshes — only blank to a spinner on
    // the first cold load.
    if (!silent && state is! P2PConversationsLoaded) {
      _safeEmit(P2PConversationsLoading());
    }

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

    // Drop this response if a newer loadConversations() has since started —
    // prevents a stale count (read before markRead committed) from winning.
    if (seq != _loadSeq) return;

    // If both data calls failed, show error
    if (failCount >= 2) {
      _safeEmit(P2PConversationsError(
        message: lastError ?? 'Failed to load connections',
      ));
      return;
    }

    var convos = conversations.cast<P2PConversationEntity>();
    var total = unread;

    // Drop nonsensical SELF-conversations (participant1 == participant2 — e.g. a
    // self-transfer that spawned a P2P conversation). Opening a chat with
    // yourself is blocked, so their unread could NEVER be cleared from the UI and
    // would pin a phantom badge forever. Exclude them from the list AND subtract
    // their unread from the aggregate so the badge stays truthful.
    final me = _currentUserId;
    if (me != null && me.isNotEmpty) {
      final selfUnread = convos
          .where((c) => c.otherUserId.trim().isEmpty || c.otherUserId == me)
          .fold<int>(0, (s, c) => s + c.unreadCount);
      if (selfUnread > 0) total = (total - selfUnread).clamp(0, 1 << 30);
      convos = convos
          .where((c) => c.otherUserId.trim().isNotEmpty && c.otherUserId != me)
          .toList();
    }

    // Apply any pending reads (conversations opened before this list existed):
    // zero their per-tile unread and discount them from the server total so a
    // just-read conversation never flashes its old count.
    if (_pendingReads.isNotEmpty) {
      convos = convos.map((c) {
        if (_pendingReads.contains(c.id) && c.unreadCount > 0) {
          total = (total - c.unreadCount).clamp(0, 1 << 30);
          return c.copyWith(unreadCount: 0);
        }
        return c;
      }).toList();
      // Drop pending entries that are no longer unread server-side (reconciled).
      _pendingReads.removeWhere((id) =>
          !convos.any((c) => c.id == id && c.unreadCount > 0));
    }

    _safeEmit(P2PConversationsLoaded(
      conversations: convos,
      incomingRequests: requests.cast(),
      totalUnread: total,
      requestCount: requests.length,
    ));

    // Upcoming connection birthdays resolve DOB per connection server-side, so
    // load them AFTER the list is on screen and merge them in when ready —
    // best-effort, never blocking or breaking the connections list.
    _loadUpcomingBirthdays(seq);
  }

  Future<void> _loadUpcomingBirthdays(int seq) async {
    List birthdays;
    try {
      birthdays = await _repository.listConnectionBirthdays();
    } catch (e) {
      debugPrint('P2PConversationsCubit: listConnectionBirthdays failed: $e');
      return;
    }
    if (seq != _loadSeq || birthdays.isEmpty) return;
    final s = state;
    if (s is P2PConversationsLoaded) {
      _safeEmit(P2PConversationsLoaded(
        conversations: s.conversations,
        incomingRequests: s.incomingRequests,
        totalUnread: s.totalUnread,
        requestCount: s.requestCount,
        upcomingBirthdays: birthdays.cast(),
      ));
    }
  }

  Future<void> refresh() async {
    await loadConversations(silent: true);
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
      await loadConversations(silent: true);
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
      await loadConversations(silent: true);
    } catch (e) {
      if (previousState is P2PConversationsLoaded) {
        _safeEmit(previousState);
      }
      _safeEmit(P2PConversationsError(message: 'Failed to decline request'));
    }
  }

  /// Archive / unarchive a conversation for THIS user (list declutter).
  /// Optimistically flips `isArchived` so it moves between the Chats and
  /// Archived pills instantly, then reconciles with a silent reload.
  Future<void> setArchived(String conversationId, bool archived) async {
    final previousState = state;
    if (previousState is P2PConversationsLoaded) {
      final updated = previousState.conversations
          .map((c) =>
              c.id == conversationId ? c.copyWith(isArchived: archived) : c)
          .toList();
      _safeEmit(P2PConversationsLoaded(
        conversations: updated,
        incomingRequests: previousState.incomingRequests,
        totalUnread: previousState.totalUnread,
        requestCount: previousState.requestCount,
      ));
    }
    try {
      await _repository.setArchived(conversationId, archived);
      await loadConversations(silent: true);
    } catch (e) {
      if (previousState is P2PConversationsLoaded) _safeEmit(previousState);
      _safeEmit(P2PConversationsError(
          message: archived ? 'Failed to archive chat' : 'Failed to unarchive chat'));
    }
  }

  /// Per-user delete: hides the conversation from this user's lists only (the
  /// DB row + history + the other user's view stay). Optimistically removes the
  /// tile, then reconciles with a silent reload.
  Future<void> deleteConversationForMe(String conversationId) async {
    final previousState = state;
    if (previousState is P2PConversationsLoaded) {
      final idx = previousState.conversations
          .indexWhere((c) => c.id == conversationId);
      final removedUnread =
          idx >= 0 ? previousState.conversations[idx].unreadCount : 0;
      final remaining = previousState.conversations
          .where((c) => c.id != conversationId)
          .toList();
      // Keep the aggregate badge honest: subtract the deleted chat's unread.
      final newTotal =
          (previousState.totalUnread - removedUnread).clamp(0, 1 << 30);
      _safeEmit(P2PConversationsLoaded(
        conversations: remaining,
        incomingRequests: previousState.incomingRequests,
        totalUnread: newTotal,
        requestCount: previousState.requestCount,
      ));
    }
    try {
      await _repository.deleteConversationForMe(conversationId);
      await loadConversations(silent: true);
    } catch (e) {
      if (previousState is P2PConversationsLoaded) _safeEmit(previousState);
      _safeEmit(P2PConversationsError(message: 'Failed to delete chat'));
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

  @override
  Future<void> close() {
    _msgSub?.cancel();
    _acceptSub?.cancel();
    _typingSub?.cancel();
    for (final t in _typingTimers.values) {
      t.cancel();
    }
    _typingTimers.clear();
    typingConversations.dispose();
    return super.close();
  }
}
