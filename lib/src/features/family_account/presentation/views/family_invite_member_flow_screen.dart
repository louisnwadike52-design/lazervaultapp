import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/family_account/presentation/widgets/invite_member_steps/contact_method_step.dart';
import 'package:lazervault/src/features/family_account/presentation/widgets/invite_member_steps/allocation_role_step.dart';
import 'package:lazervault/src/features/family_account/presentation/widgets/invite_member_steps/spending_limits_step.dart';
import 'package:lazervault/src/features/family_account/presentation/widgets/invite_member_steps/review_send_step.dart';

/// Multi-step wizard flow for inviting a new member to a Family & Friends account
/// Features:
/// - Step 1: Contact Method (Email/Phone/Username)
/// - Step 2: Initial Allocation & Role
/// - Step 3: Spending Limits
/// - Step 4: Review & Send Invitation
class FamilyInviteMemberFlowScreen extends StatefulWidget {
  final String familyId;
  final String? familyName;

  const FamilyInviteMemberFlowScreen({
    super.key,
    required this.familyId,
    this.familyName,
  });

  @override
  State<FamilyInviteMemberFlowScreen> createState() =>
      _FamilyInviteMemberFlowScreenState();
}

class _FamilyInviteMemberFlowScreenState
    extends State<FamilyInviteMemberFlowScreen> {
  final PageController _pageController = PageController();
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();

  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form data collected across steps
  final Map<String, dynamic> _formData = {
    // Step 1: Contact Method
    'invitationMethod': 'email', // email, phone, username
    'invitationDestination': '',

    // Step 2: Allocation & Role
    'initialAllocation': 0.0,
    'role': 'member', // member, admin

    // Step 3: Spending Limits
    'noLimits': false,
    'dailyLimit': 0.0,
    'monthlyLimit': 0.0,
    'perTransactionLimit': 0.0,
    'allocationPercentageCap': 100.0,

    // Step 4: Personal Message
    'personalMessage': '',
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
      _pageController.animateToPage(
        _currentStep,
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
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  void _updateFormData(Map<String, dynamic> data) {
    setState(() {
      _formData.addAll(data);
    });
  }

  void _submitInvitation() {
    // Convert limits to 0 if noLimits is true
    final noLimits = _formData['noLimits'] as bool? ?? false;

    _cubit.addMember(
      familyId: widget.familyId,
      invitationMethod: _formData['invitationMethod'] as String,
      invitationDestination: _formData['invitationDestination'] as String,
      initialAllocation: _formData['initialAllocation'] as double,
      dailyLimit: noLimits ? 0.0 : (_formData['dailyLimit'] as double),
      monthlyLimit: noLimits ? 0.0 : (_formData['monthlyLimit'] as double),
      perTransactionLimit:
          noLimits ? 0.0 : (_formData['perTransactionLimit'] as double),
      allocationPercentageCap: _formData['allocationPercentageCap'] as double,
      role: _formData['role'] as String,
      personalMessage: (_formData['personalMessage'] as String).isEmpty
          ? null
          : _formData['personalMessage'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<FamilyAccountCubit, FamilyAccountState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is FamilyMemberAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Invitation sent successfully!'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                ),
              );
              Get.back(result: true);
            } else if (state is FamilyAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          child: Column(
            children: [
              // Progress Header
              _buildProgressHeader(),

              // Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable manual swipe
                  children: [
                    ContactMethodStep(
                      formData: _formData,
                      onNext: (data) {
                        _updateFormData(data);
                        _nextStep();
                      },
                    ),
                    AllocationRoleStep(
                      formData: _formData,
                      onNext: (data) {
                        _updateFormData(data);
                        _nextStep();
                      },
                    ),
                    SpendingLimitsStep(
                      formData: _formData,
                      onNext: (data) {
                        _updateFormData(data);
                        _nextStep();
                      },
                    ),
                    ReviewSendStep(
                      formData: _formData,
                      cubit: _cubit,
                      onSend: _submitInvitation,
                      onUpdateMessage: (message) {
                        _updateFormData({'personalMessage': message});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                onTap: _previousStep,
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
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
        return 'Invite Member';
      case 1:
        return 'Allocation & Role';
      case 2:
        return 'Spending Limits';
      case 3:
        return 'Review & Send';
      default:
        return 'Invite Member';
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
                  color:
                      index <= _currentStep ? null : const Color(0xFFE0E0E0),
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
}
