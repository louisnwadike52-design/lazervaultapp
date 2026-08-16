import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';

/// Bottom sheet to create or edit a Plan My Day reminder.
///
/// The user picks a real-world event (date, optional time) and the backend
/// derives the notifications: 1 day before AND 1 hour before — collapsing to
/// just the 1-hour reminder when the event is <24h away. Channels default to the
/// user's notification profile; the user can override per reminder (the backend
/// only ever NARROWS from the profile, never widens past an opt-out).
class CreateReminderBottomSheet extends StatefulWidget {
  final Reminder? existing;

  const CreateReminderBottomSheet({super.key, this.existing});

  @override
  State<CreateReminderBottomSheet> createState() => _CreateReminderBottomSheetState();
}

class _CreateReminderBottomSheetState extends State<CreateReminderBottomSheet> {
  static const _accent = Color(0xFF4E03D0);
  static const _surface = Color(0xFF1F1F1F);
  static const _field = Color(0xFF2D2D2D);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  late DateTime _date;
  late TimeOfDay _time;
  bool _allDay = false;
  String _repeat = 'once'; // once | daily | weekly | monthly
  String _category = 'custom';
  bool _dayBefore = true;
  bool _hourBefore = true;

  // Channels: when true, leave channels null so the backend uses the user's
  // notification-profile defaults. Flip off to choose per reminder.
  bool _useProfileChannels = true;
  bool _push = true;
  bool _email = true;
  bool _sms = false;

  bool _submitting = false;

  bool get _isEdit => (widget.existing?.id ?? '').isNotEmpty;

  @override
  void initState() {
    super.initState();
    final r = widget.existing;
    final base = r?.eventTime ?? r?.remindAt ?? DateTime.now().add(const Duration(hours: 1));
    _date = DateTime(base.year, base.month, base.day);
    _time = TimeOfDay(hour: base.hour, minute: base.minute);
    if (r != null) {
      _titleController.text = r.title;
      _allDay = r.allDay;
      _repeat = r.reminderType == 'recurring' ? (r.repeatPattern ?? 'daily') : 'once';
      _category = r.category;
      _dayBefore = r.leadOffsets.contains('day_before');
      _hourBefore = r.leadOffsets.contains('hour_before');
      if (!_dayBefore && !_hourBefore) {
        _dayBefore = true;
        _hourBefore = true;
      }
      if (r.channels != null) {
        _useProfileChannels = false;
        _push = r.channels!.contains('push');
        _email = r.channels!.contains('email');
        _sms = r.channels!.contains('sms');
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 20.h,
        left: 20.w,
        right: 20.w,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
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
                    _isEdit ? 'Edit Reminder' : 'New Reminder',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _titleField(),
              SizedBox(height: 16.h),
              _label('Category'),
              SizedBox(height: 8.h),
              _categoryChips(),
              SizedBox(height: 16.h),
              _label('When'),
              SizedBox(height: 8.h),
              _dateRow(),
              SizedBox(height: 8.h),
              _allDaySwitch(),
              if (!_allDay) ...[
                SizedBox(height: 8.h),
                _timeRow(),
              ],
              SizedBox(height: 16.h),
              _label('Repeat'),
              SizedBox(height: 8.h),
              _repeatChips(),
              SizedBox(height: 16.h),
              _label('Remind me'),
              SizedBox(height: 4.h),
              _leadOffsets(),
              SizedBox(height: 16.h),
              _label('Notify via'),
              SizedBox(height: 4.h),
              _channels(),
              SizedBox(height: 20.h),
              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(
        t,
        style: TextStyle(color: Colors.grey[400], fontSize: 13.sp, fontWeight: FontWeight.w600),
      );

  Widget _titleField() {
    return TextFormField(
      controller: _titleController,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      textCapitalization: TextCapitalization.sentences,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Give your reminder a title' : null,
      decoration: InputDecoration(
        labelText: 'Title',
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: "e.g. Amaka's birthday",
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: _field,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: _accent),
        ),
      ),
    );
  }

  Widget _categoryChips() {
    const cats = [
      ['custom', 'Custom', Icons.notifications_active_outlined],
      ['birthday', 'Birthday', Icons.cake_outlined],
      ['bill', 'Bill', Icons.receipt_long_outlined],
      ['event', 'Event', Icons.event_outlined],
    ];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: cats.map((c) {
        final id = c[0] as String;
        final selected = _category == id;
        return GestureDetector(
          onTap: () => setState(() {
            _category = id;
            // Birthdays are date-anchored: default them to all-day (fires 12:00 AM).
            if (id == 'birthday') _allDay = true;
          }),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selected ? _accent.withValues(alpha: 0.18) : _field,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: selected ? _accent : Colors.grey[800]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(c[2] as IconData, size: 16.sp, color: selected ? _accent : Colors.grey[400]),
                SizedBox(width: 6.w),
                Text(c[1] as String,
                    style: TextStyle(color: selected ? Colors.white : Colors.grey[400], fontSize: 13.sp)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _dateRow() {
    return _pickerTile(
      icon: Icons.calendar_today_outlined,
      label: DateFormat('EEE, d MMM yyyy').format(_date),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime.now().subtract(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.dark(primary: _accent)),
            child: child!,
          ),
        );
        if (picked != null) setState(() => _date = picked);
      },
    );
  }

  Widget _timeRow() {
    return _pickerTile(
      icon: Icons.access_time,
      label: _time.format(context),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: _time,
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.dark(primary: _accent)),
            child: child!,
          ),
        );
        if (picked != null) setState(() => _time = picked);
      },
    );
  }

  Widget _pickerTile({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _field,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: Colors.grey[400]),
            SizedBox(width: 10.w),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
            const Spacer(),
            Icon(Icons.chevron_right, size: 18.sp, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _allDaySwitch() {
    return _switchTile(
      title: 'All day',
      subtitle: 'Fires at 12:00 AM on the day',
      value: _allDay,
      onChanged: (v) => setState(() => _allDay = v),
    );
  }

  Widget _repeatChips() {
    const repeats = [
      ['once', 'Once'],
      ['daily', 'Daily'],
      ['weekly', 'Weekly'],
      ['monthly', 'Monthly'],
    ];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: repeats.map((r) {
        final selected = _repeat == r[0];
        return GestureDetector(
          onTap: () => setState(() => _repeat = r[0]),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selected ? _accent.withValues(alpha: 0.18) : _field,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: selected ? _accent : Colors.grey[800]!),
            ),
            child: Text(r[1],
                style: TextStyle(color: selected ? Colors.white : Colors.grey[400], fontSize: 13.sp)),
          ),
        );
      }).toList(),
    );
  }

  Widget _leadOffsets() {
    return Column(
      children: [
        _checkTile(
          title: '1 day before',
          value: _dayBefore,
          onChanged: (v) => setState(() => _dayBefore = v),
        ),
        _checkTile(
          title: '1 hour before',
          value: _hourBefore,
          onChanged: (v) => setState(() => _hourBefore = v),
        ),
      ],
    );
  }

  Widget _channels() {
    return Column(
      children: [
        _switchTile(
          title: 'Use my notification defaults',
          subtitle: 'Push / email / SMS from your profile settings',
          value: _useProfileChannels,
          onChanged: (v) => setState(() => _useProfileChannels = v),
        ),
        if (!_useProfileChannels) ...[
          _checkTile(title: 'Push', value: _push, onChanged: (v) => setState(() => _push = v)),
          _checkTile(title: 'Email', value: _email, onChanged: (v) => setState(() => _email = v)),
          _checkTile(title: 'SMS', value: _sms, onChanged: (v) => setState(() => _sms = v)),
        ],
      ],
    );
  }

  Widget _switchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                if (subtitle != null)
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12.sp)),
              ],
            ),
          ),
          Switch(value: value, activeColor: _accent, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _checkTile({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Icon(value ? Icons.check_box : Icons.check_box_outline_blank,
                color: value ? _accent : Colors.grey[600], size: 22.sp),
            SizedBox(width: 10.w),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
          ],
        ),
      ),
    );
  }

  Widget _saveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitting ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: _submitting
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(_isEdit ? 'Save changes' : 'Create reminder',
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_dayBefore && !_hourBefore) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one reminder time (1 day / 1 hour before)')),
      );
      return;
    }
    if (!_useProfileChannels && !_push && !_email && !_sms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one notification channel')),
      );
      return;
    }

    final when = _allDay
        ? DateTime(_date.year, _date.month, _date.day) // local midnight
        : DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);

    final offsets = <String>[
      if (_dayBefore) 'day_before',
      if (_hourBefore) 'hour_before',
    ];
    final channels = _useProfileChannels
        ? null
        : <String>[
            if (_push) 'push',
            if (_email) 'email',
            if (_sms) 'sms',
          ];

    final reminder = Reminder(
      id: widget.existing?.id ?? '',
      userId: widget.existing?.userId ?? '',
      title: _titleController.text.trim(),
      remindAt: when,
      eventTime: when,
      allDay: _allDay,
      reminderType: _repeat == 'once' ? 'absolute' : 'recurring',
      repeatPattern: _repeat == 'once' ? null : _repeat,
      isActive: widget.existing?.isActive ?? true,
      leadOffsets: offsets,
      channels: channels,
      category: _category,
      createdAt: widget.existing?.createdAt ?? DateTime.now(),
    );

    setState(() => _submitting = true);
    final cubit = context.read<PlanMyDayCubit>();
    if (_isEdit) {
      await cubit.updateReminder(reminder.id, reminder);
    } else {
      await cubit.createReminder(reminder);
    }
    if (mounted) Navigator.pop(context);
  }
}
