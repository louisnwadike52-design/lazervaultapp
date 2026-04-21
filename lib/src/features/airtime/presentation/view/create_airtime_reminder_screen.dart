import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_cubit.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_state.dart'
    show AirtimeBeneficiariesLoaded, AirtimeBeneficiary, AirtimeReminder, AirtimeState;
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_reminder_cubit.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_reminder_state.dart';

enum _RecurrenceType { daily, weekly, monthly }

class CreateAirtimeReminderScreen extends StatefulWidget {
  const CreateAirtimeReminderScreen({super.key});

  @override
  State<CreateAirtimeReminderScreen> createState() =>
      _CreateAirtimeReminderScreenState();
}

class _CreateAirtimeReminderScreenState
    extends State<CreateAirtimeReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  AirtimeBeneficiary? _selectedBeneficiary;
  bool _isRecurring = false;
  _RecurrenceType _recurrenceType = _RecurrenceType.monthly;

  bool _isEditing = false;
  String? _reminderId;

  @override
  void initState() {
    super.initState();
    // The AirtimeCubit owns the beneficiaries flow; ensure the list is loaded
    // so the user can optionally link a reminder to a saved contact.
    context.read<AirtimeCubit>().loadBeneficiaries();

    // Pre-fill from caller (e.g. history actions sheet or edit).
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      // Edit mode: pre-fill from existing reminder.
      final existing = args['reminder'] as AirtimeReminder?;
      if (existing != null) {
        _isEditing = true;
        _reminderId = existing.id;
        _titleController.text = existing.title;
        _descriptionController.text = existing.description ?? '';
        if (existing.amount != null && existing.amount! > 0) {
          _amountController.text = existing.amount!.toStringAsFixed(0);
        }
        _isRecurring = existing.isRecurring;
        if (existing.recurrenceType != null) {
          _recurrenceType = _RecurrenceType.values.firstWhere(
            (r) => r.name == existing.recurrenceType,
            orElse: () => _RecurrenceType.monthly,
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF10B981),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
            dialogTheme:
                const DialogThemeData(backgroundColor: Color(0xFF1A1A1A)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF10B981),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
            dialogTheme:
                const DialogThemeData(backgroundColor: Color(0xFF1A1A1A)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submitReminder() {
    if (!_formKey.currentState!.validate()) return;

    final reminderDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (reminderDateTime.isBefore(DateTime.now())) {
      Get.snackbar(
        'Invalid Time',
        'Please choose a time in the future',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    final amountText = _amountController.text.trim();
    final amount = amountText.isEmpty ? null : double.tryParse(amountText);

    if (_isEditing && _reminderId != null) {
      context.read<AirtimeReminderCubit>().updateReminder(
            reminderId: _reminderId!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: reminderDateTime,
            amount: amount,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrenceType.name : null,
          );
    } else {
      context.read<AirtimeReminderCubit>().createReminder(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: reminderDateTime,
            amount: amount,
            beneficiaryId: _selectedBeneficiary?.id,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrenceType.name : null,
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
          _isEditing ? 'Edit Airtime Reminder' : 'Create Airtime Reminder',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<AirtimeReminderCubit, AirtimeReminderState>(
        listener: (context, state) {
          if (state is AirtimeReminderCreated) {
            Get.back(result: true);
            Get.snackbar(
              'Success',
              'Reminder created successfully',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(16.w),
            );
          } else if (state is AirtimeRemindersLoaded && _isEditing) {
            // updateReminder re-fetches the list on success — treat as
            // successful update and pop back.
            Get.back(result: true);
            Get.snackbar(
              'Success',
              'Reminder updated successfully',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(16.w),
            );
          } else if (state is AirtimeReminderError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(16.w),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AirtimeReminderCreating ||
              state is AirtimeReminderUpdating ||
              state is AirtimeReminderLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Reminder Title'),
                  SizedBox(height: 12.h),
                  _textField(
                    controller: _titleController,
                    hintText: 'e.g., Recharge airtime for mom',
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Please enter a title'
                        : null,
                  ),
                  SizedBox(height: 24.h),
                  _sectionTitle('Description (Optional)'),
                  SizedBox(height: 12.h),
                  _textField(
                    controller: _descriptionController,
                    hintText: 'Add details about this reminder',
                    maxLines: 3,
                  ),
                  SizedBox(height: 24.h),
                  _sectionTitle('Reminder Date & Time'),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _dateTimeCard(
                          icon: Icons.calendar_today,
                          label: 'Date',
                          value: DateFormat('MMM dd, yyyy').format(_selectedDate),
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
                  _sectionTitle('Amount (Optional)'),
                  SizedBox(height: 12.h),
                  _textField(
                    controller: _amountController,
                    hintText: '0.00',
                    keyboardType: TextInputType.number,
                    prefixText: '₦ ',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return null;
                      final amount = double.tryParse(value.trim());
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      // NG MNOs accept N50–N10,000 per top-up — block
                      // out-of-range values up front so the reminder
                      // copy stays a viable purchase amount.
                      if (amount < 50) {
                        return 'Minimum amount is ₦50';
                      }
                      if (amount > 10000) {
                        return 'Maximum amount is ₦10,000 per top-up';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  _sectionTitle('Link to Beneficiary (Optional)'),
                  SizedBox(height: 12.h),
                  _buildBeneficiarySelector(),
                  SizedBox(height: 24.h),
                  _buildRecurringSection(),
                  SizedBox(height: 32.h),
                  _buildSummaryCard(),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitReminder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        disabledBackgroundColor:
                            const Color(0xFF10B981).withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            )
                          : Text(
                              _isEditing ? 'Update Reminder' : 'Create Reminder',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
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

  Widget _sectionTitle(String title) => Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? prefixText,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        prefixText: prefixText,
        prefixStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      ),
    );
  }

  Widget _dateTimeCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
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
                Icon(icon, size: 16.sp, color: const Color(0xFF10B981)),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiarySelector() {
    return BlocBuilder<AirtimeCubit, AirtimeState>(
      buildWhen: (prev, curr) => curr is AirtimeBeneficiariesLoaded,
      builder: (context, state) {
        if (state is AirtimeBeneficiariesLoaded) {
          final beneficiaries = state.beneficiaries;
          if (beneficiaries.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border:
                    Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                'No saved beneficiaries — reminder will be unlinked.',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
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
              child: DropdownButton<AirtimeBeneficiary>(
                isExpanded: true,
                value: _selectedBeneficiary,
                hint: Text(
                  'Select a beneficiary',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
                dropdownColor: const Color(0xFF1A1A1A),
                style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
                items: [
                  DropdownMenuItem<AirtimeBeneficiary>(
                    value: null,
                    child: Text(
                      'None',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  ...beneficiaries.map((b) => DropdownMenuItem<AirtimeBeneficiary>(
                        value: b,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              b.nickname ?? b.phoneNumber,
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '${b.networkName} • ${b.phoneNumber}',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
                onChanged: (value) => setState(() => _selectedBeneficiary = value),
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
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecurringSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF10B981).withValues(alpha: 0.1),
            const Color(0xFF059669).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.repeat,
                      color: const Color(0xFF10B981), size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Recurring Reminder',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _isRecurring,
                onChanged: (value) => setState(() => _isRecurring = value),
                activeThumbColor: const Color(0xFF10B981),
                activeTrackColor:
                    const Color(0xFF10B981).withValues(alpha: 0.5),
              ),
            ],
          ),
          if (_isRecurring) ...[
            SizedBox(height: 20.h),
            Row(
              children: [
                _buildRecurrenceButton(_RecurrenceType.daily, 'Daily'),
                SizedBox(width: 12.w),
                _buildRecurrenceButton(_RecurrenceType.weekly, 'Weekly'),
                SizedBox(width: 12.w),
                _buildRecurrenceButton(_RecurrenceType.monthly, 'Monthly'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecurrenceButton(_RecurrenceType type, String label) {
    final isSelected = _recurrenceType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _recurrenceType = type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF10B981)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF10B981)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final reminderDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    String recurrenceText = 'One-time reminder';
    if (_isRecurring) {
      recurrenceText = switch (_recurrenceType) {
        _RecurrenceType.daily => 'Repeats daily',
        _RecurrenceType.weekly => 'Repeats weekly',
        _RecurrenceType.monthly => 'Repeats monthly',
      };
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF10B981).withValues(alpha: 0.15),
            const Color(0xFF059669).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline,
                  color: const Color(0xFF10B981), size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                'Reminder Summary',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _summaryRow(
            'Next Reminder',
            DateFormat('MMM dd, yyyy at hh:mm a').format(reminderDateTime),
          ),
          SizedBox(height: 8.h),
          _summaryRow('Frequency', recurrenceText),
          if (_amountController.text.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            _summaryRow(
              'Amount',
              '₦${double.tryParse(_amountController.text.trim())?.toStringAsFixed(2) ?? '0.00'}',
            ),
          ],
          if (_selectedBeneficiary != null) ...[
            SizedBox(height: 8.h),
            _summaryRow(
              'Beneficiary',
              _selectedBeneficiary!.nickname ??
                  _selectedBeneficiary!.phoneNumber,
            ),
          ],
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }
}
