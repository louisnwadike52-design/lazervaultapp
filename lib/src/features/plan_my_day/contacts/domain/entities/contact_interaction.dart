import 'package:lazervault/src/features/plan_my_day/domain/entities/plan_timestamp.dart';

/// A logged touchpoint with a [Contact] — call, meeting, email, note, etc.
class ContactInteraction {
  final String id;
  final String contactId;
  final String userId;
  final String type;
  final String? note;
  final DateTime? occurredAt;

  const ContactInteraction({
    required this.id,
    required this.contactId,
    required this.userId,
    required this.type,
    this.note,
    this.occurredAt,
  });

  factory ContactInteraction.fromJson(Map<String, dynamic> json) {
    return ContactInteraction(
      id: json['id'] as String? ?? '',
      contactId: json['contact_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      type: json['type'] as String? ?? 'note',
      note: (json['note'] as String?)?.isEmpty ?? true
          ? null
          : json['note'] as String?,
      occurredAt: parsePlanTimestamp(json['occurred_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        if (note != null) 'note': note,
        if (occurredAt != null) 'occurred_at': occurredAt!.toIso8601String(),
      };
}
