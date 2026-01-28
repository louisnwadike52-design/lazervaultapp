import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 2: Allocation & Role Selection
/// - Initial allocation amount input (currency formatted)
/// - Role selection cards: Member / Admin
/// - Role description for each option
class AllocationRoleStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onNext;

  const AllocationRoleStep({
    super.key,
    required this.formData,
    required this.onNext,
  });

  @override
  State<AllocationRoleStep> createState() => _AllocationRoleStepState();
}

class _AllocationRoleStepState extends State<AllocationRoleStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _allocationController;
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    final allocation = widget.formData['initialAllocation'] as double? ?? 0.0;
    _allocationController = TextEditingController(
      text: allocation > 0 ? allocation.toStringAsFixed(2) : '',
    );
    _selectedRole = widget.formData['role'] as String? ?? 'member';
  }

  @override
  void dispose() {
    _allocationController.dispose();
    super.dispose();
  }

  void _submitStep() {
    if (_formKey.currentState!.validate()) {
      widget.onNext({
        'initialAllocation':
            double.tryParse(_allocationController.text) ?? 0.0,
        'role': _selectedRole,
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
            // Header
            Text(
              'Set initial allocation\nand role',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Define how much they can access and their permissions',
              style: TextStyle(
                color: const Color(0xFF666666),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 32.h),

            // Initial Allocation Section
            Text(
              'Initial Allocation',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Amount to allocate to this member from the family pool',
              style: TextStyle(
                color: const Color(0xFF888888),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Amount Input
            Container(
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
                children: [
                  TextFormField(
                    controller: _allocationController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1E1E2E),
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      prefixText: '\$ ',
                      prefixStyle: TextStyle(
                        color: const Color(0xFF6C5CE7),
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: '0.00',
                      hintStyle: TextStyle(
                        color: const Color(0xFFCCCCCC),
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
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
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter 0 to invite without initial funds',
                    style: TextStyle(
                      color: const Color(0xFF888888),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Role Selection Section
            Text(
              'Member Role',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose what permissions this member will have',
              style: TextStyle(
                color: const Color(0xFF888888),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Role Cards
            _buildRoleCard(
              role: 'member',
              icon: Icons.person_outline,
              title: 'Member',
              description: 'Can spend allocated funds and view their balance',
              features: [
                'Spend from allocated balance',
                'View transaction history',
                'Receive notifications',
              ],
            ),
            SizedBox(height: 12.h),
            _buildRoleCard(
              role: 'admin',
              icon: Icons.admin_panel_settings_outlined,
              title: 'Admin',
              description: 'Full access to manage the family account',
              features: [
                'All member permissions',
                'Add and remove members',
                'Allocate funds to members',
                'Modify spending limits',
              ],
            ),
            SizedBox(height: 40.h),

            // Continue Button
            _buildContinueButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C5CE7).withValues(alpha: 0.08)
              : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C5CE7)
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6C5CE7).withValues(alpha: 0.15)
                        : const Color(0xFFE0E0E0).withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? const Color(0xFF6C5CE7)
                        : const Color(0xFF888888),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF6C5CE7)
                              : const Color(0xFF1E1E2E),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          color: const Color(0xFF888888),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6C5CE7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  )
                else
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 2,
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(height: 16.h),
              Divider(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                height: 1,
              ),
              SizedBox(height: 16.h),
              ...features.map(
                (feature) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF6C5CE7),
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        feature,
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
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
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _submitStep,
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
    );
  }
}
