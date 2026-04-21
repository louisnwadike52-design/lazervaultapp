import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/education_beneficiary.dart';
import '../cubit/education_beneficiary_cubit.dart';
import '../cubit/education_beneficiary_state.dart';
import '../cubit/education_reminder_cubit.dart';
import '../cubit/education_reminder_state.dart';

/// Create an education reminder. Title + date/time + optional candidate
/// + optional amount + optional recurrence.
class CreateEducationReminderScreen extends StatefulWidget {
  const CreateEducationReminderScreen({super.key});

  @override
  State<CreateEducationReminderScreen> createState() =>
      _CreateEducationReminderScreenState();
}

class _CreateEducationReminderScreenState
    extends State<CreateEducationReminderScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  EducationBeneficiary? _beneficiary;
  DateTime _reminderDate = DateTime.now().add(const Duration(days: 7));
  bool _isRecurring = false;
  String _recurrenceType = 'yearly';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    context.read<EducationBeneficiaryCubit>().load();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      final b = args['beneficiary'];
      if (b is EducationBeneficiary) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() {
            _beneficiary = b;
            _titleController.text =
                '${b.examType.toUpperCase()} PIN for ${b.nickname ?? b.candidateNumber}';
          });
        });
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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _reminderDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked == null) return;
    if (!mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_reminderDate),
    );
    if (!mounted) return;
    setState(() {
      _reminderDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        time?.hour ?? _reminderDate.hour,
        time?.minute ?? _reminderDate.minute,
      );
    });
  }

  Future<void> _submit() async {
    if (_titleController.text.trim().isEmpty) {
      _snack('Enter a title', error: true);
      return;
    }
    final amountText = _amountController.text.trim();
    final amount = amountText.isEmpty ? null : double.tryParse(amountText);
    setState(() => _saving = true);
    try {
      await context.read<EducationReminderCubit>().createReminder(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: _reminderDate,
            beneficiaryId: _beneficiary?.id,
            amount: amount,
            currency: 'NGN',
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrenceType : null,
          );
      if (!mounted) return;
      Get.back(result: true);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            error ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationReminderCubit, EducationReminderState>(
      listener: (context, state) {
        if (state is EducationReminderError && _saving) {
          setState(() => _saving = false);
          _snack(state.message, error: true);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
            onPressed: () => Get.back(),
          ),
          title: Text('New Reminder',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Title'),
                SizedBox(height: 8.h),
                _textInput(_titleController, 'e.g., JAMB registration deadline'),
                SizedBox(height: 16.h),
                _label('Reminder date & time'),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: _pickDate,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            color: const Color(0xFFFB923C), size: 18.sp),
                        SizedBox(width: 10.w),
                        Text(
                            DateFormat('MMM dd, yyyy \u00B7 hh:mm a')
                                .format(_reminderDate),
                            style: TextStyle(
                                color: Colors.white, fontSize: 15.sp)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                _label('Saved Candidate (optional)'),
                SizedBox(height: 8.h),
                _beneficiarySelector(),
                SizedBox(height: 16.h),
                _label('Description (optional)'),
                SizedBox(height: 8.h),
                _textInput(_descriptionController, 'Notes for yourself',
                    maxLines: 2),
                SizedBox(height: 16.h),
                _label('Expected amount (optional, NGN)'),
                SizedBox(height: 8.h),
                _textInput(_amountController, 'e.g., 6200',
                    keyboardType: TextInputType.number,
                    formatters: [FilteringTextInputFormatter.digitsOnly]),
                SizedBox(height: 16.h),
                SwitchListTile(
                  value: _isRecurring,
                  onChanged: (v) => setState(() => _isRecurring = v),
                  activeThumbColor: const Color(0xFFFB923C),
                  contentPadding: EdgeInsets.zero,
                  title: Text('Recurring',
                      style: TextStyle(
                          color: Colors.white, fontSize: 14.sp)),
                  subtitle: Text('Repeat yearly for exam cycles',
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                ),
                if (_isRecurring) ...[
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _recChip('yearly', 'Yearly'),
                      SizedBox(width: 8.w),
                      _recChip('monthly', 'Monthly'),
                      SizedBox(width: 8.w),
                      _recChip('weekly', 'Weekly'),
                    ],
                  ),
                ],
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB923C),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      elevation: 0,
                    ),
                    child: _saving
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text('Create Reminder',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(t,
      style: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFF9CA3AF),
          fontWeight: FontWeight.w500));

  Widget _textInput(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? formatters,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: const Color(0xFF4B5563), fontSize: 15.sp),
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFFB923C)),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _beneficiarySelector() {
    return BlocBuilder<EducationBeneficiaryCubit, EducationBeneficiaryState>(
      buildWhen: (_, s) => s is EducationBeneficiariesLoaded,
      builder: (context, state) {
        if (state is! EducationBeneficiariesLoaded) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text('Loading candidates…',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          );
        }
        final list = state.beneficiaries;
        if (list.isEmpty) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text(
                'No saved candidates (reminder will still be created)',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<EducationBeneficiary?>(
              isExpanded: true,
              value: _beneficiary,
              hint: Text('None',
                  style: TextStyle(
                      color: const Color(0xFF4B5563), fontSize: 15.sp)),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF9CA3AF)),
              dropdownColor: const Color(0xFF1F1F1F),
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              items: [
                DropdownMenuItem<EducationBeneficiary?>(
                  value: null,
                  child: Text('None',
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 15.sp)),
                ),
                ...list.map((b) => DropdownMenuItem<EducationBeneficiary?>(
                      value: b,
                      child: Text(
                        '${b.nickname ?? b.candidateNumber} \u00B7 ${b.examType.toUpperCase()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ],
              onChanged: (v) => setState(() => _beneficiary = v),
            ),
          ),
        );
      },
    );
  }

  Widget _recChip(String value, String label) {
    final selected = _recurrenceType == value;
    return GestureDetector(
      onTap: () => setState(() => _recurrenceType = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFB923C) : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: selected
                  ? const Color(0xFFFB923C)
                  : const Color(0xFF2D2D2D)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : const Color(0xFF9CA3AF))),
      ),
    );
  }
}
