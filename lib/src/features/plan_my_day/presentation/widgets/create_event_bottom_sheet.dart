import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';

class CreateEventBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final List<Category> categories;
  final VoidCallback onEventCreated;

  const CreateEventBottomSheet({
    super.key,
    required this.selectedDate,
    required this.categories,
    required this.onEventCreated,
  });

  @override
  State<CreateEventBottomSheet> createState() => _CreateEventBottomSheetState();
}

class _CreateEventBottomSheetState extends State<CreateEventBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime _startTime = DateTime.now();
  // End time is OPTIONAL. _hasEndTime gates whether it's sent — when off, the
  // event is saved as a point in time with NO end (we never fabricate one).
  // _endTime is only the picker's working value once the user opts in.
  DateTime _endTime = DateTime.now().add(const Duration(hours: 1));
  bool _hasEndTime = false;
  bool _isAllDay = false;
  bool _submitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
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
                  'Create Event',
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
            TextFormField(
              controller: _titleController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Event Title',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Enter event title',
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
            // Date + All-day toggle Row
            Row(
              children: [
                // Date picker
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
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
                            '${_startTime.day}/${_startTime.month}/${_startTime.year}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // All-day toggle
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _isAllDay = !_isAllDay),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: _isAllDay
                              ? const Color(0xFF3B82F6)
                              : Colors.grey[800]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isAllDay
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: _isAllDay
                                ? const Color(0xFF3B82F6)
                                : Colors.grey[400],
                            size: 20,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'All day',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (!_isAllDay)
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectStartTime(context),
                      child: _buildTimeField(
                        icon: Icons.access_time,
                        label: 'Start',
                        time: _startTime,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // End time is optional: tap to add, tap the x to clear.
                  Expanded(
                    child: _hasEndTime
                        ? Stack(
                            children: [
                              InkWell(
                                onTap: () => _selectEndTime(context),
                                child: _buildTimeField(
                                  icon: Icons.access_time,
                                  label: 'End',
                                  time: _endTime,
                                ),
                              ),
                              Positioned(
                                right: 4.w,
                                top: 0,
                                bottom: 0,
                                child: IconButton(
                                  icon: Icon(Icons.close, size: 16, color: Colors.grey[400]),
                                  onPressed: () => setState(() => _hasEndTime = false),
                                  tooltip: 'Remove end time',
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: () => setState(() {
                              _hasEndTime = true;
                              if (!_endTime.isAfter(_startTime)) {
                                _endTime = _startTime.add(const Duration(hours: 1));
                              }
                            }),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2D),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.grey[800]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add, color: Colors.grey[400], size: 20),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      'End time (optional)',
                                      style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
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
                hintText: 'Add event description',
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
            TextFormField(
              controller: _locationController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Location (Optional)',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Add event location',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[400],
                  size: 20,
                ),
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
            SizedBox(height: 24.h),
            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitting ? null : _submitEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  disabledBackgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _submitting
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Create Event',
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

  Widget _buildTimeField({
    required IconData icon,
    required String label,
    required DateTime time,
  }) {
    return InkWell(
      onTap: () async {
        if (label == 'Start') {
          _selectStartTime(context);
        } else {
          _selectEndTime(context);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[400], size: 20),
            SizedBox(width: 12.w),
            Text(
              '${_formatTime(time)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _startTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _startTime.hour,
          _startTime.minute,
        );
        // Keep the (opted-in) end time on the same day, after the start.
        if (_hasEndTime) _endTime = _startTime.add(const Duration(hours: 1));
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startTime),
    );

    if (picked != null) {
      setState(() {
        _startTime = DateTime(
          _startTime.year,
          _startTime.month,
          _startTime.day,
          picked.hour,
          picked.minute,
        );
        // Ensure end time is after start time
        if (_endTime.isBefore(_startTime)) {
          _endTime = _startTime.add(const Duration(hours: 1));
        }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_endTime),
    );

    if (picked != null) {
      setState(() {
        _endTime = DateTime(
          _endTime.year,
          _endTime.month,
          _endTime.day,
          picked.hour,
          picked.minute,
        );
        // Validate end time is after start time
        if (_endTime.isBefore(_startTime)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('End time must be after start time')),
          );
          return;
        }
      });
    }
  }

  Future<void> _submitEvent() async {
    if (!_formKey.currentState!.validate()) return;
    if (_submitting) return;
    setState(() => _submitting = true);

    await context.read<PlanMyDayCubit>().createEvent(
      title: _titleController.text,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      startTime: _startTime,
      // Never fabricate an end — send it only when the user opted in.
      endTime: _hasEndTime ? _endTime : null,
      location: _locationController.text.isEmpty ? null : _locationController.text,
      isAllDay: _isAllDay,
    );

    if (!mounted) return;
    Navigator.pop(context);
    widget.onEventCreated();
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
