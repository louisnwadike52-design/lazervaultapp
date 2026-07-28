import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import '../../domain/entities/employee_entity.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/utils/form_validators.dart';
import 'package:lazervault/core/widgets/app_phone_field.dart';
import 'package:lazervault/core/widgets/bank_picker_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';

class _WizardStep {
  final String label;
  final Widget Function() builder;
  const _WizardStep(this.label, this.builder);
}

class EditEmployeeScreen extends StatefulWidget {
  final EmployeeEntity employee;

  const EditEmployeeScreen({super.key, required this.employee});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Payout destination is fixed at edit time (to change it, remove + re-add) —
  // but bank details for an external employee can still be corrected + re-verified.
  late final bool _isInternal;

  // Step: Personal Info
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ninController = TextEditingController();
  PhoneNumber? _phone;

  // Step: Bank Details (external only)
  final _bankAccountController = TextEditingController();
  String _bankCode = '';
  String _bankName = '';
  String _bankAccountName = '';
  bool _verifying = false;
  String _verifyError = '';

  // Step: Employment
  EmploymentType _employmentType = EmploymentType.fullTime;
  final _payRateController = TextEditingController();
  PayFrequency _payFrequency = PayFrequency.monthly;
  final _departmentController = TextEditingController();
  final _jobTitleController = TextEditingController();
  DateTime? _startDate;

  @override
  void initState() {
    super.initState();
    final employee = widget.employee;
    _isInternal = employee.isInternalPayout;

    _nameController.text = employee.fullName;
    _emailController.text = employee.email;
    _ninController.text = employee.nin;

    _bankAccountController.text = employee.bankAccountNumber;
    _bankCode = employee.bankCode;
    _bankName = employee.bankName;
    // An already-saved external employee carries a verified name; treat it as
    // verified until the operator changes the account/bank (which re-verifies).
    _bankAccountName = employee.bankAccountName;

    _employmentType = employee.employmentType;
    _payRateController.text = employee.payRate.toStringAsFixed(0);
    _payFrequency = employee.payFrequency;
    _departmentController.text = employee.department;
    _jobTitleController.text = employee.jobTitle;

    if (employee.startDate != null && employee.startDate!.isNotEmpty) {
      try {
        _startDate = DateTime.parse(employee.startDate!);
      } catch (_) {
        _startDate = null;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ninController.dispose();
    _bankAccountController.dispose();
    _payRateController.dispose();
    _departmentController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  List<_WizardStep> get _steps {
    final steps = <_WizardStep>[
      _WizardStep('Personal', _buildPersonalInfoStep),
    ];
    if (!_isInternal) {
      steps.add(_WizardStep('Bank', _buildBankDetailsStep));
    }
    steps.add(_WizardStep('Employment', _buildEmploymentStep));
    return steps;
  }

  bool get _isLastStep => _currentStep >= _steps.length - 1;

  void _nextStep() {
    final label = _steps[_currentStep].label;
    if (label == 'Bank' && _bankAccountName.trim().isEmpty) {
      _toast('Verify the bank account before continuing', isError: true);
      return;
    }
    if (!(_formKey.currentState?.validate() ?? true)) return;
    if (!_isLastStep) {
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
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final payRateNaira =
        double.tryParse(_payRateController.text.replaceAll(',', '')) ?? 0.0;
    final payRateKobo = (payRateNaira * 100).toInt();

    context.read<PayrollCubit>().updateEmployee(
          employeeId: widget.employee.id,
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phone != null
              ? AppPhoneField.complete(_phone)
              : widget.employee.phone,
          nin: _ninController.text.trim(),
          bankAccountNumber: _isInternal ? '' : _bankAccountController.text.trim(),
          bankCode: _isInternal ? '' : _bankCode,
          bankName: _isInternal ? '' : _bankName,
          bankAccountName: _isInternal ? '' : _bankAccountName,
          payoutType: _isInternal ? 'internal' : 'external',
          employmentType: _employmentType,
          payRate: payRateKobo,
          payFrequency: _payFrequency,
          department: _departmentController.text.trim(),
          jobTitle: _jobTitleController.text.trim(),
        );
  }

  void _toast(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? InvoiceThemeColors.errorRed : InvoiceThemeColors.successGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is EmployeeUpdated) {
          _toast(state.message);
          Navigator.of(context).pop(true);
        } else if (state is PayrollError) {
          _toast(state.message, isError: true);
        }
      },
      builder: (context, state) {
        final isLoading = state is PayrollLoading;

        return Scaffold(
          backgroundColor: InvoiceThemeColors.primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: _previousStep,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Edit Employee',
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
                      child: _steps[_currentStep].builder(),
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
    final steps = _steps;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: List.generate(steps.length, (index) {
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
                              ? InvoiceThemeColors.primaryPurpleLight
                              : InvoiceThemeColors.borderColor,
                        ),
                      ),
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: isActive
                            ? InvoiceThemeColors.primaryPurple
                            : InvoiceThemeColors.borderColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.inter(
                            color: isActive
                                ? Colors.white
                                : InvoiceThemeColors.textGray500,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (index < steps.length - 1)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: index < _currentStep
                              ? InvoiceThemeColors.primaryPurpleLight
                              : InvoiceThemeColors.borderColor,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  steps[index].label,
                  style: GoogleFonts.inter(
                    color: isCurrent
                        ? InvoiceThemeColors.primaryPurpleLight
                        : InvoiceThemeColors.textGray500,
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

  // ---------------------------------------------------------------------------
  // Step: Personal Info
  // ---------------------------------------------------------------------------

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        SizedBox(height: 12.h),
        _buildPayoutBadge(),
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
          validator: (v) => FormValidators.email(v, required: true),
        ),
        SizedBox(height: 14.h),
        AppPhoneField(
          label: 'Phone Number',
          isRequired: true,
          initialNumber: widget.employee.phone,
          onChanged: (p) => _phone = p,
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

  Widget _buildPayoutBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: InvoiceThemeColors.borderColor),
      ),
      child: Row(
        children: [
          Icon(
            _isInternal
                ? Icons.account_balance_wallet_outlined
                : Icons.account_balance_outlined,
            color: InvoiceThemeColors.primaryPurpleLight,
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              _isInternal
                  ? 'Paid to their Lazervault wallet'
                  : 'Paid to ${widget.employee.payoutDisplay}',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray300,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step: Bank Details (external only)
  // ---------------------------------------------------------------------------

  Widget _buildBankDetailsStep() {
    return BlocListener<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, state) {
        if (state is AccountVerificationLoading) {
          setState(() {
            _verifying = true;
            _verifyError = '';
            _bankAccountName = '';
          });
        } else if (state is AccountVerificationSuccess) {
          setState(() {
            _verifying = false;
            _bankAccountName = state.accountName;
            _verifyError = '';
          });
        } else if (state is AccountVerificationFailure) {
          setState(() {
            _verifying = false;
            _bankAccountName = '';
            _verifyError = state.userMessage;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Bank Details'),
          SizedBox(height: 8.h),
          Text(
            'Where this employee is paid. Changing the account re-verifies the name.',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Bank',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: _pickBank,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: InvoiceThemeColors.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_outlined,
                      color: InvoiceThemeColors.textGray400, size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _bankName.isNotEmpty ? _bankName : 'Select bank',
                      style: GoogleFonts.inter(
                        color: _bankName.isNotEmpty
                            ? Colors.white
                            : InvoiceThemeColors.textGray500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: InvoiceThemeColors.textGray400, size: 20.sp),
                ],
              ),
            ),
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
            onChanged: (_) {
              // Editing the number invalidates the prior resolved name.
              setState(() => _bankAccountName = '');
              _maybeVerify();
            },
          ),
          SizedBox(height: 12.h),
          _buildVerificationStatus(),
        ],
      ),
    );
  }

  Widget _buildVerificationStatus() {
    if (_verifying) {
      return Row(
        children: [
          LazerVaultLoader(size: 18),
          SizedBox(width: 10.w),
          Text(
            'Verifying account…',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
            ),
          ),
        ],
      );
    }
    if (_bankAccountName.isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.successGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: InvoiceThemeColors.successGreen.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Icon(Icons.verified_outlined,
                color: InvoiceThemeColors.successGreen, size: 20.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                _bankAccountName,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (_verifyError.isNotEmpty) {
      return Text(
        _verifyError,
        style: GoogleFonts.inter(
          color: InvoiceThemeColors.errorRed,
          fontSize: 13.sp,
        ),
      );
    }
    return Text(
      'Pick a bank and enter a 10-digit account number to verify.',
      style: GoogleFonts.inter(
        color: InvoiceThemeColors.textGray500,
        fontSize: 12.sp,
      ),
    );
  }

  Future<void> _pickBank() async {
    final bank = await BankPickerSheet.show(
      context,
      country: 'NG',
      selectedBankCode: _bankCode.isNotEmpty ? _bankCode : null,
    );
    if (bank == null) return;
    setState(() {
      _bankName = bank['name'] ?? '';
      _bankCode = bank['code'] ?? '';
      _bankAccountName = '';
      _verifyError = '';
    });
    _maybeVerify();
  }

  void _maybeVerify() {
    final acct = _bankAccountController.text.trim();
    if (_bankCode.isEmpty || acct.length != 10) return;
    context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _bankCode,
          accountNumber: acct,
          bankName: _bankName,
        );
  }

  // ---------------------------------------------------------------------------
  // Step: Employment
  // ---------------------------------------------------------------------------

  Widget _buildEmploymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Employment Details'),
        SizedBox(height: 16.h),

        Text(
          'Employment Type',
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
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
                        ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                        : InvoiceThemeColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? InvoiceThemeColors.primaryPurpleLight
                          : InvoiceThemeColors.borderColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? InvoiceThemeColors.primaryPurpleLight
                            : InvoiceThemeColors.textGray400,
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
            final amount = double.tryParse(v.replaceAll(',', ''));
            if (amount == null || amount <= 0) return 'Enter a valid amount';
            return null;
          },
        ),
        SizedBox(height: 14.h),

        Text(
          'Pay Frequency',
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
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
                        ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                        : InvoiceThemeColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? InvoiceThemeColors.primaryPurpleLight
                          : InvoiceThemeColors.borderColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? InvoiceThemeColors.primaryPurpleLight
                            : InvoiceThemeColors.textGray400,
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

        Text(
          'Start Date',
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
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
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: InvoiceThemeColors.borderColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: InvoiceThemeColors.textGray400,
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
                        : InvoiceThemeColors.textGray500,
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
              primary: InvoiceThemeColors.primaryPurple,
              surface: InvoiceThemeColors.secondaryBackground,
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
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
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
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray500,
              fontSize: 15.sp,
            ),
            prefixIcon: Icon(icon, color: InvoiceThemeColors.textGray400, size: 20.sp),
            filled: true,
            fillColor: InvoiceThemeColors.secondaryBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: InvoiceThemeColors.errorRed),
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
        color: InvoiceThemeColors.primaryBackground,
        border: Border(
          top: BorderSide(color: InvoiceThemeColors.borderColor),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: InvoiceThemeColors.primaryPurple,
            disabledBackgroundColor:
                InvoiceThemeColors.primaryPurple.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? LazerVaultLoader(size: 22)
              : Text(
                  _isLastStep ? 'Save Changes' : 'Continue',
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
