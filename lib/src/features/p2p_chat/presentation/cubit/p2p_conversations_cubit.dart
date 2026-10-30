import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_paged.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/connection_birthday_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_page_store.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';

part 'p2p_conversations_cubit_load.dart';

class P2PConversationsCubit extends Cubit<P2PConversationsState> {
  /// Drop the signed-out user's conversation list.
  ///
  /// A lazy singleton, so without this the next person to sign in on the
  /// device sees the previous user's chat threads — names, last messages and
  /// unread counts — until a refetch replaces them. Of everything a singleton
  /// can leak, a conversation list is among the most plainly private.
  void clearOnLogout() {
    P2PConversationsPageStore.clear();
    if (!isClosed) emit(P2PConversationsInitial());
  }

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

  /// Loads currently between their first fetch and their final emit. A
  /// realtime "connection accepted" nudge that lands meanwhile is queued
  /// ([_nudgeAfterLoad]) instead of starting a nested load that would bump
  /// [_loadSeq] and make the in-flight one drop its own result.
  int _loadsInFlight = 0;
  bool _nudgeAfterLoad = false;

  /// True while THIS cubit is (re)connecting the realtime socket. The server
  /// re-fires `connection_accepted` on connect; that echo must not trigger a
  /// reload of the list the connect is running alongside.
  bool _connectingRealtime = false;

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
      if (m.conversationId == _openConversationId)
        return; // open chat handles it
      _bumpBadge(m.conversationId);
    });
    // A newly accepted/created connection should refresh the requests badge.
    _acceptSub = ws.connectionAcceptedStream.listen((_) {
      // Don't kick a nested load during the cold load — loadConversations()
      // reconnects the WS via _connectRealtime, which re-fires this stream; a
      // nested reload would bump _loadSeq and make the in-flight cold load drop
      // itself (seq check) WITHOUT ever emitting Loaded → the list spins forever.
      if (state is P2PConversationsLoading) return;
      if (_connectingRealtime) return; // our own reconnect's echo
      if (_loadsInFlight > 0) {
        // The list may already be painted from the store while a load runs;
        // let that load finish, then refresh once behind it.
        _nudgeAfterLoad = true;
        return;
      }
      loadConversations(silent: true);
    });
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

  /// Re-sync the signed-in user id before a load. This cubit is a lazy
  /// singleton that survives logout, so after logout→login as a DIFFERENT
  /// user the self-conversation filter and the "my own echo" guard would
  /// otherwise keep using the previous user's id. Local secure-storage read:
  /// fast, and it decides which user's remembered page may be painted.
  Future<void> _refreshCurrentUserId() async {
    try {
      final uid = await _secureStorage?.getUserId();
      if (uid != null && uid.isNotEmpty) _currentUserId = uid;
    } catch (_) {}
  }

  /// Reconnect the realtime WS as the CURRENT user (logout disconnects it, and
  /// the shared `connect()` early-returns when already connected — so this
  /// rebinds it to the new user instead of leaking the previous user's events).
  ///
  /// BOUNDED, never fatal, and never on the list's critical path.
  ///
  /// This was a bare `await ws.connect(token)` BEFORE the list fetches: the
  /// conversation list could not even start loading until a REALTIME socket
  /// finished handshaking. On a weak connection — or any time the socket
  /// stalls rather than fails — the whole screen sat there and ended as
  /// "Request timed out. Try again.", even though the list itself is a plain
  /// HTTP GET that answers in milliseconds.
  ///
  /// Realtime is an enhancement: it makes the list update live. The list does
  /// not need it to EXIST. So it now runs ALONGSIDE the fetches, capped at a
  /// few seconds — a user with no socket sees their conversations and simply
  /// has to pull to refresh, instead of seeing nothing at all.
  Future<void> _connectRealtime() async {
    final ws = _wsService;
    if (ws == null || ws.isConnected) return;
    _connectingRealtime = true;
    try {
      final token = await _secureStorage?.getAccessToken();
      if (token != null && token.isNotEmpty) {
        await ws.connect(token).timeout(
          const Duration(seconds: 4),
          onTimeout: () {
            debugPrint('[p2p] realtime connect timed out — '
                'conversations loaded over HTTP anyway');
          },
        );
      }
    } catch (e) {
      // A socket that refuses must not take the list with it. Logged rather
      // than swallowed silently, because a permanently failing socket is
      // worth seeing in the logs.
      debugPrint('[p2p] realtime connect failed: $e — list still loading');
    } finally {
      _connectingRealtime = false;
    }
  }

  void _bumpBadge(String conversationId) {
    final s = state;
    if (s is! P2PConversationsLoaded) {
      // Already cold-loading → the in-flight load will produce the real numbers;
      // a nested load here would just churn _loadSeq and stall the spinner.
      if (s is! P2PConversationsLoading) {
        loadConversations(); // not populated yet — fetch the real numbers
      }
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
  /// Paints what the app already knows FIRST (the current Loaded state, else
  /// the remembered page from [P2PConversationsPageStore] — which survives a
  /// cold start), then fetches the three lists IN PARALLEL and re-paints each
  /// the moment it arrives. The spinner is reserved for a genuine first load
  /// with nothing remembered.
  ///
  /// [silent]: when the list is already loaded (a refresh — return-from-chat,
  /// badge tap, realtime nudge) do NOT flash the full-screen loading state;
  /// keep the current data on screen and swap it in place once the fetch
  /// completes.
  // ── PAGING ────────────────────────────────────────────────────────────────
  //
  // The server has always returned `total`, `page` and `limit`; the client
  // parsed only the rows, so a user with more than one page of connections
  // could not reach the rest. These fields keep the numbers the server sends.

  /// Rows per request. Larger than the server's default of 20 because a
  /// connections list is cheap to render and the common case should need no
  /// paging at all.
  static const int connectionsPageSize = 50;

  int _loadedPage = 0;
  int _serverTotal = 0;
  bool _loadingMore = false;

  /// The NEXT page, already in flight.
  ///
  /// Prefetched as soon as a page lands, so by the time the user reaches the
  /// bottom the rows are usually in memory and appending is instant. Holding
  /// the Future (rather than the rows) means a scroll that arrives mid-flight
  /// joins the existing request instead of firing a second one.
  Future<P2PPaged<P2PConversationEntity>>? _nextPagePrefetch;

  /// Whether more connections exist on the server than are currently loaded.
  bool get hasMoreConnections =>
      _serverTotal > 0 && _loadedPage * connectionsPageSize < _serverTotal;

  bool get isLoadingMoreConnections => _loadingMore;

  int get totalConnectionCount => _serverTotal;

  /// Kick off the next page without waiting for it. Best-effort: a failed
  /// prefetch must never surface as an error, because the user did not ask for
  /// anything yet — [loadMoreConversations] will simply fetch on demand.
  void _prefetchNextPage() {
    if (!hasMoreConnections || _nextPagePrefetch != null) return;
    final next = _loadedPage + 1;
    _nextPagePrefetch = _repository.listConversationsPaged(
        page: next, limit: connectionsPageSize)
      ..catchError((Object e) {
        debugPrint('P2PConversationsCubit: prefetch of page $next failed: $e');
        _nextPagePrefetch = null;
        return P2PPaged.empty<P2PConversationEntity>();
      });
  }

  /// Append the next page of connections.
  ///
  /// Idempotent while in flight, so the scroll listener can call it freely
  /// without firing duplicate requests — the common failure of
  /// scroll-triggered paging.
  Future<void> loadMoreConversations() async {
    if (_loadingMore || !hasMoreConnections) return;
    final current = state;
    if (current is! P2PConversationsLoaded) return;

    _loadingMore = true;
    _safeEmit(_composeLoaded(
      current.conversations,
      current.incomingRequests,
      unread: current.totalUnread,
      commitPendingReads: false,
      upcomingBirthdays: current.upcomingBirthdays,
    ));

    try {
      final pending = _nextPagePrefetch;
      _nextPagePrefetch = null;
      final paged = pending != null
          ? await pending
          : await _repository.listConversationsPaged(
              page: _loadedPage + 1, limit: connectionsPageSize);

      // A page that comes back empty means the list shrank under us (a
      // connection was removed between pages). Stop rather than loop forever
      // asking for a page that will never arrive.
      if (paged.items.isEmpty) {
        _serverTotal = current.conversations.length;
      } else {
        _loadedPage = paged.page;
        _serverTotal = paged.total;
      }

      // De-duplicate by id. Rows can shift between pages when a conversation
      // is bumped by a new message, which would otherwise show the same person
      // twice — and a duplicate in a list of people you send money to is the
      // kind of glitch that makes someone pay the wrong tile.
      final seen = current.conversations.map((c) => c.id).toSet();
      final merged = <P2PConversationEntity>[
        ...current.conversations,
        ...paged.items.where((c) => seen.add(c.id)),
      ];

      _loadingMore = false;
      final latest = state;
      _safeEmit(_composeLoaded(
        merged,
        latest is P2PConversationsLoaded
            ? latest.incomingRequests
            : current.incomingRequests,
        unread: latest is P2PConversationsLoaded
            ? latest.totalUnread
            : current.totalUnread,
        commitPendingReads: false,
        upcomingBirthdays: latest is P2PConversationsLoaded
            ? latest.upcomingBirthdays
            : current.upcomingBirthdays,
      ));
      _prefetchNextPage();
    } catch (e) {
      _loadingMore = false;
      debugPrint('P2PConversationsCubit: loadMore failed: $e');
      // Keep the rows already on screen; paging failing is not the list
      // failing, so this must not replace a populated list with an error.
      final latest = state;
      if (latest is P2PConversationsLoaded) {
        _safeEmit(_composeLoaded(
          latest.conversations,
          latest.incomingRequests,
          unread: latest.totalUnread,
          commitPendingReads: false,
          upcomingBirthdays: latest.upcomingBirthdays,
        ));
      }
    }
  }

  Future<void> loadConversations({bool silent = false}) async {
    final seq = ++_loadSeq;
    _loadsInFlight++;
    try {
      await _refreshCurrentUserId();
      final me = _currentUserId ?? '';

      // 1. Paint the remembered page when nothing is on screen yet.
      if (state is! P2PConversationsLoaded && me.isNotEmpty) {
        final cached = await P2PConversationsPageStore.hydrate(me);
        if (seq != _loadSeq) return;
        if (cached != null && state is! P2PConversationsLoaded) {
          _safeEmit(_composeLoaded(cached.conversations, cached.requests,
              unread: null, commitPendingReads: false));
        }
      }
      if (!silent && state is! P2PConversationsLoaded) {
        _safeEmit(P2PConversationsLoading());
      }

      // 2. Fetch all three independently AND concurrently; the realtime
      // (re)connect runs alongside and never gates a paint.
      final realtime = _connectRealtime();
      List<P2PConversationEntity>? conversations;
      List<P2PConversationEntity>? requests;
      int? unread;
      String? lastError;

      // Use listConversations (all conversations) instead of listConnections
      // (accepted only) so pending outgoing connections also appear.
      // Future.sync: a repository that throws synchronously must land in
      // the same catchError as one whose Future fails.
      final convF = Future.sync(() => _repository.listConversationsPaged(
          page: 1, limit: connectionsPageSize)).then((paged) {
        // Record the server's own total so the list knows a second page
        // exists, then warm it. A fresh load resets paging: the rows on screen
        // are page one again.
        _loadedPage = paged.page;
        _serverTotal = paged.total;
        _nextPagePrefetch = null;
        conversations = paged.items.cast<P2PConversationEntity>();
        _emitPartial(seq,
            conversations: conversations, requests: requests, unread: unread);
      }).catchError((Object e) {
        lastError = _classifyError(e);
        debugPrint('P2PConversationsCubit: listConversations failed: $e');
      });
      final reqF =
          Future.sync(() => _repository.listIncomingRequests()).then((rows) {
        requests = rows.cast<P2PConversationEntity>();
        _emitPartial(seq,
            conversations: conversations, requests: requests, unread: unread);
      }).catchError((Object e) {
        lastError = _classifyError(e);
        debugPrint('P2PConversationsCubit: listIncomingRequests failed: $e');
      });
      final unreadF = Future.sync(() => _repository.getUnreadCount()).then((n) {
        unread = n;
      }).catchError((Object e) {
        debugPrint('P2PConversationsCubit: getUnreadCount failed: $e');
      });
      await Future.wait([convF, reqF, unreadF]);

      // Drop this response if a newer loadConversations() has since started —
      // prevents a stale count (read before markRead committed) from winning.
      if (seq != _loadSeq) return;

      final shown = state;
      final current = shown is P2PConversationsLoaded ? shown : null;

      // Both data calls failed: an error screen only when there is nothing
      // on screen to keep. A background refresh that fails leaves the list
      // the user is looking at exactly as it is.
      if (conversations == null && requests == null) {
        if (current == null) {
          _safeEmit(P2PConversationsError(
            message: lastError ?? 'Failed to load connections',
          ));
        } else {
          debugPrint('P2PConversationsCubit: refresh failed, keeping shown '
              'list (${lastError ?? 'unknown'})');
        }
        return;
      }

      // Remember what the server said (raw rows) for the next open.
      if (me.isNotEmpty) {
        if (conversations != null) {
          P2PConversationsPageStore.conversations
              .put(conversations!, userId: me);
        }
        if (requests != null) {
          P2PConversationsPageStore.incomingRequests.put(requests!, userId: me);
        }
      }

      _safeEmit(_composeLoaded(
        conversations ?? current?.conversations ?? const [],
        requests ?? current?.incomingRequests ?? const [],
        unread: unread,
        commitPendingReads: true,
      ));

      // Upcoming connection birthdays resolve DOB per connection server-side,
      // so load them AFTER the list is on screen and merge them in when ready
      // — best-effort, never blocking or breaking the connections list.
      _loadUpcomingBirthdays(seq);
      await realtime;
    } finally {
      _loadsInFlight--;
      if (_nudgeAfterLoad && _loadsInFlight == 0) {
        _nudgeAfterLoad = false;
        loadConversations(silent: true);
      }
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
          message: archived
              ? 'Failed to archive chat'
              : 'Failed to unarchive chat'));
    }
  }

  /// Per-user delete: hides the conversation from this user's lists only (the
  /// DB row + history + the other user's view stay). Optimistically removes the
  /// tile, then reconciles with a silent reload.
  Future<void> deleteConversationForMe(String conversationId) async {
    final previousState = state;
    if (previousState is P2PConversationsLoaded) {
      final idx =
          previousState.conversations.indexWhere((c) => c.id == conversationId);
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
