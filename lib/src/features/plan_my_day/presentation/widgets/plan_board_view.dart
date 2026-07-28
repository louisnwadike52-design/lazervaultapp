import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task_status.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_contact_chip.dart';

/// Plan My Day board — a single, well-aligned vertical list filtered by a
/// progress-state dropdown at the top (To-do / In progress / Blocked / In review
/// / Done), instead of a horizontally-scrolling Kanban.
///
/// Styling mirrors the Group Funds / Family Accounts surfaces: Inter type, a
/// purple gradient summary header, 0xFF1F1F1F cards with soft shadows and a
/// status-coloured accent, and coloured status/priority pills.
///
/// Each card can be reordered within its state (drag handle) and moved to
/// another state via its overflow menu — both flow through the existing
/// [onReorder] / [onMove] callbacks so the cubit's move/complete semantics are
/// unchanged.
class PlanBoardView extends StatefulWidget {
  final List<Task> tasks;
  final void Function(Task task, String status, {int? index}) onMove;
  final void Function(String status, List<String> orderedIds) onReorder;
  final void Function(Task task)? onTapTask;
  final void Function(Task task)? onOptions;
  final VoidCallback? onAddTask;
  final Future<void> Function()? onRefresh;
  final Map<String, Contact> contactsById;
  final Map<String, List<Task>> subtasksByParent;
  final void Function(Contact contact)? onOpenContact;

  const PlanBoardView({
    super.key,
    required this.tasks,
    required this.onMove,
    required this.onReorder,
    this.onTapTask,
    this.onOptions,
    this.onAddTask,
    this.onRefresh,
    this.contactsById = const {},
    this.subtasksByParent = const {},
    this.onOpenContact,
  });

  @override
  State<PlanBoardView> createState() => _PlanBoardViewState();
}

class _PlanBoardViewState extends State<PlanBoardView> {
  static const _purple = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);

  late PlanTaskStatus _selected;

  @override
  void initState() {
    super.initState();
    // Land on the first state that actually has tasks (else To-do), then stay
    // put — the filter never auto-jumps when a column empties after a move.
    _selected = PlanTaskStatus.boardColumns.firstWhere(
      (s) => widget.tasks.any((t) => t.status == s.value),
      orElse: () => PlanTaskStatus.todo,
    );
  }

  PlanTaskStatus get _active => _selected;

  int _countFor(PlanTaskStatus s) =>
      widget.tasks.where((t) => t.status == s.value).length;

  List<Task> _tasksFor(PlanTaskStatus status) {
    return widget.tasks.where((t) => t.status == status.value).toList()
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
    final active = _active;
    final items = _tasksFor(active);
    return Column(
      children: [
        _progressHeader(),
        _filterBar(active),
        Expanded(
          child: items.isEmpty ? _empty(active) : _list(active, items),
        ),
      ],
    );
  }

  // ── Summary header ──────────────────────────────────────────────────────
  Widget _progressHeader() {
    final total = widget.tasks
        .where((t) => PlanTaskStatus.boardColumns.any((s) => s.value == t.status))
        .length;
    final done = _countFor(PlanTaskStatus.done);
    final pct = total == 0 ? 0.0 : done / total;
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_purple, Color(0xCC4E03D0)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: _purple.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights_rounded,
                  color: Colors.white.withValues(alpha: 0.9), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                "Today's progress",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '$done of $total done',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6.h,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter pills ────────────────────────────────────────────────────────
  Widget _filterBar(PlanTaskStatus active) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: Row(
        children: [
          for (int i = 0; i < PlanTaskStatus.boardColumns.length; i++) ...[
            if (i > 0) SizedBox(width: 8.w),
            _statusPill(PlanTaskStatus.boardColumns[i], active),
          ],
        ],
      ),
    );
  }

  Widget _statusPill(PlanTaskStatus s, PlanTaskStatus active) {
    final isSelected = s.value == active.value;
    final count = _countFor(s);
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selected = s);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? s.color : _card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: isSelected ? s.color : _border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isSelected) ...[
              _dot(s.color),
              SizedBox(width: 8.w),
            ],
            Text(
              s.label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : _muted,
                fontSize: 12.5.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6.w),
              Text(
                '$count',
                style: GoogleFonts.inter(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.85)
                      : _muted,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Task list ───────────────────────────────────────────────────────────
  Widget _list(PlanTaskStatus status, List<Task> items) {
    final list = ReorderableListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 96.h),
      physics: const AlwaysScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: items.length,
      proxyDecorator: (child, index, animation) => Material(
        color: Colors.transparent,
        child: child,
      ),
      onReorder: (oldIndex, newIndex) {
        HapticFeedback.selectionClick();
        if (newIndex > oldIndex) newIndex -= 1;
        final ids = items.map((t) => t.id).toList();
        final moved = ids.removeAt(oldIndex);
        ids.insert(newIndex, moved);
        widget.onReorder(status.value, ids);
      },
      itemBuilder: (context, i) =>
          _taskTile(items[i], i, key: ValueKey(items[i].id)),
    );
    if (widget.onRefresh == null) return list;
    return RefreshIndicator(
      color: const Color(0xFF4E03D0),
      backgroundColor: _card,
      onRefresh: widget.onRefresh!,
      child: list,
    );
  }

  Widget _taskTile(Task task, int index, {required Key key}) {
    final pColor = _priorityColor(task.priority);
    final overdue = task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;
    return Padding(
      key: key,
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => widget.onTapTask?.call(task),
          onLongPress: () => widget.onOptions?.call(task),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16.r),
              border: Border(left: BorderSide(color: pColor, width: 3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Completion toggle (complete ⇄ back to To-do).
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    widget.onMove(
                        task, task.isCompleted ? 'pending' : 'completed');
                  },
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    margin: EdgeInsets.only(top: 2.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted
                          ? const Color(0xFF10B981)
                          : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted
                            ? const Color(0xFF10B981)
                            : _muted,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check,
                            size: 14, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: task.isCompleted ? _muted : Colors.white,
                          fontSize: 15.sp,
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
                          style: GoogleFonts.inter(
                            color: _muted,
                            fontSize: 12.5.sp,
                            height: 1.35,
                          ),
                        ),
                      ],
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          _pill(task.priorityLabel, pColor),
                          if (task.dueDate != null) ...[
                            SizedBox(width: 8.w),
                            Icon(Icons.event_rounded,
                                size: 13.sp,
                                color: overdue
                                    ? const Color(0xFFEF4444)
                                    : _muted),
                            SizedBox(width: 3.w),
                            Text(
                              DateFormat('MMM d').format(task.dueDate!),
                              style: GoogleFonts.inter(
                                color: overdue
                                    ? const Color(0xFFEF4444)
                                    : _muted,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          if (task.completionPercentage > 0 &&
                              task.completionPercentage < 100) ...[
                            SizedBox(width: 8.w),
                            Text(
                              '${task.completionPercentage}%',
                              style: GoogleFonts.inter(
                                color: _muted,
                                fontSize: 11.sp,
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
                                    widget.onOpenContact?.call(_contactFor(task)!),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Options (long-press equivalent) + reorder handle.
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => widget.onOptions?.call(task),
                      child: Icon(Icons.more_vert_rounded,
                          color: _muted, size: 20.sp),
                    ),
                    SizedBox(height: 6.h),
                    ReorderableDragStartListener(
                      index: index,
                      child: Icon(Icons.drag_indicator_rounded,
                          color: _border, size: 20.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Empty state ─────────────────────────────────────────────────────────
  Widget _empty(PlanTaskStatus status) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: status.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.inbox_rounded,
                  color: status.color, size: 40.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'Nothing in ${status.label.toLowerCase()}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              status.value == 'pending'
                  ? 'Add a task or ask the AI to plan your day.'
                  : 'Move a task here from another state.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _muted, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  // ── Contact + subtask helpers ───────────────────────────────────────────
  Contact? _contactFor(Task task) =>
      task.contactId == null ? null : widget.contactsById[task.contactId];

  List<Task> _subtasksFor(Task task) =>
      widget.subtasksByParent[task.id] ?? const [];

  Widget _subtaskChip(List<Task> subtasks) {
    final done = subtasks.where((t) => t.isCompleted).length;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.checklist_rounded, size: 12.sp, color: _muted),
          SizedBox(width: 4.w),
          Text(
            '$done/${subtasks.length}',
            style: GoogleFonts.inter(
              color: _muted,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ── Small pieces ────────────────────────────────────────────────────────
  Widget _dot(Color c) => Container(
        width: 10.w,
        height: 10.w,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );


  Widget _pill(String text, Color c) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: c.withValues(alpha: 0.4)),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: c,
            fontSize: 10.sp,
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
