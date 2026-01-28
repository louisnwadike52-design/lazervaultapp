import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// Edit Family Member Limits Screen
/// Allows admins to update:
/// - Allocated balance
/// - Daily spending limit
/// - Monthly spending limit
/// - Per-transaction limit
/// - Allocation percentage cap
/// - Member role
class FamilyEditMemberLimitsScreen extends StatefulWidget {
  const FamilyEditMemberLimitsScreen({
    super.key,
    required this.familyId,
    required this.member,
  });

  final String familyId;
  final FamilyMember member;

  @override
  State<FamilyEditMemberLimitsScreen> createState() => _FamilyEditMemberLimitsScreenState();
}

class _FamilyEditMemberLimitsScreenState extends State<FamilyEditMemberLimitsScreen> {
  final _formKey = GlobalKey<FormState>();
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();

  // Text controllers
  late TextEditingController _allocatedBalanceController;
  late TextEditingController _dailyLimitController;
  late TextEditingController _monthlyLimitController;
  late TextEditingController _perTransactionLimitController;

  // Other fields
  late double _allocationPercentageCap;
  late String _role;

  // Track which fields have been modified
  final Set<String> _modifiedFields = {};

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _allocatedBalanceController = TextEditingController(
      text: widget.member.allocatedBalance.toStringAsFixed(2),
    );
    _dailyLimitController = TextEditingController(
      text: widget.member.dailySpendingLimit.toStringAsFixed(2),
    );
    _monthlyLimitController = TextEditingController(
      text: widget.member.monthlySpendingLimit.toStringAsFixed(2),
    );
    _perTransactionLimitController = TextEditingController(
      text: widget.member.perTransactionLimit.toStringAsFixed(2),
    );
    _allocationPercentageCap = widget.member.allocationPercentageCap;
    _role = widget.member.role.name;
  }

  @override
  void dispose() {
    _allocatedBalanceController.dispose();
    _dailyLimitController.dispose();
    _monthlyLimitController.dispose();
    _perTransactionLimitController.dispose();
    super.dispose();
  }

  void _markAsModified(String field) {
    setState(() {
      _modifiedFields.add(field);
    });
  }

  bool _hasChanges() {
    return _modifiedFields.isNotEmpty;
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_hasChanges()) {
      Get.back();
      return;
    }

    // Build request with only modified fields
    _cubit.updateMember(
      familyId: widget.familyId,
      memberId: widget.member.id,
      allocatedBalance: _modifiedFields.contains('allocated')
          ? double.tryParse(_allocatedBalanceController.text)
          : null,
      dailySpendingLimit: _modifiedFields.contains('daily')
          ? double.tryParse(_dailyLimitController.text)
          : null,
      monthlySpendingLimit: _modifiedFields.contains('monthly')
          ? double.tryParse(_monthlyLimitController.text)
          : null,
      perTransactionLimit: _modifiedFields.contains('perTransaction')
          ? double.tryParse(_perTransactionLimitController.text)
          : null,
      allocationPercentageCap: _modifiedFields.contains('percentageCap')
          ? _allocationPercentageCap
          : null,
      role: _modifiedFields.contains('role') ? _role : null,
    );
  }

  void _resetField(String field) {
    setState(() {
      _modifiedFields.remove(field);
      switch (field) {
        case 'allocated':
          _allocatedBalanceController.text = widget.member.allocatedBalance.toStringAsFixed(2);
          break;
        case 'daily':
          _dailyLimitController.text = widget.member.dailySpendingLimit.toStringAsFixed(2);
          break;
        case 'monthly':
          _monthlyLimitController.text = widget.member.monthlySpendingLimit.toStringAsFixed(2);
          break;
        case 'perTransaction':
          _perTransactionLimitController.text = widget.member.perTransactionLimit.toStringAsFixed(2);
          break;
        case 'percentageCap':
          _allocationPercentageCap = widget.member.allocationPercentageCap;
          break;
        case 'role':
          _role = widget.member.role.name;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E2E),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E1E2E),
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
            'Edit Limits',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // Reset button
            if (_hasChanges())
              TextButton(
                onPressed: () {
                  // Reset all modified fields
                  for (var field in List.from(_modifiedFields)) {
                    _resetField(field);
                  }
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                ),
              ),
          ],
        ),
        body: BlocListener<FamilyAccountCubit, FamilyAccountState>(
          listener: (context, state) {
            if (state is FamilyMemberUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Member limits updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              Get.back(result: true); // Return true to indicate success
            } else if (state is FamilyAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              children: [
                // Member Info Card
                _buildMemberInfoCard(),
                SizedBox(height: 24.h),

                // Allocated Balance Section
                _buildSectionHeader('Allocated Balance', Icons.account_balance_wallet),
                SizedBox(height: 12.h),
                _buildAmountField(
                  controller: _allocatedBalanceController,
                  label: 'Allocated Balance',
                  hint: '0.00',
                  fieldKey: 'allocated',
                  icon: Icons.monetization_on,
                ),
                _buildFieldInfo('Amount allocated to this member from the family pool'),
                SizedBox(height: 24.h),

                // Spending Limits Section
                _buildSectionHeader('Spending Limits', Icons.gavel),
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
                  controller: _dailyLimitController,
                  label: 'Daily Spending Limit',
                  hint: '0.00',
                  fieldKey: 'daily',
                  icon: Icons.today,
                  description: 'Maximum amount per day',
                ),
                SizedBox(height: 16.h),

                // Monthly Limit
                _buildLimitField(
                  controller: _monthlyLimitController,
                  label: 'Monthly Spending Limit',
                  hint: '0.00',
                  fieldKey: 'monthly',
                  icon: Icons.calendar_month,
                  description: 'Maximum amount per month',
                ),
                SizedBox(height: 16.h),

                // Per-Transaction Limit
                _buildLimitField(
                  controller: _perTransactionLimitController,
                  label: 'Per-Transaction Limit',
                  hint: '0.00',
                  fieldKey: 'perTransaction',
                  icon: Icons.payment,
                  description: 'Maximum per single transaction',
                ),
                SizedBox(height: 24.h),

                // Allocation Percentage Cap
                _buildSectionHeader('Allocation Percentage Cap', Icons.pie_chart),
                SizedBox(height: 12.h),
                _buildPercentageCapSlider(),
                _buildFieldInfo('Maximum percentage of total pool this member can have'),
                SizedBox(height: 24.h),

                // Member Role Section
                _buildSectionHeader('Member Role', Icons.admin_panel_settings),
                SizedBox(height: 12.h),
                _buildRoleSelector(),
                SizedBox(height: 32.h),

                // Save Button
                BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
                  builder: (context, state) {
                    final isLoading = state is FamilyMemberUpdating;

                    return Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: _hasChanges()
                            ? const LinearGradient(
                                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                              )
                            : null,
                        color: _hasChanges() ? null : Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(28.r),
                        boxShadow: _hasChanges()
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ]
                            : null,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: isLoading || !_hasChanges() ? null : _saveChanges,
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
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.save,
                                        color: _hasChanges() ? Colors.white : Colors.white.withValues(alpha: 0.4),
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Save Changes',
                                        style: TextStyle(
                                          color: _hasChanges() ? Colors.white : Colors.white.withValues(alpha: 0.4),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }

  Widget _buildMemberInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7).withValues(alpha: 0.2),
            const Color(0xFFA29BFE).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                  const Color(0xFFA29BFE).withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: widget.member.avatarUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.network(
                      widget.member.avatarUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 24.sp,
                    color: Colors.white,
                  ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.member.fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 14.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        widget.member.email ?? 'No email',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      widget.member.phone ?? 'No phone',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Current Stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${widget.member.remainingBalance.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Remaining',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6C5CE7),
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String fieldKey,
    required IconData icon,
  }) {
    final isModified = _modifiedFields.contains(fieldKey);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isModified ? const Color(0xFF6C5CE7).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
          width: isModified ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF6C5CE7),
                    size: 18.sp,
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
              if (isModified)
                GestureDetector(
                  onTap: () => _resetField(fieldKey),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) => _markAsModified(fieldKey),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                color: const Color(0xFF6C5CE7),
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 20.sp,
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
                  color: Color(0xFF6C5CE7),
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
        ],
      ),
    );
  }

  Widget _buildLimitField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String fieldKey,
    required IconData icon,
    required String description,
  }) {
    final isModified = _modifiedFields.contains(fieldKey);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isModified ? const Color(0xFF6C5CE7).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
          width: isModified ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF6C5CE7),
                    size: 18.sp,
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
              if (isModified)
                GestureDetector(
                  onTap: () => _resetField(fieldKey),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
            onChanged: (value) => _markAsModified(fieldKey),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                color: const Color(0xFF6C5CE7),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              hintText: hint,
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
                  color: Color(0xFF6C5CE7),
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
          SizedBox(height: 6.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageCapSlider() {
    final isModified = _modifiedFields.contains('percentageCap');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isModified ? const Color(0xFF6C5CE7).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
          width: isModified ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Maximum Pool Percentage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isModified)
                GestureDetector(
                  onTap: () => _resetField('percentageCap'),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_allocationPercentageCap.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: const Color(0xFF6C5CE7),
                  fontSize: 28.sp,
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
          SizedBox(height: 16.h),
          Slider(
            value: _allocationPercentageCap,
            min: 1,
            max: 100,
            divisions: 99,
            activeColor: const Color(0xFF6C5CE7),
            onChanged: (value) {
              setState(() {
                _allocationPercentageCap = value;
                _markAsModified('percentageCap');
              });
            },
          ),
          SizedBox(height: 8.h),
          // Percentage markers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPercentageMarker('1%', 1),
              _buildPercentageMarker('25%', 25),
              _buildPercentageMarker('50%', 50),
              _buildPercentageMarker('75%', 75),
              _buildPercentageMarker('100%', 100),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageMarker(String label, double value) {
    final isSelected = (_allocationPercentageCap - value).abs() < 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          _allocationPercentageCap = value;
          _markAsModified('percentageCap');
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C5CE7).withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.white.withValues(alpha: 0.5),
            fontSize: 11.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    final isModified = _modifiedFields.contains('role');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isModified ? const Color(0xFF6C5CE7).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
          width: isModified ? 2 : 1,
        ),
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

  Widget _buildRoleOption(String roleValue, String title, String description) {
    final isSelected = _role == roleValue;
    final isModified = _modifiedFields.contains('role');

    return InkWell(
      onTap: () {
        setState(() {
          _role = roleValue;
          _markAsModified('role');
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C5CE7).withValues(alpha: 0.2) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? const Color(0xFF6C5CE7) : Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF6C5CE7) : Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isModified && isSelected) ...[
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () => _resetField('role'),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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

  Widget _buildFieldInfo(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
