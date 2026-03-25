import 'package:flutter/material.dart';

/// Reminder entity for notifications on tasks and events
class Reminder {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime remindAt;
  final int? minutesBefore; // For event/task relative reminders
  final String reminderType; // 'absolute', 'relative', 'recurring'
  final String? repeatPattern; // 'daily', 'weekly', 'monthly', etc.
  final bool isActive;
  final String? relatedTaskId;
  final String? relatedEventId;
  final DateTime createdAt;
  final DateTime? lastTriggeredAt;

  const Reminder({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.remindAt,
    this.minutesBefore,
    required this.reminderType,
    this.repeatPattern,
    required this.isActive,
    this.relatedTaskId,
    this.relatedEventId,
    required this.createdAt,
    this.lastTriggeredAt,
  });

  Reminder copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? remindAt,
    int? minutesBefore,
    String? reminderType,
    String? repeatPattern,
    bool? isActive,
    String? relatedTaskId,
    String? relatedEventId,
    DateTime? createdAt,
    DateTime? lastTriggeredAt,
  }) {
    return Reminder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      remindAt: remindAt ?? this.remindAt,
      minutesBefore: minutesBefore ?? this.minutesBefore,
      reminderType: reminderType ?? this.reminderType,
      repeatPattern: repeatPattern ?? this.repeatPattern,
      isActive: isActive ?? this.isActive,
      relatedTaskId: relatedTaskId ?? this.relatedTaskId,
      relatedEventId: relatedEventId ?? this.relatedEventId,
      createdAt: createdAt ?? this.createdAt,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      remindAt: DateTime.parse(json['remind_at'] as String),
      minutesBefore: json['minutes_before'] as int?,
      reminderType: json['reminder_type'] as String? ?? 'absolute',
      repeatPattern: json['repeat_pattern'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      relatedTaskId: json['related_task_id'] as String?,
      relatedEventId: json['related_event_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastTriggeredAt: json['last_triggered_at'] != null
          ? DateTime.parse(json['last_triggered_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'remind_at': remindAt.toIso8601String(),
      'minutes_before': minutesBefore,
      'reminder_type': reminderType,
      'repeat_pattern': repeatPattern,
      'is_active': isActive,
      'related_task_id': relatedTaskId,
      'related_event_id': relatedEventId,
      'created_at': createdAt.toIso8601String(),
      'last_triggered_at': lastTriggeredAt?.toIso8601String(),
    };
  }

  String getReminderTypeLabel() {
    switch (reminderType) {
      case 'relative':
        return minutesBefore != null ? '${minutesBefore}m before' : 'Relative';
      case 'recurring':
        return repeatPattern ?? 'Recurring';
      default:
        return 'One-time';
    }
  }

  IconData getIcon() {
    if (relatedTaskId != null) return Icons.task_alt;
    if (relatedEventId != null) return Icons.event;
    return Icons.notification_important;
  }

  Color getColor() {
    if (!isActive) return Colors.grey;
    if (reminderType == 'recurring') return const Color(0xFF8B5CF6);
    if (relatedTaskId != null) return const Color(0xFF3B82F6);
    if (relatedEventId != null) return const Color(0xFF10B981);
    return const Color(0xFFF59E0B);
  }
}
