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

  // Event-reminder fields (backend migration 009). eventTime is the real-world
  // moment the user is reminded ABOUT (birthday, bill, event); the backend
  // derives the 1-day-before / 1-hour-before fires from it. When allDay is true
  // the client sends local midnight as eventTime (so "no time set" birthdays
  // fire at 12:00 AM). channels null => fall back to the user's profile prefs.
  final DateTime? eventTime;
  final bool allDay;
  final List<String> leadOffsets; // subset of ['day_before','hour_before']
  final List<String>? channels; // subset of ['push','email','sms']
  final String category; // custom | birthday | bill | event | task

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
    this.eventTime,
    this.allDay = false,
    this.leadOffsets = const ['day_before', 'hour_before'],
    this.channels,
    this.category = 'custom',
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
    DateTime? eventTime,
    bool? allDay,
    List<String>? leadOffsets,
    List<String>? channels,
    String? category,
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
      eventTime: eventTime ?? this.eventTime,
      allDay: allDay ?? this.allDay,
      leadOffsets: leadOffsets ?? this.leadOffsets,
      channels: channels ?? this.channels,
      category: category ?? this.category,
    );
  }

  /// Maps the planning-service backend shape (reminder_time as a proto
  /// {seconds} timestamp, repeat_type, repeat_minutes_before, enabled) onto
  /// this entity. The Flutter entity was designed independently of the backend.
  factory Reminder.fromBackendJson(Map<String, dynamic> json) {
    DateTime ts(dynamic v) {
      if (v is Map && v['seconds'] != null) {
        return DateTime.fromMillisecondsSinceEpoch((v['seconds'] as num).toInt() * 1000);
      }
      if (v is String && v.isNotEmpty) return DateTime.tryParse(v) ?? DateTime.now();
      return DateTime.now();
    }

    final repeatType = (json['repeat_type'] as String?) ?? 'once';
    final minutesBefore = (json['repeat_minutes_before'] as num?)?.toInt();
    // The canonical reminderType is persisted in repeat_rule (see toBackendJson)
    // so the absolute-vs-relative distinction survives a round-trip losslessly.
    // Fall back to inference for older rows that predate this (empty repeat_rule).
    const knownTypes = {'absolute', 'relative', 'recurring'};
    final repeatRule = ((json['repeat_rule'] as String?) ?? '').trim();
    final resolvedType = knownTypes.contains(repeatRule)
        ? repeatRule
        : (repeatType == 'once'
            ? (minutesBefore != null && minutesBefore > 0 ? 'relative' : 'absolute')
            : 'recurring');
    List<String> csv(dynamic v) {
      if (v is String && v.trim().isNotEmpty) {
        return v.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      return const [];
    }

    final offsets = csv(json['lead_offsets']);
    final chans = csv(json['channels']);
    return Reminder(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      remindAt: ts(json['reminder_time']),
      minutesBefore: minutesBefore,
      reminderType: resolvedType,
      repeatPattern: repeatType == 'once' ? null : repeatType,
      isActive: json['enabled'] as bool? ?? true,
      createdAt: ts(json['created_at']),
      eventTime: json['event_time'] != null ? ts(json['event_time']) : null,
      allDay: json['all_day'] as bool? ?? false,
      leadOffsets: offsets.isEmpty ? const ['day_before', 'hour_before'] : offsets,
      channels: chans.isEmpty ? null : chans,
      category: (json['category'] as String?)?.trim().isNotEmpty == true
          ? json['category'] as String
          : 'custom',
    );
  }

  /// The request body the planning-service expects (reverse of fromBackendJson).
  Map<String, dynamic> toBackendJson() {
    return {
      'title': title,
      'reminder_time': remindAt.toUtc().toIso8601String(),
      'repeat_type': reminderType == 'recurring' ? (repeatPattern ?? 'daily') : 'once',
      'repeat_minutes_before': minutesBefore ?? 0,
      // Persist the canonical type so fromBackendJson restores it exactly. The
      // scheduling worker keys off repeat_type only, so repeat_rule is free here.
      'repeat_rule': reminderType,
      'enabled': isActive,
      // Event-reminder fields. event_time is the target the backend derives fires
      // from (defaults to remindAt). For all-day, the caller sets eventTime to
      // local midnight so the reminder fires at 12:00 AM.
      'event_time': (eventTime ?? remindAt).toUtc().toIso8601String(),
      'all_day': allDay,
      'lead_offsets': leadOffsets.join(','),
      // Empty string => backend falls back to the user's profile channel prefs.
      'channels': channels == null ? '' : channels!.join(','),
      'category': category,
    };
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
