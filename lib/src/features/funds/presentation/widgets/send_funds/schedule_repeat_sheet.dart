import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_modal.dart';

/// The user's timing choice for a transfer: send now, a one-off future date, or
/// a recurring rule. Schedule and recurring are mutually exclusive.
class ScheduleRepeatResult {
  final DateTime? scheduledAt;
  final RecurringTransferConfig? recurring;
  const ScheduleRepeatResult({this.scheduledAt, this.recurring});
}

/// A single, light-themed bottom sheet that lets the user configure BOTH the
/// one-off schedule AND the recurring rule in one place — replacing the two
/// separate inline controls that cluttered the amount sheet. Returns the chosen
/// [ScheduleRepeatResult] via `Navigator.pop`, or `null` if dismissed (keep the
/// previous selection).
class ScheduleRepeatSheet extends StatefulWidget {
  final DateTime? initialScheduledAt;
  final RecurringTransferConfig? initialRecurring;

  const ScheduleRepeatSheet({
    super.key,
    this.initialScheduledAt,
    this.initialRecurring,
  });

  static const Color _purple = Color.fromARGB(255, 78, 3, 208);
  static const Color _card = Color(0xFFF3F4F6);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);

  static Future<ScheduleRepeatResult?> show(
    BuildContext context, {
    DateTime? scheduledAt,
    RecurringTransferConfig? recurring,
  }) {
    return showModalBottomSheet<ScheduleRepeatResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ScheduleRepeatSheet(
        initialScheduledAt: scheduledAt,
        initialRecurring: recurring,
      ),
    );
  }

  @override
  State<ScheduleRepeatSheet> createState() => _ScheduleRepeatSheetState();
}

enum _Mode { now, schedule, repeat }

class _ScheduleRepeatSheetState extends State<ScheduleRepeatSheet> {
  late _Mode _mode;
  DateTime? _scheduledAt;
  RecurringTransferConfig? _recurring;

  @override
  void initState() {
    super.initState();
    _scheduledAt = widget.initialScheduledAt;
    _recurring = widget.initialRecurring;
    _mode = _recurring != null
        ? _Mode.repeat
        : (_scheduledAt != null ? _Mode.schedule : _Mode.now);
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 90)),
      helpText: 'Schedule transfer date',
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt ?? now),
      helpText: 'Schedule transfer time',
    );
    if (time == null || !mounted) return;
    setState(() {
      _scheduledAt =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      _recurring = null;
      _mode = _Mode.schedule;
    });
  }

  Future<void> _configureRecurring() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecurringTransferModal(
        initialConfig: _recurring,
        onConfigured: (config) {
          if (!mounted) return;
          setState(() {
            _recurring = config;
            _scheduledAt = null;
            _mode = _Mode.repeat;
          });
        },
      ),
    );
  }

  void _apply() {
    switch (_mode) {
      case _Mode.now:
        Navigator.of(context).pop(const ScheduleRepeatResult());
      case _Mode.schedule:
        Navigator.of(context)
            .pop(ScheduleRepeatResult(scheduledAt: _scheduledAt));
      case _Mode.repeat:
        Navigator.of(context)
            .pop(ScheduleRepeatResult(recurring: _recurring));
    }
  }

  String _formatSchedule(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hh = d.hour.toString().padLeft(2, '0');
    final mn = d.minute.toString().padLeft(2, '0');
    return '${d.day} ${months[d.month - 1]}, $hh:$mn';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // Tap empty space to dismiss any lingering keyboard (e.g. left over from the
      // amount sheet underneath) so the fixed Done button below is always reachable.
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Scrollable middle — options can grow without pushing the CTA.
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),
                        Text('Schedule or repeat',
                            style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: ScheduleRepeatSheet._textPrimary)),
                        SizedBox(height: 4.h),
                        Text('Choose when this transfer runs.',
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: ScheduleRepeatSheet._textSecondary)),
                        SizedBox(height: 16.h),
                        _optionCard(
                          mode: _Mode.now,
                          icon: Icons.bolt_rounded,
                          title: 'Send now',
                          subtitle: 'Transfer immediately',
                        ),
                        SizedBox(height: 10.h),
                        _optionCard(
                          mode: _Mode.schedule,
                          icon: Icons.event_rounded,
                          title: 'Schedule for later',
                          subtitle: _scheduledAt != null
                              ? _formatSchedule(_scheduledAt!)
                              : 'Pick a future date & time',
                          trailingLabel: _mode == _Mode.schedule
                              ? (_scheduledAt != null ? 'Change' : 'Pick')
                              : null,
                          onTrailing: _pickDateTime,
                          onSelect: () {
                            if (_scheduledAt == null) {
                              _pickDateTime();
                            } else {
                              setState(() => _mode = _Mode.schedule);
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        _optionCard(
                          mode: _Mode.repeat,
                          icon: Icons.repeat_rounded,
                          title: 'Repeat',
                          subtitle: _recurring != null
                              ? _recurring!.summary
                              : 'Set up a recurring transfer',
                          trailingLabel: _mode == _Mode.repeat
                              ? (_recurring != null ? 'Edit' : 'Set up')
                              : null,
                          onTrailing: _configureRecurring,
                          onSelect: () {
                            if (_recurring == null) {
                              _configureRecurring();
                            } else {
                              setState(() => _mode = _Mode.repeat);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Fixed footer — Done always visible, never under the keyboard.
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _apply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ScheduleRepeatSheet._purple,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('Done',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionCard({
    required _Mode mode,
    required IconData icon,
    required String title,
    required String subtitle,
    String? trailingLabel,
    VoidCallback? onTrailing,
    VoidCallback? onSelect,
  }) {
    final selected = _mode == mode;
    return InkWell(
      onTap: onSelect ?? () => setState(() => _mode = mode),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: selected
              ? ScheduleRepeatSheet._purple.withValues(alpha: 0.06)
              : ScheduleRepeatSheet._card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? ScheduleRepeatSheet._purple.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 20.sp,
                color: selected
                    ? ScheduleRepeatSheet._purple
                    : ScheduleRepeatSheet._textSecondary),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ScheduleRepeatSheet._textPrimary)),
                  SizedBox(height: 2.h),
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 11.5.sp,
                          color: ScheduleRepeatSheet._textSecondary)),
                ],
              ),
            ),
            if (selected && trailingLabel != null) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onTrailing,
                child: Text(trailingLabel,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: ScheduleRepeatSheet._purple)),
              ),
            ] else if (selected)
              Icon(Icons.check_circle_rounded,
                  size: 20.sp, color: ScheduleRepeatSheet._purple),
          ],
        ),
      ),
    );
  }
}
