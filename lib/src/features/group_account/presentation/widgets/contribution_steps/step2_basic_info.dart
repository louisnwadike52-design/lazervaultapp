import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../cubit/create_contribution_cubit.dart';
import '../../cubit/create_contribution_state.dart';

/// Step 2: Basic Information (Title, Description, Target Amount, Currency, Deadline)
class Step2BasicInfo extends StatefulWidget {
  const Step2BasicInfo({super.key});

  @override
  State<Step2BasicInfo> createState() => _Step2BasicInfoState();
}

class _Step2BasicInfoState extends State<Step2BasicInfo> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _targetAmountController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateContributionCubit>();
    _titleController = TextEditingController(text: cubit.title);
    _descriptionController = TextEditingController(text: cubit.description);
    _targetAmountController = TextEditingController(
      text: cubit.targetAmount?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContributionCubit, CreateContributionState>(
      builder: (context, state) {
        final cubit = context.read<CreateContributionCubit>();
        final formState = state is CreateContributionFormUpdated ? state : null;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contribution Details',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Tell us about your contribution goal',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 32.h),

              // Title Field
              _buildSectionLabel('Title *', '${_titleController.text.length}/100'),
              SizedBox(height: 8.h),
              _buildTextField(
                controller: _titleController,
                hint: 'e.g., Monthly Savings Goal',
                maxLength: 100,
                onChanged: (value) => cubit.updateTitle(value),
              ),
              SizedBox(height: 24.h),

              // Description Field
              _buildSectionLabel(
                'Description *',
                '${_descriptionController.text.length}/500',
              ),
              SizedBox(height: 8.h),
              _buildTextField(
                controller: _descriptionController,
                hint: 'Describe the purpose of this contribution...',
                maxLines: 3,
                maxLength: 500,
                onChanged: (value) => cubit.updateDescription(value),
              ),
              SizedBox(height: 24.h),

              // Target Amount and Currency
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('Target Amount *', null),
                        SizedBox(height: 8.h),
                        _buildAmountField(
                          controller: _targetAmountController,
                          onChanged: (value) {
                            final amount = double.tryParse(value);
                            cubit.updateTargetAmount(amount);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('Currency', null),
                        SizedBox(height: 8.h),
                        _buildCurrencyDropdown(
                          value: formState?.currency ?? 'USD',
                          onChanged: (value) {
                            if (value != null) cubit.updateCurrency(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Target Date
              _buildSectionLabel('Target Date *', null),
              SizedBox(height: 8.h),
              _buildDatePicker(
                selectedDate: formState?.deadline ?? DateTime.now().add(const Duration(days: 30)),
                onDateSelected: (date) => cubit.updateDeadline(date),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionLabel(String label, String? counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        if (counter != null)
          Text(
            counter,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    int? maxLength,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      onChanged: onChanged,
      inputFormatters: maxLength != null
          ? [LengthLimitingTextInputFormatter(maxLength)]
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        counterText: '',
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
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        hintText: '0.00',
        hintStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
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
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildCurrencyDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    final currencies = ['USD', 'EUR', 'GBP', 'NGN', 'GHS', 'ZAR', 'KES'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[400],
          ),
          items: currencies.map((currency) {
            return DropdownMenuItem(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required DateTime selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF6366F1),
                  surface: Color(0xFF1F1F1F),
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.grey[400],
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              DateFormat('MMM dd, yyyy').format(selectedDate),
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
