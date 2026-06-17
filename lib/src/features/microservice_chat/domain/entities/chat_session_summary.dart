/// Drawer-row payload for a single chat session.
///
/// Mirrors the shape returned by `GET /chat/sessions` on the chat-agent-gateway.
/// The Python source-of-truth is `ConversationManager._session_summary` in
/// chat-agent-gateway/conversation_manager.py.
class ChatSessionSummary {
  /// Stable session id used as the Redis key suffix.
  /// Format: `chat_{user_id}_{uuid16}` for new sessions; legacy sessions
  /// (created before multi-tab existed) use `general_{user_id}_{locale}`.
  final String sessionId;

  /// Drawer label. Defaults to "New chat", auto-derived from the first
  /// user message after 4 turns, or set explicitly via rename.
  final String title;

  /// First 80 chars of the first user message — used as subtitle row in
  /// the drawer so users can tell sessions apart.
  final String firstMessagePreview;

  /// ISO-8601 UTC timestamp of session creation.
  final DateTime createdAt;

  /// ISO-8601 UTC timestamp of last activity (any message).
  /// Drawer is sorted by this DESC.
  final DateTime lastActivity;

  /// Number of messages currently in the Redis session window
  /// (capped at 50 by MAX_MESSAGES_PER_SESSION on the gateway).
  final int messageCount;

  /// Which SERVICE_AGENTS key was handling the flow last turn.
  /// Empty string when the session hasn't routed yet.
  final String activeService;

  const ChatSessionSummary({
    required this.sessionId,
    required this.title,
    required this.firstMessagePreview,
    required this.createdAt,
    required this.lastActivity,
    required this.messageCount,
    required this.activeService,
  });

  factory ChatSessionSummary.fromJson(Map<String, dynamic> json) {
    DateTime parseTs(dynamic value) {
      if (value is String && value.isNotEmpty) {
        try {
          // Python's datetime.utcnow().isoformat() lacks a Z suffix.
          // Treat as UTC so the drawer's "x ago" formatter is consistent.
          final raw = value.endsWith('Z') ? value : '${value}Z';
          return DateTime.parse(raw).toUtc();
        } catch (_) {
          return DateTime.now().toUtc();
        }
      }
      return DateTime.now().toUtc();
    }

    return ChatSessionSummary(
      sessionId: json['session_id'] as String? ?? '',
      title: (json['title'] as String? ?? '').trim().isEmpty
          ? 'New chat'
          : (json['title'] as String).trim(),
      firstMessagePreview: json['first_message_preview'] as String? ?? '',
      createdAt: parseTs(json['created_at']),
      lastActivity: parseTs(json['last_activity']),
      messageCount: (json['message_count'] as num?)?.toInt() ?? 0,
      activeService: json['active_service'] as String? ?? '',
    );
  }

  ChatSessionSummary copyWith({
    String? title,
    String? firstMessagePreview,
    DateTime? lastActivity,
    int? messageCount,
    String? activeService,
  }) {
    return ChatSessionSummary(
      sessionId: sessionId,
      title: title ?? this.title,
      firstMessagePreview: firstMessagePreview ?? this.firstMessagePreview,
      createdAt: createdAt,
      lastActivity: lastActivity ?? this.lastActivity,
      messageCount: messageCount ?? this.messageCount,
      activeService: activeService ?? this.activeService,
    );
  }
}
