import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task_status.dart';

/// A compact CRM/Kanban card for a single task. Used inside the board columns.
class TaskBoardCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final bool dragging;

  const TaskBoardCard({
    super.key,
    required this.task,
    this.onTap,
    this.dragging = false,
  });

  static const Color _surface = Color(0xFF1F1F1F);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  Color get _priorityColor {
    switch (task.priority) {
      case 4:
        return const Color(0xFFEF4444); // urgent
      case 3:
        return const Color(0xFFFB923C); // high
      case 2:
        return const Color(0xFF3B82F6); // medium
      default:
        return const Color(0xFF6B7280); // low
    }
  }

  bool get _overdue =>
      !task.isCompleted &&
      task.dueDate != null &&
      task.dueDate!.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final statusColor = PlanTaskStatus.colorFor(task.status);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 230.w,
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border(
              left: BorderSide(color: statusColor, width: 3),
            ),
            boxShadow: dragging
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              if ((task.description ?? '').isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  task.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _textSecondary, fontSize: 12.sp),
                ),
              ],
              SizedBox(height: 10.h),
              Row(
                children: [
                  _chip(task.priorityLabel, _priorityColor),
                  const Spacer(),
                  if (task.dueDate != null)
                    Row(
                      children: [
                        Icon(
                          Icons.event_rounded,
                          size: 13.sp,
                          color: _overdue ? const Color(0xFFEF4444) : _textSecondary,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          DateFormat('MMM d').format(task.dueDate!),
                          style: TextStyle(
                            color: _overdue
                                ? const Color(0xFFEF4444)
                                : _textSecondary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
