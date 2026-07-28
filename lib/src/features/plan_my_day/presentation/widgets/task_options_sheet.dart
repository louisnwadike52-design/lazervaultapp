import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task_status.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/task_edit_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/widgets/reschedule_sheet.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/widgets/contact_picker_sheet.dart';

/// Shared task actions menu — the SINGLE source of task actions, opened
/// identically by a long-press on a task card and by the card's 3-dot button,
/// in both the Day view and the Board. All actions run through the passed
/// [cubit], captured at the call site where the PlanMyDayCubit provider is in
/// scope (bottom sheets build in a context without the provider).
class TaskOptionsSheet extends StatefulWidget {
  final Task task;
  final PlanMyDayCubit cubit;

  const TaskOptionsSheet({super.key, required this.task, required this.cubit});

  static Future<void> show(
    BuildContext context, {
    required Task task,
    required PlanMyDayCubit cubit,
  }) {
    HapticFeedback.selectionClick();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => TaskOptionsSheet(task: task, cubit: cubit),
    );
  }

  @override
  State<TaskOptionsSheet> createState() => _TaskOptionsSheetState();
}

enum _View { main, priority, status }

class _TaskOptionsSheetState extends State<TaskOptionsSheet> {
  static const _card = Color(0xFF1F1F1F);
  static const _field = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);

  _View _view = _View.main;

  Task get _task => widget.task;
  PlanMyDayCubit get _cubit => widget.cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(bottom: 16.h + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: _field,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          _header(),
          const Divider(color: _field, height: 1),
          switch (_view) {
            _View.main => _mainMenu(),
            _View.priority => _priorityMenu(),
            _View.status => _statusMenu(),
          },
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
      child: Row(
        children: [
          if (_view != _View.main)
            GestureDetector(
              onTap: () => setState(() => _view = _View.main),
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(Icons.arrow_back_rounded,
                    color: Colors.white, size: 20.sp),
              ),
            ),
          Expanded(
            child: Text(
              switch (_view) {
                _View.main => _task.title,
                _View.priority => 'Set priority',
                _View.status => 'Move to status',
              },
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainMenu() {
    final completed = _task.isCompleted;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _item(Icons.edit_outlined, 'Edit details', () {
          Navigator.pop(context);
          TaskEditSheet.show(context, task: _task, cubit: _cubit);
        }),
        _item(Icons.event_repeat_outlined, 'Change day', () {
          Navigator.pop(context);
          showReschedulePicker(context, task: _task, cubit: _cubit);
        }),
        _item(Icons.flag_outlined, 'Set priority',
            () => setState(() => _view = _View.priority),
            trailing: Icons.chevron_right_rounded),
        _item(Icons.swap_horiz_rounded, 'Move to status',
            () => setState(() => _view = _View.status),
            trailing: Icons.chevron_right_rounded),
        _item(Icons.subdirectory_arrow_right_rounded, 'Add subtask', () {
          Navigator.pop(context);
          _promptSubtask();
        }),
        _item(
          Icons.person_outline_rounded,
          _task.contactId != null ? 'Change linked contact' : 'Link to contact',
          () async {
            Navigator.pop(context);
            final picked = await ContactPickerSheet.show(context);
            if (picked != null) {
              // Empty id = the "Unlink" sentinel.
              _cubit.linkContact(_task.id, picked.id);
            }
          },
        ),
        _item(Icons.copy_rounded, 'Duplicate', () {
          Navigator.pop(context);
          _cubit.duplicateTask(_task);
        }),
        _item(
          completed ? Icons.replay_rounded : Icons.check_circle_outline,
          completed ? 'Reopen (to To-do)' : 'Mark complete',
          () {
            Navigator.pop(context);
            if (completed) {
              _cubit.moveTask(_task.id, 'pending');
            } else {
              _cubit.completeTask(_task.id);
            }
          },
          color: completed ? _muted : const Color(0xFF10B981),
        ),
        _item(Icons.delete_outline_rounded, 'Delete', () {
          Navigator.pop(context);
          _confirmDelete();
        }, color: const Color(0xFFEF4444)),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _priorityMenu() {
    const rows = [
      (1, 'Low', Color(0xFF10B981)),
      (2, 'Medium', Color(0xFF3B82F6)),
      (3, 'High', Color(0xFFFB923C)),
      (4, 'Urgent', Color(0xFFEF4444)),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (value, label, color) in rows)
          _item(Icons.flag_rounded, label, () {
            Navigator.pop(context);
            _cubit.setPriority(_task.id, value);
          },
              color: color,
              trailing: _task.priority == value ? Icons.check_rounded : null),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _statusMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final s in PlanTaskStatus.all)
          if (s.value != _task.status)
            _item(Icons.circle, s.label, () {
              Navigator.pop(context);
              _cubit.moveTask(_task.id, s.value);
            }, color: s.color, iconSize: 12),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _item(
    IconData icon,
    String label,
    VoidCallback onTap, {
    Color? color,
    IconData? trailing,
    double iconSize = 20,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.white, size: iconSize.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: color ?? Colors.white,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null)
              Icon(trailing, color: _muted, size: 20.sp),
          ],
        ),
      ),
    );
  }

  void _promptSubtask() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: Text('Add subtask',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Subtask title',
            hintStyle: GoogleFonts.inter(color: _muted),
            filled: true,
            fillColor: _field,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0)),
            onPressed: () {
              final title = controller.text.trim();
              if (title.isEmpty) return;
              _cubit.addSubtask(_task.id, title, dueDate: _task.dueDate);
              Navigator.pop(ctx);
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: Text('Delete task',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
        content: Text(
          'Delete "${_task.title}"? This can\'t be undone.',
          style: GoogleFonts.inter(color: const Color(0xFFD1D5DB)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444)),
            onPressed: () {
              _cubit.deleteTask(_task.id);
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
