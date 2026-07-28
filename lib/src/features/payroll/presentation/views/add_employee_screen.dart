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
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';

/// A single step in the add-employee wizard. The set of steps is dynamic —
/// an internal (Lazervault) employee skips the bank step entirely.
class _WizardStep {
  final String label;
  final Widget Function() builder;
  const _WizardStep(this.label, this.builder);
}

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Step 0: Payout destination — null until the operator chooses.
  String? _payoutType; // 'internal' | 'external'
  UnifiedSearchResult? _selectedUser; // internal payout target

  // Step: Personal Info
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ninController = TextEditingController();
  // Phone is captured via AppPhoneField (country picker + leading-zero tolerant).
  PhoneNumber? _phone;

  // Step: Bank Details (external only)
  final _bankAccountController = TextEditingController();
  String _bankCode = '';
  String _bankName = '';
  String _bankAccountName = ''; // resolved beneficiary name (name enquiry)
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

  // ---------------------------------------------------------------------------
  // Dynamic step set
  // ---------------------------------------------------------------------------

  List<_WizardStep> get _steps {
    final steps = <_WizardStep>[
      _WizardStep('Payout', _buildPayoutStep),
      _WizardStep('Personal', _buildPersonalInfoStep),
    ];
    // A bank destination is only relevant when paying someone who is NOT a
    // Lazervault user. Internal employees are credited straight to their wallet.
    if (_payoutType == 'external') {
      steps.add(_WizardStep('Bank', _buildBankDetailsStep));
    }
    steps.add(_WizardStep('Employment', _buildEmploymentStep));
    return steps;
  }

  bool get _isLastStep => _currentStep >= _steps.length - 1;

  void _nextStep() {
    final label = _steps[_currentStep].label;

    // Payout step gates on a chosen type (+ a picked user for internal).
    if (label == 'Payout') {
      if (_payoutType == null) {
        _toast('Choose how this employee is paid', isError: true);
        return;
      }
      if (_payoutType == 'internal' && _selectedUser == null) {
        _toast('Select the Lazervault user to pay', isError: true);
        return;
      }
    }

    // Bank step gates on a verified account (resolved beneficiary name).
    if (label == 'Bank' && _bankAccountName.trim().isEmpty) {
      _toast('Verify the bank account before continuing', isError: true);
      return;
    }

    // Validate the CURRENT step's mounted form fields (email/phone/pay rate…).
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

    final isInternal = _payoutType == 'internal';

    context.read<PayrollCubit>().addEmployee(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: AppPhoneField.complete(_phone),
          nin: _ninController.text.trim(),
          bankAccountNumber: isInternal ? '' : _bankAccountController.text.trim(),
          bankCode: isInternal ? '' : _bankCode,
          bankName: isInternal ? '' : _bankName,
          bankAccountName: isInternal ? '' : _bankAccountName,
          payoutType: _payoutType ?? 'external',
          userId: isInternal ? _selectedUser?.userId : null,
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
        if (state is EmployeeAdded) {
          _toast(state.message);
          // Return the created employee so a caller (e.g. the pay-run "Add
          // employee" sheet) can auto-select it. Plain callers ignore the value.
          Navigator.of(context).pop(state.employee);
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
                              ? InvoiceThemeColors.primaryPurple
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
                              ? InvoiceThemeColors.primaryPurple
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
  // Step: Payout destination
  // ---------------------------------------------------------------------------

  Widget _buildPayoutStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('How is this employee paid?'),
        SizedBox(height: 8.h),
        Text(
          'Pay a Lazervault user straight to their wallet, or an external person to their bank account.',
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 16.h),
        _buildPayoutOption(
          type: 'internal',
          icon: Icons.account_balance_wallet_outlined,
          title: 'A Lazervault user',
          subtitle: 'Credit their Lazervault wallet instantly',
        ),
        SizedBox(height: 12.h),
        _buildPayoutOption(
          type: 'external',
          icon: Icons.account_balance_outlined,
          title: 'External bank account',
          subtitle: 'Send to any Nigerian bank account',
        ),
        if (_payoutType == 'internal') ...[
          SizedBox(height: 20.h),
          _buildSelectedUserCard(),
        ],
      ],
    );
  }

  Widget _buildPayoutOption({
    required String type,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _payoutType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _payoutType = type;
          if (type == 'external') {
            // Leaving internal mode clears the linked user.
            _selectedUser = null;
          }
        });
        if (type == 'internal') {
          _pickLazervaultUser();
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15)
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? InvoiceThemeColors.primaryPurpleLight
                : InvoiceThemeColors.borderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon,
                  color: InvoiceThemeColors.primaryPurpleLight, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? InvoiceThemeColors.primaryPurpleLight
                  : InvoiceThemeColors.textGray500,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedUserCard() {
    if (_selectedUser == null) {
      return GestureDetector(
        onTap: _pickLazervaultUser,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: InvoiceThemeColors.borderColor),
          ),
          child: Row(
            children: [
              Icon(Icons.person_search_outlined,
                  color: InvoiceThemeColors.primaryPurpleLight, size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                'Select a Lazervault user',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurpleLight,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }
    final u = _selectedUser!;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.successGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: InvoiceThemeColors.successGreen.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle,
              color: InvoiceThemeColors.successGreen, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  u.displayName.isNotEmpty ? u.displayName : u.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (u.username.isNotEmpty || u.phoneNumber.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    u.username.isNotEmpty ? '@${u.username}' : u.phoneNumber,
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          TextButton(
            onPressed: _pickLazervaultUser,
            child: Text(
              'Change',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.primaryPurpleLight,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickLazervaultUser() async {
    final result = await UnifiedUserSearchSheet.show(
      context,
      title: 'Select employee',
      subtitle: 'Search any Lazervault user to pay',
    );
    if (result == null) return;
    // Only real platform users can be credited internally.
    if (!result.isLazervault || result.userId.isEmpty) {
      _toast('That contact is not a Lazervault user', isError: true);
      return;
    }
    setState(() {
      _selectedUser = result;
      // Prefill the personal fields from the picked user.
      _nameController.text = result.name.isNotEmpty ? result.name : result.displayName;
      if (result.email.isNotEmpty) _emailController.text = result.email;
    });
  }

  // ---------------------------------------------------------------------------
  // Step: Personal Info
  // ---------------------------------------------------------------------------

  Widget _buildPersonalInfoStep() {
    final isInternal = _payoutType == 'internal';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        if (isInternal) ...[
          SizedBox(height: 8.h),
          Text(
            'Prefilled from the selected Lazervault user — edit if needed.',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 12.sp,
            ),
          ),
        ],
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

  // ---------------------------------------------------------------------------
  // Step: Bank Details (external only) — bank picker + name enquiry
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
            'Where this employee is paid. We verify the account name before you can continue.',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 16.h),
          // Bank picker
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
            onChanged: (_) => _maybeVerify(),
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

  /// Trigger name enquiry once we have a bank + a full 10-digit account number.
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

        // Employment Type Selector
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

        // Start Date Picker
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
                  _isLastStep ? 'Add Employee' : 'Continue',
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
