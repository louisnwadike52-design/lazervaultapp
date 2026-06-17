import 'dart:async';

import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/microservice_chat/data/datasources/chat_sessions_datasource.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/chat_session_summary.dart';

/// Stateful manager for ChatGPT-style multi-session chat tabs.
///
/// Responsibilities:
/// - Persist the currently-active session id in SecureStorage so the app
///   restores the last conversation across launches.
/// - Hold the in-memory drawer list (`sessionList`), kept in sync with
///   the chat-agent-gateway via `ChatSessionsDataSource`.
/// - Broadcast switches via `currentSessionIdStream` so the chat cubit
///   can reload history when the user picks another tab.
///
/// Legacy helpers (`getGeneralSessionId`, `getServiceSessionId`) are kept
/// for the older `ai_chats` feature (which still uses the deterministic
/// `general_{userId}` session id) — removing them is out of scope here.
class ChatSessionManager {
  // SecureStorage key for the last-picked session id lives on
  // SecureStorageService.readChatCurrentSessionId — the manager doesn't
  // touch FlutterSecureStorage directly so the key constant lives there.

  final SecureStorageService _secureStorageService;
  final ChatSessionsDataSource? _sessionsDataSource;

  final StreamController<String?> _currentIdController =
      StreamController<String?>.broadcast();
  final StreamController<List<ChatSessionSummary>> _listController =
      StreamController<List<ChatSessionSummary>>.broadcast();

  String? _currentSessionId;
  List<ChatSessionSummary> _sessionList = <ChatSessionSummary>[];

  ChatSessionManager({
    required SecureStorageService secureStorageService,
    ChatSessionsDataSource? sessionsDataSource,
  })  : _secureStorageService = secureStorageService,
        _sessionsDataSource = sessionsDataSource;

  // ─── Backward-compatible deterministic-id helpers (ai_chats feature) ───

  /// Deterministic session id for the legacy bottom-nav AI chat (ai_chats).
  /// Kept for backward-compat — the new multi-tab general-chat flow uses
  /// `currentSessionId` instead.
  Future<String> getGeneralSessionId() async {
    final userId = await _secureStorageService.getUserId() ?? 'unknown';
    return 'general_$userId';
  }

  /// Deterministic session id for per-service chat bottom sheets.
  Future<String> getServiceSessionId(String sourceContext) async {
    final userId = await _secureStorageService.getUserId() ?? 'unknown';
    return 'svc_${userId}_$sourceContext';
  }

  // ─── Multi-tab session API ────────────────────────────────────────────

  /// Current active session id, or `null` if none has been resolved yet.
  String? get currentSessionId => _currentSessionId;

  /// Snapshot of the drawer list (most-recent-first).
  List<ChatSessionSummary> get sessionList =>
      List.unmodifiable(_sessionList);

  /// Broadcasts the active session id whenever it changes (or is set for
  /// the first time). Replays nothing — listeners only get future events.
  /// Cubit listens here and reloads history when the user picks a tab.
  Stream<String?> get currentSessionIdStream => _currentIdController.stream;

  /// Broadcasts the drawer list. Cubit listens to drive the drawer UI.
  Stream<List<ChatSessionSummary>> get sessionListStream =>
      _listController.stream;

  /// Bootstrap the manager: restore the last-picked session id from
  /// SecureStorage. Safe to call multiple times — only emits a stream
  /// event when the resolved id is different from the in-memory value.
  Future<String?> restoreCurrentSession() async {
    final stored =
        await _secureStorageService.readChatCurrentSessionId();
    if (stored != null && stored.isNotEmpty) {
      _currentSessionId = stored;
      _currentIdController.add(stored);
    }
    return _currentSessionId;
  }

  /// Fetch the drawer list from the gateway. Falls back to keeping the
  /// existing list on failure so the drawer doesn't blank out on
  /// transient network blips.
  Future<List<ChatSessionSummary>> loadSessions({int limit = 20}) async {
    final ds = _requireDataSource();
    final result = await ds.list(limit: limit);
    _sessionList = result.sessions;
    _listController.add(_sessionList);

    // If we never picked a session before, default to the most recent
    // one (drawer top row) — keeps existing-user "open chat" UX intact.
    if ((_currentSessionId == null || _currentSessionId!.isEmpty) &&
        _sessionList.isNotEmpty) {
      await switchTo(_sessionList.first.sessionId);
    }
    return _sessionList;
  }

  /// Seed a fresh empty session on the gateway, prepend it to the local
  /// list, and switch the active id to it (so the next message lands in
  /// the new tab).
  Future<ChatSessionSummary> createSession({String? title, String? locale}) async {
    final ds = _requireDataSource();
    final created = await ds.create(title: title, locale: locale);
    // Prepend (drawer is sorted by last_activity DESC)
    _sessionList = [created, ..._sessionList];
    _listController.add(_sessionList);
    await switchTo(created.sessionId);
    return created;
  }

  /// Switch the active session. Persists to SecureStorage and emits a
  /// stream event so listeners (the chat cubit) reload history.
  Future<void> switchTo(String sessionId) async {
    if (sessionId.isEmpty) return;
    if (_currentSessionId == sessionId) return;
    _currentSessionId = sessionId;
    await _secureStorageService.writeChatCurrentSessionId(sessionId);
    _currentIdController.add(sessionId);
  }

  /// Rename a session (server-authoritative). Updates local list on
  /// success.
  Future<ChatSessionSummary> rename({
    required String sessionId,
    required String title,
  }) async {
    final ds = _requireDataSource();
    final updated = await ds.rename(sessionId: sessionId, title: title);
    final idx =
        _sessionList.indexWhere((s) => s.sessionId == sessionId);
    if (idx >= 0) {
      _sessionList = List.of(_sessionList)
        ..[idx] = _sessionList[idx].copyWith(
          title: updated.title,
          lastActivity: updated.lastActivity,
        );
      _listController.add(_sessionList);
    }
    return updated;
  }

  /// Delete a session. Removes from local list and switches to the next
  /// available session (top of list) — or creates a new one if the list
  /// is now empty so the user is never left without an active tab.
  Future<void> delete(String sessionId) async {
    final ds = _requireDataSource();
    await ds.delete(sessionId);
    _sessionList = _sessionList
        .where((s) => s.sessionId != sessionId)
        .toList(growable: false);
    _listController.add(_sessionList);
    if (_currentSessionId == sessionId) {
      if (_sessionList.isNotEmpty) {
        await switchTo(_sessionList.first.sessionId);
      } else {
        // Auto-create so the chat screen is never staring at "no session".
        final created = await createSession();
        await switchTo(created.sessionId);
      }
    }
  }

  /// Locally update a row's last-activity / message-count after the user
  /// posts a turn in that session. Avoids a full GET refetch on every
  /// message. Pure UI sync — server is still the source of truth.
  void touchLocalActivity(String sessionId, {String? previewIfMissing}) {
    final idx =
        _sessionList.indexWhere((s) => s.sessionId == sessionId);
    if (idx < 0) return;
    final current = _sessionList[idx];
    final updated = current.copyWith(
      lastActivity: DateTime.now().toUtc(),
      messageCount: current.messageCount + 1,
      firstMessagePreview: current.firstMessagePreview.isEmpty &&
              (previewIfMissing != null && previewIfMissing.isNotEmpty)
          ? previewIfMissing.length > 80
              ? previewIfMissing.substring(0, 80)
              : previewIfMissing
          : current.firstMessagePreview,
    );
    final newList = List.of(_sessionList)..removeAt(idx);
    // Re-insert at top (drawer is sorted by last_activity DESC).
    _sessionList = [updated, ...newList];
    _listController.add(_sessionList);
  }

  ChatSessionsDataSource _requireDataSource() {
    final ds = _sessionsDataSource;
    if (ds == null) {
      throw StateError(
        'ChatSessionManager was constructed without a ChatSessionsDataSource — '
        'multi-tab API is unavailable in this context.',
      );
    }
    return ds;
  }

  Future<void> dispose() async {
    await _currentIdController.close();
    await _listController.close();
  }
}
