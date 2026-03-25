import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';

abstract class IPlanMyDayRepository {
  // Events
  Future<List<Event>> getEvents(DateTime startDate, DateTime endDate);
  Future<Event> getEventById(String id);
  Future<Event> createEvent({
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
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
  });
  Future<void> deleteTask(String id);
  Future<Task> completeTask(String id);

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
}
