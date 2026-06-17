class TimeBlock {
  final String id;
  final String userId;
  final String date; // YYYY-MM-DD
  final String startTime; // HH:MM
  final String endTime; // HH:MM
  final String title;
  final String? description;
  final String type; // focused_work, meeting, break, exercise, commute, other
  final String? color;
  final bool isLocked;
  final List<String> taskIds;
  final List<String> eventIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  TimeBlock({
    required this.id,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.title,
    this.description,
    this.type = 'other',
    this.color,
    this.isLocked = false,
    this.taskIds = const [],
    this.eventIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory TimeBlock.fromJson(Map<String, dynamic> json) {
    return TimeBlock(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'other',
      color: json['color'] as String?,
      isLocked: json['is_locked'] as bool? ?? false,
      taskIds: (json['task_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      eventIds: (json['event_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'title': title,
      'description': description,
      'type': type,
      'color': color,
      'is_locked': isLocked,
      'task_ids': taskIds,
      'event_ids': eventIds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Get start DateTime for the time block
  DateTime get startDateTime {
    final parts = date.split('-');
    final timeParts = startTime.split(':');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  // Get end DateTime for the time block
  DateTime get endDateTime {
    final parts = date.split('-');
    final timeParts = endTime.split(':');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  // Get duration in minutes
  int get durationMinutes {
    return endDateTime.difference(startDateTime).inMinutes;
  }
}
