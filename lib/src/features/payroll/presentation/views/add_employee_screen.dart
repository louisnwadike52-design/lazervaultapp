import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import '../../domain/entities/employee_entity.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Step 1: Personal Info
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ninController = TextEditingController();

  // Step 2: Bank Details
  final _bankAccountController = TextEditingController();
  final _bankCodeController = TextEditingController();
  final _bankNameController = TextEditingController();

  // Step 3: Employment
  EmploymentType _employmentType = EmploymentType.fullTime;
  final _payRateController = TextEditingController();
  PayFrequency _payFrequency = PayFrequency.monthly;
  final _departmentController = TextEditingController();
  final _jobTitleController = TextEditingController();
  DateTime? _startDate;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ninController.dispose();
    _bankAccountController.dispose();
    _bankCodeController.dispose();
    _bankNameController.dispose();
    _payRateController.dispose();
    _departmentController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final payRateNaira =
        double.tryParse(_payRateController.text.replaceAll(',', '')) ?? 0.0;
    final payRateKobo = (payRateNaira * 100).toInt();

    context.read<PayrollCubit>().addEmployee(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          nin: _ninController.text.trim(),
          bankAccountNumber: _bankAccountController.text.trim(),
          bankCode: _bankCodeController.text.trim(),
          bankName: _bankNameController.text.trim(),
          employmentType: _employmentType,
          payRate: payRateKobo,
          payFrequency: _payFrequency,
          department: _departmentController.text.trim(),
          jobTitle: _jobTitleController.text.trim(),
          startDate: _startDate != null
              ? '${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}'
              : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is EmployeeAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is PayrollError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is PayrollLoading;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: _previousStep,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Add Employee',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                _buildStepIndicator(),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: _buildCurrentStep(),
                    ),
                  ),
                ),
                _buildBottomActions(isLoading),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepIndicator() {
    const labels = ['Personal', 'Bank', 'Employment'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index <= _currentStep;
          final isCurrent = index == _currentStep;
          return Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    if (index > 0)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: isActive
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF2D2D2D),
                        ),
                      ),
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.inter(
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF6B7280),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (index < 2)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: index < _currentStep
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF2D2D2D),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  labels[index],
                  style: GoogleFonts.inter(
                    color: isCurrent
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF6B7280),
                    fontSize: 11.sp,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildBankDetailsStep();
      case 2:
        return _buildEmploymentStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------------------------------------------------------------------------
  // Step 1: Personal Info
  // ---------------------------------------------------------------------------

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          hint: 'e.g. Adebayo Ogunlesi',
          icon: Icons.person_outline,
          validator: (v) =>
              v == null || v.trim().isEmpty ? 'Full name is required' : null,
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _emailController,
          label: 'Email Address',
          hint: 'e.g. adebayo@company.com',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Email is required';
            if (!v.contains('@')) return 'Enter a valid email';
            return null;
          },
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          hint: 'e.g. 08012345678',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) =>
              v == null || v.trim().isEmpty ? 'Phone number is required' : null,
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _ninController,
          label: 'NIN (National Identification Number)',
          hint: 'e.g. 12345678901',
          icon: Icons.badge_outlined,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2: Bank Details
  // ---------------------------------------------------------------------------

  Widget _buildBankDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Bank Details'),
        SizedBox(height: 8.h),
        Text(
          'Employee bank details for salary disbursement',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _bankNameController,
          label: 'Bank Name',
          hint: 'e.g. First Bank',
          icon: Icons.account_balance_outlined,
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _bankAccountController,
          label: 'Account Number',
          hint: 'e.g. 0123456789',
          icon: Icons.numbers,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _bankCodeController,
          label: 'Bank Code',
          hint: 'e.g. 011',
          icon: Icons.code,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3: Employment
  // ---------------------------------------------------------------------------

  Widget _buildEmploymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Employment Details'),
        SizedBox(height: 16.h),

        // Employment Type Selector
        Text(
          'Employment Type',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: EmploymentType.values.map((type) {
            final isSelected = type == _employmentType;
            String label;
            switch (type) {
              case EmploymentType.fullTime:
                label = 'Full-Time';
                break;
              case EmploymentType.partTime:
                label = 'Part-Time';
                break;
              case EmploymentType.contract:
                label = 'Contract';
                break;
            }
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _employmentType = type),
                child: Container(
                  margin: EdgeInsets.only(right: type != EmploymentType.contract ? 8.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 14.h),

        _buildTextField(
          controller: _payRateController,
          label: 'Pay Rate (Naira)',
          hint: 'e.g. 350000',
          icon: Icons.payments_outlined,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
          ],
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Pay rate is required';
            final amount =
                double.tryParse(v.replaceAll(',', ''));
            if (amount == null || amount <= 0) return 'Enter a valid amount';
            return null;
          },
        ),
        SizedBox(height: 14.h),

        // Pay Frequency Selector
        Text(
          'Pay Frequency',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: PayFrequency.values.map((freq) {
            final isSelected = freq == _payFrequency;
            String label;
            switch (freq) {
              case PayFrequency.monthly:
                label = 'Monthly';
                break;
              case PayFrequency.biweekly:
                label = 'Bi-Weekly';
                break;
              case PayFrequency.weekly:
                label = 'Weekly';
                break;
            }
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _payFrequency = freq),
                child: Container(
                  margin: EdgeInsets.only(right: freq != PayFrequency.weekly ? 8.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 14.h),

        _buildTextField(
          controller: _departmentController,
          label: 'Department',
          hint: 'e.g. Engineering',
          icon: Icons.business_outlined,
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _jobTitleController,
          label: 'Job Title',
          hint: 'e.g. Senior Developer',
          icon: Icons.work_outline,
        ),
        SizedBox(height: 14.h),

        // Start Date Picker
        Text(
          'Start Date',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _pickStartDate,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: const Color(0xFF9CA3AF),
                  size: 18.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  _startDate != null
                      ? '${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}'
                      : 'Select start date',
                  style: GoogleFonts.inter(
                    color: _startDate != null
                        ? Colors.white
                        : const Color(0xFF6B7280),
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  // ---------------------------------------------------------------------------
  // Shared Widgets
  // ---------------------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 15.sp,
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            disabledBackgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  _currentStep < 2 ? 'Continue' : 'Add Employee',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
