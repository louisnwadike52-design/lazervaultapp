import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/voice_session/models/voice_conversation.dart';

/// State for voice chat history
class VoiceChatHistoryState extends Equatable {
  final VoiceConversation? conversation;
  final bool isLoading;
  final String? error;

  const VoiceChatHistoryState({
    this.conversation,
    this.isLoading = false,
    this.error,
  });

  VoiceChatHistoryState copyWith({
    VoiceConversation? conversation,
    bool? isLoading,
    String? error,
  }) {
    return VoiceChatHistoryState(
      conversation: conversation ?? this.conversation,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [conversation, isLoading, error];
}

/// Cubit for managing voice chat conversation history
///
/// Edge cases handled:
/// - Memory limits (max messages per conversation, max conversations)
/// - Session ID conflicts
/// - Timer cleanup
class VoiceChatHistoryCubit extends Cubit<VoiceChatHistoryState> {
  final Map<String, VoiceConversation> _conversations = {};
  Timer? _persistTimer;

  // Edge case: Memory limits
  static const int _maxMessagesPerConversation = 500;
  static const int _maxConversations = 50;
  static const Duration _persistDelay = Duration(seconds: 2);

  VoiceChatHistoryCubit() : super(const VoiceChatHistoryState());

  /// Get or create a conversation for a session
  VoiceConversation _getOrCreateConversation(String sessionId) {
    return _conversations.putIfAbsent(
      sessionId,
      () => VoiceConversation(
        sessionId: sessionId,
        startedAt: DateTime.now(),
        messages: [],
      ),
    );
  }

  /// Start tracking a new voice session
  void startSession(String sessionId, {String? language}) {
    // Edge case: Check for session ID conflict (end existing session if needed)
    if (_conversations.containsKey(sessionId)) {
      // Session already exists - maybe reconnection scenario
      final existing = _conversations[sessionId]!;
      if (existing.endedAt == null) {
        // Session is still active - don't recreate
        emit(VoiceChatHistoryState(conversation: existing));
        return;
      }
    }

    // Edge case: Enforce max conversations limit (remove oldest)
    if (_conversations.length >= _maxConversations) {
      _removeOldestConversation();
    }

    final conversation = VoiceConversation(
      sessionId: sessionId,
      startedAt: DateTime.now(),
      messages: [],
      language: language,
    );
    _conversations[sessionId] = conversation;
    emit(VoiceChatHistoryState(conversation: conversation));
  }

  /// Add a user message to the conversation
  void addUserMessage(String sessionId, String text, {VoiceConversationMetadata? metadata}) {
    if (sessionId.isEmpty || text.trim().isEmpty) return;

    final conversation = _getOrCreateConversation(sessionId);

    // Edge case: Enforce message limit
    if (conversation.messages.length >= _maxMessagesPerConversation) {
      // Remove oldest message if at limit
      final trimmedMessages = conversation.messages.sublist(1);
      _conversations[sessionId] = conversation.copyWith(messages: trimmedMessages);
    }

    final updated = _conversations[sessionId]!.addUserMessage(text, metadata: metadata);
    _conversations[sessionId] = updated;

    // Only emit if this is the active conversation
    if (state.conversation?.sessionId == sessionId) {
      emit(VoiceChatHistoryState(conversation: updated));
    }

    // Schedule persistence
    _schedulePersist();
  }

  /// Add an agent message to the conversation
  void addAgentMessage(String sessionId, String text, {VoiceConversationMetadata? metadata}) {
    if (sessionId.isEmpty || text.trim().isEmpty) return;

    final conversation = _getOrCreateConversation(sessionId);

    // Edge case: Enforce message limit
    if (conversation.messages.length >= _maxMessagesPerConversation) {
      final trimmedMessages = conversation.messages.sublist(1);
      _conversations[sessionId] = conversation.copyWith(messages: trimmedMessages);
    }

    final updated = _conversations[sessionId]!.addAgentMessage(text, metadata: metadata);
    _conversations[sessionId] = updated;

    // Only emit if this is the active conversation
    if (state.conversation?.sessionId == sessionId) {
      emit(VoiceChatHistoryState(conversation: updated));
    }

    // Schedule persistence
    _schedulePersist();
  }

  /// End a session
  void endSession(String sessionId) {
    if (sessionId.isEmpty) return;

    final conversation = _conversations[sessionId];
    if (conversation != null) {
      final updated = conversation.copyWith(
        endedAt: DateTime.now(),
      );
      _conversations[sessionId] = updated;

      if (state.conversation?.sessionId == sessionId) {
        emit(VoiceChatHistoryState(conversation: updated));
      }
    }
    _persistTimer?.cancel();
    _persistAll();
  }

  /// Load a specific conversation
  void loadConversation(String sessionId) {
    final conversation = _conversations[sessionId];
    if (conversation != null) {
      emit(VoiceChatHistoryState(conversation: conversation));
    } else {
      emit(const VoiceChatHistoryState(error: 'Conversation not found'));
    }
  }

  /// Add transaction result to the conversation
  void addTransactionResult(
    String sessionId,
    Map<String, dynamic> result,
  ) {
    if (sessionId.isEmpty) return;

    final success = result['success'] as bool? ?? true;
    final reference = result['reference'] as String?;
    final amount = result['amount'] as num?;
    final recipient = result['recipient'] as String?;

    final summary = success
        ? 'Transfer of ${amount ?? 0} to ${recipient ?? 'recipient'} completed successfully. Ref: $reference'
        : 'Transfer failed. ${result['error'] ?? 'Unknown error'}';

    addAgentMessage(
      sessionId,
      summary,
      metadata: VoiceConversationMetadata(
        type: 'transaction_result',
        data: result,
      ),
    );
  }

  /// Add transfer summary to the conversation
  void addTransferSummary(
    String sessionId,
    Map<String, dynamic> summary,
  ) {
    if (sessionId.isEmpty) return;

    final amount = summary['amount'] as num?;
    final recipient = summary['recipient'] as String?;
    final bank = summary['bank'] as String?;

    final text = 'Confirm transfer of ${amount ?? 0} to $recipient (${bank ?? 'Bank'})?';

    addAgentMessage(
      sessionId,
      text,
      metadata: VoiceConversationMetadata(
        type: 'transfer_summary',
        data: summary,
      ),
    );
  }

  /// Add error message to the conversation
  void addErrorToSession(String sessionId, String error) {
    if (sessionId.isEmpty || error.isEmpty) return;
    addAgentMessage(
      sessionId,
      error,
      metadata: VoiceConversationMetadata(
        type: 'error',
      ),
    );
  }

  /// Get all session IDs (for history list)
  List<String> get allSessionIds {
    return _conversations.keys.toList()
      ..sort((a, b) {
        final aConv = _conversations[a];
        final bConv = _conversations[b];
        if (aConv == null || bConv == null) return 0;
        return bConv.startedAt.compareTo(aConv.startedAt);
      });
  }

  /// Get conversation for a specific session
  VoiceConversation? getConversation(String sessionId) {
    return _conversations[sessionId];
  }

  /// Remove oldest conversation (memory management)
  void _removeOldestConversation() {
    String? oldestId;
    DateTime? oldestTime;

    _conversations.forEach((id, conv) {
      if (oldestTime == null || conv.startedAt.isBefore(oldestTime!)) {
        oldestTime = conv.startedAt;
        oldestId = id;
      }
    });

    if (oldestId != null) {
      _conversations.remove(oldestId);
    }
  }

  /// Clear all conversations (for logout, etc.)
  void clearAll() {
    _conversations.clear();
    emit(const VoiceChatHistoryState());
    _persistTimer?.cancel();
  }

  /// Remove a specific conversation
  void removeConversation(String sessionId) {
    _conversations.remove(sessionId);
    // Emit current state if the removed conversation was active
    if (state.conversation?.sessionId == sessionId) {
      emit(const VoiceChatHistoryState());
    }
  }

  void _schedulePersist() {
    _persistTimer?.cancel();
    _persistTimer = Timer(_persistDelay, _persistAll);
  }

  Future<void> _persistAll() async {
    // In a real app, persist to local storage or backend
    // For now, just keep in memory
  }

  @override
  Future<void> close() {
    _persistTimer?.cancel();
    return super.close();
  }
}
