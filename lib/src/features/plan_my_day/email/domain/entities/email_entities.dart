// Domain entities for the Gmail / email integration inside Plan My Day.
//
// The backend serializes its proto messages as JSON with snake_case field
// names (e.g. `gmail_message_id`, `from_addr`). These entities are the app's
// clean-architecture view of that data; the data layer (models) is what parses
// the raw JSON into these.

/// Connection status of the user's Gmail integration.
class EmailConnectionStatus {
  final bool connected;
  final String email;
  final String status;
  final bool autoReplyEnabled;
  final int digestHour;
  final DateTime? lastSyncedAt;

  const EmailConnectionStatus({
    required this.connected,
    required this.email,
    required this.status,
    required this.autoReplyEnabled,
    required this.digestHour,
    this.lastSyncedAt,
  });

  static const EmailConnectionStatus disconnected = EmailConnectionStatus(
    connected: false,
    email: '',
    status: 'not_connected',
    autoReplyEnabled: false,
    digestHour: 8,
    lastSyncedAt: null,
  );

  EmailConnectionStatus copyWith({
    bool? connected,
    String? email,
    String? status,
    bool? autoReplyEnabled,
    int? digestHour,
    DateTime? lastSyncedAt,
  }) {
    return EmailConnectionStatus(
      connected: connected ?? this.connected,
      email: email ?? this.email,
      status: status ?? this.status,
      autoReplyEnabled: autoReplyEnabled ?? this.autoReplyEnabled,
      digestHour: digestHour ?? this.digestHour,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }
}

/// A single summarized email message.
class EmailMessage {
  final String id;
  final String gmailMessageId;
  final String threadId;
  final String fromAddr;
  final String subject;
  final String snippet;
  final String summary;
  final DateTime? receivedAt;
  final bool isRead;
  final List<String> labels;

  const EmailMessage({
    required this.id,
    required this.gmailMessageId,
    required this.threadId,
    required this.fromAddr,
    required this.subject,
    required this.snippet,
    required this.summary,
    this.receivedAt,
    required this.isRead,
    this.labels = const [],
  });

  /// Best-effort display name derived from the from address
  /// (`Jane Doe <jane@x.com>` -> `Jane Doe`; `jane@x.com` -> `jane`).
  String get fromDisplay {
    final trimmed = fromAddr.trim();
    if (trimmed.isEmpty) return 'Unknown sender';
    final lt = trimmed.indexOf('<');
    if (lt > 0) {
      final name = trimmed.substring(0, lt).replaceAll('"', '').trim();
      if (name.isNotEmpty) return name;
    }
    final at = trimmed.indexOf('@');
    if (at > 0) return trimmed.substring(0, at);
    return trimmed;
  }
}

/// The full body of a message, fetched live on demand.
class EmailMessageDetail {
  final EmailMessage message;
  final String body;

  const EmailMessageDetail({required this.message, required this.body});
}

/// A page of summarized messages plus the optional AI digest for the range.
class EmailSummariesResult {
  final List<EmailMessage> messages;
  final String digest;
  final int total;

  const EmailSummariesResult({
    required this.messages,
    required this.digest,
    required this.total,
  });
}

/// An AI-drafted (or queued) reply.
class EmailDraft {
  final String id;
  final String threadId;
  final String gmailMessageId;
  final String toAddr;
  final String subject;
  final String body;
  final String mode; // approve | auto_send
  final String status;
  final DateTime? createdAt;

  const EmailDraft({
    required this.id,
    required this.threadId,
    required this.gmailMessageId,
    required this.toAddr,
    required this.subject,
    required this.body,
    required this.mode,
    required this.status,
    this.createdAt,
  });
}

/// Result of building a day from emails.
class EmailBuildDayResult {
  final int createdTasks;
  final int createdEvents;
  final int createdBlocks;
  final String message;

  const EmailBuildDayResult({
    required this.createdTasks,
    required this.createdEvents,
    required this.createdBlocks,
    required this.message,
  });

  int get total => createdTasks + createdEvents + createdBlocks;
}

/// An auto-reply rule.
class EmailRule {
  final String id;
  final String name;
  final String fromContains;
  final String subjectContains;
  final String label;
  final String mode; // approve | auto_send
  final String tone;
  final bool enabled;

  const EmailRule({
    required this.id,
    required this.name,
    required this.fromContains,
    required this.subjectContains,
    required this.label,
    required this.mode,
    required this.tone,
    required this.enabled,
  });
}
