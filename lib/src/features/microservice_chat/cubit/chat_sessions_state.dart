import 'package:equatable/equatable.dart';
import '../domain/entities/chat_session_summary.dart';

/// Sealed state hierarchy for the multi-tab chat drawer.
sealed class ChatSessionsState extends Equatable {
  const ChatSessionsState();

  @override
  List<Object?> get props => const [];
}

/// Initial state before any load attempt.
class ChatSessionsInitial extends ChatSessionsState {
  const ChatSessionsInitial();
}

/// In-flight load / refresh.
class ChatSessionsLoading extends ChatSessionsState {
  /// Existing list (if any) shown beneath the spinner. Lets the drawer
  /// keep showing rows while a refresh runs in the background.
  final List<ChatSessionSummary> sessions;
  final String? currentId;

  const ChatSessionsLoading({this.sessions = const [], this.currentId});

  @override
  List<Object?> get props => [sessions, currentId];
}

/// Loaded list — drawer can render rows.
class ChatSessionsLoaded extends ChatSessionsState {
  final List<ChatSessionSummary> sessions;
  final String? currentId;

  const ChatSessionsLoaded({
    required this.sessions,
    required this.currentId,
  });

  @override
  List<Object?> get props => [sessions, currentId];

  ChatSessionsLoaded copyWith({
    List<ChatSessionSummary>? sessions,
    String? currentId,
  }) {
    return ChatSessionsLoaded(
      sessions: sessions ?? this.sessions,
      currentId: currentId ?? this.currentId,
    );
  }
}

/// Error fetching/creating/renaming/deleting.
class ChatSessionsError extends ChatSessionsState {
  final String message;
  final List<ChatSessionSummary> sessions;
  final String? currentId;

  const ChatSessionsError({
    required this.message,
    this.sessions = const [],
    this.currentId,
  });

  @override
  List<Object?> get props => [message, sessions, currentId];
}
