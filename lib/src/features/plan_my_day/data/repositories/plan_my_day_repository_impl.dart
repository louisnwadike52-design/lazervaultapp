import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';
import 'package:lazervault/src/features/plan_my_day/domain/repositories/i_plan_my_day_repository.dart';

class PlanMyDayRepository implements IPlanMyDayRepository {
  final String _baseUrl;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final AccountManager _accountManager;
  final http.Client _client;
  final FlutterSecureStorage _storage;

  // Timeout durations
  static const Duration _connectTimeout = Duration(seconds: 15);
  static const Duration _receiveTimeout = Duration(seconds: 30);
  static const String _accessTokenKey = 'access_token';

  // Canonical task statuses (CRM/Kanban board). Mirrors the planning-service
  // valid_status CHECK constraint.
  static const List<String> _validStatuses = [
    'pending',
    'in_progress',
    'blocked',
    'in_review',
    'completed',
    'cancelled',
  ];

  /// The request paths below already carry the `/api/v1` prefix
  /// (`/api/v1/planning/...`). Both an injected `baseUrl` (DI passes
  /// `PLANNING_GATEWAY_URL`) and `endpointRegistry.httpPlanning` ALSO end in
  /// `/api/v1`, so without this the URL doubled to `.../api/v1/api/v1/planning/...`
  /// and 404'd. Strip a trailing `/api/v1` (and any trailing slash) so the final
  /// URL has exactly one.
  static String _normalizeBase(String base) {
    final trimmed = base.replaceAll(RegExp(r'/+$'), '');
    return trimmed.replaceAll(RegExp(r'/api/v1$'), '');
  }

  PlanMyDayRepository({
    String? baseUrl,
    required GrpcCallOptionsHelper callOptionsHelper,
    required AccountManager accountManager,
    http.Client? client,
    FlutterSecureStorage? storage,
  })  : _baseUrl = _normalizeBase(baseUrl ?? endpointRegistry.httpPlanning),
        _callOptionsHelper = callOptionsHelper,
        _accountManager = accountManager,
        _client = client ?? http.Client(),
        _storage = storage ?? const FlutterSecureStorage();

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw PlanMyDayAuthException('No authentication token found');
    }
    return {
      ..._headers,
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> _handleRequest<T>(
    Future<http.Response> Function() request,
    T Function(dynamic) parser,
    String errorMessage,
  ) async {
    try {
      final response = await request().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw PlanMyDayNetworkException('Request timed out');
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return null; // Successful empty response
        }
        try {
          return parser(jsonDecode(response.body));
        } catch (e) {
          throw PlanMyDayParseException('Failed to parse response: $e');
        }
      } else if (response.statusCode == 401) {
        throw PlanMyDayAuthException('Authentication failed');
      } else if (response.statusCode == 404) {
        throw PlanMyDayNotFoundException('Resource not found');
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        throw PlanMyDayValidationException(
          errorData['error'] ?? 'Validation error',
          details: errorData['details'],
        );
      } else {
        final errorData = jsonDecode(response.body);
        throw PlanMyDayApiException(
          errorData['error'] ?? errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on SocketException catch (e) {
      throw PlanMyDayNetworkException('Network error: ${e.message}');
    } on PlanMyDayException {
      rethrow;
    } catch (e) {
      throw PlanMyDayException('Unexpected error: ${e.toString()}');
    }
  }

  // ==================== EVENT METHODS ====================

  @override
  Future<List<Event>> getEvents(DateTime startDate, DateTime endDate) async {
    final headers = await _getAuthHeaders();
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/planning/events'
          '?start_date=${startDate.toIso8601String()}'
          '&end_date=${endDate.toIso8601String()}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['events'] != null) {
          return (data['events'] as List)
              .map((e) => Event.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        // If parsing fails, return empty list
        return [];
      }
    }
    return [];
  }

  @override
  Future<Event> getEventById(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/planning/events/$id'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['event'] != null) {
        return Event.fromJson(data['event'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayNotFoundException('Event not found');
  }

  @override
  Future<Event> createEvent({
    required String title,
    String? description,
    required DateTime startTime,
    DateTime? endTime, // optional — a point-in-time event has no end
    String? location,
    List<String> categoryIds = const [],
    bool isAllDay = false,
  }) async {
    if (title.trim().isEmpty) {
      throw PlanMyDayValidationException('Title cannot be empty');
    }
    if (endTime != null && endTime.isBefore(startTime)) {
      throw PlanMyDayValidationException('End time must be after start time');
    }

    final headers = await _getAuthHeaders();
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/events'),
      headers: headers,
      body: jsonEncode({
        'title': title.trim(),
        'description': description?.trim(),
        'start_time': startTime.toIso8601String(),
        // Omit end_time entirely when there's none — never send a fabricated end.
        if (endTime != null) 'end_time': endTime.toIso8601String(),
        'location': location?.trim(),
        'category_ids': categoryIds,
        'is_all_day': isAllDay,
      }),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['event'] != null) {
        return Event.fromJson(data['event'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to create event');
  }

  @override
  Future<Event> updateEvent({
    required String id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    List<String>? categoryIds,
    bool? isAllDay,
  }) async {
    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{};

    if (title != null) body['title'] = title.trim();
    if (description != null) body['description'] = description.trim();
    if (startTime != null) body['start_time'] = startTime.toIso8601String();
    if (endTime != null) body['end_time'] = endTime.toIso8601String();
    if (location != null) body['location'] = location.trim();
    if (categoryIds != null) body['category_ids'] = categoryIds;
    if (isAllDay != null) body['is_all_day'] = isAllDay;

    if (body.isEmpty) {
      throw PlanMyDayValidationException('No fields to update');
    }

    // Validate time range if both provided
    if (startTime != null && endTime != null && endTime.isBefore(startTime)) {
      throw PlanMyDayValidationException('End time must be after start time');
    }

    final response = await _client.put(
      Uri.parse('$_baseUrl/api/v1/planning/events/$id'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['event'] != null) {
        return Event.fromJson(data['event'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to update event');
  }

  @override
  Future<void> deleteEvent(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.delete(
      Uri.parse('$_baseUrl/api/v1/planning/events/$id'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw PlanMyDayException('Failed to delete event');
    }
  }

  // ==================== TASK METHODS ====================

  @override
  Future<List<Task>> getTasks({
    String status = '',
    DateTime? startDate,
    DateTime? endDate,
    List<String>? categoryIds,
    int? priority,
    String? parentTaskId,
    bool includeSubtasks = false,
  }) async {
    final headers = await _getAuthHeaders();
    final queryParams = <String, String>{};

    if (status.isNotEmpty) queryParams['status'] = status;
    if (priority != null && priority > 0) queryParams['priority'] = priority.toString();
    if (parentTaskId != null) queryParams['parent_task_id'] = parentTaskId;
    if (includeSubtasks) queryParams['include_subtasks'] = 'true';

    final uri = Uri.parse('$_baseUrl/api/v1/planning/tasks')
        .replace(queryParameters: queryParams);

    final response = await _client.get(uri, headers: headers).timeout(_connectTimeout);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['tasks'] != null) {
          return (data['tasks'] as List)
              .map((t) => Task.fromJson(t as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<Task> getTaskById(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/planning/tasks/$id'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['task'] != null) {
        return Task.fromJson(data['task'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayNotFoundException('Task not found');
  }

  @override
  Future<Task> createTask({
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
    if (title.trim().isEmpty) {
      throw PlanMyDayValidationException('Title cannot be empty');
    }
    if (priority < 1 || priority > 4) {
      throw PlanMyDayValidationException('Priority must be between 1 and 4');
    }

    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{
      'title': title.trim(),
      'priority': priority,
      'category_ids': categoryIds,
    };

    if (description != null) body['description'] = description.trim();
    if (dueDate != null) body['due_date'] = dueDate.toIso8601String();
    if (parentTaskId != null) body['parent_task_id'] = parentTaskId;
    if (recurringRule != null) body['recurring_rule'] = recurringRule;
    if (estimatedDuration != null) body['estimated_duration'] = estimatedDuration;
    if (reminderIds.isNotEmpty) body['reminder_ids'] = reminderIds;

    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/tasks'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['task'] != null) {
        return Task.fromJson(data['task'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to create task');
  }

  @override
  Future<Task> updateTask({
    required String id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    String? status,
    List<String>? categoryIds,
    String? estimatedDuration,
  }) async {
    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{};

    if (title != null) body['title'] = title.trim();
    if (description != null) body['description'] = description.trim();
    if (dueDate != null) body['due_date'] = dueDate.toIso8601String();
    if (priority != null) {
      if (priority < 1 || priority > 4) {
        throw PlanMyDayValidationException('Priority must be between 1 and 4');
      }
      body['priority'] = priority;
    }
    if (status != null) {
      if (!_validStatuses.contains(status)) {
        throw PlanMyDayValidationException('Invalid status value');
      }
      body['status'] = status;
    }
    if (categoryIds != null) body['category_ids'] = categoryIds;
    if (estimatedDuration != null) body['estimated_duration'] = estimatedDuration;

    if (body.isEmpty) {
      throw PlanMyDayValidationException('No fields to update');
    }

    final response = await _client.put(
      Uri.parse('$_baseUrl/api/v1/planning/tasks/$id'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['task'] != null) {
        return Task.fromJson(data['task'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to update task');
  }

  @override
  Future<void> deleteTask(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.delete(
      Uri.parse('$_baseUrl/api/v1/planning/tasks/$id'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw PlanMyDayException('Failed to delete task');
    }
  }

  @override
  Future<Task> completeTask(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/tasks/$id/complete'),
      headers: headers,
      body: jsonEncode({'completed_at': DateTime.now().toIso8601String()}),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['task'] != null) {
        return Task.fromJson(data['task'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to complete task');
  }

  @override
  Future<Task> moveTask(String id, String status, {int? boardOrder}) async {
    if (!_validStatuses.contains(status)) {
      throw PlanMyDayValidationException('Invalid status value');
    }
    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{'status': status};
    if (boardOrder != null) body['board_order'] = boardOrder;
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/tasks/$id/move'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['task'] != null) {
        return Task.fromJson(data['task'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to move task');
  }

  @override
  Future<void> reorderTasks(String status, List<String> taskIds) async {
    if (taskIds.isEmpty) return;
    final headers = await _getAuthHeaders();
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/tasks/reorder'),
      headers: headers,
      body: jsonEncode({'status': status, 'task_ids': taskIds}),
    ).timeout(_receiveTimeout);

    if (response.statusCode != 200) {
      throw PlanMyDayException('Failed to reorder tasks');
    }
  }

  // ==================== TIME BLOCK METHODS ====================

  @override
  Future<List<TimeBlock>> getTimeBlocks({
    String? date,
    String? startDate,
    String? endDate,
  }) async {
    final headers = await _getAuthHeaders();
    final queryParams = <String, String>{};

    if (date != null) queryParams['date'] = date;
    if (startDate != null) queryParams['start_date'] = startDate;
    if (endDate != null) queryParams['end_date'] = endDate;

    final uri = Uri.parse('$_baseUrl/api/v1/planning/time-blocks')
        .replace(queryParameters: queryParams);

    final response = await _client.get(uri, headers: headers).timeout(_connectTimeout);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['time_blocks'] != null) {
          return (data['time_blocks'] as List)
              .map((t) => TimeBlock.fromJson(t as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<TimeBlock> createTimeBlock({
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
    // Validate date format
    try {
      DateTime.parse(date);
    } catch (e) {
      throw PlanMyDayValidationException('Invalid date format. Use YYYY-MM-DD');
    }

    // Validate time format
    if (!_isValidTime(startTime) || !_isValidTime(endTime)) {
      throw PlanMyDayValidationException('Invalid time format. Use HH:MM');
    }

    // Validate time order
    if (_parseTimeToMinutes(startTime) >= _parseTimeToMinutes(endTime)) {
      throw PlanMyDayValidationException('End time must be after start time');
    }

    final headers = await _getAuthHeaders();
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/time-blocks'),
      headers: headers,
      body: jsonEncode({
        'date': date,
        'start_time': startTime,
        'end_time': endTime,
        'title': title.trim(),
        'description': description?.trim(),
        'type': type,
        'task_ids': taskIds,
        'event_ids': eventIds,
        'color': color,
        'is_locked': isLocked,
      }),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['time_block'] != null) {
        return TimeBlock.fromJson(data['time_block'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to create time block');
  }

  @override
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
  }) async {
    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{};

    if (date != null) body['date'] = date;
    if (startTime != null) {
      if (!_isValidTime(startTime)) {
        throw PlanMyDayValidationException('Invalid time format');
      }
      body['start_time'] = startTime;
    }
    if (endTime != null) {
      if (!_isValidTime(endTime)) {
        throw PlanMyDayValidationException('Invalid time format');
      }
      body['end_time'] = endTime;
    }
    if (title != null) body['title'] = title.trim();
    if (description != null) body['description'] = description.trim();
    if (type != null) body['type'] = type;
    if (taskIds != null) body['task_ids'] = taskIds;
    if (eventIds != null) body['event_ids'] = eventIds;
    if (color != null) body['color'] = color;
    if (isLocked != null) body['is_locked'] = isLocked;

    // Validate time order if both provided
    if (startTime != null && endTime != null) {
      if (_parseTimeToMinutes(startTime) >= _parseTimeToMinutes(endTime)) {
        throw PlanMyDayValidationException('End time must be after start time');
      }
    }

    final response = await _client.put(
      Uri.parse('$_baseUrl/api/v1/planning/time-blocks/$id'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['time_block'] != null) {
        return TimeBlock.fromJson(data['time_block'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to update time block');
  }

  @override
  Future<void> deleteTimeBlock(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.delete(
      Uri.parse('$_baseUrl/api/v1/planning/time-blocks/$id'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw PlanMyDayException('Failed to delete time block');
    }
  }

  // ==================== CATEGORY METHODS ====================

  @override
  Future<List<Category>> getCategories({String? type}) async {
    final headers = await _getAuthHeaders();
    final queryParams = <String, String>{};
    if (type != null && type.isNotEmpty) queryParams['type'] = type;

    final uri = Uri.parse('$_baseUrl/api/v1/planning/categories')
        .replace(queryParameters: queryParams);

    final response = await _client.get(uri, headers: headers).timeout(_connectTimeout);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['categories'] != null) {
          return (data['categories'] as List)
              .map((c) => Category.fromJson(c as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<Category> createCategory({
    required String name,
    String? icon,
    String? color,
    String type = 'both',
  }) async {
    if (name.trim().isEmpty) {
      throw PlanMyDayValidationException('Category name cannot be empty');
    }

    final headers = await _getAuthHeaders();
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/planning/categories'),
      headers: headers,
      body: jsonEncode({
        'name': name.trim(),
        'icon': icon,
        'color': color,
        'type': type,
      }),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['category'] != null) {
        return Category.fromJson(data['category'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to create category');
  }

  @override
  Future<Category> updateCategory({
    required String id,
    String? name,
    String? icon,
    String? color,
  }) async {
    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{};

    if (name != null) body['name'] = name.trim();
    if (icon != null) body['icon'] = icon;
    if (color != null) body['color'] = color;

    if (body.isEmpty) {
      throw PlanMyDayValidationException('No fields to update');
    }

    final response = await _client.put(
      Uri.parse('$_baseUrl/api/v1/planning/categories/$id'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(_receiveTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['category'] != null) {
        return Category.fromJson(data['category'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to update category');
  }

  @override
  Future<void> deleteCategory(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client.delete(
      Uri.parse('$_baseUrl/api/v1/planning/categories/$id'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw PlanMyDayException('Failed to delete category');
    }
  }

  @override
  Future<DailySummary> getDailySummary(String date) async {
    final headers = await _getAuthHeaders();
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/planning/summary/daily?date=$date'),
      headers: headers,
    ).timeout(_connectTimeout);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['summary'] != null) {
          return DailySummary.fromJson(data['summary'] as Map<String, dynamic>);
        }
      } catch (e) {
        // Return default summary on parse error
      }
    }

    // Return default summary if API fails or returns no data
    return DailySummary(
      date: date,
      tasksCompleted: 0,
      tasksTotal: 0,
      eventsAttended: 0,
      focusMinutes: 0,
      completionRate: 0.0,
      topCategories: [],
      productivityScore: 'medium',
    );
  }

  // ==================== REMINDERS ====================

  @override
  Future<List<Reminder>> getReminders({
    bool enabledOnly = false,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final headers = await _getAuthHeaders();
    final qp = <String, String>{
      if (enabledOnly) 'enabled_only': 'true',
      // Backend filters reminder_time by YYYY-MM-DD (inclusive) when supplied.
      if (startDate != null)
        'start_date':
            '${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}',
      if (endDate != null)
        'end_date':
            '${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}',
    };
    final uri = Uri.parse('$_baseUrl/api/v1/planning/reminders')
        .replace(queryParameters: qp.isEmpty ? null : qp);
    final response = await _client.get(uri, headers: headers).timeout(_connectTimeout);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['reminders'] != null) {
        return (data['reminders'] as List)
            .map((r) => Reminder.fromBackendJson(r as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  @override
  Future<Reminder> createReminder(Reminder reminder) async {
    final headers = await _getAuthHeaders();
    final response = await _client
        .post(Uri.parse('$_baseUrl/api/v1/planning/reminders'),
            headers: headers, body: jsonEncode(reminder.toBackendJson()))
        .timeout(_receiveTimeout);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['reminder'] != null) {
        return Reminder.fromBackendJson(data['reminder'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to create reminder');
  }

  @override
  Future<Reminder> updateReminder(String id, Reminder reminder) async {
    final headers = await _getAuthHeaders();
    final response = await _client
        .put(Uri.parse('$_baseUrl/api/v1/planning/reminders/$id'),
            headers: headers, body: jsonEncode(reminder.toBackendJson()))
        .timeout(_receiveTimeout);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['reminder'] != null) {
        return Reminder.fromBackendJson(data['reminder'] as Map<String, dynamic>);
      }
    }
    throw PlanMyDayException('Failed to update reminder');
  }

  @override
  Future<void> deleteReminder(String id) async {
    final headers = await _getAuthHeaders();
    final response = await _client
        .delete(Uri.parse('$_baseUrl/api/v1/planning/reminders/$id'), headers: headers)
        .timeout(_connectTimeout);
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw PlanMyDayException('Failed to delete reminder');
    }
  }

  // ==================== WEEKLY SUMMARY + INSIGHTS ====================

  @override
  Future<Map<String, dynamic>> getWeeklySummary({String? startDate}) async {
    final headers = await _getAuthHeaders();
    final uri = Uri.parse('$_baseUrl/api/v1/planning/summary/weekly')
        .replace(queryParameters: startDate != null ? {'start_date': startDate} : null);
    final response = await _client.get(uri, headers: headers).timeout(_connectTimeout);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['summary'] as Map<String, dynamic>?) ?? {};
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> getProductivityInsights({String period = 'week'}) async {
    final headers = await _getAuthHeaders();
    final uri = Uri.parse('$_baseUrl/api/v1/planning/insights')
        .replace(queryParameters: {'period': period});
    final response = await _client.get(uri, headers: headers).timeout(_connectTimeout);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['insights'] as Map<String, dynamic>?) ?? {};
    }
    return {};
  }

  // ==================== PRIVATE HELPERS ====================

  bool _isValidTime(String time) {
    final regex = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');
    return regex.hasMatch(time);
  }

  int _parseTimeToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

// ==================== EXCEPTIONS ====================

class PlanMyDayException implements Exception {
  final String message;
  PlanMyDayException(this.message);

  @override
  String toString() => message;
}

class PlanMyDayNetworkException extends PlanMyDayException {
  PlanMyDayNetworkException(super.message);
}

class PlanMyDayAuthException extends PlanMyDayException {
  PlanMyDayAuthException(super.message);
}

class PlanMyDayValidationException extends PlanMyDayException {
  final dynamic details;
  PlanMyDayValidationException(super.message, {this.details});
}

class PlanMyDayNotFoundException extends PlanMyDayException {
  PlanMyDayNotFoundException(super.message);
}

class PlanMyDayParseException extends PlanMyDayException {
  PlanMyDayParseException(super.message);
}

class PlanMyDayApiException extends PlanMyDayException {
  final int statusCode;
  PlanMyDayApiException(super.message, {this.statusCode = 500});
}
