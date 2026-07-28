import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task_status.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_contact_chip.dart';

/// Horizontal, Monday/Jira-style Kanban board — the full cross-column
/// drag-and-drop surface. Columns are laid out side by side; a card is a
/// [LongPressDraggable] and each column is a [DragTarget], so dropping a card
/// into another column changes its status (drop position sets board_order).
///
/// Shares the same callbacks as [PlanBoardView] (the single-column layout):
/// [onMove] persists status/order, [onTapTask] opens detail, [onOptions] opens
/// the shared task actions menu.
class PlanKanbanView extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task task, String status, {int? index}) onMove;
  final void Function(Task task)? onTapTask;
  final void Function(Task task)? onOptions;
  final Map<String, Contact> contactsById;
  final Map<String, List<Task>> subtasksByParent;
  final void Function(Contact contact)? onOpenContact;

  const PlanKanbanView({
    super.key,
    required this.tasks,
    required this.onMove,
    this.onTapTask,
    this.onOptions,
    this.contactsById = const {},
    this.subtasksByParent = const {},
    this.onOpenContact,
  });

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);

  List<Task> _tasksFor(PlanTaskStatus status) {
    return tasks.where((t) => t.status == status.value).toList()
      ..sort((a, b) {
        final bo = a.boardOrder.compareTo(b.boardOrder);
        if (bo != 0) return bo;
        final p = b.priority.compareTo(a.priority);
        if (p != 0) return p;
        final ad = a.dueDate, bd = b.dueDate;
        if (ad == null && bd == null) return 0;
        if (ad == null) return 1;
        if (bd == null) return -1;
        return ad.compareTo(bd);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 96.h),
      children: [
        for (final status in PlanTaskStatus.boardColumns) _column(status),
      ],
    );
  }

  Widget _column(PlanTaskStatus status) {
    final items = _tasksFor(status);
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column header with the status colour + count.
          Container(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
            child: Row(
              children: [
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration:
                      BoxDecoration(color: status.color, shape: BoxShape.circle),
                ),
                SizedBox(width: 8.w),
                Text(
                  status.label,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '${items.length}',
                  style: GoogleFonts.inter(
                    color: _muted,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: _border, height: 1),
          // The droppable column body.
          Expanded(
            child: DragTarget<Task>(
              onWillAcceptWithDetails: (d) => d.data.status != status.value,
              onAcceptWithDetails: (d) {
                HapticFeedback.selectionClick();
                // Append to the end of the target column.
                onMove(d.data, status.value, index: items.length);
              },
              builder: (context, candidate, rejected) {
                final highlight = candidate.isNotEmpty;
                return Container(
                  decoration: BoxDecoration(
                    color: highlight
                        ? status.color.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: items.isEmpty
                      ? _emptyColumn(status, highlight)
                      : ListView.builder(
                          padding: EdgeInsets.all(10.w),
                          itemCount: items.length,
                          itemBuilder: (context, i) =>
                              _cardSlot(status, items, i),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// A card wrapped in a per-position DragTarget so a drop lands at index [i].
  Widget _cardSlot(PlanTaskStatus status, List<Task> items, int i) {
    final task = items[i];
    return DragTarget<Task>(
      onWillAcceptWithDetails: (d) => d.data.id != task.id,
      onAcceptWithDetails: (d) {
        HapticFeedback.selectionClick();
        onMove(d.data, status.value, index: i);
      },
      builder: (context, candidate, rejected) {
        return Column(
          children: [
            if (candidate.isNotEmpty)
              Container(
                height: 3.h,
                margin: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(
                  color: status.color,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            LongPressDraggable<Task>(
              data: task,
              feedback: Material(
                color: Colors.transparent,
                child: Opacity(
                  opacity: 0.9,
                  child: SizedBox(width: 260.w, child: _card2(task)),
                ),
              ),
              childWhenDragging: Opacity(opacity: 0.35, child: _card2(task)),
              child: _card2(task),
            ),
          ],
        );
      },
    );
  }

  Widget _card2(Task task) {
    final pColor = _priorityColor(task.priority);
    final overdue = task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () => onTapTask?.call(task),
          onLongPress: () => onOptions?.call(task),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border(left: BorderSide(color: pColor, width: 3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: task.isCompleted ? _muted : Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onOptions?.call(task),
                      child: Icon(Icons.more_vert_rounded,
                          color: _muted, size: 18.sp),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _pill(task.priorityLabel, pColor),
                    if (task.dueDate != null) ...[
                      SizedBox(width: 8.w),
                      Icon(Icons.event_rounded,
                          size: 12.sp,
                          color:
                              overdue ? const Color(0xFFEF4444) : _muted),
                      SizedBox(width: 3.w),
                      Text(
                        DateFormat('MMM d').format(task.dueDate!),
                        style: GoogleFonts.inter(
                          color: overdue ? const Color(0xFFEF4444) : _muted,
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                if (_contactFor(task) != null ||
                    _subtasksFor(task).isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: [
                      if (_subtasksFor(task).isNotEmpty)
                        _subtaskChip(_subtasksFor(task)),
                      if (_contactFor(task) != null)
                        TaskContactChip(
                          contact: _contactFor(task)!,
                          onTap: () =>
                              onOpenContact?.call(_contactFor(task)!),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Contact? _contactFor(Task task) =>
      task.contactId == null ? null : contactsById[task.contactId];

  List<Task> _subtasksFor(Task task) => subtasksByParent[task.id] ?? const [];

  Widget _subtaskChip(List<Task> subtasks) {
    final done = subtasks.where((t) => t.isCompleted).length;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.checklist_rounded, size: 11.sp, color: _muted),
          SizedBox(width: 4.w),
          Text(
            '$done/${subtasks.length}',
            style: GoogleFonts.inter(
              color: _muted,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyColumn(PlanTaskStatus status, bool highlight) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Text(
          highlight ? 'Drop here' : 'Drag a task here',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: _muted, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _pill(String text, Color c) => Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: c.withValues(alpha: 0.4)),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: c,
            fontSize: 9.5.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Color _priorityColor(int priority) {
    switch (priority) {
      case 4:
        return const Color(0xFFEF4444);
      case 3:
        return const Color(0xFFFB923C);
      case 2:
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
