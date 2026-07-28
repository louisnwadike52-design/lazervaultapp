import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';

/// Edit-task bottom sheet — title, description, priority and due date.
///
/// Harvested from the (removed) task_detail_screen edit dialog and reshaped as
/// a scroll-controlled bottom sheet so it can be reached from the shared
/// [TaskOptionsSheet], the task detail sheet and the board card menu. All saves
/// route through [cubit.updateTask]; the [cubit] is captured at the call site
/// where the PlanMyDayCubit provider is in scope.
class TaskEditSheet extends StatefulWidget {
  final Task task;
  final PlanMyDayCubit cubit;

  const TaskEditSheet({super.key, required this.task, required this.cubit});

  static Future<void> show(
    BuildContext context, {
    required Task task,
    required PlanMyDayCubit cubit,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => TaskEditSheet(task: task, cubit: cubit),
    );
  }

  @override
  State<TaskEditSheet> createState() => _TaskEditSheetState();
}

class _TaskEditSheetState extends State<TaskEditSheet> {
  static const _card = Color(0xFF1F1F1F);
  static const _field = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late int _priority;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description ?? '');
    _priority = widget.task.priority;
    _dueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title is required')),
      );
      return;
    }
    final desc = _descriptionController.text.trim();
    widget.cubit.updateTask(
      id: widget.task.id,
      title: title,
      description: desc.isEmpty ? null : desc,
      dueDate: _dueDate,
      priority: _priority,
      // The user cleared a previously-set due date → send an explicit clear.
      clearDueDate: _dueDate == null && widget.task.dueDate != null,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: _field,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Text(
                'Edit task',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              _label('Title'),
              SizedBox(height: 6.h),
              _textField(_titleController, hint: 'Task title'),
              SizedBox(height: 14.h),
              _label('Description'),
              SizedBox(height: 6.h),
              _textField(_descriptionController,
                  hint: 'Optional details', maxLines: 3),
              SizedBox(height: 14.h),
              _label('Due date'),
              SizedBox(height: 6.h),
              InkWell(
                onTap: _pickDueDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: _field,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          color: _muted, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text(
                        _dueDate != null
                            ? DateFormat('EEE, MMM d, yyyy').format(_dueDate!)
                            : 'Set a due date',
                        style: GoogleFonts.inter(
                          color: _dueDate != null ? Colors.white : _muted,
                          fontSize: 14.sp,
                        ),
                      ),
                      const Spacer(),
                      if (_dueDate != null)
                        GestureDetector(
                          onTap: () => setState(() => _dueDate = null),
                          child: Icon(Icons.close_rounded,
                              color: _muted, size: 18.sp),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              _label('Priority'),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                children: [
                  _priorityChip('Low', 1, const Color(0xFF10B981)),
                  _priorityChip('Medium', 2, const Color(0xFF3B82F6)),
                  _priorityChip('High', 3, const Color(0xFFFB923C)),
                  _priorityChip('Urgent', 4, const Color(0xFFEF4444)),
                ],
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _purple,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save changes',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.inter(
          color: _muted,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _textField(TextEditingController c,
      {String? hint, int maxLines = 1}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: _muted, fontSize: 14.sp),
        filled: true,
        fillColor: _field,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _priorityChip(String label, int value, Color color) {
    final selected = _priority == value;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _priority = value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? color : _field,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: selected ? color : Colors.transparent),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: selected ? Colors.white : _muted,
            fontSize: 12.5.sp,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
