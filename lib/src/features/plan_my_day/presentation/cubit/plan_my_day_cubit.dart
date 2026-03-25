import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart' as plan;
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/domain/repositories/i_plan_my_day_repository.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';

class PlanMyDayCubit extends Cubit<PlanMyDayState> {
  final IPlanMyDayRepository _repository;
  PlanMyDayLoaded? _cachedState;

  PlanMyDayCubit(this._repository) : super(PlanMyDayInitial());

  // ==================== DATA LOADING ====================

  Future<void> loadDayData(DateTime date, {bool forceRefresh = false}) async {
    emit(PlanMyDayLoading());

    try {
      // Use cached data if available and not forcing refresh
      if (_cachedState != null &&
          !forceRefresh &&
          _isSameDay(_cachedState!.selectedDate, date)) {
        emit(_cachedState!);
        return;
      }

      final startDate = DateTime(date.year, date.month, date.day);
      final endDate = startDate.add(const Duration(days: 1));

      final results = await Future.wait([
        _repository.getEvents(startDate, endDate),
        _repository.getTasks(startDate: startDate, endDate: endDate),
        _repository.getTimeBlocks(date: _toDateString(date)),
        _repository.getCategories(type: ''),
      ]);

      final events = results[0] as List<Event>;
      final tasks = results[1] as List<Task>;
      final timeBlocks = results[2] as List<TimeBlock>;
      final categories = results[3] as List<plan.Category>;

      DailySummary? dailySummary;
      try {
        dailySummary = await _repository.getDailySummary(_toDateString(date));
      } catch (_) {
        // Continue without summary if it fails
        dailySummary = null;
      }

      final state = PlanMyDayLoaded(
        events: events,
        tasks: tasks,
        timeBlocks: timeBlocks,
        categories: categories,
        selectedDate: date,
        dailySummary: dailySummary,
      );

      _cachedState = state;
      if (!isClosed) emit(state);
    } catch (e) {
      if (!isClosed) emit(_parseError(e, 'Failed to load day data'));
    }
  }

  Future<void> loadCalendarMonth(DateTime month) async {
    try {
      final startDate = DateTime(month.year, month.month, 1);
      final endDate = DateTime(month.year, month.month + 1, 1);

      final results = await Future.wait([
        _repository.getEvents(startDate, endDate),
        _repository.getTimeBlocks(
          startDate: _toDateString(startDate),
          endDate: _toDateString(endDate),
        ),
      ]);

      if (!isClosed) {
        emit(PlanMyDayCalendarView(
          events: results[0] as List<Event>,
          timeBlocks: results[1] as List<TimeBlock>,
          selectedMonth: month,
        ));
      }
    } catch (e) {
      if (!isClosed) emit(_parseError(e, 'Failed to load calendar'));
    }
  }

  Future<void> loadTasks({String status = '', DateTime? startDate, DateTime? endDate}) async {
    try {
      final tasks = await _repository.getTasks(
        status: status,
        startDate: startDate,
        endDate: endDate,
      );
      if (!isClosed) {
        emit(TaskListLoaded(tasks: tasks, filterStatus: status.isEmpty ? null : status));
      }
    } catch (e) {
      if (!isClosed) emit(_parseError(e, 'Failed to load tasks'));
    }
  }

  Future<void> loadCategories() async {
    try {
      final categories = await _repository.getCategories(type: '');
      if (!isClosed) {
        emit(CategoryListLoaded(categories: categories));
      }
    } catch (e) {
      if (!isClosed) emit(_parseError(e, 'Failed to load categories'));
    }
  }

  // ==================== TASK OPERATIONS ====================

  Future<void> createTask({
    required String title,
    String? description,
    DateTime? dueDate,
    int priority = 2,
    List<String> categoryIds = const [],
    String? parentTaskId,
    String? recurringRule,
    String? estimatedDuration,
    List<String> reminderIds = const [],
  }) async {
    try {
      final previousState = state;
      final task = await _repository.createTask(
        title: title.trim(),
        description: description?.trim(),
        dueDate: dueDate,
        priority: priority,
        categoryIds: categoryIds,
        parentTaskId: parentTaskId,
        recurringRule: recurringRule,
        estimatedDuration: estimatedDuration,
        reminderIds: reminderIds,
      );

      if (!isClosed) {
        emit(TaskCreated(task: task));
        // Reload data to get fresh state
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to create task'));
    }
  }

  Future<void> updateTask({
    required String id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    String? status,
    List<String>? categoryIds,
    String? estimatedDuration,
  }) async {
    try {
      final task = await _repository.updateTask(
        id: id,
        title: title?.trim(),
        description: description?.trim(),
        dueDate: dueDate,
        priority: priority,
        status: status,
        categoryIds: categoryIds,
        estimatedDuration: estimatedDuration,
      );

      if (!isClosed) {
        emit(TaskUpdated(task: task));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to update task'));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _repository.deleteTask(id);

      if (!isClosed) {
        emit(TaskDeleted(taskId: id));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to delete task'));
    }
  }

  Future<void> completeTask(String id, {DateTime? completedAt}) async {
    try {
      final task = await _repository.completeTask(id);

      if (!isClosed) {
        emit(TaskCompleted(task: task));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to complete task'));
    }
  }

  Future<void> toggleTaskStatus(String id) async {
    try {
      // Find the task first
      Task? task;
      if (_cachedState != null) {
        task = _cachedState!.tasks.firstWhere(
          (t) => t.id == id,
          orElse: () => throw Exception('Task not found'),
        );
      } else {
        // Need to fetch tasks first
        final tasks = await _repository.getTasks();
        task = tasks.firstWhere(
          (t) => t.id == id,
          orElse: () => throw Exception('Task not found'),
        );
      }

      if (task.isCompleted) {
        // Uncomplete - set to pending
        await updateTask(id: id, status: 'pending');
      } else {
        // Complete
        await completeTask(id);
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to toggle task status'));
    }
  }

  // ==================== EVENT OPERATIONS ====================

  Future<void> createEvent({
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    List<String> categoryIds = const [],
    bool isAllDay = false,
    String? recurrenceRule,
    List<String> reminderIds = const [],
  }) async {
    // Validation
    if (endTime.isBefore(startTime)) {
      _emitAndRestore(PlanMyDayError('End time must be after start time'));
      return;
    }

    try {
      final event = await _repository.createEvent(
        title: title.trim(),
        description: description?.trim(),
        startTime: startTime,
        endTime: endTime,
        location: location?.trim(),
        categoryIds: categoryIds,
        isAllDay: isAllDay,
      );

      if (!isClosed) {
        emit(EventCreated(event: event));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to create event'));
    }
  }

  Future<void> updateEvent({
    required String id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    List<String>? categoryIds,
    bool? isAllDay,
  }) async {
    // Validation
    if (startTime != null && endTime != null && endTime.isBefore(startTime)) {
      _emitAndRestore(PlanMyDayError('End time must be after start time'));
      return;
    }

    try {
      final event = await _repository.updateEvent(
        id: id,
        title: title?.trim(),
        description: description?.trim(),
        startTime: startTime,
        endTime: endTime,
        location: location?.trim(),
        categoryIds: categoryIds,
        isAllDay: isAllDay,
      );

      if (!isClosed) {
        emit(EventUpdated(event: event));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to update event'));
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _repository.deleteEvent(id);

      if (!isClosed) {
        emit(EventDeleted(eventId: id));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to delete event'));
    }
  }

  // ==================== TIME BLOCK OPERATIONS ====================

  Future<void> createTimeBlock({
    required String date,
    required String startTime,
    required String endTime,
    required String title,
    String? description,
    String type = 'other',
    List<String> taskIds = const [],
    List<String> eventIds = const [],
    String? color,
    bool isLocked = false,
  }) async {
    // Validation
    if (_parseTime(startTime) >= _parseTime(endTime)) {
      _emitAndRestore(PlanMyDayError('End time must be after start time'));
      return;
    }

    try {
      final timeBlock = await _repository.createTimeBlock(
        date: date,
        startTime: startTime,
        endTime: endTime,
        title: title.trim(),
        description: description?.trim(),
        type: type,
        taskIds: taskIds,
        eventIds: eventIds,
        color: color,
        isLocked: isLocked,
      );

      if (!isClosed) {
        emit(TimeBlockCreated(timeBlock: timeBlock));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to create time block'));
    }
  }

  Future<void> updateTimeBlock({
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
  }) async {
    try {
      final timeBlock = await _repository.updateTimeBlock(
        id: id,
        date: date,
        startTime: startTime,
        endTime: endTime,
        title: title?.trim(),
        description: description?.trim(),
        type: type,
        taskIds: taskIds,
        eventIds: eventIds,
        color: color,
        isLocked: isLocked,
      );

      if (!isClosed) {
        emit(TimeBlockUpdated(timeBlock: timeBlock));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to update time block'));
    }
  }

  Future<void> deleteTimeBlock(String id) async {
    try {
      await _repository.deleteTimeBlock(id);

      if (!isClosed) {
        emit(TimeBlockDeleted(timeBlockId: id));
        if (_cachedState != null) {
          await loadDayData(_cachedState!.selectedDate);
        }
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to delete time block'));
    }
  }

  // ==================== CATEGORY OPERATIONS ====================

  Future<void> createCategory({
    required String name,
    String? icon,
    String? color,
    String type = 'both',
  }) async {
    try {
      final category = await _repository.createCategory(
        name: name.trim(),
        icon: icon,
        color: color,
        type: type,
      );

      if (!isClosed) {
        emit(CategoryCreated(category: category));
        // Refresh categories list
        await loadCategories();
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to create category'));
    }
  }

  Future<void> updateCategory({
    required String id,
    String? name,
    String? icon,
    String? color,
  }) async {
    try {
      final category = await _repository.updateCategory(
        id: id,
        name: name?.trim(),
        icon: icon,
        color: color,
      );

      if (!isClosed) {
        // Refresh categories list
        await loadCategories();
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to update category'));
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _repository.deleteCategory(id);

      if (!isClosed) {
        emit(CategoryDeleted(categoryId: id));
        await loadCategories();
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to delete category'));
    }
  }

  // ==================== UTILITY METHODS ====================

  void clearError() {
    if (_cachedState != null && !isClosed) {
      emit(_cachedState!);
    }
  }

  void refresh() {
    if (_cachedState != null) {
      loadDayData(_cachedState!.selectedDate, forceRefresh: true);
    }
  }

  // ==================== PRIVATE HELPERS ====================

  PlanMyDayError _parseError(dynamic error, String defaultMessage) {
    String message = defaultMessage;
    String? errorCode;

    if (error is Exception) {
      final errorStr = error.toString();
      if (errorStr.contains('Exception: ')) {
        message = errorStr.substring(11);
      } else {
        message = errorStr;
      }

      // Detect error types
      if (message.contains('network') || message.contains('connection')) {
        errorCode = 'network_error';
      } else if (message.contains('401') || message.contains('unauthorized') || message.contains('auth')) {
        errorCode = 'auth_error';
      } else if (message.contains('400') || message.contains('validation')) {
        errorCode = 'validation_error';
      }
    }

    return PlanMyDayError(message, errorCode: errorCode);
  }

  void _emitAndRestore(PlanMyDayState errorState) {
    if (!isClosed) {
      emit(errorState);
      // Restore previous state after a delay if it was an error
      if (errorState is PlanMyDayError && _cachedState != null) {
        Future.delayed(const Duration(seconds: 3), () {
          if (!isClosed && state is PlanMyDayError) {
            emit(_cachedState!);
          }
        });
      }
    }
  }

  String _toDateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  int _parseTime(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}
