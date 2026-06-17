import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/core/services/chat_session_manager.dart';
import '../domain/entities/chat_session_summary.dart';
import 'chat_sessions_state.dart';

/// Cubit that wraps `ChatSessionManager` for the drawer UI.
///
/// Responsibilities:
/// - Subscribe to the manager's session-list + current-id streams so the
///   drawer stays in sync regardless of who triggered the change (cubit
///   itself, the chat screen, a deep-link, etc.).
/// - Surface loading / error states the drawer can render directly.
/// - Expose imperative `createNew / switchTo / rename / delete / refresh`
///   verbs the drawer widgets call.
class ChatSessionsCubit extends Cubit<ChatSessionsState> {
  final ChatSessionManager _manager;

  StreamSubscription<List<ChatSessionSummary>>? _listSub;
  StreamSubscription<String?>? _currentIdSub;

  ChatSessionsCubit({required ChatSessionManager manager})
      : _manager = manager,
        super(const ChatSessionsInitial()) {
    _listSub = _manager.sessionListStream.listen((list) {
      // Mirror the manager into our latest state envelope so the drawer
      // rebuilds without us having to refetch.
      final currentId = _manager.currentSessionId;
      emit(ChatSessionsLoaded(sessions: list, currentId: currentId));
    });
    _currentIdSub = _manager.currentSessionIdStream.listen((id) {
      final s = state;
      if (s is ChatSessionsLoaded) {
        emit(s.copyWith(currentId: id));
      } else {
        emit(ChatSessionsLoaded(
          sessions: _manager.sessionList,
          currentId: id,
        ));
      }
    });
  }

  /// Bootstrap: restore the last-picked session id from secure storage,
  /// then pull the list from the gateway. Idempotent — calling twice
  /// re-fetches the list but keeps the current id intact.
  Future<void> initialize() async {
    emit(ChatSessionsLoading(
      sessions: _manager.sessionList,
      currentId: _manager.currentSessionId,
    ));
    try {
      await _manager.restoreCurrentSession();
      await _manager.loadSessions();
      emit(ChatSessionsLoaded(
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    } catch (e) {
      emit(ChatSessionsError(
        message: 'Couldn\'t load chats. Tap retry to try again.',
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    }
  }

  Future<void> refresh() async {
    try {
      await _manager.loadSessions();
      emit(ChatSessionsLoaded(
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    } catch (e) {
      emit(ChatSessionsError(
        message: 'Couldn\'t refresh chats.',
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    }
  }

  Future<void> createNew({String? title}) async {
    try {
      await _manager.createSession(title: title);
    } catch (e) {
      emit(ChatSessionsError(
        message: 'Couldn\'t start a new chat.',
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    }
  }

  Future<void> switchTo(String sessionId) async {
    // ChatSessionManager.switchTo is a no-op when id matches; safe to
    // call without guarding here.
    await _manager.switchTo(sessionId);
  }

  Future<void> rename({required String sessionId, required String title}) async {
    try {
      await _manager.rename(sessionId: sessionId, title: title);
    } catch (e) {
      emit(ChatSessionsError(
        message: 'Couldn\'t rename chat.',
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    }
  }

  Future<void> delete(String sessionId) async {
    try {
      await _manager.delete(sessionId);
    } catch (e) {
      emit(ChatSessionsError(
        message: 'Couldn\'t delete chat.',
        sessions: _manager.sessionList,
        currentId: _manager.currentSessionId,
      ));
    }
  }

  @override
  Future<void> close() async {
    await _listSub?.cancel();
    await _currentIdSub?.cancel();
    return super.close();
  }
}
