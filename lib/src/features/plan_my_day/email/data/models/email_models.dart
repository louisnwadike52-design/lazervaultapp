import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';

/// JSON parsing for the email feature. Backend proto messages are serialized
/// with snake_case field names (`gmail_message_id`, `from_addr`, ...).

DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
  return null;
}

bool _parseBool(dynamic v) {
  if (v is bool) return v;
  if (v is String) return v.toLowerCase() == 'true';
  return false;
}

int _parseInt(dynamic v, {int fallback = 0}) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

String _parseString(dynamic v) => v == null ? '' : v.toString();

List<String> _parseStringList(dynamic v) {
  if (v is List) {
    return v.map((e) => e.toString()).toList();
  }
  return const [];
}

class EmailConnectionStatusModel {
  static EmailConnectionStatus fromJson(Map<String, dynamic> json) {
    return EmailConnectionStatus(
      connected: _parseBool(json['connected']),
      email: _parseString(json['email']),
      status: _parseString(json['status']),
      autoReplyEnabled: _parseBool(json['auto_reply_enabled']),
      digestHour: _parseInt(json['digest_hour'], fallback: 8),
      lastSyncedAt: _parseDate(json['last_synced_at']),
    );
  }
}

class EmailMessageModel {
  static EmailMessage fromJson(Map<String, dynamic> json) {
    return EmailMessage(
      id: _parseString(json['id']),
      gmailMessageId: _parseString(json['gmail_message_id']),
      threadId: _parseString(json['thread_id']),
      fromAddr: _parseString(json['from_addr']),
      subject: _parseString(json['subject']),
      snippet: _parseString(json['snippet']),
      summary: _parseString(json['summary']),
      receivedAt: _parseDate(json['received_at']),
      isRead: _parseBool(json['is_read']),
      labels: _parseStringList(json['labels']),
    );
  }
}

class EmailSummariesResultModel {
  static EmailSummariesResult fromJson(Map<String, dynamic> json) {
    final rawMessages = json['messages'];
    final messages = rawMessages is List
        ? rawMessages
            .whereType<Map>()
            .map((m) => EmailMessageModel.fromJson(Map<String, dynamic>.from(m)))
            .toList()
        : <EmailMessage>[];
    return EmailSummariesResult(
      messages: messages,
      digest: _parseString(json['digest']),
      total: _parseInt(json['total'], fallback: messages.length),
    );
  }
}

class EmailMessageDetailModel {
  static EmailMessageDetail fromJson(Map<String, dynamic> json) {
    final rawMessage = json['message'];
    final message = rawMessage is Map
        ? EmailMessageModel.fromJson(Map<String, dynamic>.from(rawMessage))
        : const EmailMessage(
            id: '',
            gmailMessageId: '',
            threadId: '',
            fromAddr: '',
            subject: '',
            snippet: '',
            summary: '',
            isRead: true,
          );
    return EmailMessageDetail(
      message: message,
      body: _parseString(json['body']),
    );
  }
}

class EmailDraftModel {
  static EmailDraft fromJson(Map<String, dynamic> json) {
    return EmailDraft(
      id: _parseString(json['id']),
      threadId: _parseString(json['thread_id']),
      gmailMessageId: _parseString(json['gmail_message_id']),
      toAddr: _parseString(json['to_addr']),
      subject: _parseString(json['subject']),
      body: _parseString(json['body']),
      mode: _parseString(json['mode']),
      status: _parseString(json['status']),
      createdAt: _parseDate(json['created_at']),
    );
  }
}

class EmailBuildDayResultModel {
  static EmailBuildDayResult fromJson(Map<String, dynamic> json) {
    return EmailBuildDayResult(
      createdTasks: _parseInt(json['created_tasks']),
      createdEvents: _parseInt(json['created_events']),
      createdBlocks: _parseInt(json['created_blocks']),
      message: _parseString(json['message']),
    );
  }
}

class EmailRuleModel {
  static EmailRule fromJson(Map<String, dynamic> json) {
    return EmailRule(
      id: _parseString(json['id']),
      name: _parseString(json['name']),
      fromContains: _parseString(json['from_contains']),
      subjectContains: _parseString(json['subject_contains']),
      label: _parseString(json['label']),
      mode: _parseString(json['mode']),
      tone: _parseString(json['tone']),
      enabled: _parseBool(json['enabled']),
    );
  }

  static Map<String, dynamic> toJson(EmailRule rule) {
    return {
      if (rule.id.isNotEmpty) 'id': rule.id,
      'name': rule.name,
      'from_contains': rule.fromContains,
      'subject_contains': rule.subjectContains,
      'label': rule.label,
      'mode': rule.mode,
      'tone': rule.tone,
      'enabled': rule.enabled,
    };
  }
}
