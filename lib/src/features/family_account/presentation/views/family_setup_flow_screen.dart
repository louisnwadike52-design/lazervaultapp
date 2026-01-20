import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// Multi-step setup flow for creating a Family & Friends account
/// Features:
/// - Step 1: Welcome/Intro
/// - Step 2: Account Details (name, description, funding)
/// - Step 3: Funding Confirmation
/// - Step 4: Invite Members
class FamilySetupFlowScreen extends StatefulWidget {
  const FamilySetupFlowScreen({super.key});

  @override
  State<FamilySetupFlowScreen> createState() => _FamilySetupFlowScreenState();
}

class _FamilySetupFlowScreenState extends State<FamilySetupFlowScreen> {
  final PageController _pageController = PageController();
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();

  int _currentStep = 0;
  final int _totalSteps = 4;
  String? _createdFamilyId; // Store the created family account ID

  // Form data
  final Map<String, dynamic> _formData = {
    'name': '',
    'description': '',
    'initialCurrency': 'USD',
    'initialFunding': 0.0,
    'allowMemberContributions': true,
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onComplete() {
    // Navigate back to dashboard with result to trigger refresh
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            _buildProgressHeader(),

            // Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable manual swipe
                children: [
                  _buildWelcomeStep(),
                  _buildAccountDetailsStep(),
                  _buildFundingConfirmationStep(),
                  _buildInviteMembersStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title and Back/Close Button
          Row(
            children: [
              GestureDetector(
                onTap: _currentStep > 0 ? _previousStep : () => Get.back(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _currentStep > 0 ? Icons.arrow_back_ios_new : Icons.close,
                    color: const Color(0xFF1E1E2E),
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  _getStepTitle(),
                  style: TextStyle(
                    color: const Color(0xFF1E1E2E),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 56.w), // Balance the back button
            ],
          ),
          SizedBox(height: 24.h),

          // Progress Indicator
          _buildProgressBar(),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Family & Friends';
      case 1:
        return 'Account Details';
      case 2:
        return 'Funding';
      case 3:
        return 'Invite Members';
      default:
        return 'Setup';
    }
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          children: List.generate(
            _totalSteps,
            (index) => Expanded(
              child: Container(
                height: 4.h,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  gradient: index <= _currentStep
                      ? const LinearGradient(
                          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                        )
                      : null,
                  color: index <= _currentStep ? null : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Step ${_currentStep + 1} of $_totalSteps',
          style: TextStyle(
            color: const Color(0xFF666666),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeStep() {
    return FamilyWelcomeStep(
      onNext: _nextStep,
    );
  }

  Widget _buildAccountDetailsStep() {
    return FamilyAccountDetailsStep(
      initialData: _formData,
      onNext: (data) {
        setState(() {
          _formData.addAll(data);
        });
        _nextStep();
      },
    );
  }

  Widget _buildFundingConfirmationStep() {
    return FamilyFundingConfirmationStep(
      formData: _formData,
      cubit: _cubit,
      onNext: (String familyId) {
        setState(() {
          _createdFamilyId = familyId;
        });
        _nextStep();
      },
    );
  }

  Widget _buildInviteMembersStep() {
    return FamilyInviteMembersStep(
      familyId: _createdFamilyId ?? '',
      cubit: _cubit,
      onComplete: _onComplete,
      onSkip: _onComplete,
    );
  }
}

// Step 1: Welcome Screen
class FamilyWelcomeStep extends StatelessWidget {
  final VoidCallback onNext;

  const FamilyWelcomeStep({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          // Illustration
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6C5CE7).withOpacity(0.2),
                  const Color(0xFFA29BFE).withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.family_restroom,
              size: 50.sp,
              color: const Color(0xFF6C5CE7),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            'Share Money\nwith Loved Ones',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),

          // Description
          Text(
            'Create a Family & Friends account to manage shared expenses, set spending limits, and stay in control together.',
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 13.sp,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),

          // Features
          _buildFeature(
            Icons.people_outline,
            'Add Members',
            'Invite family and friends',
          ),
          SizedBox(height: 10.h),
          _buildFeature(
            Icons.account_balance_wallet_outlined,
            'Set Limits',
            'Control spending limits',
          ),
          SizedBox(height: 10.h),
          _buildFeature(
            Icons.visibility_outlined,
            'Full Transparency',
            'Shared balance and transactions',
          ),
          SizedBox(height: 24.h),

          // CTA Button
          Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
              ),
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onNext,
                borderRadius: BorderRadius.circular(25.r),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6C5CE7),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF1E1E2E),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF888888),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Step 2: Account Details
class FamilyAccountDetailsStep extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onNext;

  const FamilyAccountDetailsStep({
    super.key,
    required this.initialData,
    required this.onNext,
  });

  @override
  State<FamilyAccountDetailsStep> createState() => _FamilyAccountDetailsStepState();
}

class _FamilyAccountDetailsStepState extends State<FamilyAccountDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _fundingController;
  late bool _allowMemberContributions;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['name'] as String? ?? '');
    _descriptionController = TextEditingController(text: widget.initialData['description'] as String? ?? '');
    _fundingController = TextEditingController(
      text: widget.initialData['initialFunding'] > 0
          ? widget.initialData['initialFunding'].toString()
          : '',
    );
    _allowMemberContributions = widget.initialData['allowMemberContributions'] as bool? ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _fundingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onNext({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'initialFunding': double.tryParse(_fundingController.text) ?? 0.0,
        'allowMemberContributions': _allowMemberContributions,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Family Name
            Text(
              'Family Account Name',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _nameController,
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'e.g., "Smith Family" or "Vacation Fund"',
                hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF8F8F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF6C5CE7),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a family account name';
                }
                if (value.trim().length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),

            // Description (Optional)
            Text(
              'Description (Optional)',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'What is this account for?',
                hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF8F8F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF6C5CE7),
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Initial Funding
            Text(
              'Initial Funding',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _fundingController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  color: const Color(0xFF1E1E2E),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                hintText: '0.00',
                hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: 20.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF8F8F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF6C5CE7),
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter initial funding amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount < 100) {
                  return 'Minimum initial funding is \$100';
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),

            // Allow Member Contributions
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Allow Member Contributions',
                          style: TextStyle(
                            color: const Color(0xFF1E1E2E),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Let members contribute to the family pool',
                          style: TextStyle(
                            color: const Color(0xFF888888),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _allowMemberContributions,
                    onChanged: (value) {
                      setState(() {
                        _allowMemberContributions = value;
                      });
                    },
                    activeColor: const Color(0xFF6C5CE7),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Continue Button
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                ),
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _submitForm,
                  borderRadius: BorderRadius.circular(28.r),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

// Step 3: Funding Confirmation
class FamilyFundingConfirmationStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final FamilyAccountCubit cubit;
  final void Function(String familyId) onNext;

  const FamilyFundingConfirmationStep({
    super.key,
    required this.formData,
    required this.cubit,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          // Success Icon
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6C5CE7).withOpacity(0.2),
                  const Color(0xFFA29BFE).withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 50.sp,
              color: const Color(0xFF6C5CE7),
            ),
          ),
          SizedBox(height: 32.h),

          // Title
          Text(
            'Account Details',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Review your family account information',
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 32.h),

          // Summary Card - Full width
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('Account Name', formData['name'] as String? ?? ''),
                SizedBox(height: 16.h),
                if (formData['description'] != null && (formData['description'] as String).isNotEmpty) ...[
                  _buildSummaryRow('Description', formData['description'] as String? ?? ''),
                  SizedBox(height: 16.h),
                ],
                _buildSummaryRow(
                  'Initial Funding',
                  '\$${(formData['initialFunding'] as double).toStringAsFixed(2)}',
                ),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                  'Member Contributions',
                  (formData['allowMemberContributions'] as bool? ?? true) ? 'Enabled' : 'Disabled',
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          // Confirm & Create Button
          BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is FamilyAccountCreated) {
                onNext(state.familyAccount.id);
              } else if (state is FamilyAccountError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is FamilyAccountCreating;

              return Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  ),
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isLoading
                        ? null
                        : () {
                            cubit.createAccount(
                              name: formData['name'] as String,
                              description: formData['description'] as String?,
                              initialCurrency: 'USD',
                              initialFunding: formData['initialFunding'] as double,
                              allowMemberContributions: formData['allowMemberContributions'] as bool? ?? true,
                            );
                          },
                    borderRadius: BorderRadius.circular(28.r),
                    child: Center(
                      child: isLoading
                          ? SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Confirm & Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF888888),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF1E1E2E),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Step 4: Invite Members
class FamilyInviteMembersStep extends StatelessWidget {
  final String familyId;
  final FamilyAccountCubit cubit;
  final VoidCallback onComplete;
  final VoidCallback onSkip;

  const FamilyInviteMembersStep({
    super.key,
    required this.familyId,
    required this.cubit,
    required this.onComplete,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          // Success Icon
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.withOpacity(0.2),
                  Colors.green.withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 50.sp,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 24.h),

          // Success Title
          Text(
            'Account Created!',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32.h),

          // Invite Icon
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6C5CE7).withOpacity(0.2),
                  const Color(0xFFA29BFE).withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.group_add,
              size: 40.sp,
              color: const Color(0xFF6C5CE7),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Text(
            'Invite Family & Friends',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Add members to your family account now or do it later from settings',
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),

          // Invite Button
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
              ),
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate to family details to add members
                  if (familyId.isNotEmpty) {
                    Get.offNamed(AppRoutes.familyDetails, arguments: {'familyId': familyId});
                  } else {
                    onComplete();
                  }
                },
                borderRadius: BorderRadius.circular(28.r),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Invite Members',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Done Button
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSkip,
                borderRadius: BorderRadius.circular(28.r),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: const Color(0xFF666666),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Info
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF6C5CE7).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF6C5CE7),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'You can always invite more members later from the family account settings',
                    style: TextStyle(
                      color: const Color(0xFF666666),
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
