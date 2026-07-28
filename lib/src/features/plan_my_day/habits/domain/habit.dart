import 'package:lazervault/src/features/plan_my_day/domain/entities/plan_timestamp.dart';

/// A habit tracked in Plan My Day (planning-service Habits RPCs).
class Habit {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? frequency; // daily | weekly | custom
  final String? customFrequency;
  final String? color;
  final String? icon;
  final int currentStreak;
  final int longestStreak;
  final int targetStreakDays;
  final String? reminderId;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Habit({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.frequency,
    this.customFrequency,
    this.color,
    this.icon,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.targetStreakDays = 0,
    this.reminderId,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        id: json['id'] as String? ?? '',
        userId: json['user_id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String?,
        frequency: json['frequency'] as String?,
        customFrequency: json['custom_frequency'] as String?,
        color: json['color'] as String?,
        icon: json['icon'] as String?,
        currentStreak: json['current_streak'] as int? ?? 0,
        longestStreak: json['longest_streak'] as int? ?? 0,
        targetStreakDays: json['target_streak_days'] as int? ?? 0,
        reminderId: json['reminder_id'] as String?,
        isActive: json['is_active'] as bool? ?? true,
        createdAt: parsePlanTimestamp(json['created_at']),
        updatedAt: parsePlanTimestamp(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        if (description != null) 'description': description,
        if (frequency != null) 'frequency': frequency,
        if (customFrequency != null) 'custom_frequency': customFrequency,
        if (color != null) 'color': color,
        if (icon != null) 'icon': icon,
        if (targetStreakDays > 0) 'target_streak_days': targetStreakDays,
        'is_active': isActive,
      };
}
