import 'dart:async';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter/widgets.dart';

/// Service for scheduling local notifications for Plan My Day reminders
/// This is a simplified version that can be extended with flutter_local_notifications package
class PlanNotificationService {
  static final PlanNotificationService _instance = PlanNotificationService._internal();
  factory PlanNotificationService() => _instance;
  PlanNotificationService._internal();

  bool _initialized = false;
  final Map<String, Timer> _scheduledTimers = {};

  // Callback to show notification (to be connected to actual notification plugin)
  void Function(String title, String body)? onShowNotification;

  /// Initialize the notification service. Timezone bootstrapping is
  /// intentionally omitted — the scheduler here uses `DateTime.difference`
  /// against the device's local clock, which already reflects the user's
  /// timezone. Once we integrate `flutter_local_notifications`, this is
  /// where we'd call `tz.setLocalLocation(tz.getLocation(deviceTz))`.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
  }

  /// Schedule a task reminder notification
  ///
  /// [taskId] - Unique identifier for the task
  /// [title] - Task title
  /// [description] - Task description
  /// [dueDate] - When the task is due
  /// [reminderMinutesBefore] - How many minutes before due date to remind (default: 15)
  Future<void> scheduleTaskReminder({
    required String taskId,
    required String title,
    String? description,
    required DateTime dueDate,
    int reminderMinutesBefore = 15,
  }) async {
    await initialize();

    // Cancel any existing reminder for this task
    cancelTaskReminder(taskId);

    final reminderTime = dueDate.subtract(Duration(minutes: reminderMinutesBefore));
    final now = DateTime.now();

    if (reminderTime.isBefore(now)) {
      // Reminder time has passed, don't schedule
      return;
    }

    final delay = reminderTime.difference(now);

    // Schedule the notification
    _scheduledTimers[taskId] = Timer(delay, () {
      _showTaskReminderNotification(title, description, dueDate);
    });

    // Also schedule a notification at the exact due time if not completed
    final dueTimerKey = '${taskId}_due';
    final dueDelay = dueDate.difference(now);
    if (dueDelay.inSeconds > 0) {
      _scheduledTimers[dueTimerKey] = Timer(dueDelay, () {
        _showTaskDueNotification(title);
      });
    }
  }

  /// Schedule an event reminder notification
  ///
  /// [eventId] - Unique identifier for the event
  /// [title] - Event title
  /// [location] - Event location
  /// [startTime] - When the event starts
  /// [reminderMinutesBefore] - How many minutes before start to remind (default: 30)
  Future<void> scheduleEventReminder({
    required String eventId,
    required String title,
    String? location,
    required DateTime startTime,
    int reminderMinutesBefore = 30,
  }) async {
    await initialize();

    // Cancel any existing reminder for this event
    cancelEventReminder(eventId);

    final reminderTime = startTime.subtract(Duration(minutes: reminderMinutesBefore));
    final now = DateTime.now();

    if (reminderTime.isBefore(now)) {
      return;
    }

    final delay = reminderTime.difference(now);

    _scheduledTimers[eventId] = Timer(delay, () {
      _showEventReminderNotification(title, location, startTime);
    });
  }

  /// Schedule a recurring reminder for daily planning
  Future<void> scheduleDailyPlanningReminder({
    required TimeOfDay time,
  }) async {
    await initialize();

    final key = 'daily_planning';
    cancelReminder(key);

    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final delay = scheduledTime.difference(now);

    _scheduledTimers[key] = Timer(delay, () {
      onShowNotification?.call(
        'Plan Your Day',
        'Take a moment to plan your day for maximum productivity!',
      );
      // Reschedule for next day
      scheduleDailyPlanningReminder(time: time);
    });
  }

  /// Cancel a task reminder
  void cancelTaskReminder(String taskId) {
    _scheduledTimers[taskId]?.cancel();
    _scheduledTimers.remove(taskId);
    _scheduledTimers['${taskId}_due']?.cancel();
    _scheduledTimers.remove('${taskId}_due');
  }

  /// Cancel an event reminder
  void cancelEventReminder(String eventId) {
    _scheduledTimers[eventId]?.cancel();
    _scheduledTimers.remove(eventId);
  }

  /// Cancel a specific reminder by key
  void cancelReminder(String key) {
    _scheduledTimers[key]?.cancel();
    _scheduledTimers.remove(key);
  }

  /// Cancel all reminders
  void cancelAllReminders() {
    for (final timer in _scheduledTimers.values) {
      timer.cancel();
    }
    _scheduledTimers.clear();
  }

  /// Show notification for task reminder
  void _showTaskReminderNotification(String title, String? description, DateTime dueDate) {
    final timeStr = '${dueDate.hour}:${dueDate.minute.toString().padLeft(2, '0')}';
    onShowNotification?.call(
      'Task Reminder',
      '$title is due at $timeStr. ${description ?? ''}',
    );
  }

  /// Show notification for task due
  void _showTaskDueNotification(String title) {
    onShowNotification?.call(
      'Task Due Now',
      '$title is due now!',
    );
  }

  /// Show notification for event reminder
  void _showEventReminderNotification(String title, String? location, DateTime startTime) {
    final timeStr = '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    final locationStr = location != null ? ' at $location' : '';
    onShowNotification?.call(
      'Event Reminder',
      '$title starts at $timeStr$locationStr',
    );
  }

  /// Dispose of resources
  void dispose() {
    cancelAllReminders();
  }
}
