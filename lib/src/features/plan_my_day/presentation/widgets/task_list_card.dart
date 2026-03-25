import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';

class TaskListCard extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task)? onTaskTap;
  final Function(Task)? onTaskToggle;
  final bool showCompleted;

  const TaskListCard({
    super.key,
    required this.tasks,
    this.onTaskTap,
    this.onTaskToggle,
    this.showCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    // Filter tasks based on showCompleted flag
    final filteredTasks = showCompleted
        ? tasks
        : tasks.where((t) => !t.isCompleted).toList();

    if (filteredTasks.isEmpty) {
      return _buildEmptyState();
    }

    // Sort by priority (descending) and due date
    final sortedTasks = List<Task>.from(filteredTasks);
    sortedTasks.sort((a, b) {
      if (a.priority != b.priority) {
        return b.priority.compareTo(a.priority);
      }
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      }
      return 0;
    });

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sortedTasks.map((task) => _buildTaskItem(context, task)).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48.h),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.grey[600],
            size: 48,
          ),
          SizedBox(height: 16.h),
          Text(
            showCompleted
                ? 'No completed tasks yet'
                : 'No tasks for today',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap + to create a new task',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task) {
    final isOverdue = task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;

    return GestureDetector(
      onTap: () => onTaskTap?.call(task),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _getPriorityColor(task.priority).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: () => onTaskToggle?.call(task),
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: task.isCompleted
                      ? Colors.green
                      : Colors.transparent,
                  border: Border.all(
                    color: task.isCompleted
                        ? Colors.green
                        : (Colors.grey[600] ?? Colors.grey),
                    width: 2,
                  ),
                ),
                child: task.isCompleted
                    ? Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: task.isCompleted
                          ? Colors.grey[500]
                          : Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  if (task.description != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      task.description!,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (task.dueDate != null || task.estimatedDuration != null) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        if (task.dueDate != null) ...[
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: isOverdue
                                ? const Color(0xFFEF4444)
                                : Colors.grey[500],
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            DateFormat('MMM d').format(task.dueDate!),
                            style: TextStyle(
                              color: isOverdue
                                  ? const Color(0xFFEF4444)
                                  : Colors.grey[500],
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                        if (task.dueDate != null && task.estimatedDuration != null)
                          SizedBox(width: 12.w),
                        if (task.estimatedDuration != null) ...[
                          Icon(
                            Icons.schedule_outlined,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            task.estimatedDuration!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                        if (task.completionPercentage > 0 &&
                            task.completionPercentage < 100) ...[
                          SizedBox(width: 12.w),
                          Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: task.completionPercentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B82F6),
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${task.completionPercentage}%',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // Priority indicator
            Container(
              width: 4.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: _getPriorityColor(task.priority),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return const Color(0xFF10B981); // Green - Low
      case 2:
        return const Color(0xFFF59E0B); // Orange - Medium
      case 3:
        return const Color(0xFFEF4444); // Red - High
      case 4:
        return const Color(0xFFDC2626); // Dark Red - Urgent
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }
}
