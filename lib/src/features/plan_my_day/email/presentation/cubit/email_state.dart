import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';

sealed class EmailState {}

class EmailInitial extends EmailState {}

/// The inbox is loading (status + first page of summaries).
class EmailLoading extends EmailState {}

/// Not connected — show the connect banner.
class EmailNotConnected extends EmailState {
  final String? message;
  EmailNotConnected({this.message});
}

/// OAuth / connect in progress.
class EmailConnecting extends EmailState {}

/// The inbox is loaded. Holds status, the current range, the digest and the
/// page of summarized messages. A separate [syncing]/[loadingMore] flag lets the
/// UI show inline progress without dropping the list.
class EmailInboxLoaded extends EmailState {
  final EmailConnectionStatus status;
  final String range; // today | last_24h | last_7d
  final String digest;
  final List<EmailMessage> messages;
  final int total;
  final bool syncing;
  final bool loadingMore;
  final bool hasMore;

  EmailInboxLoaded({
    required this.status,
    required this.range,
    required this.digest,
    required this.messages,
    required this.total,
    this.syncing = false,
    this.loadingMore = false,
    this.hasMore = false,
  });

  EmailInboxLoaded copyWith({
    EmailConnectionStatus? status,
    String? range,
    String? digest,
    List<EmailMessage>? messages,
    int? total,
    bool? syncing,
    bool? loadingMore,
    bool? hasMore,
  }) {
    return EmailInboxLoaded(
      status: status ?? this.status,
      range: range ?? this.range,
      digest: digest ?? this.digest,
      messages: messages ?? this.messages,
      total: total ?? this.total,
      syncing: syncing ?? this.syncing,
      loadingMore: loadingMore ?? this.loadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class EmailError extends EmailState {
  final String message;
  EmailError(this.message);
}

/// One-shot signal that a sync finished (so the UI can snackbar the count).
class EmailSynced extends EmailState {
  final int newCount;
  EmailSynced(this.newCount);
}

// ── Thread view ─────────────────────────────────────────────────────────────

class EmailThreadLoading extends EmailState {}

class EmailThreadLoaded extends EmailState {
  final EmailMessageDetail detail;
  final EmailDraft? draft; // AI draft, once composed
  final bool drafting;
  final bool sending;

  EmailThreadLoaded({
    required this.detail,
    this.draft,
    this.drafting = false,
    this.sending = false,
  });

  EmailThreadLoaded copyWith({
    EmailMessageDetail? detail,
    EmailDraft? draft,
    bool clearDraft = false,
    bool? drafting,
    bool? sending,
  }) {
    return EmailThreadLoaded(
      detail: detail ?? this.detail,
      draft: clearDraft ? null : (draft ?? this.draft),
      drafting: drafting ?? this.drafting,
      sending: sending ?? this.sending,
    );
  }
}

class EmailReplySent extends EmailState {
  final String sentId;
  EmailReplySent(this.sentId);
}

// ── Approval queue ──────────────────────────────────────────────────────────

class EmailDraftsLoading extends EmailState {}

class EmailDraftsLoaded extends EmailState {
  final List<EmailDraft> drafts;
  EmailDraftsLoaded(this.drafts);
}

// ── Build my day ────────────────────────────────────────────────────────────

class EmailBuildingDay extends EmailState {}

class EmailDayBuilt extends EmailState {
  final EmailBuildDayResult result;
  EmailDayBuilt(this.result);
}

// ── Settings / rules ────────────────────────────────────────────────────────

class EmailSettingsLoading extends EmailState {}

class EmailSettingsLoaded extends EmailState {
  final EmailConnectionStatus status;
  final List<EmailRule> rules;
  final bool saving;

  EmailSettingsLoaded({
    required this.status,
    required this.rules,
    this.saving = false,
  });

  EmailSettingsLoaded copyWith({
    EmailConnectionStatus? status,
    List<EmailRule>? rules,
    bool? saving,
  }) {
    return EmailSettingsLoaded(
      status: status ?? this.status,
      rules: rules ?? this.rules,
      saving: saving ?? this.saving,
    );
  }
}

class EmailDisconnected extends EmailState {}
