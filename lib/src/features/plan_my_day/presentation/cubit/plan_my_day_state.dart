import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';

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

  PlanMyDayLoaded({
    required this.events,
    required this.tasks,
    required this.timeBlocks,
    required this.categories,
    required this.selectedDate,
    this.dailySummary,
  });

  PlanMyDayLoaded copyWith({
    List<Event>? events,
    List<Task>? tasks,
    List<TimeBlock>? timeBlocks,
    List<Category>? categories,
    DateTime? selectedDate,
    DailySummary? dailySummary,
  }) {
    return PlanMyDayLoaded(
      events: events ?? this.events,
      tasks: tasks ?? this.tasks,
      timeBlocks: timeBlocks ?? this.timeBlocks,
      categories: categories ?? this.categories,
      selectedDate: selectedDate ?? this.selectedDate,
      dailySummary: dailySummary ?? this.dailySummary,
    );
  }

  List<Task> get pendingTasks => tasks.where((t) => !t.isCompleted).toList();
  List<Task> get completedTasks => tasks.where((t) => t.isCompleted).toList();
  List<Task> get highPriorityTasks => tasks.where((t) => t.priority >= 3 && !t.isCompleted).toList();
  List<Task> get overdueTasks => tasks.where((t) => !t.isCompleted && t.dueDate != null && t.dueDate!.isBefore(DateTime.now())).toList();
  List<Event> get upcomingEvents => events.where((e) => e.startTime.isAfter(DateTime.now())).toList();
  List<Event> get todayEvents => events.where((e) => _isSameDay(e.startTime, selectedDate)).toList();
}

class PlanMyDayCalendarView extends PlanMyDayState {
  final List<Event> events;
  final List<TimeBlock> timeBlocks;
  final DateTime selectedMonth;
  final Map<String, List<Event>> eventsByDate;
  final Map<String, List<TimeBlock>> timeBlocksByDate;

  PlanMyDayCalendarView({
    required this.events,
    required this.timeBlocks,
    required this.selectedMonth,
    Map<String, List<Event>>? eventsByDate,
    Map<String, List<TimeBlock>>? timeBlocksByDate,
  })  : eventsByDate = eventsByDate ?? _groupEventsByDate(events),
        timeBlocksByDate = timeBlocksByDate ?? _groupTimeBlocksByDate(timeBlocks);

  static Map<String, List<Event>> _groupEventsByDate(List<Event> events) {
    final Map<String, List<Event>> grouped = {};
    for (final event in events) {
      final dateKey = _formatDateKey(event.startTime);
      grouped.putIfAbsent(dateKey, () => []).add(event);
    }
    return grouped;
  }

  static Map<String, List<TimeBlock>> _groupTimeBlocksByDate(List<TimeBlock> blocks) {
    final Map<String, List<TimeBlock>> grouped = {};
    for (final block in blocks) {
      grouped.putIfAbsent(block.date, () => []).add(block);
    }
    return grouped;
  }

  static String _formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class TaskListLoaded extends PlanMyDayState {
  final List<Task> tasks;
  final String? filterStatus;

  TaskListLoaded({
    required this.tasks,
    this.filterStatus,
  });

  List<Task> get filteredTasks {
    if (filterStatus == null || filterStatus!.isEmpty) {
      return tasks;
    }
    return tasks.where((t) => t.status == filterStatus).toList();
  }
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
  bool get isAuthError => errorCode == 'auth_error';
  bool get isValidationError => errorCode == 'validation_error';
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

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
