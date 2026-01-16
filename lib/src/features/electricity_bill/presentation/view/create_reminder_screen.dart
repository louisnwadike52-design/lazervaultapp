import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/electricity_bill/domain/entities/beneficiary_entity.dart';
import 'package:lazervault/src/features/electricity_bill/domain/entities/reminder_entity.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/beneficiary_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/beneficiary_state.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/reminder_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/reminder_state.dart';

class CreateReminderScreen extends StatefulWidget {
  const CreateReminderScreen({super.key});

  @override
  State<CreateReminderScreen> createState() => _CreateReminderScreenState();
}

class _CreateReminderScreenState extends State<CreateReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  BillBeneficiaryEntity? _selectedBeneficiary;
  bool _isRecurring = false;
  ReminderRecurrenceType _recurrenceType = ReminderRecurrenceType.monthly;

  @override
  void initState() {
    super.initState();
    // Load beneficiaries
    context.read<BeneficiaryCubit>().getBeneficiaries();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4E03D0),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ), dialogTheme: DialogThemeData(backgroundColor: const Color(0xFF1A1A1A)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4E03D0),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ), dialogTheme: DialogThemeData(backgroundColor: const Color(0xFF1A1A1A)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _createReminder() {
    if (_formKey.currentState!.validate()) {
      final reminderDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final amount = _amountController.text.trim().isEmpty
          ? null
          : double.tryParse(_amountController.text.trim());

      context.read<ReminderCubit>().createReminder(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim().isNotEmpty
                ? _descriptionController.text.trim()
                : '',
            reminderDate: reminderDateTime,
            amount: amount,
            beneficiaryId: _selectedBeneficiary?.id,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrenceType : null,
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
          'Create Reminder',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<ReminderCubit, ReminderState>(
        listener: (context, state) {
          if (state is ReminderCreated) {
            Get.back();
            Get.snackbar(
              'Success',
              'Reminder created successfully',
              backgroundColor: const Color(0xFF4CAF50),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(16.w),
            );
          } else if (state is ReminderError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF5350),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(16.w),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ReminderLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Input
                  _buildSectionTitle('Reminder Title'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: _titleController,
                    hintText: 'e.g., Pay electricity bill',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 24.h),

                  // Description Input (Optional)
                  _buildSectionTitle('Description (Optional)'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: _descriptionController,
                    hintText: 'Add details about this reminder',
                    maxLines: 3,
                  ),

                  SizedBox(height: 24.h),

                  // Date and Time Selection
                  _buildSectionTitle('Reminder Date & Time'),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateTimeCard(
                          icon: Icons.calendar_today,
                          label: 'Date',
                          value: DateFormat('MMM dd, yyyy').format(_selectedDate),
                          onTap: _selectDate,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDateTimeCard(
                          icon: Icons.access_time,
                          label: 'Time',
                          value: _selectedTime.format(context),
                          onTap: _selectTime,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Amount Input (Optional)
                  _buildSectionTitle('Amount (Optional)'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: _amountController,
                    hintText: '0.00',
                    keyboardType: TextInputType.number,
                    prefixText: '₦ ',
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        final amount = double.tryParse(value.trim());
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 24.h),

                  // Beneficiary Selection (Optional)
                  _buildSectionTitle('Link to Beneficiary (Optional)'),
                  SizedBox(height: 12.h),
                  _buildBeneficiarySelector(),

                  SizedBox(height: 24.h),

                  // Recurring Reminder Toggle
                  _buildRecurringSection(),

                  SizedBox(height: 32.h),

                  // Summary Card
                  _buildSummaryCard(),

                  SizedBox(height: 24.h),

                  // Create Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _createReminder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        disabledBackgroundColor: const Color(0xFF4E03D0).withOpacity(0.5),
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
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Create Reminder',
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  Widget _buildTextField({
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
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.3),
        ),
        prefixText: prefixText,
        prefixStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFFEF5350)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      ),
    );
  }

  Widget _buildDateTimeCard({
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
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16.sp, color: const Color(0xFF4E03D0)),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.5),
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
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        if (state is BeneficiariesLoaded) {
          final beneficiaries = state.beneficiaries;

          if (beneficiaries.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Text(
                'No beneficiaries available',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BillBeneficiaryEntity>(
                isExpanded: true,
                value: _selectedBeneficiary,
                hint: Text(
                  'Select a beneficiary',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withOpacity(0.5),
                ),
                dropdownColor: const Color(0xFF1A1A1A),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem<BillBeneficiaryEntity>(
                    value: null,
                    child: Text(
                      'None',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  ...beneficiaries.map((beneficiary) {
                    return DropdownMenuItem<BillBeneficiaryEntity>(
                      value: beneficiary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            beneficiary.nickname ?? beneficiary.meterNumber,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          ...[
                          SizedBox(height: 2.h),
                          Text(
                            beneficiary.meterNumber,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                        ],
                      ),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedBeneficiary = value;
                  });
                },
              ),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
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
            const Color(0xFF4E03D0).withOpacity(0.1),
            const Color(0xFF6B21E0).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF4E03D0).withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.repeat,
                    color: const Color(0xFF4E03D0),
                    size: 20.sp,
                  ),
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
                onChanged: (value) {
                  setState(() {
                    _isRecurring = value;
                  });
                },
                activeThumbColor: const Color(0xFF4E03D0),
                activeTrackColor: const Color(0xFF4E03D0).withOpacity(0.5),
              ),
            ],
          ),
          if (_isRecurring) ...[
            SizedBox(height: 20.h),
            _buildRecurrenceTypeSelector(),
          ],
        ],
      ),
    );
  }

  Widget _buildRecurrenceTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repeat every:',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildRecurrenceButton(ReminderRecurrenceType.daily, 'Daily'),
            SizedBox(width: 12.w),
            _buildRecurrenceButton(ReminderRecurrenceType.weekly, 'Weekly'),
            SizedBox(width: 12.w),
            _buildRecurrenceButton(ReminderRecurrenceType.monthly, 'Monthly'),
          ],
        ),
      ],
    );
  }

  Widget _buildRecurrenceButton(ReminderRecurrenceType type, String label) {
    final isSelected = _recurrenceType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _recurrenceType = type;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4E03D0)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4E03D0)
                  : Colors.white.withOpacity(0.1),
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
      switch (_recurrenceType) {
        case ReminderRecurrenceType.daily:
          recurrenceText = 'Repeats daily';
          break;
        case ReminderRecurrenceType.weekly:
          recurrenceText = 'Repeats weekly';
          break;
        case ReminderRecurrenceType.monthly:
          recurrenceText = 'Repeats monthly';
          break;
      }
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4E03D0).withOpacity(0.15),
            const Color(0xFF6B21E0).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF4E03D0).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF4E03D0),
                size: 20.sp,
              ),
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
          _buildSummaryRow(
            'Next Reminder',
            DateFormat('MMM dd, yyyy at hh:mm a').format(reminderDateTime),
          ),
          if (_isRecurring) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow('Frequency', recurrenceText),
          ],
          if (_amountController.text.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow(
              'Amount',
              '₦${double.tryParse(_amountController.text.trim())?.toStringAsFixed(2) ?? '0.00'}',
            ),
          ],
          if (_selectedBeneficiary != null) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow(
              'Beneficiary',
              _selectedBeneficiary!.nickname ?? _selectedBeneficiary!.meterNumber,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.6),
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
}
