import 'package:flutter/foundation.dart';

/// A single message the AI located and the user chose to jump to.
class MessageHighlightAnchor {
  final String messageId;
  final String snippet;
  final String createdAt;
  const MessageHighlightAnchor({
    required this.messageId,
    this.snippet = '',
    this.createdAt = '',
  });
}

/// Hand-off holder for the AI "jump to message" feature.
///
/// When the conversation-AI locates message(s) and the user taps "Show in
/// chat", the assistant sheet stores the target anchors here (scoped to the
/// conversation) and closes. The P2P chat page beneath consumes them once and
/// scrolls to + highlights the matching bubble(s). Kept as a tiny singleton
/// (mirrors [PendingChatNavigation]) so the sheet and the page don't need a
/// shared BuildContext or a bespoke Navigator result channel.
class PendingMessageHighlight {
  PendingMessageHighlight._();
  static final PendingMessageHighlight instance = PendingMessageHighlight._();

  String? _conversationId;
  List<MessageHighlightAnchor> _anchors = const [];

  /// Notifies listeners (the open P2P chat page) that a new jump target is
  /// pending, so a page ALREADY on screen reacts immediately (not only on the
  /// post-sheet `.then`).
  final ValueNotifier<int> tick = ValueNotifier<int>(0);

  bool get hasPending => _conversationId != null && _anchors.isNotEmpty;
  String? get conversationId => _conversationId;

  /// Store a jump target. [conversationId] guards against applying it to the
  /// wrong chat if the user navigated elsewhere.
  void set(String conversationId, List<MessageHighlightAnchor> anchors) {
    if (conversationId.isEmpty || anchors.isEmpty) return;
    _conversationId = conversationId;
    _anchors = List.unmodifiable(anchors);
    tick.value = tick.value + 1;
  }

  /// Consume the pending target for [conversationId] (once). Returns null if
  /// nothing is pending or it belongs to a different conversation.
  List<MessageHighlightAnchor>? consume(String conversationId) {
    if (_conversationId != conversationId || _anchors.isEmpty) return null;
    final out = _anchors;
    _conversationId = null;
    _anchors = const [];
    return out;
  }

  void clear() {
    _conversationId = null;
    _anchors = const [];
  }
}
