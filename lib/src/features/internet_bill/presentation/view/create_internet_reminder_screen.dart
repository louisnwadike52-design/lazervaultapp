import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/internet_beneficiary.dart';
import '../../domain/entities/internet_reminder.dart';
import '../cubit/internet_beneficiary_cubit.dart';
import '../cubit/internet_beneficiary_state.dart';
import '../cubit/internet_reminder_cubit.dart';
import '../cubit/internet_reminder_state.dart';

enum _Recurrence { daily, weekly, monthly }

/// Create or edit an internet reminder. Mirrors `CreateDataReminderScreen`.
/// Optional pre-fills via `Get.arguments`:
///   * `accountNumber` — surfaces in the title default
///   * `amount` — pre-fills the optional amount field
///   * `title` — overrides the auto-generated title
///   * `packageId` — links to a specific package for one-tap re-buy later
///   * `reminder` — an [InternetReminder] to edit (enters edit mode)
class CreateInternetReminderScreen extends StatefulWidget {
  const CreateInternetReminderScreen({super.key});

  @override
  State<CreateInternetReminderScreen> createState() =>
      _CreateInternetReminderScreenState();
}

class _CreateInternetReminderScreenState
    extends State<CreateInternetReminderScreen> {
  static const _accent = Color(0xFF4E03D0);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  InternetBeneficiary? _selectedBeneficiary;
  String? _packageId;
  bool _isRecurring = false;
  _Recurrence _recurrence = _Recurrence.monthly;

  bool _isEditing = false;
  String? _reminderId;

  @override
  void initState() {
    super.initState();
    context.read<InternetBeneficiaryCubit>().load();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      final existing = args['reminder'] as InternetReminder?;
      if (existing != null) {
        _isEditing = true;
        _reminderId = existing.id;
        _titleController.text = existing.title;
        _descriptionController.text = existing.description ?? '';
        if (existing.amount != null && existing.amount! > 0) {
          _amountController.text = existing.amount!.toStringAsFixed(0);
        }
        _packageId = existing.packageId;
        _isRecurring = existing.isRecurring;
        if (existing.recurrenceType != null) {
          _recurrence = _Recurrence.values.firstWhere(
            (r) => r.name == existing.recurrenceType,
            orElse: () => _Recurrence.monthly,
          );
        }
        final dt = existing.reminderDate.isNotEmpty
            ? DateTime.tryParse(existing.reminderDate)?.toLocal()
            : null;
        if (dt != null) {
          _selectedDate = dt;
          _selectedTime = TimeOfDay.fromDateTime(dt);
        }
      } else {
        final title = args['title'] as String?;
        if (title != null) _titleController.text = title;
        final amount = args['amount'];
        if (amount != null) {
          _amountController.text = (amount as num).toStringAsFixed(0);
        }
        _packageId = args['packageId'] as String?;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: _accent,
            onPrimary: Colors.white,
            surface: Color(0xFF1A1A1A),
            onSurface: Colors.white,
          ),
          dialogTheme:
              const DialogThemeData(backgroundColor: Color(0xFF1A1A1A)),
        ),
        child: child!,
      ),
    );
    if (!mounted) return;
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: _accent,
            onPrimary: Colors.white,
            surface: Color(0xFF1A1A1A),
            onSurface: Colors.white,
          ),
          dialogTheme:
              const DialogThemeData(backgroundColor: Color(0xFF1A1A1A)),
        ),
        child: child!,
      ),
    );
    if (!mounted) return;
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final dt = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    if (dt.isBefore(DateTime.now())) {
      Get.snackbar('Invalid Time', 'Please choose a time in the future',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white);
      return;
    }
    final amountText = _amountController.text.trim();
    final amount = amountText.isEmpty ? null : double.tryParse(amountText);

    if (_isEditing && _reminderId != null) {
      context.read<InternetReminderCubit>().updateReminder(
            reminderId: _reminderId!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: dt,
            amount: amount,
            packageId: _packageId,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrence.name : null,
          );
    } else {
      context.read<InternetReminderCubit>().createReminder(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: dt,
            amount: amount,
            packageId: _packageId,
            beneficiaryId: _selectedBeneficiary?.id,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrence.name : null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
            _isEditing ? 'Edit Internet Reminder' : 'Create Internet Reminder',
            style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      body: BlocConsumer<InternetReminderCubit, InternetReminderState>(
        listener: (context, state) {
          if (state is InternetReminderCreated) {
            Get.back(result: true);
            Get.snackbar('Success', 'Reminder created successfully',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.w));
          } else if (state is InternetReminderUpdated) {
            Get.back(result: true);
            Get.snackbar('Success', 'Reminder updated successfully',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.w));
          } else if (state is InternetReminderError) {
            Get.snackbar('Error', state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.w));
          }
        },
        builder: (context, state) {
          final isLoading = state is InternetReminderCreating ||
              state is InternetReminderUpdating ||
              state is InternetReminderLoading;
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section('Reminder Title'),
                  SizedBox(height: 12.h),
                  _textField(
                    controller: _titleController,
                    hint: 'e.g., Renew Smile monthly plan',
                    // Title column is varchar(200) on the backend;
                    // match that here so the server never has to
                    // truncate silently.
                    maxLength: 200,
                    validator: (v) {
                      final trimmed = v?.trim() ?? '';
                      if (trimmed.isEmpty) return 'Please enter a title';
                      if (trimmed.length > 200) {
                        return 'Title must be 200 characters or less';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  _section('Description (Optional)'),
                  SizedBox(height: 12.h),
                  _textField(
                    controller: _descriptionController,
                    hint: 'Add details about this reminder',
                    maxLines: 3,
                    maxLength: 1000,
                  ),
                  SizedBox(height: 24.h),
                  _section('Reminder Date & Time'),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _dateTimeCard(
                          icon: Icons.calendar_today,
                          label: 'Date',
                          value: DateFormat('MMM dd, yyyy')
                              .format(_selectedDate),
                          onTap: _selectDate,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _dateTimeCard(
                          icon: Icons.access_time,
                          label: 'Time',
                          value: _formatTime(_selectedTime),
                          onTap: _selectTime,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  _section('Amount (Optional)'),
                  SizedBox(height: 12.h),
                  _textField(
                    controller: _amountController,
                    hint: '0',
                    keyboardType: TextInputType.number,
                    prefix: '\u20A6 ',
                    validator: (v) {
                      if (v != null && v.trim().isNotEmpty) {
                        final a = double.tryParse(v.trim());
                        if (a == null || a <= 0) {
                          return 'Please enter a valid amount';
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  _section('Link to Saved Account (Optional)'),
                  SizedBox(height: 12.h),
                  _beneficiaryDropdown(),
                  SizedBox(height: 24.h),
                  _recurringSection(),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        disabledBackgroundColor:
                            _accent.withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              _isEditing
                                  ? 'Update Reminder'
                                  : 'Create Reminder',
                              style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _section(String t) => Text(t,
      style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white.withValues(alpha: 0.7)));

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? prefix,
    int? maxLength,
  }) =>
      TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        // Hide the counter — the maxLength is a hard cap, not a target
        // the user needs to watch.
        buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
        style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
              fontSize: 16.sp, color: Colors.white.withValues(alpha: 0.3)),
          prefixText: prefix,
          prefixStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: _accent, width: 2)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
      );

  Widget _dateTimeCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16.sp, color: _accent),
                  SizedBox(width: 8.w),
                  Text(label,
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.5))),
                ],
              ),
              SizedBox(height: 8.h),
              Text(value,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
        ),
      );

  Widget _beneficiaryDropdown() {
    return BlocBuilder<InternetBeneficiaryCubit, InternetBeneficiaryState>(
      buildWhen: (_, s) =>
          s is InternetBeneficiariesLoaded || s is InternetBeneficiaryError,
      builder: (context, state) {
        if (state is InternetBeneficiaryError) {
          // Failing to load saved accounts must not block reminder
          // creation — the link is optional. Fall back to an
          // "unlinked" explainer + retry so the user still moves
          // forward.
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: const Color(0xFFFB923C), size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "Couldn't load saved accounts. Reminder will stay unlinked.",
                    style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6)),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<InternetBeneficiaryCubit>().load(),
                  child: Text('Retry',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _accent)),
                ),
              ],
            ),
          );
        }
        if (state is InternetBeneficiariesLoaded) {
          final list = state.beneficiaries;
          if (list.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border:
                    Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                  'No saved internet accounts \u2014 reminder will be unlinked.',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.5))),
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<InternetBeneficiary>(
                isExpanded: true,
                value: _selectedBeneficiary,
                hint: Text('Select an account',
                    style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: Colors.white.withValues(alpha: 0.3))),
                icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.white.withValues(alpha: 0.5)),
                dropdownColor: const Color(0xFF1A1A1A),
                style:
                    GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
                items: [
                  DropdownMenuItem<InternetBeneficiary>(
                    value: null,
                    child: Text('None',
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            color:
                                Colors.white.withValues(alpha: 0.5))),
                  ),
                  ...list.map((b) => DropdownMenuItem<InternetBeneficiary>(
                        value: b,
                        child: Text(
                          '${(b.nickname?.isNotEmpty == true ? b.nickname! : b.accountNumber)} \u00B7 ${b.providerName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ],
                onChanged: (v) => setState(() => _selectedBeneficiary = v),
              ),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_accent),
            ),
          ),
        );
      },
    );
  }

  Widget _recurringSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _accent.withValues(alpha: 0.1),
            _accent.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.repeat, color: _accent, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text('Recurring Reminder',
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              Switch(
                value: _isRecurring,
                onChanged: (v) => setState(() => _isRecurring = v),
                activeThumbColor: _accent,
                activeTrackColor: _accent.withValues(alpha: 0.5),
              ),
            ],
          ),
          if (_isRecurring) ...[
            SizedBox(height: 20.h),
            Row(
              children: [
                _recurChip(_Recurrence.daily, 'Daily'),
                SizedBox(width: 12.w),
                _recurChip(_Recurrence.weekly, 'Weekly'),
                SizedBox(width: 12.w),
                _recurChip(_Recurrence.monthly, 'Monthly'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _recurChip(_Recurrence type, String label) {
    final selected = _recurrence == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _recurrence = type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: selected
                ? _accent
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: selected
                    ? _accent
                    : Colors.white.withValues(alpha: 0.1)),
          ),
          child: Center(
            child: Text(label,
                style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w500,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay t) {
    final now = DateTime.now();
    return DateFormat.jm()
        .format(DateTime(now.year, now.month, now.day, t.hour, t.minute));
  }
}
