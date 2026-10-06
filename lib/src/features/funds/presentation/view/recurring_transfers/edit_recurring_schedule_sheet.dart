import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_modal.dart';

/// What the user changed. Every field is null when untouched.
///
/// Null means "not sent" rather than "set to empty", which matters on the wire:
/// the server treats an empty string / zero as no-change for most fields, but
/// schedule_day 0 is Sunday — so a day that was not edited must never be
/// transmitted at all.
@immutable
class RecurringScheduleEdit {
  const RecurringScheduleEdit({
    this.amount,
    this.scheduleTime,
    this.frequency,
    this.scheduleDay,
    this.endDate,
    this.description,
  });

  final double? amount;
  final String? scheduleTime;
  final RecurringFrequency? frequency;
  final int? scheduleDay;

  /// YYYY-MM-DD, the format the server parses.
  final String? endDate;
  final String? description;

  bool get isEmpty =>
      amount == null &&
      scheduleTime == null &&
      frequency == null &&
      scheduleDay == null &&
      endDate == null &&
      description == null;

  /// A human list of what will change, for the confirm step. A schedule edit
  /// moves real money on a new date, so it is worth one explicit read-back.
  List<String> describe(RecurringTransferEntity from) {
    final out = <String>[];
    if (amount != null) {
      final f = NumberFormat('#,##0.00');
      out.add('Amount ${from.currency} ${f.format(from.amount)} '
          '→ ${from.currency} ${f.format(amount)}');
    }
    if (frequency != null) out.add('Frequency ${from.frequency.label} → ${frequency!.label}');
    if (scheduleDay != null) out.add('Day changes');
    if (scheduleTime != null) {
      final tz = from.scheduleTimezoneLabel;
      out.add('Time ${from.scheduleTime} → $scheduleTime'
          '${tz.isEmpty ? '' : ' $tz'}');
    }
    if (endDate != null) out.add('Ends $endDate');
    if (description != null) out.add('Note updated');
    return out;
  }
}

/// Edits an EXISTING recurring payment's timing, amount and note.
///
/// Returns the edit to apply, or null if the user backed out. Deliberately
/// reuses [RecurringTransferModal] for the schedule itself rather than growing
/// a second set of frequency/day/time pickers: the two would drift, and the
/// day-domain rule (a weekly day-of-week is not a monthly day-of-month) is
/// already encoded there.
Future<RecurringScheduleEdit?> showEditRecurringScheduleSheet(
  BuildContext context, {
  required RecurringTransferEntity transfer,
}) async {
  return showModalBottomSheet<RecurringScheduleEdit>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _EditRecurringSheet(transfer: transfer),
  );
}

class _EditRecurringSheet extends StatefulWidget {
  const _EditRecurringSheet({required this.transfer});
  final RecurringTransferEntity transfer;

  @override
  State<_EditRecurringSheet> createState() => _EditRecurringSheetState();
}

class _EditRecurringSheetState extends State<_EditRecurringSheet> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF9CA3AF);
  static const _blue = Color(0xFF3B82F6);

  late RecurringTransferConfig _config;
  late TextEditingController _amountCtrl;
  late TextEditingController _noteCtrl;
  String? _amountError;

  @override
  void initState() {
    super.initState();
    _config = RecurringTransferConfig.fromEntity(widget.transfer);
    _amountCtrl = TextEditingController(
      text: widget.transfer.amount.toStringAsFixed(2),
    );
    _noteCtrl = TextEditingController(text: widget.transfer.description);
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  bool get _isTerminal =>
      widget.transfer.status == RecurringTransferStatus.cancelled ||
      widget.transfer.status == RecurringTransferStatus.expired;

  Future<void> _openScheduleEditor() async {
    final tz = widget.transfer.scheduleTimezoneLabel;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecurringTransferModal(
        initialConfig: _config,
        title: 'Edit schedule',
        ctaLabel: 'Use this schedule',
        footnote: tz.isEmpty
            ? 'Runs at the time shown.'
            : 'Runs at the time shown in $tz — the zone this payment was set '
                'up in, not your device\'s.',
        onConfigured: (c) => setState(() => _config = c),
      ),
    );
  }

  /// The diff. Only genuinely changed fields are returned; see
  /// [RecurringScheduleEdit] for why "unchanged" has to mean "absent".
  RecurringScheduleEdit? _buildEdit() {
    final t = widget.transfer;

    final raw = _amountCtrl.text.replaceAll(',', '').trim();
    final parsed = double.tryParse(raw);
    if (raw.isEmpty || parsed == null || parsed <= 0) {
      setState(() => _amountError = 'Enter an amount greater than zero');
      return null;
    }
    // Compared in minor units: 100.00 and 100.0 are the same amount, and a
    // re-send of an unchanged value would make the server recompute the next
    // run for nothing.
    final amountChanged =
        (parsed * 100).round() != (t.amount * 100).round();

    final timeChanged = _config.scheduleTimeString != t.scheduleTime;
    final freqChanged = _config.frequency != t.frequency;
    final dayChanged = _config.scheduleDay != t.scheduleDay;

    String? endDate;
    final newEnd = _config.endDate;
    final oldEnd = t.endDate;
    final sameEnd = (newEnd == null && oldEnd == null) ||
        (newEnd != null &&
            oldEnd != null &&
            DateUtils.isSameDay(newEnd, oldEnd));
    if (!sameEnd && newEnd != null) {
      endDate = DateFormat('yyyy-MM-dd').format(newEnd);
    }
    // NOTE: clearing an end date is not expressible — the server reads an empty
    // string as "no change". Surfaced to the user rather than silently dropped.

    final note = _noteCtrl.text.trim();
    final noteChanged = note.isNotEmpty && note != t.description;

    return RecurringScheduleEdit(
      amount: amountChanged ? parsed : null,
      scheduleTime: timeChanged ? _config.scheduleTimeString : null,
      frequency: freqChanged ? _config.frequency : null,
      // The day travels whenever EITHER changed: the server validates the pair
      // together, and a frequency change with a stale day is the failure mode.
      scheduleDay: (dayChanged || freqChanged) ? _config.scheduleDay : null,
      endDate: endDate,
      description: noteChanged ? note : null,
    );
  }

  void _submit() {
    setState(() => _amountError = null);
    final edit = _buildEdit();
    if (edit == null) return; // validation already surfaced
    if (edit.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pop(edit);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.transfer;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Edit recurring payment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: _muted),
                  ),
                ],
              ),
              Text(
                'To ${t.recipientName}',
                style: TextStyle(color: _muted, fontSize: 12.sp),
              ),
              SizedBox(height: 18.h),

              if (_isTerminal) ...[
                _Notice(
                  icon: Icons.lock_outline,
                  color: const Color(0xFFEF4444),
                  // The server refuses outright, so saying so here beats
                  // letting the user fill the form and be rejected.
                  text: 'This payment is ${t.status.label.toLowerCase()} and '
                      'can no longer be edited. Create a new one instead.',
                ),
                SizedBox(height: 16.h),
              ],

              Text('Amount', style: TextStyle(color: _muted, fontSize: 13.sp)),
              SizedBox(height: 8.h),
              TextField(
                controller: _amountCtrl,
                enabled: !_isTerminal,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                decoration: InputDecoration(
                  prefixText: '${t.currency} ',
                  prefixStyle: TextStyle(color: _muted, fontSize: 16.sp),
                  filled: true,
                  fillColor: _card,
                  errorText: _amountError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              Text('Schedule', style: TextStyle(color: _muted, fontSize: 13.sp)),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _isTerminal ? null : _openScheduleEditor,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.repeat, color: _blue, size: 18.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          _config.summary,
                          style: TextStyle(
                              color: Colors.white, fontSize: 13.sp),
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          color: _muted, size: 20.sp),
                    ],
                  ),
                ),
              ),
              if (t.endDate != null && _config.endDate != null) ...[
                SizedBox(height: 8.h),
                Text(
                  // Honest about a limit rather than letting the user try and
                  // wonder why nothing happened.
                  'An end date can be moved but not removed. Cancel the '
                  'payment instead if you want it to stop.',
                  style: TextStyle(color: _muted, fontSize: 11.sp),
                ),
              ],
              SizedBox(height: 18.h),

              Text('Note', style: TextStyle(color: _muted, fontSize: 13.sp)),
              SizedBox(height: 8.h),
              TextField(
                controller: _noteCtrl,
                enabled: !_isTerminal,
                maxLength: 100,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'What is this for?',
                  hintStyle: TextStyle(color: _muted, fontSize: 13.sp),
                  filled: true,
                  fillColor: _card,
                  counterStyle: TextStyle(color: _muted, fontSize: 10.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 6.h),

              if (!_isTerminal && t.status == RecurringTransferStatus.paused)
                _Notice(
                  icon: Icons.pause_circle_outline,
                  color: const Color(0xFFFB923C),
                  // Otherwise the edit looks inert: no next-run date moves,
                  // because a paused transfer has none until it resumes.
                  text: 'This payment is paused. Your changes are saved now '
                      'and take effect when you resume it.',
                ),
              SizedBox(height: 14.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _isTerminal ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    disabledBackgroundColor: _blue.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save changes',
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text,
                style: TextStyle(color: color, fontSize: 11.5.sp, height: 1.4)),
          ),
        ],
      ),
    );
  }
}
