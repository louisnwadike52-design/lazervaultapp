import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Called when the user taps "Create Reminder". Must throw on failure so the
/// sheet can surface a retryable snackbar. The caller owns the cubit/repo
/// layer and decides how to wire these fields to its backend.
///
/// `recurrenceType` is `null` when [isRecurring] is `false`, else one of
/// `'daily'`, `'weekly'`, `'monthly'`.
typedef BillReminderSubmit = Future<void> Function({
  required String title,
  required String description,
  required DateTime reminderDate,
  required double? amount,
  required bool isRecurring,
  required String? recurrenceType,
});

/// Shared reminder-creation bottom-sheet used by every utility bill
/// (airtime, data, electricity, cable, internet, water, education). Callers
/// provide a [subtitle] identifying the beneficiary the reminder is for, a
/// [defaultTitle]/[defaultAmount] to prefill, and an [onSubmit] adapter
/// that wires to its own cubit. The sheet is identity-agnostic: it never
/// touches a cubit itself.
class BillReminderCreateSheet extends StatefulWidget {
  const BillReminderCreateSheet({
    super.key,
    required this.subtitle,
    required this.onSubmit,
    this.title = 'Create Reminder',
    this.defaultTitle = '',
    this.defaultAmount,
    this.showAmountField = true,
    this.currencySymbol = '\u20A6',
    this.successMessage = 'Reminder created',
  });

  /// Header line under the title — identifies the beneficiary.
  final String subtitle;
  final BillReminderSubmit onSubmit;
  final String title;
  final String defaultTitle;
  final double? defaultAmount;
  final bool showAmountField;
  final String currencySymbol;
  final String successMessage;

  static Future<void> show(
    BuildContext context, {
    required String subtitle,
    required BillReminderSubmit onSubmit,
    String title = 'Create Reminder',
    String defaultTitle = '',
    double? defaultAmount,
    bool showAmountField = true,
    String currencySymbol = '\u20A6',
    String successMessage = 'Reminder created',
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => BillReminderCreateSheet(
        subtitle: subtitle,
        onSubmit: onSubmit,
        title: title,
        defaultTitle: defaultTitle,
        defaultAmount: defaultAmount,
        showAmountField: showAmountField,
        currencySymbol: currencySymbol,
        successMessage: successMessage,
      ),
    );
  }

  @override
  State<BillReminderCreateSheet> createState() =>
      _BillReminderCreateSheetState();
}

class _BillReminderCreateSheetState extends State<BillReminderCreateSheet> {
  static const _accent = Color(0xFF4E03D0);
  static const _fieldBg = Color(0xFF0A0A0A);
  static const _border = Color(0xFF2D2D2D);
  static const _textMuted = Color(0xFF9CA3AF);
  static const _errorRed = Color(0xFFEF4444);

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;

  DateTime _reminderDate =
      DateTime.now().add(const Duration(days: 1)).copyWith(minute: 0);
  bool _isRecurring = false;
  String _recurrence = 'monthly';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.defaultTitle);
    _descriptionController = TextEditingController();
    _amountController = TextEditingController(
      text: widget.defaultAmount != null
          ? widget.defaultAmount!.toStringAsFixed(0)
          : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      _snack('Enter a title', _errorRed);
      return;
    }
    if (_reminderDate.isBefore(DateTime.now())) {
      _snack('Reminder must be in the future', _errorRed);
      return;
    }
    double? amount;
    if (widget.showAmountField) {
      final raw = _amountController.text.trim();
      if (raw.isNotEmpty) {
        amount = double.tryParse(raw);
        if (amount == null || amount <= 0) {
          _snack('Enter a valid amount', _errorRed);
          return;
        }
      }
    }
    setState(() => _loading = true);
    try {
      await widget.onSubmit(
        title: title,
        description: _descriptionController.text.trim(),
        reminderDate: _reminderDate,
        amount: amount,
        isRecurring: _isRecurring,
        recurrenceType: _isRecurring ? _recurrence : null,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      _snack(widget.successMessage, _accent);
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: _errorRed,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _submit,
            ),
            duration: const Duration(seconds: 8),
          ),
        );
    }
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _reminderDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_reminderDate),
    );
    if (time == null) return;
    setState(() {
      _reminderDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _snack(String message, Color bg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: bg),
      );
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('MMM d, yyyy \u00B7 h:mm a');
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
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
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              widget.subtitle,
              style: TextStyle(fontSize: 13.sp, color: _textMuted),
            ),
            SizedBox(height: 20.h),
            _label('Title'),
            SizedBox(height: 8.h),
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              decoration: _fieldDecoration(hint: 'e.g. Monthly electricity'),
            ),
            SizedBox(height: 16.h),
            _label('Note (optional)'),
            SizedBox(height: 8.h),
            TextField(
              controller: _descriptionController,
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration:
                  _fieldDecoration(hint: 'Anything to remember...'),
            ),
            SizedBox(height: 16.h),
            _label('When'),
            SizedBox(height: 8.h),
            InkWell(
              onTap: _pickDateTime,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: _fieldBg,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _border),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, color: _accent, size: 18.sp),
                    SizedBox(width: 10.w),
                    Text(
                      fmt.format(_reminderDate),
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.showAmountField) ...[
              SizedBox(height: 16.h),
              _label('Amount (optional)'),
              SizedBox(height: 8.h),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: _fieldDecoration(
                  hint: '${widget.currencySymbol}1000',
                ),
              ),
            ],
            SizedBox(height: 16.h),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Repeat',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              subtitle: Text(
                _isRecurring
                    ? 'Fires every $_recurrence'
                    : 'One-off reminder',
                style: TextStyle(color: _textMuted, fontSize: 12.sp),
              ),
              value: _isRecurring,
              activeThumbColor: _accent,
              onChanged: (v) => setState(() => _isRecurring = v),
            ),
            if (_isRecurring) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  _recurrenceChip('daily', 'Daily'),
                  SizedBox(width: 8.w),
                  _recurrenceChip('weekly', 'Weekly'),
                  SizedBox(width: 8.w),
                  _recurrenceChip('monthly', 'Monthly'),
                ],
              ),
            ],
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: _loading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Create Reminder',
                        style: TextStyle(
                          fontSize: 15.sp,
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

  Widget _label(String t) => Text(
        t,
        style: TextStyle(
          fontSize: 13.sp,
          color: _textMuted,
          fontWeight: FontWeight.w500,
        ),
      );

  InputDecoration _fieldDecoration({required String hint}) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF4B5563), fontSize: 14.sp),
        filled: true,
        fillColor: _fieldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _accent),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      );

  Widget _recurrenceChip(String value, String label) {
    final selected = _recurrence == value;
    return GestureDetector(
      onTap: () => setState(() => _recurrence = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? _accent : _fieldBg,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: selected ? _accent : _border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : _textMuted,
          ),
        ),
      ),
    );
  }
}
