import 'package:lazervault/src/features/plan_my_day/domain/entities/plan_timestamp.dart';

/// A quick note in Plan My Day (backed by planning-service Notes RPCs).
/// Timestamps arrive as {"seconds":N,"nanos":M} from the gateway.
class Note {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String? linkedEntityType;
  final String? linkedEntityId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Note({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    this.linkedEntityType,
    this.linkedEntityId,
    this.createdAt,
    this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] as String? ?? '',
        userId: json['user_id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        linkedEntityType: json['linked_entity_type'] as String?,
        linkedEntityId: json['linked_entity_id'] as String?,
        createdAt: parsePlanTimestamp(json['created_at']),
        updatedAt: parsePlanTimestamp(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        if (linkedEntityType != null) 'linked_entity_type': linkedEntityType,
        if (linkedEntityId != null) 'linked_entity_id': linkedEntityId,
      };
}
