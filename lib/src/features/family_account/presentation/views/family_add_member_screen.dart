import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// Screen for adding a new member to a Family & Friends account
/// Allows setting all spending limits and member details
class FamilyAddMemberScreen extends StatefulWidget {
  final String familyId;
  final String? familyName;

  const FamilyAddMemberScreen({
    super.key,
    required this.familyId,
    this.familyName,
  });

  @override
  State<FamilyAddMemberScreen> createState() => _FamilyAddMemberScreenState();
}

class _FamilyAddMemberScreenState extends State<FamilyAddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();

  // Invitation method
  String _invitationMethod = 'email';
  final TextEditingController _invitationDestinationController = TextEditingController();

  // Initial allocation
  final TextEditingController _initialAllocationController = TextEditingController(text: '0');

  // Spending limits
  final TextEditingController _dailyLimitController = TextEditingController(text: '0');
  final TextEditingController _monthlyLimitController = TextEditingController(text: '0');
  final TextEditingController _perTransactionLimitController = TextEditingController(text: '0');
  double _allocationPercentageCap = 100.0;

  // Member role
  String _role = 'member';

  // Personal message
  final TextEditingController _personalMessageController = TextEditingController();

  @override
  void dispose() {
    _invitationDestinationController.dispose();
    _initialAllocationController.dispose();
    _dailyLimitController.dispose();
    _monthlyLimitController.dispose();
    _perTransactionLimitController.dispose();
    _personalMessageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _cubit.addMember(
        familyId: widget.familyId,
        invitationMethod: _invitationMethod,
        invitationDestination: _invitationDestinationController.text.trim(),
        initialAllocation: double.tryParse(_initialAllocationController.text) ?? 0.0,
        dailyLimit: double.tryParse(_dailyLimitController.text) ?? 0.0,
        monthlyLimit: double.tryParse(_monthlyLimitController.text) ?? 0.0,
        perTransactionLimit: double.tryParse(_perTransactionLimitController.text) ?? 0.0,
        allocationPercentageCap: _allocationPercentageCap,
        role: _role,
        personalMessage: _personalMessageController.text.trim().isEmpty
            ? null
            : _personalMessageController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Add Family Member',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<FamilyAccountCubit, FamilyAccountState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is FamilyMemberAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Member invited successfully!'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            children: [
              // Invitation Method Section
              _buildSectionHeader('Invitation Method'),
              SizedBox(height: 12.h),
              _buildInvitationMethodSelector(),
              SizedBox(height: 24.h),

              // Contact Info
              Text(
                _invitationMethod == 'email' ? 'Email Address' : 'Phone Number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _invitationDestinationController,
                keyboardType: _invitationMethod == 'email'
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: _invitationMethod == 'email'
                      ? 'Enter email address'
                      : 'Enter phone number',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14.sp,
                  ),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: Color(0xFF3B82F6),
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
                    return 'Please enter ${_invitationMethod == 'email' ? 'email' : 'phone number'}';
                  }
                  if (_invitationMethod == 'email') {
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),

              // Initial Allocation
              _buildSectionHeader('Initial Allocation'),
              SizedBox(height: 12.h),
              _buildAmountField(
                _initialAllocationController,
                '0.00',
                'Amount to allocate to this member',
              ),
              SizedBox(height: 24.h),

              // Spending Limits
              _buildSectionHeader('Spending Limits'),
              SizedBox(height: 12.h),
              Text(
                'Set how much this member can spend. Enter 0 for no limit.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // Daily Limit
              _buildLimitField(
                _dailyLimitController,
                'Daily Limit',
                Icons.today,
                'Maximum spending per day',
              ),
              SizedBox(height: 16.h),

              // Monthly Limit
              _buildLimitField(
                _monthlyLimitController,
                'Monthly Limit',
                Icons.calendar_month,
                'Maximum spending per month',
              ),
              SizedBox(height: 16.h),

              // Per-Transaction Limit
              _buildLimitField(
                _perTransactionLimitController,
                'Per-Transaction Limit',
                Icons.payment,
                'Maximum per single transaction',
              ),
              SizedBox(height: 24.h),

              // Allocation Percentage Cap
              _buildSectionHeader('Allocation Percentage Cap'),
              SizedBox(height: 12.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_allocationPercentageCap.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: const Color(0xFF3B82F6),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'of total pool',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Slider(
                    value: _allocationPercentageCap,
                    min: 1,
                    max: 100,
                    divisions: 99,
                    activeColor: const Color(0xFF3B82F6),
                    onChanged: (value) {
                      setState(() {
                        _allocationPercentageCap = value;
                      });
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Maximum percentage of total pool this member can have allocated to them',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Member Role
              _buildSectionHeader('Member Role'),
              SizedBox(height: 12.h),
              _buildRoleSelector(),
              SizedBox(height: 24.h),

              // Personal Message (Optional)
              _buildSectionHeader('Personal Message (Optional)'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _personalMessageController,
                maxLines: 3,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Add a personal message to the invitation...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14.sp,
                  ),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: Color(0xFF3B82F6),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Submit Button
              BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
                bloc: _cubit,
                builder: (context, state) {
                  final isLoading = state is FamilyMemberAdding;

                  return Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                      ),
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: isLoading ? null : _submitForm,
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
                                  'Send Invitation',
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
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInvitationMethodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildMethodOption('email', Icons.email, 'Email'),
          Divider(
            height: 1.h,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          _buildMethodOption('sms', Icons.sms, 'SMS'),
          Divider(
            height: 1.h,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          _buildMethodOption('username', Icons.person, 'Username'),
        ],
      ),
    );
  }

  Widget _buildMethodOption(String method, IconData icon, String label) {
    final isSelected = _invitationMethod == method;

    return InkWell(
      onTap: () {
        setState(() {
          _invitationMethod = method;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF3B82F6) : Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                fontSize: 15.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField(
    TextEditingController controller,
    String placeholder,
    String hint,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        prefixText: '\$ ',
        prefixStyle: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 20.sp,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Color(0xFF3B82F6),
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
          return 'Please enter an amount';
        }
        final amount = double.tryParse(value);
        if (amount == null || amount < 0) {
          return 'Please enter a valid amount';
        }
        return null;
      },
    );
  }

  Widget _buildLimitField(
    TextEditingController controller,
    String label,
    IconData icon,
    String hint,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              hintText: '0.00',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 18.sp,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Color(0xFF3B82F6),
                  width: 2,
                ),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter an amount';
              }
              final amount = double.tryParse(value);
              if (amount == null || amount < 0) {
                return 'Invalid amount';
              }
              return null;
            },
          ),
          SizedBox(height: 4.h),
          Text(
            hint,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildRoleOption('member', 'Member', 'Can spend allocated funds'),
          Divider(
            height: 1.h,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          _buildRoleOption('admin', 'Admin', 'Full control + can manage members'),
        ],
      ),
    );
  }

  Widget _buildRoleOption(String role, String title, String description) {
    final isSelected = _role == role;

    return InkWell(
      onTap: () {
        setState(() {
          _role = role;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? const Color(0xFF3B82F6) : Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
