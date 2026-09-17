import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasources/contribution_chat_remote_data_source.dart';

part 'contribution_chat_media.dart';

/// Orchestrates one contribution's chat: message list, optimistic send,
/// typing presence and read receipts.
///
/// A plain ChangeNotifier rather than a Bloc because this is screen-local
/// state with a high update rate (every poll tick, every keystroke's typing
/// debounce) — routing that through cubit states would emit constantly for no
/// benefit and make the polling lifecycle harder to reason about.
///
/// Delivery is POLLED, matching how the backend RPCs were designed
/// ("WebSocket fanout can be layered on later without changing the schema or
/// these RPCs"). Two independent cadences: messages on a slower tick, chat
/// state (typing + ticks) on a faster one, because typing must feel live while
/// message history does not need to.
class ContributionChatCubit extends ChangeNotifier {
  ContributionChatCubit({
    required this.contributionId,
    required this.currentUserId,
    required String Function() tokenProvider,
    ContributionChatRemoteDataSource? dataSource,
  })  : _token = tokenProvider,
        _ds = dataSource ?? ContributionChatRemoteDataSource();

  final String contributionId;
  final String currentUserId;
  final String Function() _token;
  final ContributionChatRemoteDataSource _ds;
  final _uuid = const Uuid();

  // ── Polling cadences ──────────────────────────────────────────────────
  // Messages every 4s; presence every 2s so "typing…" appears promptly and
  // clears within its 6s server TTL even if a tick is missed.
  static const _messageInterval = Duration(seconds: 4);
  static const _stateInterval = Duration(seconds: 2);

  // ── Public state ──────────────────────────────────────────────────────
  final List<ContributionMessage> messages = [];
  List<ContributionReader> readers = const [];
  List<ContributionTyping> typing = const [];
  int unreadCount = 0;
  bool loading = true;
  String? error;

  /// The message currently being replied to, if any.
  ContributionMessage? replyingTo;

  Timer? _messageTimer;
  Timer? _stateTimer;
  Timer? _typingDebounce;
  bool _typingSignalled = false;
  bool _disposed = false;

  /// False while the app is backgrounded or the screen is covered. Polling a
  /// chat nobody is looking at burns battery and data for nothing, and
  /// marking messages READ while the phone is in a pocket is simply untrue —
  /// both are gated on this.
  bool _visible = true;

  /// True when the caller is scrolled far enough from the bottom that
  /// auto-scrolling would yank them away from what they're reading. The
  /// screen keeps this in sync; the cubit only reports whether it should
  /// scroll on new content.
  bool viewerIsAtBottom = true;

  /// Newest server-acknowledged message time — the delta-poll cursor.
  DateTime? _cursor;

  // ── Lifecycle ─────────────────────────────────────────────────────────

  Future<void> start() async {
    await _loadInitial();
    _messageTimer = Timer.periodic(_messageInterval, (_) => _pollMessages());
    _stateTimer = Timer.periodic(_stateInterval, (_) => _pollState());
  }

  /// Called when the app backgrounds / the screen is covered. Stops the polls
  /// and clears our typing ping so the group doesn't see a phantom
  /// "typing…" from someone who walked away.
  void pause() {
    if (!_visible) return;
    _visible = false;
    _messageTimer?.cancel();
    _stateTimer?.cancel();
    _typingDebounce?.cancel();
    _clearTyping();
  }

  /// Called when the chat becomes visible again: catch up immediately rather
  /// than waiting a full tick, then resume the cadences.
  void resume() {
    if (_visible || _disposed) return;
    _visible = true;
    _pollMessages();
    _pollState();
    _messageTimer = Timer.periodic(_messageInterval, (_) => _pollMessages());
    _stateTimer = Timer.periodic(_stateInterval, (_) => _pollState());
  }

  @override
  void dispose() {
    _disposed = true;
    _messageTimer?.cancel();
    _stateTimer?.cancel();
    _typingDebounce?.cancel();
    // Clear presence on the way out so we don't leave a stale "typing…"
    // hanging for the group until its TTL lapses.
    if (_typingSignalled) {
      _ds.setTyping(
          token: _token(), contributionId: contributionId, isTyping: false);
    }
    super.dispose();
  }

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  // ── Loading ───────────────────────────────────────────────────────────

  Future<void> _loadInitial() async {
    try {
      final list = await _ds.list(token: _token(), contributionId: contributionId);
      messages
        ..clear()
        ..addAll(list);
      _cursor = list.isNotEmpty ? list.last.createdAt : null;
      error = null;
    } catch (e) {
      error = '$e';
    } finally {
      loading = false;
      _safeNotify();
    }
    await _pollState();
    _markNewestRead();
  }

  Future<void> _pollMessages() async {
    if (_disposed || !_visible) return;
    try {
      final fresh = await _ds.list(
        token: _token(),
        contributionId: contributionId,
        since: _cursor,
      );
      if (fresh.isEmpty) return;

      var changed = false;
      for (final m in fresh) {
        // Reconcile against the OPTIMISTIC bubble by client id: without this
        // the sender sees their own message twice (once local, once polled).
        final localIdx = m.clientMessageId.isEmpty
            ? -1
            : messages.indexWhere((x) =>
                x.clientMessageId.isNotEmpty &&
                x.clientMessageId == m.clientMessageId);
        if (localIdx >= 0) {
          messages[localIdx] = m.copyWith(status: ChatDeliveryStatus.sent);
          changed = true;
          continue;
        }
        if (messages.any((x) => x.id == m.id)) {
          // Already known — but an edit/retraction may have changed it.
          final i = messages.indexWhere((x) => x.id == m.id);
          messages[i] = m.copyWith(status: messages[i].status);
          changed = true;
          continue;
        }
        messages.add(m);
        changed = true;
      }
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      final newest = messages.where((m) => m.id.isNotEmpty).toList();
      if (newest.isNotEmpty) _cursor = newest.last.createdAt;
      if (changed) {
        _safeNotify();
        _markNewestRead();
      }
    } catch (_) {
      // A dropped poll is not worth showing: the next tick retries and the
      // user is still reading the messages they already have.
    }
  }

  Future<void> _pollState() async {
    if (_disposed || !_visible) return;
    try {
      final s = await _ds.chatState(
          token: _token(), contributionId: contributionId);
      readers = s.readers;
      typing = s.typing;
      unreadCount = s.unreadCount;
      _safeNotify();
    } catch (_) {
      // Presence/ticks are cosmetic — never surface a failure.
    }
  }

  // ── Read receipts ─────────────────────────────────────────────────────

  /// Mark the newest message read. Called on open and whenever new messages
  /// arrive while the screen is visible.
  void _markNewestRead() {
    // Only claim a read when the user can actually SEE the chat. Marking
    // messages read from a backgrounded app would tell the sender they were
    // seen when nobody looked.
    if (!_visible) return;
    final newest =
        messages.lastWhere((m) => m.id.isNotEmpty, orElse: () => _empty);
    if (newest.id.isEmpty) return;
    _ds.markRead(
        token: _token(), contributionId: contributionId, messageId: newest.id);
  }

  static final _empty = ContributionMessage(
    id: '',
    contributionId: '',
    senderId: '',
    senderName: '',
    kind: 'text',
    body: '',
    mediaUrl: '',
    durationMs: 0,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  /// How many OTHER members have read [message]. Drives the tick state and
  /// the "seen by" sheet — computed locally from the watermark list rather
  /// than a request per message.
  List<ContributionReader> readersOf(ContributionMessage message) {
    if (message.id.isEmpty) return const [];
    final target = message.createdAt;
    return readers.where((r) {
      if (r.userId == currentUserId) return false;
      final at = r.lastReadAt;
      if (at == null) return false;
      // A member has seen this message when their watermark is at or past it.
      return !at.isBefore(target);
    }).toList(growable: false);
  }

  /// Tick state for one of MY messages: read once every other member with a
  /// watermark has caught up to it.
  ChatDeliveryStatus statusOf(ContributionMessage m) {
    if (m.status != ChatDeliveryStatus.sent) return m.status;
    if (m.senderId != currentUserId) return ChatDeliveryStatus.sent;
    final others = readers.where((r) => r.userId != currentUserId).toList();
    if (others.isEmpty) return ChatDeliveryStatus.sent;
    final seen = readersOf(m).length;
    return seen >= others.length
        ? ChatDeliveryStatus.read
        : ChatDeliveryStatus.sent;
  }

  // ── Typing ────────────────────────────────────────────────────────────

  /// Called on every keystroke. Pings at most once per debounce window and
  /// auto-clears shortly after typing stops, so a burst of keystrokes is one
  /// request rather than one per character.
  void onTypingChanged(String text) {
    _typingDebounce?.cancel();
    if (text.trim().isEmpty) {
      _clearTyping();
      return;
    }
    if (!_typingSignalled) {
      _typingSignalled = true;
      _ds.setTyping(
          token: _token(), contributionId: contributionId, isTyping: true);
    }
    // Re-ping while still typing (server TTL is 6s), and clear on idle.
    _typingDebounce = Timer(const Duration(seconds: 3), () {
      if (_typingSignalled) {
        _ds.setTyping(
            token: _token(), contributionId: contributionId, isTyping: true);
      }
      Timer(const Duration(seconds: 3), _clearTyping);
    });
  }

  void _clearTyping() {
    if (!_typingSignalled) return;
    _typingSignalled = false;
    _ds.setTyping(
        token: _token(), contributionId: contributionId, isTyping: false);
  }

  // ── Composing ─────────────────────────────────────────────────────────

  void setReplyTo(ContributionMessage? m) {
    replyingTo = m;
    _safeNotify();
  }

  /// Sends [body], rendering an optimistic bubble immediately.
  ///
  /// The optimistic row carries a client id; the server echoes it back so the
  /// poll can reconcile rather than duplicate. On failure the bubble stays
  /// with a `failed` status so the user can retry instead of losing what they
  /// typed.
  /// [mentionedUserIds] are people @-tagged in [body]. Already reconciled
  /// against the final text by the composer, so a name deleted after being
  /// picked is not in this list.
  Future<void> send(String body, {List<String> mentionedUserIds = const []}) async {
    final text = body.trim();
    if (text.isEmpty) return;
    final clientId = _uuid.v4();
    final reply = replyingTo;

    final optimistic = ContributionMessage(
      id: '',
      contributionId: contributionId,
      senderId: currentUserId,
      senderName: 'You',
      kind: 'text',
      body: text,
      mediaUrl: '',
      durationMs: 0,
      createdAt: DateTime.now(),
      clientMessageId: clientId,
      replyToMessageId: reply?.id ?? '',
      replyToBody: reply?.body ?? '',
      replyToSender: reply?.senderName ?? '',
      status: ChatDeliveryStatus.sending,
    );
    messages.add(optimistic);
    replyingTo = null;
    _clearTyping();
    _safeNotify();

    try {
      final saved = await _ds.send(
        token: _token(),
        contributionId: contributionId,
        body: text,
        clientMessageId: clientId,
        replyToMessageId: reply?.id ?? '',
        mentionedUserIds: mentionedUserIds,
      );
      final i = messages
          .indexWhere((m) => m.clientMessageId == clientId && m.id.isEmpty);
      if (i >= 0) {
        messages[i] = saved.copyWith(status: ChatDeliveryStatus.sent);
        if (_cursor == null || saved.createdAt.isAfter(_cursor!)) {
          _cursor = saved.createdAt;
        }
      }
    } catch (_) {
      final i = messages
          .indexWhere((m) => m.clientMessageId == clientId && m.id.isEmpty);
      if (i >= 0) {
        messages[i] = messages[i].copyWith(status: ChatDeliveryStatus.failed);
      }
    }
    _safeNotify();
  }

  /// Retry a failed bubble. Reuses the SAME client id, so if the original
  /// request actually landed the server returns that row instead of posting a
  /// second copy.
  Future<void> retry(ContributionMessage failed) async {
    final i = messages.indexWhere(
        (m) => m.clientMessageId == failed.clientMessageId && m.id.isEmpty);
    if (i < 0) return;
    messages[i] = messages[i].copyWith(status: ChatDeliveryStatus.sending);
    _safeNotify();
    try {
      final saved = await _ds.send(
        token: _token(),
        contributionId: contributionId,
        body: failed.body,
        clientMessageId: failed.clientMessageId,
        replyToMessageId: failed.replyToMessageId,
      );
      messages[i] = saved.copyWith(status: ChatDeliveryStatus.sent);
    } catch (_) {
      messages[i] = messages[i].copyWith(status: ChatDeliveryStatus.failed);
    }
    _safeNotify();
  }

  Future<void> edit(ContributionMessage m, String newBody) async {
    final body = newBody.trim();
    if (body.isEmpty || body == m.body) return;
    try {
      final saved = await _ds.edit(
        token: _token(),
        contributionId: contributionId,
        messageId: m.id,
        body: body,
      );
      final i = messages.indexWhere((x) => x.id == m.id);
      if (i >= 0) messages[i] = saved.copyWith(status: ChatDeliveryStatus.sent);
      _safeNotify();
    } catch (e) {
      error = '$e';
      _safeNotify();
    }
  }

  Future<void> deleteForEveryone(ContributionMessage m) async {
    try {
      await _ds.deleteForEveryone(
        token: _token(),
        contributionId: contributionId,
        messageId: m.id,
      );
      final i = messages.indexWhere((x) => x.id == m.id);
      if (i >= 0) {
        messages[i] =
            messages[i].copyWith(deletedForEveryone: true, body: '');
      }
      _safeNotify();
    } catch (e) {
      error = '$e';
      _safeNotify();
    }
  }
}
