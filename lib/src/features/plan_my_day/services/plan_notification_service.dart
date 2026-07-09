import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';

/// Schedules real, OS-level local notifications for Plan My Day reminders so
/// alerts fire even when the app is backgrounded or closed.
///
/// Scheduling uses absolute UTC instants (`zonedSchedule` against `tz.UTC`),
/// so it fires at the right wall-clock moment without needing the device's
/// timezone database to be configured. [onShowNotification] remains as an
/// optional in-app hook for foreground display.
class PlanNotificationService {
  static final PlanNotificationService _instance =
      PlanNotificationService._internal();
  factory PlanNotificationService() => _instance;
  PlanNotificationService._internal();

  static const String _channelId = 'plan_my_day_reminders';
  static const String _channelName = 'Plan My Day Reminders';
  static const String _channelDesc =
      'Task and event reminders from Plan My Day';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Task ids we currently hold scheduled notifications for (so a re-sync can
  /// cancel ones that no longer need a reminder).
  final Set<String> _scheduledTaskIds = {};

  /// Optional in-app callback (e.g. to show an in-app banner in the foreground).
  void Function(String title, String body)? onShowNotification;

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      tzdata.initializeTimeZones();

      const androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      await _plugin.initialize(
        const InitializationSettings(android: androidInit, iOS: iosInit),
      );

      // Android 8+ notification channel.
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDesc,
          importance: Importance.high,
        ),
      );

      _initialized = true;
    } catch (e) {
      debugPrint('PlanNotificationService init failed: $e');
    }
  }

  NotificationDetails get _details => const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      );

  /// Stable 31-bit notification id derived from a string key.
  int _idFor(String key) => key.hashCode & 0x7fffffff;

  Future<void> _scheduleAt({
    required String key,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    await initialize();
    if (!_initialized) {
      onShowNotification?.call(title, body);
      return;
    }
    if (when.isBefore(DateTime.now())) return;
    try {
      final tzWhen = tz.TZDateTime.from(when.toUtc(), tz.UTC);
      await _plugin.zonedSchedule(
        _idFor(key),
        title,
        body,
        tzWhen,
        _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      debugPrint('PlanNotificationService schedule failed for $key: $e');
    }
  }

  /// Schedule a reminder ahead of a task's due date (and an at-due nudge).
  Future<void> scheduleTaskReminder({
    required String taskId,
    required String title,
    String? description,
    required DateTime dueDate,
    int reminderMinutesBefore = 15,
  }) async {
    cancelTaskReminder(taskId);

    final reminderTime =
        dueDate.subtract(Duration(minutes: reminderMinutesBefore));
    final timeStr =
        '${dueDate.hour}:${dueDate.minute.toString().padLeft(2, '0')}';

    await _scheduleAt(
      key: taskId,
      title: 'Task reminder',
      body:
          '$title is due at $timeStr${description != null && description.isNotEmpty ? ' — $description' : ''}',
      when: reminderTime,
    );
    await _scheduleAt(
      key: '${taskId}_due',
      title: 'Task due now',
      body: '$title is due now',
      when: dueDate,
    );
    _scheduledTaskIds.add(taskId);
  }

  /// Schedule a reminder ahead of an event's start.
  Future<void> scheduleEventReminder({
    required String eventId,
    required String title,
    String? location,
    required DateTime startTime,
    int reminderMinutesBefore = 30,
  }) async {
    cancelEventReminder(eventId);
    final reminderTime =
        startTime.subtract(Duration(minutes: reminderMinutesBefore));
    final timeStr =
        '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    await _scheduleAt(
      key: eventId,
      title: 'Event reminder',
      body:
          '$title starts at $timeStr${location != null && location.isNotEmpty ? ' at $location' : ''}',
      when: reminderTime,
    );
  }

  /// Reconcile scheduled task reminders against the current task list. Cancels
  /// reminders for tasks that are gone/completed and (re)schedules the rest
  /// that have a future due date. Safe to call on every board load.
  Future<void> syncTaskSchedules(
    List<Task> tasks, {
    int reminderMinutesBefore = 15,
  }) async {
    await initialize();
    final now = DateTime.now();
    final keep = <String>{};

    for (final t in tasks) {
      final due = t.dueDate;
      final active = !t.isCompleted && !t.isCancelled;
      if (active && due != null && due.isAfter(now)) {
        keep.add(t.id);
        await scheduleTaskReminder(
          taskId: t.id,
          title: t.title,
          description: t.description,
          dueDate: due,
          reminderMinutesBefore: reminderMinutesBefore,
        );
      }
    }

    // Cancel reminders for tasks no longer needing one.
    for (final id in _scheduledTaskIds.difference(keep).toList()) {
      cancelTaskReminder(id);
    }
  }

  Future<void> scheduleDailyPlanningReminder({required TimeOfDay time}) async {
    await initialize();
    final now = DateTime.now();
    var scheduledTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    await _scheduleAt(
      key: 'daily_planning',
      title: 'Plan your day',
      body: 'Take a moment to plan your day for maximum productivity!',
      when: scheduledTime,
    );
  }

  void cancelTaskReminder(String taskId) {
    _plugin.cancel(_idFor(taskId));
    _plugin.cancel(_idFor('${taskId}_due'));
    _scheduledTaskIds.remove(taskId);
  }

  void cancelEventReminder(String eventId) {
    _plugin.cancel(_idFor(eventId));
  }

  void cancelReminder(String key) {
    _plugin.cancel(_idFor(key));
  }

  Future<void> cancelAllReminders() async {
    await _plugin.cancelAll();
    _scheduledTaskIds.clear();
  }

  void dispose() {
    // OS-scheduled notifications persist intentionally; nothing to tear down.
  }
}
