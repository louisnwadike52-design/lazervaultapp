import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart'
    as plan;
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';
import 'package:lazervault/src/features/plan_my_day/domain/repositories/i_plan_my_day_repository.dart';
import 'package:lazervault/src/features/plan_my_day/data/repositories/plan_my_day_repository_impl.dart'
    show
        PlanMyDayException,
        PlanMyDayNetworkException,
        PlanMyDayAuthException,
        PlanMyDayValidationException,
        PlanMyDayNotFoundException,
        PlanMyDayApiException;
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/data/contact_repository.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';

class PlanMyDayCubit extends Cubit<PlanMyDayState> {
  final IPlanMyDayRepository _repository;
  // CRM contacts, so task cards can show a linked-person chip. Read-only here;
  // the People segment owns contact mutations via its own ContactCubit.
  final ContactRepository _contactRepository;
  PlanMyDayLoaded? _cachedState;

  PlanMyDayCubit(this._repository, this._contactRepository)
      : super(PlanMyDayInitial());

  // ==================== DATA LOADING ====================

  /// Load the agenda for [date]. Used by day-selection, pull-to-refresh, and the
  /// initial load. When we already have data on screen the previous content is
  /// KEPT and only the changing sections shimmer (via [PlanMyDayLoaded.isDayLoading])
  /// instead of blanking the whole page with a spinner.
  Future<void> loadDayData(DateTime date, {bool forceRefresh = false}) async {
    // Same day, already cached, not forcing → serve instantly, no flash.
    final cached = _cachedState;
    if (cached != null &&
        !forceRefresh &&
        _isSameDay(cached.selectedDate, date)) {
      if (!isClosed) emit(cached);
      return;
    }
    await _fetchDay(date, showSkeleton: true);
  }

  /// Silently re-fetch the currently-selected day after a mutation. No skeleton:
  /// the fresh lists arrive and only the sections that actually changed rebuild.
  /// The optimistic move/reorder paths bypass this and patch state directly.
  Future<void> _refreshCurrentDay() async {
    final date = _cachedState?.selectedDate ?? DateTime.now();
    await _fetchDay(date, showSkeleton: false);
  }

  /// Fetch + emit the agenda for [date]. When [showSkeleton] and we already have
  /// data, flip the day-loading flag (keeps header + week strip live, shimmers
  /// the sections). With no prior data, fall back to the full-screen skeleton
  /// (PlanMyDayLoading). When not [showSkeleton], fetch quietly and swap in the
  /// new content when it arrives.
  Future<void> _fetchDay(DateTime date, {required bool showSkeleton}) async {
    final cached = _cachedState;
    if (cached != null) {
      if (showSkeleton && !isClosed) {
        emit(cached.copyWith(selectedDate: date, isDayLoading: true));
      }
    } else if (!isClosed) {
      emit(PlanMyDayLoading());
    }

    try {
      final startDate = DateTime(date.year, date.month, date.day);
      final endDate = startDate.add(const Duration(days: 1));

      final results = await Future.wait([
        _repository.getEvents(startDate, endDate),
        // include_subtasks so parents AND children come back in one list; the UI
        // nests children under their parent and never shows them as loose cards.
        _repository.getTasks(
            startDate: startDate, endDate: endDate, includeSubtasks: true),
        _repository.getTimeBlocks(date: _toDateString(date)),
        _repository.getCategories(type: ''),
        // Contacts for the linked-person chip. Best-effort — a CRM hiccup must
        // never block the day from loading.
        _loadContactsSafely(),
      ]);

      final events = results[0] as List<Event>;
      final tasks = results[1] as List<Task>;
      final timeBlocks = results[2] as List<TimeBlock>;
      final categories = results[3] as List<plan.Category>;
      final contactsById = results[4] as Map<String, Contact>;

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
        contactsById: contactsById,
      );

      _cachedState = state;
      if (!isClosed) emit(state);
    } catch (e) {
      if (!isClosed) emit(_parseError(e, 'Failed to load day data'));
    }
  }

  /// Fetch contacts as an id→Contact map; never throws (returns {} on failure)
  /// so a CRM hiccup can't block the day board from loading.
  Future<Map<String, Contact>> _loadContactsSafely() async {
    try {
      final contacts = await _contactRepository.getContacts();
      return {for (final c in contacts) c.id: c};
    } catch (_) {
      return _cachedState?.contactsById ?? const {};
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
    // When set, a reminder is created for this timeframe and linked to the task;
    // the planning-service worker fires it (push/email/SMS) at [remindAt].
    DateTime? remindAt,
    String? remindRepeat, // 'once' | 'daily' | 'weekly' | 'monthly'
  }) async {
    try {
      final ids = List<String>.from(reminderIds);
      var reminderFailed = false;
      if (remindAt != null) {
        try {
          final reminder = await _repository.createReminder(Reminder(
            id: '',
            userId: '',
            title: title.trim(),
            remindAt: remindAt,
            reminderType:
                (remindRepeat ?? 'once') == 'once' ? 'absolute' : 'recurring',
            repeatPattern:
                (remindRepeat ?? 'once') == 'once' ? null : remindRepeat,
            isActive: true,
            createdAt: DateTime.now(),
          ));
          if (reminder.id.isNotEmpty) ids.add(reminder.id);
        } catch (_) {
          // Don't block task creation, but remember so we can tell the user the
          // reminder wasn't set (previously this failed completely silently).
          reminderFailed = true;
        }
      }
      final task = await _repository.createTask(
        title: title.trim(),
        description: description?.trim(),
        dueDate: dueDate,
        priority: priority,
        categoryIds: categoryIds,
        parentTaskId: parentTaskId,
        recurringRule: recurringRule,
        estimatedDuration: estimatedDuration,
        reminderIds: ids,
      );

      if (!isClosed) {
        emit(TaskCreated(task: task));
        // Reload data to get fresh state
        await _refreshCurrentDay();
        // The task saved; if only its reminder failed, tell the user (non-blocking).
        if (reminderFailed && !isClosed) {
          _emitAndRestore(PlanMyDayError(
              "Task created, but its reminder couldn't be set. Add it again from the task if you need it."));
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
    String? contactId,
    bool clearDueDate = false,
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
        contactId: contactId,
        clearDueDate: clearDueDate,
      );

      if (!isClosed) {
        emit(TaskUpdated(task: task));
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
      }
    } catch (e) {
      _emitAndRestore(_parseError(e, 'Failed to complete task'));
    }
  }

  /// Duplicate a task — clones the editable fields into a brand-new task.
  /// Status/board position/completion reset to defaults (a fresh To-do).
  Future<void> duplicateTask(Task task) async {
    await createTask(
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      priority: task.priority,
      categoryIds: task.categoryIds,
      estimatedDuration: task.estimatedDuration,
    );
  }

  /// Create a child task under [parentTaskId] (the backend + proto already
  /// support parent_task_id; this is just a convenience over createTask).
  Future<void> addSubtask(
    String parentTaskId,
    String title, {
    DateTime? dueDate,
    int priority = 2,
  }) async {
    await createTask(
      title: title,
      parentTaskId: parentTaskId,
      dueDate: dueDate,
      priority: priority,
    );
  }

  /// Change only a task's due date ("Change day" / reschedule / drag-to-day).
  Future<void> rescheduleTask(String id, DateTime dueDate) async {
    await updateTask(id: id, dueDate: dueDate);
  }

  /// Set only a task's priority (1-4).
  Future<void> setPriority(String id, int priority) async {
    await updateTask(id: id, priority: priority);
  }

  /// Link (or unlink with empty string) a task to a CRM contact.
  Future<void> linkContact(String id, String contactId) async {
    await updateTask(id: id, contactId: contactId);
  }

  /// Move a task to another board column / status (CRM/Kanban drag or menu).
  ///
  /// Optimistic: the card jumps to the new column immediately; we reconcile
  /// with the server result, or revert + surface an error if the call fails.
  Future<void> moveTask(String id, String newStatus, {int? boardOrder}) async {
    final cached = _cachedState;
    if (cached == null) {
      // No board loaded — fall back to a plain update/complete.
      if (newStatus == 'completed') {
        await completeTask(id);
      } else {
        await updateTask(id: id, status: newStatus);
      }
      return;
    }

    final idx = cached.tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final original = cached.tasks[idx];
    if (original.status == newStatus && boardOrder == null) return;

    final isComplete = newStatus == 'completed';
    final optimistic = original.copyWith(
      status: newStatus,
      completionPercentage: isComplete ? 100 : original.completionPercentage,
      completedAt: isComplete ? DateTime.now() : original.completedAt,
      boardOrder: boardOrder ?? original.boardOrder,
    );

    final optimisticTasks = List<Task>.from(cached.tasks)..[idx] = optimistic;
    var working = cached.copyWith(tasks: optimisticTasks);
    _cachedState = working;
    if (!isClosed) emit(working);

    try {
      final saved =
          await _repository.moveTask(id, newStatus, boardOrder: boardOrder);
      final tasks = List<Task>.from(_cachedState!.tasks);
      final ri = tasks.indexWhere((t) => t.id == id);
      if (ri != -1) tasks[ri] = saved;
      working = _cachedState!.copyWith(tasks: tasks);
      _cachedState = working;
      if (!isClosed) emit(working);
    } catch (e) {
      // Revert the optimistic move, then show the error briefly.
      final tasks = List<Task>.from(_cachedState!.tasks);
      final ri = tasks.indexWhere((t) => t.id == id);
      if (ri != -1) tasks[ri] = original;
      final reverted = _cachedState!.copyWith(tasks: tasks);
      _cachedState = reverted;
      if (!isClosed) {
        emit(_parseError(e, 'Failed to move task'));
        Future.delayed(const Duration(seconds: 2), () {
          if (!isClosed && state is PlanMyDayError) emit(reverted);
        });
      }
    }
  }

  /// Reorder a single status column after a drag-reorder. [orderedIds] is the
  /// new top-to-bottom order of that column. Optimistic: applies board_order
  /// locally and re-emits, then persists; on failure reloads from the server.
  Future<void> reorderColumn(String status, List<String> orderedIds) async {
    final cached = _cachedState;
    if (cached == null) return;

    // Apply the new order optimistically by stamping board_order = index.
    final orderIndex = {
      for (var i = 0; i < orderedIds.length; i++) orderedIds[i]: i
    };
    final tasks = cached.tasks.map((t) {
      final oi = orderIndex[t.id];
      return oi == null ? t : t.copyWith(status: status, boardOrder: oi);
    }).toList();
    final working = cached.copyWith(tasks: tasks);
    _cachedState = working;
    if (!isClosed) emit(working);

    try {
      await _repository.reorderTasks(status, orderedIds);
    } catch (e) {
      // Reload authoritative order on failure.
      await loadDayData(cached.selectedDate, forceRefresh: true);
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
    DateTime? endTime, // optional — a point-in-time event has no end
    String? location,
    List<String> categoryIds = const [],
    bool isAllDay = false,
    String? recurrenceRule,
    List<String> reminderIds = const [],
  }) async {
    // Validation — only when an end time was actually provided.
    if (endTime != null && endTime.isBefore(startTime)) {
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
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
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
        await _refreshCurrentDay();
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
    // Classify by exception TYPE (the repository throws typed exceptions), not by
    // fragile substring matching — the old checks were case-sensitive and missed
    // 'Network error…' / 'Request timed out'. The errorCode drives the inline
    // error UI, which distinguishes the user's own connectivity from a backend
    // outage. Neither ever raises the pre-login maintenance modal (that overlay
    // is auth-screens-only — see AppStartupGate).
    if (error is PlanMyDayAuthException) {
      return PlanMyDayError(
        'Your session has expired. Please sign in again.',
        errorCode: 'auth_error',
      );
    }
    if (error is PlanMyDayValidationException) {
      return PlanMyDayError(
        _cleanMessage(error.message, defaultMessage),
        errorCode: 'validation_error',
        errorData: error.details,
      );
    }
    if (error is PlanMyDayNetworkException) {
      // Transport-level: no HTTP response reached us (socket error / timeout).
      // This is EITHER the user's own network OR the backend being unreachable —
      // the inline error widget resolves which via a live connectivity check.
      return PlanMyDayError(
        "We couldn't reach Plan My Day. Check your connection and try again.",
        errorCode: 'network_error',
      );
    }
    if (error is PlanMyDayApiException) {
      // A 5xx means the edge answered but the backend erred — a SERVER problem,
      // not the user's network. Kept inline (never the maintenance modal).
      final serverDown = const {500, 502, 503, 504}.contains(error.statusCode);
      return PlanMyDayError(
        serverDown
            ? 'Plan My Day is having trouble right now. Please try again shortly.'
            : _cleanMessage(error.message, defaultMessage),
        errorCode: serverDown ? 'server_error' : null,
      );
    }
    if (error is PlanMyDayNotFoundException) {
      return PlanMyDayError(defaultMessage, errorCode: 'not_found');
    }
    if (error is PlanMyDayException) {
      return PlanMyDayError(_cleanMessage(error.message, defaultMessage));
    }
    return PlanMyDayError(defaultMessage);
  }

  // Show the exception's own sentence when it's a genuine user-facing message;
  // otherwise fall back to the caller's context line. Never leak raw
  // 'Unexpected error: …' / parse-failure text to the user.
  String _cleanMessage(String raw, String fallback) {
    final m = raw.trim();
    if (m.isEmpty ||
        m.startsWith('Unexpected error') ||
        m.startsWith('Failed to parse')) {
      return fallback;
    }
    return m;
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

  // ===== Reminders =====

  Future<void> loadReminders({bool enabledOnly = false}) async {
    emit(PlanMyDayLoading());
    try {
      final reminders =
          await _repository.getReminders(enabledOnly: enabledOnly);
      emit(ReminderListLoaded(reminders: reminders));
    } catch (e) {
      emit(_parseError(e, 'Failed to load reminders'));
    }
  }

  Future<void> createReminder(Reminder reminder) async {
    try {
      final created = await _repository.createReminder(reminder);
      emit(ReminderCreated(reminder: created));
      await loadReminders();
    } catch (e) {
      emit(_parseError(e, 'Failed to create reminder'));
    }
  }

  Future<void> updateReminder(String id, Reminder reminder) async {
    try {
      final updated = await _repository.updateReminder(id, reminder);
      emit(ReminderUpdated(reminder: updated));
      await loadReminders();
    } catch (e) {
      emit(_parseError(e, 'Failed to update reminder'));
    }
  }

  Future<void> deleteReminder(String id) async {
    try {
      await _repository.deleteReminder(id);
      emit(ReminderDeleted(reminderId: id));
      await loadReminders();
    } catch (e) {
      emit(_parseError(e, 'Failed to delete reminder'));
    }
  }

  // ===== Weekly summary + productivity insights =====

  Future<void> loadWeeklySummary({String? startDate}) async {
    emit(PlanMyDayLoading());
    try {
      final summary = await _repository.getWeeklySummary(startDate: startDate);
      emit(WeeklySummaryLoaded(summary: summary));
    } catch (e) {
      emit(_parseError(e, 'Failed to load weekly summary'));
    }
  }

  Future<void> loadProductivityInsights({String period = 'week'}) async {
    emit(PlanMyDayLoading());
    try {
      final insights =
          await _repository.getProductivityInsights(period: period);
      emit(ProductivityInsightsLoaded(insights: insights));
    } catch (e) {
      emit(_parseError(e, 'Failed to load insights'));
    }
  }
}
