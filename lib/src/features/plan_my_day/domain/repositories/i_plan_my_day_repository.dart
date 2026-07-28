import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';

abstract class IPlanMyDayRepository {
  // Events
  Future<List<Event>> getEvents(DateTime startDate, DateTime endDate);
  Future<Event> getEventById(String id);
  Future<Event> createEvent({
    required String title,
    String? description,
    required DateTime startTime,
    DateTime? endTime, // optional — a point-in-time event has no end
    String? location,
    List<String> categoryIds,
    bool isAllDay,
  });
  Future<Event> updateEvent({
    required String id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    List<String>? categoryIds,
    bool? isAllDay,
  });
  Future<void> deleteEvent(String id);

  // Tasks
  Future<List<Task>> getTasks({
    String status,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? categoryIds,
    int? priority,
    String? parentTaskId,
    bool includeSubtasks = false,
  });
  Future<Task> getTaskById(String id);
  Future<Task> createTask({
    required String title,
    String? description,
    DateTime? dueDate,
    int priority,
    List<String> categoryIds,
    String? parentTaskId,
    String? recurringRule,
    String? estimatedDuration,
    List<String> reminderIds,
  });
  Future<Task> updateTask({
    required String id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    String? status,
    List<String>? categoryIds,
    String? estimatedDuration,
    String? contactId,
    // When true, explicitly clear the due date (send due_date:"") instead of
    // leaving it unchanged — dueDate:null alone means "not provided".
    bool clearDueDate,
  });
  Future<void> deleteTask(String id);
  Future<Task> completeTask(String id);

  /// Move a task to another board column / status (CRM/Kanban).
  /// status ∈ pending, in_progress, blocked, in_review, completed, cancelled.
  /// [boardOrder], when given, sets the drop position in the target column.
  Future<Task> moveTask(String id, String status, {int? boardOrder});

  /// Persist a whole column's top-to-bottom order after a drag reorder.
  /// [taskIds] is the new order; each task's board_order becomes its index and
  /// its status is set to [status].
  Future<void> reorderTasks(String status, List<String> taskIds);

  // Time Blocks
  Future<List<TimeBlock>> getTimeBlocks({
    String? date,
    String? startDate,
    String? endDate,
  });
  Future<TimeBlock> createTimeBlock({
    required String date,
    required String startTime,
    required String endTime,
    required String title,
    String? description,
    String type,
    List<String> taskIds,
    List<String> eventIds,
    String? color,
    bool isLocked,
  });
  Future<TimeBlock> updateTimeBlock({
    required String id,
    String? date,
    String? startTime,
    String? endTime,
    String? title,
    String? description,
    String? type,
    List<String>? taskIds,
    List<String>? eventIds,
    String? color,
    bool? isLocked,
  });
  Future<void> deleteTimeBlock(String id);

  // Categories
  Future<List<Category>> getCategories({String? type});
  Future<Category> createCategory({
    required String name,
    String? icon,
    String? color,
    String type,
  });
  Future<Category> updateCategory({
    required String id,
    String? name,
    String? icon,
    String? color,
  });
  Future<void> deleteCategory(String id);

  // Analytics
  Future<DailySummary> getDailySummary(String date);

  // Reminders
  Future<List<Reminder>> getReminders({
    bool enabledOnly = false,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Reminder> createReminder(Reminder reminder);
  Future<Reminder> updateReminder(String id, Reminder reminder);
  Future<void> deleteReminder(String id);

  // Weekly summary + productivity insights (raw maps — screens shape their own view)
  Future<Map<String, dynamic>> getWeeklySummary({String? startDate});
  Future<Map<String, dynamic>> getProductivityInsights({String period = 'week'});
}
