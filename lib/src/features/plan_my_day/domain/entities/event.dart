class Event {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final String? location;
  final String? color;
  final bool isAllDay;
  final String? recurrenceRule;
  final List<String> categoryIds;
  final List<String> reminderIds;
  final String? externalEventId;
  final String? externalCalendar;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.location,
    this.color,
    this.isAllDay = false,
    this.recurrenceRule,
    this.categoryIds = const [],
    this.reminderIds = const [],
    this.externalEventId,
    this.externalCalendar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      location: json['location'] as String?,
      color: json['color'] as String?,
      isAllDay: json['is_all_day'] as bool? ?? false,
      recurrenceRule: json['recurrence_rule'] as String?,
      categoryIds: (json['category_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      reminderIds: (json['reminder_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      externalEventId: json['external_event_id'] as String?,
      externalCalendar: json['external_calendar'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'location': location,
      'color': color,
      'is_all_day': isAllDay,
      'recurrence_rule': recurrenceRule,
      'category_ids': categoryIds,
      'reminder_ids': reminderIds,
      'external_event_id': externalEventId,
      'external_calendar': externalCalendar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Event copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    String? color,
    bool? isAllDay,
    String? recurrenceRule,
    List<String>? categoryIds,
    List<String>? reminderIds,
    String? externalEventId,
    String? externalCalendar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      color: color ?? this.color,
      isAllDay: isAllDay ?? this.isAllDay,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      categoryIds: categoryIds ?? this.categoryIds,
      reminderIds: reminderIds ?? this.reminderIds,
      externalEventId: externalEventId ?? this.externalEventId,
      externalCalendar: externalCalendar ?? this.externalCalendar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
