import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/microservice_chat/data/datasources/http_direct_chat_datasource.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';

/// Task-creation input mode: a manual structured form, or a natural-language
/// "AI" mode that hands the text to the Plan My Day agent (same planning
/// source-context as the AI-plan modal) to create the task(s).
enum _TaskMode { manual, ai }

class CreateTaskBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final List<Category> categories;
  final VoidCallback onTaskCreated;

  const CreateTaskBottomSheet({
    super.key,
    required this.selectedDate,
    required this.categories,
    required this.onTaskCreated,
  });

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _aiController = TextEditingController();

  _TaskMode _mode = _TaskMode.manual;
  bool _aiSubmitting = false;
  String _priority = '2'; // Medium
  DateTime? _dueDate;
  DateTime? _remindAt; // when to fire a push/email/SMS reminder
  String? _selectedCategoryId;
  String? _estimatedDuration;

  static const _accent = Color(0xFF8B5CF6);

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _aiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 24.h,
        left: 24.w,
        right: 24.w,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildModeToggle(),
            SizedBox(height: 20.h),
            if (_mode == _TaskMode.ai) ..._aiFields(),
            if (_mode == _TaskMode.manual) ...[
            TextFormField(
              controller: _titleController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Task Title',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Enter task title',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Add a description',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Due Date Picker
            InkWell(
              onTap: () => _selectDueDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      _dueDate != null
                          ? 'Due: ${_formatDate(_dueDate!)}'
                          : 'Due Date (Optional)',
                      style: TextStyle(
                        color: _dueDate != null ? Colors.white : Colors.grey[500],
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Reminder timeframe picker — schedules a push/email/SMS reminder.
            InkWell(
              onTap: () => _selectRemindAt(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.notifications_active_outlined,
                        color: Colors.grey[400], size: 20),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _remindAt != null
                            ? 'Remind: ${_formatDateTime(_remindAt!)}'
                            : 'Remind me (Optional)',
                        style: TextStyle(
                          color: _remindAt != null ? Colors.white : Colors.grey[500],
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    if (_remindAt != null)
                      GestureDetector(
                        onTap: () => setState(() => _remindAt = null),
                        child: Icon(Icons.close, color: Colors.grey[500], size: 18),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Priority Selector
            Text(
              'Priority',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              children: [
                _buildPriorityChip('Low', '1', const Color(0xFF10B981)),
                _buildPriorityChip('Medium', '2', const Color(0xFFF59E0B)),
                _buildPriorityChip('High', '3', const Color(0xFFEF4444)),
                _buildPriorityChip('Urgent', '4', const Color(0xFFDC2626)),
              ],
            ),
            SizedBox(height: 16.h),
            // Estimated Duration
            InkWell(
              onTap: () => _selectDuration(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      _estimatedDuration ?? 'Est. Duration (Optional)',
                      style: TextStyle(
                        color: _estimatedDuration != null ? Colors.white : Colors.grey[500],
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.categories.isNotEmpty) ...[
              SizedBox(height: 16.h),
              Text(
                'Category (Optional)',
                style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final cat in widget.categories)
                    _buildCategoryChip(cat),
                ],
              ),
            ],
            SizedBox(height: 24.h),
            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Create Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ],
          ],
        ),
      ),
    );
  }

  /// Manual / AI segmented toggle. AI mode swaps the structured form for a
  /// free-text field routed to the Plan My Day agent.
  Widget _buildModeToggle() {
    Widget seg(String label, IconData icon, _TaskMode mode) {
      final selected = _mode == mode;
      final accent = mode == _TaskMode.ai ? _accent : const Color(0xFF3B82F6);
      return Expanded(
        child: GestureDetector(
          onTap: () {
            if (_mode == mode) return;
            HapticFeedback.selectionClick();
            setState(() => _mode = mode);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: selected ? accent : Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    size: 16,
                    color: selected ? Colors.white : Colors.grey[400]),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.grey[400],
                    fontSize: 14.sp,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          seg('Manual', Icons.edit_outlined, _TaskMode.manual),
          seg('AI', Icons.auto_awesome, _TaskMode.ai),
        ],
      ),
    );
  }

  /// Natural-language task creation via the Plan My Day agent.
  List<Widget> _aiFields() {
    return [
      TextField(
        controller: _aiController,
        autofocus: true,
        maxLines: 4,
        minLines: 3,
        enabled: !_aiSubmitting,
        textInputAction: TextInputAction.newline,
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText:
              'Describe the task — "call the bank tomorrow at 3pm, high priority, remind me an hour before"',
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
          filled: true,
          fillColor: const Color(0xFF2D2D2D),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _accent),
          ),
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        'The AI reads dates, times, priority and reminders from your text and '
        'adds the task to your board.',
        style: TextStyle(color: Colors.grey[500], fontSize: 12.sp, height: 1.3),
      ),
      SizedBox(height: 20.h),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _aiSubmitting ? null : _submitAiTask,
          icon: _aiSubmitting
              ? SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.auto_awesome, size: 18),
          label: Text(_aiSubmitting ? 'Creating…' : 'Create with AI'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _accent,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    ];
  }

  Future<void> _submitAiTask() async {
    final text = _aiController.text.trim();
    if (text.isEmpty) return;
    FocusScope.of(context).unfocus();
    HapticFeedback.lightImpact();
    // Capture context-derived handles before the async gap — the sheet's own
    // context is popped on success, but the messenger/navigator resolve to the
    // surviving app-level scope.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _aiSubmitting = true);

    try {
      final d = widget.selectedDate;
      final dateStr =
          '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      final dataSource = HttpDirectChatDataSource(
        dio: Dio(),
        callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        baseUrl: endpointRegistry.httpChatAgent,
      );
      await dataSource.processDirectChat(
        DirectChatRequest(
          message: 'Create a task for $dateStr: $text',
          sessionId: 'task-${DateTime.now().millisecondsSinceEpoch}',
          userId: '',
          accessToken: '',
          sourceContext: 'planning',
        ),
      );
      if (!mounted) return;
      navigator.pop();
      widget.onTaskCreated();
      messenger.showSnackBar(
        const SnackBar(content: Text('Task added to your board')),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _aiSubmitting = false);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Could not create that task right now. Please try again.'),
        ),
      );
    }
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final isSelected = _priority == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _priority = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? color : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color : Colors.grey[800]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(Category cat) {
    final isSelected = _selectedCategoryId == cat.id;
    Color chipColor = const Color(0xFF8B5CF6);
    if ((cat.color ?? '').isNotEmpty) {
      try {
        chipColor = Color(int.parse(cat.color!.replaceAll('#', '0xFF')));
      } catch (_) {}
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          // Tap again to clear the selection.
          _selectedCategoryId = isSelected ? null : cat.id;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? chipColor : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: isSelected ? chipColor : Colors.grey[800]!),
        ),
        child: Text(
          cat.name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? widget.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _selectDuration(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Select Duration',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDurationOption('15 min', '15'),
            SizedBox(height: 8.h),
            _buildDurationOption('30 min', '30'),
            SizedBox(height: 8.h),
            _buildDurationOption('45 min', '45'),
            SizedBox(height: 8.h),
            _buildDurationOption('1 hour', '60'),
            SizedBox(height: 8.h),
            _buildDurationOption('2 hours', '120'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    ).then((value) {
      if (value != null && value is String) {
        setState(() {
          _estimatedDuration = value as String;
        });
      }
    });
  }

  Widget _buildDurationOption(String label, String minutes) {
    return InkWell(
      onTap: () => Navigator.pop(context, minutes),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _submitTask() {
    if (!_formKey.currentState!.validate()) return;

    context.read<PlanMyDayCubit>().createTask(
      title: _titleController.text,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      dueDate: _dueDate,
      priority: int.parse(_priority),
      estimatedDuration: _estimatedDuration,
      categoryIds: _selectedCategoryId != null ? [_selectedCategoryId!] : const [],
      remindAt: _remindAt,
    );

    Navigator.pop(context);
    widget.onTaskCreated();
  }

  Future<void> _selectRemindAt(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _remindAt ?? (_dueDate ?? now),
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: DateTime(now.year + 2),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_remindAt ?? now.add(const Duration(hours: 1))),
    );
    if (time == null) return;
    setState(() {
      _remindAt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDateTime(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${d.day}/${d.month} $hh:$mm';
  }
}
