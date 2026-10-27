part of 'p2p_conversations_cubit.dart';

/// The pure parts of [P2PConversationsCubit.loadConversations]: turning raw
/// server rows (or remembered rows) into the state the list paints from.
///
/// Lives in a part so the cubit file stays readable; it shares the library's
/// private scope, so nothing here is public API.
extension _P2PConversationsLoadHelpers on P2PConversationsCubit {
  /// Compose the Loaded state from raw rows, applying the SAME rules a fetch
  /// always applied: drop self-conversations (and discount their unread),
  /// zero conversations the user already opened ([_pendingReads]).
  ///
  /// [unread] is the server's aggregate when it has arrived. Until then the
  /// badge shows the sum of the visible, non-archived tiles — the same
  /// quantity the server computes — so the list never waits on the slowest
  /// call to paint. [commitPendingReads] prunes reconciled pending entries;
  /// only the final emit of a load does that.
  P2PConversationsLoaded _composeLoaded(
    List<P2PConversationEntity> conversations,
    List<P2PConversationEntity> requests, {
    required int? unread,
    required bool commitPendingReads,
    List<ConnectionBirthdayEntity> upcomingBirthdays = const [],
  }) {
    var convos = List<P2PConversationEntity>.from(conversations);
    var total = unread ?? _provisionalUnread(convos);

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

    if (_pendingReads.isNotEmpty) {
      convos = convos.map((c) {
        if (_pendingReads.contains(c.id) && c.unreadCount > 0) {
          total = (total - c.unreadCount).clamp(0, 1 << 30);
          return c.copyWith(unreadCount: 0);
        }
        return c;
      }).toList();
      if (commitPendingReads) {
        _pendingReads.removeWhere(
            (id) => !convos.any((c) => c.id == id && c.unreadCount > 0));
      }
    }

    return P2PConversationsLoaded(
      conversations: convos,
      incomingRequests: requests,
      totalUnread: total,
      requestCount: requests.length,
      upcomingBirthdays: upcomingBirthdays,
    );
  }

  /// What the aggregate badge would be from the rows alone: unread on
  /// non-archived tiles (archived unread lives under the Archived pill and
  /// never counts, exactly as the server excludes it).
  int _provisionalUnread(List<P2PConversationEntity> convos) => convos
      .where((c) => !c.isArchived)
      .fold<int>(0, (s, c) => s + c.unreadCount);

  /// Paint a list the moment IT arrives, without waiting for its siblings:
  /// whatever has not arrived yet is taken from what is already on screen.
  void _emitPartial(
    int seq, {
    required List<P2PConversationEntity>? conversations,
    required List<P2PConversationEntity>? requests,
    required int? unread,
  }) {
    if (seq != _loadSeq) return;
    final shown = state;
    final current = shown is P2PConversationsLoaded ? shown : null;
    _safeEmit(_composeLoaded(
      conversations ?? current?.conversations ?? const [],
      requests ?? current?.incomingRequests ?? const [],
      unread: unread,
      commitPendingReads: false,
      upcomingBirthdays: current?.upcomingBirthdays ?? const [],
    ));
  }

  Future<void> _loadUpcomingBirthdays(int seq) async {
    List birthdays;
    try {
      // Surface a connection's birthday starting 7 days before the date (not the
      // 60-day default) so the Birthdays tab stays timely and uncluttered.
      birthdays = await _repository.listConnectionBirthdays(withinDays: 7);
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
}
