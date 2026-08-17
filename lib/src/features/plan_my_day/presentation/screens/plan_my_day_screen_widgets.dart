part of 'plan_my_day_screen.dart';

class _TaskDetailBottomSheet extends StatelessWidget {
  final Task task;
  final PlanMyDayCubit cubit;

  const _TaskDetailBottomSheet({required this.task, required this.cubit});

  @override
  Widget build(BuildContext context) {
    // Bound to the cubit so subtask toggles / adds refresh live in place.
    return BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
      bloc: cubit,
      builder: (context, state) {
        final loaded = state is PlanMyDayLoaded ? state : null;
        final subtasks = loaded?.subtasksFor(task.id) ?? const <Task>[];
        final contact = loaded?.contactFor(task);
        return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  task.priorityLabel,
                  style: TextStyle(
                    color: _getPriorityColor(task.priority),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (task.description != null) ...[
            SizedBox(height: 12.h),
            Text(
              task.description!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: task.isCompleted ? Colors.green : Colors.grey[600],
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                task.isCompleted ? 'Completed' : 'Pending',
                style: TextStyle(
                  color: task.isCompleted ? Colors.green : Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
              if (task.dueDate != null) ...[
                SizedBox(width: 16.w),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 4.w),
                Text(
                  DateFormat('MMM d').format(task.dueDate!),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ],
          ),
          if (contact != null) ...[
            SizedBox(height: 14.h),
            Align(
              alignment: Alignment.centerLeft,
              child: TaskContactChip(
                contact: contact,
                compact: false,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => serviceLocator<ContactCubit>(),
                        child: ContactDetailScreen(contactId: contact.id),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          SizedBox(height: 18.h),
          Row(
            children: [
              Text(
                'Subtasks',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtasks.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Text(
                  '${subtasks.where((t) => t.isCompleted).length}/${subtasks.length}',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                ),
              ],
              const Spacer(),
              GestureDetector(
                onTap: () => _promptAddSubtask(context),
                child: Row(
                  children: [
                    Icon(Icons.add_rounded,
                        color: const Color(0xFF8B5CF6), size: 18.sp),
                    SizedBox(width: 2.w),
                    Text('Add',
                        style: GoogleFonts.inter(
                            color: const Color(0xFF8B5CF6),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (subtasks.isEmpty)
            Text(
              'No subtasks yet.',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 12.5.sp),
            )
          else
            ...subtasks.map((s) => _subtaskRow(s)),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _detailAction(
                  Icons.edit_outlined,
                  'Edit',
                  () {
                    Navigator.pop(context);
                    TaskEditSheet.show(context, task: task, cubit: cubit);
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _detailAction(
                  Icons.event_repeat_outlined,
                  'Reschedule',
                  () {
                    Navigator.pop(context);
                    showReschedulePicker(context, task: task, cubit: cubit);
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _detailAction(
                  Icons.more_horiz_rounded,
                  'More',
                  () {
                    Navigator.pop(context);
                    TaskOptionsSheet.show(context, task: task, cubit: cubit);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
        );
      },
    );
  }

  /// A single subtask row inside the task detail sheet — tap the circle to
  /// toggle its completion (routes through the cubit, refreshes in place).
  Widget _subtaskRow(Task s) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (s.isCompleted) {
                cubit.moveTask(s.id, 'pending');
              } else {
                cubit.completeTask(s.id);
              }
            },
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: s.isCompleted ? const Color(0xFF10B981) : Colors.transparent,
                border: Border.all(
                  color: s.isCompleted
                      ? const Color(0xFF10B981)
                      : const Color(0xFF9CA3AF),
                  width: 2,
                ),
              ),
              child: s.isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              s.title,
              style: GoogleFonts.inter(
                color: s.isCompleted ? const Color(0xFF9CA3AF) : Colors.white,
                fontSize: 13.5.sp,
                decoration:
                    s.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _promptAddSubtask(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Add subtask',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Subtask title',
            hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            filled: true,
            fillColor: const Color(0xFF2D2D2D),
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
              cubit.addSubtask(task.id, title, dueDate: task.dueDate);
              Navigator.pop(ctx);
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _detailAction(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            SizedBox(height: 6.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
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

class _EventDetailBottomSheet extends StatelessWidget {
  final Event event;

  const _EventDetailBottomSheet({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (event.description != null) ...[
            SizedBox(height: 12.h),
            Text(
              event.description!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: const Color(0xFF3B82F6),
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                '${DateFormat('HH:mm').format(event.startTime)}${event.endTime != null ? ' - ${DateFormat('HH:mm').format(event.endTime!)}' : ''}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          if (event.location != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF3B82F6),
                  size: 20,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    event.location!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (event.isAllDay) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.all_inclusive,
                  color: const Color(0xFF3B82F6),
                  size: 20,
                ),
                SizedBox(width: 8.w),
                Text(
                  'All day event',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
