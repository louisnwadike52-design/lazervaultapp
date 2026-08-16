import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';

sealed class PlanMyDayState {}

class PlanMyDayInitial extends PlanMyDayState {}

class PlanMyDayLoading extends PlanMyDayState {}

class PlanMyDayLoaded extends PlanMyDayState {
  final List<Event> events;
  final List<Task> tasks;
  final List<TimeBlock> timeBlocks;
  final List<Category> categories;
  final DateTime selectedDate;
  final DailySummary? dailySummary;
  // Calendar-tab-scoped data: the whole visible month's events/time-blocks.
  // Kept SEPARATE from `events`/`timeBlocks` (which are the selected day only)
  // so the Calendar tab can show month-wide markers without changing the state
  // type — the Board/Day/Tasks tabs keep reading the day-scoped lists.
  final List<Event> calendarEvents;
  final List<TimeBlock> calendarTimeBlocks;
  final DateTime? calendarMonth;

  /// True while the day's data is being (re)fetched but we're keeping the
  /// PREVIOUS loaded content on screen. Lets the Day view shimmer only the
  /// sections that change (schedule / events / tasks) instead of blanking the
  /// whole page with a full-screen spinner. See `PlanMyDayCubit._fetchDay`.
  final bool isDayLoading;

  /// CRM contacts resolved by id, so task cards can render a linked-person chip
  /// (the task itself only carries `contactId`). Loaded alongside the day data.
  final Map<String, Contact> contactsById;

  PlanMyDayLoaded({
    required this.events,
    required this.tasks,
    required this.timeBlocks,
    required this.categories,
    required this.selectedDate,
    this.dailySummary,
    this.calendarEvents = const [],
    this.calendarTimeBlocks = const [],
    this.calendarMonth,
    this.isDayLoading = false,
    this.contactsById = const {},
  });

  PlanMyDayLoaded copyWith({
    List<Event>? events,
    List<Task>? tasks,
    List<TimeBlock>? timeBlocks,
    List<Category>? categories,
    DateTime? selectedDate,
    DailySummary? dailySummary,
    List<Event>? calendarEvents,
    List<TimeBlock>? calendarTimeBlocks,
    DateTime? calendarMonth,
    bool? isDayLoading,
    Map<String, Contact>? contactsById,
  }) {
    return PlanMyDayLoaded(
      events: events ?? this.events,
      tasks: tasks ?? this.tasks,
      timeBlocks: timeBlocks ?? this.timeBlocks,
      categories: categories ?? this.categories,
      selectedDate: selectedDate ?? this.selectedDate,
      dailySummary: dailySummary ?? this.dailySummary,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      calendarTimeBlocks: calendarTimeBlocks ?? this.calendarTimeBlocks,
      calendarMonth: calendarMonth ?? this.calendarMonth,
      isDayLoading: isDayLoading ?? this.isDayLoading,
      contactsById: contactsById ?? this.contactsById,
    );
  }

  // ── Subtask grouping ─────────────────────────────────────────────────────
  // Tasks are fetched with include_subtasks, so `tasks` holds parents AND
  // children in one flat list. Top-level views (Day sections, Board columns)
  // show only parents; children surface under their parent (count chip + the
  // task detail sheet). Keeps a subtask from appearing as its own board card.

  /// Parent (non-child) tasks only.
  List<Task> get topLevelTasks =>
      tasks.where((t) => t.parentTaskId == null).toList();

  /// Children of [parentId].
  List<Task> subtasksFor(String parentId) =>
      tasks.where((t) => t.parentTaskId == parentId).toList();

  /// Linked contact for a task, or null.
  Contact? contactFor(Task task) =>
      task.contactId == null ? null : contactsById[task.contactId];

  List<Task> get pendingTasks => tasks.where((t) => !t.isCompleted).toList();
  List<Task> get completedTasks => tasks.where((t) => t.isCompleted).toList();
  List<Task> get highPriorityTasks =>
      tasks.where((t) => t.priority >= 3 && !t.isCompleted).toList();
  List<Task> get overdueTasks => tasks
      .where((t) =>
          !t.isCompleted &&
          t.dueDate != null &&
          t.dueDate!.isBefore(DateTime.now()))
      .toList();

  // ── Day-view grouping ────────────────────────────────────────────────────
  // The task list returned by the gateway is NOT date-filtered, so the Day view
  // scopes it client-side: [tasksForDay] is what belongs to the shown date,
  // while [overdueBeforeToday] and [undatedTasks] surface tasks that would
  // otherwise be invisible on any given day. Board reads the full [tasks] list.

  /// Top-level tasks whose due date falls on [day] (local calendar day).
  List<Task> tasksForDay(DateTime day) => topLevelTasks
      .where((t) => t.dueDate != null && _isSameDay(t.dueDate!, day))
      .toList();

  /// Not-completed top-level tasks whose due date is before the start of today.
  List<Task> get overdueBeforeToday {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    return topLevelTasks
        .where((t) =>
            !t.isCompleted &&
            t.dueDate != null &&
            t.dueDate!.isBefore(todayStart))
        .toList();
  }

  /// Top-level tasks with no due date at all (unscheduled backlog — surfaced in
  /// the Board, not the date-scoped Day view).
  List<Task> get undatedTasks =>
      topLevelTasks.where((t) => t.dueDate == null).toList();
  List<Event> get upcomingEvents =>
      events.where((e) => e.startTime.isAfter(DateTime.now())).toList();
  List<Event> get todayEvents =>
      events.where((e) => _isSameDay(e.startTime, selectedDate)).toList();
}

class TaskDetailLoaded extends PlanMyDayState {
  final Task task;

  TaskDetailLoaded({required this.task});
}

class EventDetailLoaded extends PlanMyDayState {
  final Event event;

  EventDetailLoaded({required this.event});
}

class CategoryListLoaded extends PlanMyDayState {
  final List<Category> categories;

  CategoryListLoaded({required this.categories});
}

class PlanMyDayError extends PlanMyDayState {
  final String message;
  final String? errorCode;
  final dynamic errorData;

  PlanMyDayError(this.message, {this.errorCode, this.errorData});

  bool get isNetworkError => errorCode == 'network_error';
  bool get isServerError => errorCode == 'server_error';
  bool get isAuthError => errorCode == 'auth_error';
  bool get isValidationError => errorCode == 'validation_error';

  /// A transport/backend-reachability failure (as opposed to a validation or
  /// auth error). The inline error UI uses this to decide whether to run a
  /// connectivity check and show a "you're offline" vs "can't reach our servers"
  /// variant.
  bool get isConnectivityError => isNetworkError || isServerError;
}

class TaskCreated extends PlanMyDayState {
  final Task task;

  TaskCreated({required this.task});
}

class TaskUpdated extends PlanMyDayState {
  final Task task;

  TaskUpdated({required this.task});
}

class TaskDeleted extends PlanMyDayState {
  final String taskId;

  TaskDeleted({required this.taskId});
}

class TaskCompleted extends PlanMyDayState {
  final Task task;

  TaskCompleted({required this.task});
}

class EventCreated extends PlanMyDayState {
  final Event event;

  EventCreated({required this.event});
}

class EventUpdated extends PlanMyDayState {
  final Event event;

  EventUpdated({required this.event});
}

class EventDeleted extends PlanMyDayState {
  final String eventId;

  EventDeleted({required this.eventId});
}

class TimeBlockCreated extends PlanMyDayState {
  final TimeBlock timeBlock;

  TimeBlockCreated({required this.timeBlock});
}

class TimeBlockUpdated extends PlanMyDayState {
  final TimeBlock timeBlock;

  TimeBlockUpdated({required this.timeBlock});
}

class TimeBlockDeleted extends PlanMyDayState {
  final String timeBlockId;

  TimeBlockDeleted({required this.timeBlockId});
}

class CategoryCreated extends PlanMyDayState {
  final Category category;

  CategoryCreated({required this.category});
}

class CategoryDeleted extends PlanMyDayState {
  final String categoryId;

  CategoryDeleted({required this.categoryId});
}

class CalendarSyncing extends PlanMyDayState {
  final String? message;

  CalendarSyncing({this.message});
}

class CalendarSynced extends PlanMyDayState {
  final bool success;
  final int eventsAdded;
  final int eventsUpdated;

  CalendarSynced({
    required this.success,
    this.eventsAdded = 0,
    this.eventsUpdated = 0,
  });
}

class EmptyState extends PlanMyDayState {
  final String title;
  final String message;
  final String? actionLabel;

  EmptyState({
    required this.title,
    required this.message,
    this.actionLabel,
  });
}

class ReminderListLoaded extends PlanMyDayState {
  final List<Reminder> reminders;

  ReminderListLoaded({required this.reminders});
}

class ReminderCreated extends PlanMyDayState {
  final Reminder reminder;

  ReminderCreated({required this.reminder});
}

class ReminderUpdated extends PlanMyDayState {
  final Reminder reminder;

  ReminderUpdated({required this.reminder});
}

class ReminderDeleted extends PlanMyDayState {
  final String reminderId;

  ReminderDeleted({required this.reminderId});
}

class WeeklySummaryLoaded extends PlanMyDayState {
  final Map<String, dynamic> summary;

  WeeklySummaryLoaded({required this.summary});
}

class ProductivityInsightsLoaded extends PlanMyDayState {
  final Map<String, dynamic> insights;

  ProductivityInsightsLoaded({required this.insights});
}

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
