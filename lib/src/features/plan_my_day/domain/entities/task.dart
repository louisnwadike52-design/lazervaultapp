class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final int priority; // 1=low, 2=medium, 3=high, 4=urgent
  final String status; // pending, in_progress, completed, cancelled
  final List<String> categoryIds;
  final String? parentTaskId;
  final String? recurringRule;
  final String? estimatedDuration;
  final int completionPercentage;
  final DateTime? completedAt;
  final List<String> reminderIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.dueDate,
    this.priority = 2,
    this.status = 'pending',
    this.categoryIds = const [],
    this.parentTaskId,
    this.recurringRule,
    this.estimatedDuration,
    this.completionPercentage = 0,
    this.completedAt,
    this.reminderIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      priority: json['priority'] as int? ?? 2,
      status: json['status'] as String? ?? 'pending',
      categoryIds: (json['category_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      parentTaskId: json['parent_task_id'] as String?,
      recurringRule: json['recurring_rule'] as String?,
      estimatedDuration: json['estimated_duration'] as String?,
      completionPercentage: json['completion_percentage'] as int? ?? 0,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      reminderIds: (json['reminder_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'due_date': dueDate?.toIso8601String(),
      'priority': priority,
      'status': status,
      'category_ids': categoryIds,
      'parent_task_id': parentTaskId,
      'recurring_rule': recurringRule,
      'estimated_duration': estimatedDuration,
      'completion_percentage': completionPercentage,
      'completed_at': completedAt?.toIso8601String(),
      'reminder_ids': reminderIds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get isCompleted => status == 'completed';
  bool get isPending => status == 'pending';
  bool get isInProgress => status == 'in_progress';

  Task copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    String? status,
    List<String>? categoryIds,
    String? parentTaskId,
    String? recurringRule,
    String? estimatedDuration,
    int? completionPercentage,
    DateTime? completedAt,
    List<String>? reminderIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      categoryIds: categoryIds ?? this.categoryIds,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      recurringRule: recurringRule ?? this.recurringRule,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      completedAt: completedAt ?? this.completedAt,
      reminderIds: reminderIds ?? this.reminderIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get priorityLabel {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      case 4:
        return 'Urgent';
      default:
        return 'Medium';
    }
  }
}
