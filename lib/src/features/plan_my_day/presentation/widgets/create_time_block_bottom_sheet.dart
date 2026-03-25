import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';

class CreateTimeBlockBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final List<Task> tasks;
  final List<Event> events;
  final VoidCallback onTimeBlockCreated;

  const CreateTimeBlockBottomSheet({
    super.key,
    required this.selectedDate,
    required this.tasks,
    required this.events,
    required this.onTimeBlockCreated,
  });

  @override
  State<CreateTimeBlockBottomSheet> createState() => _CreateTimeBlockBottomSheetState();
}

class _CreateTimeBlockBottomSheetState extends State<CreateTimeBlockBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _blockType = 'focused_work';
  String? _color;
  bool _isLocked = false;
  List<String> _selectedTaskIds = [];
  List<String> _selectedEventIds = [];

  // Predefined colors for time blocks
  static const List<Map<String, dynamic>> _blockTypes = [
    {'type': 'focused_work', 'label': 'Focused Work', 'color': '#3B82F6', 'icon': Icons.work_outline},
    {'type': 'meeting', 'label': 'Meeting', 'color': '#EF4444', 'icon': Icons.groups},
    {'type': 'break', 'label': 'Break', 'color': '#10B981', 'icon': Icons.free_breakfast},
    {'type': 'exercise', 'label': 'Exercise', 'color': '#F59E0B', 'icon': Icons.fitness_center},
    {'type': 'commute', 'label': 'Commute', 'color': '#8B5CF6', 'icon': Icons.directions_car},
    {'type': 'other', 'label': 'Other', 'color': '#6B7280', 'icon': Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
    // Default to current time rounded to next hour
    final now = TimeOfDay.now();
    _startTime = TimeOfDay(hour: now.hour + 1, minute: 0);
    _endTime = TimeOfDay(hour: now.hour + 2, minute: 0);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
                  'Create Time Block',
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
            SizedBox(height: 24.h),

            // Time Range Picker
            Row(
              children: [
                Expanded(
                  child: _buildTimePicker(
                    label: 'Start Time',
                    time: _startTime,
                    onTap: () => _selectStartTime(context),
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[600],
                  size: 20,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildTimePicker(
                    label: 'End Time',
                    time: _endTime,
                    onTap: () => _selectEndTime(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Title Input
            TextFormField(
              controller: _titleController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Title (Optional)',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'e.g., Deep Work',
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

            // Block Type Selection
            Text(
              'Block Type',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _blockTypes.map((blockType) {
                final isSelected = _blockType == blockType['type'];
                final color = Color(int.parse(blockType['color'].replaceAll('#', '0xFF')));
                return _buildBlockTypeChip(
                  blockType['label'],
                  blockType['type'],
                  blockType['icon'],
                  color,
                  isSelected,
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),

            // Description (Optional)
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Notes (Optional)',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Add any notes',
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

            // Lock Toggle
            Row(
              children: [
                Switch(
                  value: _isLocked,
                  onChanged: (value) {
                    setState(() {
                      _isLocked = value;
                    });
                  },
                  activeColor: const Color(0xFF3B82F6),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Lock this time block',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.lock_outline,
                  color: _isLocked ? const Color(0xFF3B82F6) : Colors.grey[600],
                  size: 16,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTimeBlock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Create Time Block',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: time != null ? const Color(0xFF3B82F6) : Colors.grey[600],
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Text(
                  time != null ? _formatTime(time) : 'Select',
                  style: TextStyle(
                    color: time != null ? Colors.white : Colors.grey[500],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlockTypeChip(
    String label,
    String type,
    IconData icon,
    Color color,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _blockType = type;
          _color = '#${color.value.toRadixString(16).substring(2)}';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color : Colors.grey[800]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[400],
              size: 16,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey[400],
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              onPrimary: Colors.white,
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startTime = picked;
        // Auto-adjust end time if it's before start time
        if (_endTime != null) {
          final startMinutes = picked.hour * 60 + picked.minute;
          final endMinutes = _endTime!.hour * 60 + _endTime!.minute;
          if (endMinutes <= startMinutes) {
            _endTime = TimeOfDay(
              hour: (picked.hour + 1) % 24,
              minute: picked.minute,
            );
          }
        }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              onPrimary: Colors.white,
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _submitTimeBlock() {
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end times')),
      );
      return;
    }

    final startTimeStr = '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}';
    final endTimeStr = '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}';

    context.read<PlanMyDayCubit>().createTimeBlock(
      date: widget.selectedDate.toIso8601String().split('T')[0],
      startTime: startTimeStr,
      endTime: endTimeStr,
      title: _titleController.text.isEmpty
          ? _blockTypes.firstWhere((t) => t['type'] == _blockType)['label']
          : _titleController.text,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      type: _blockType,
      color: _color ?? '#3B82F6',
      isLocked: _isLocked,
      taskIds: _selectedTaskIds,
      eventIds: _selectedEventIds,
    );

    Navigator.pop(context);
    widget.onTimeBlockCreated();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
