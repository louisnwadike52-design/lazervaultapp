import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 2: Allocation, Role & Spending Limits (consolidated)
/// - Initial allocation amount input
/// - Role selection: Member / Admin
/// - No Spending Limits toggle
/// - Daily / Monthly / Per-transaction limits (if limits enabled)
/// - Allocation percentage cap slider
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

  // Spending limits
  late bool _noLimits;
  late TextEditingController _dailyLimitController;
  late TextEditingController _monthlyLimitController;
  late TextEditingController _perTransactionLimitController;
  late double _allocationPercentageCap;

  @override
  void initState() {
    super.initState();
    final allocation = widget.formData['initialAllocation'] as double? ?? 0.0;
    _allocationController = TextEditingController(
      text: allocation > 0 ? allocation.toStringAsFixed(2) : '',
    );
    _selectedRole = widget.formData['role'] as String? ?? 'member';

    _noLimits = widget.formData['noLimits'] as bool? ?? true;

    final dailyLimit = widget.formData['dailyLimit'] as double? ?? 0.0;
    final monthlyLimit = widget.formData['monthlyLimit'] as double? ?? 0.0;
    final perTxnLimit = widget.formData['perTransactionLimit'] as double? ?? 0.0;

    _dailyLimitController = TextEditingController(
      text: dailyLimit > 0 ? dailyLimit.toStringAsFixed(2) : '',
    );
    _monthlyLimitController = TextEditingController(
      text: monthlyLimit > 0 ? monthlyLimit.toStringAsFixed(2) : '',
    );
    _perTransactionLimitController = TextEditingController(
      text: perTxnLimit > 0 ? perTxnLimit.toStringAsFixed(2) : '',
    );
    _allocationPercentageCap =
        widget.formData['allocationPercentageCap'] as double? ?? 100.0;
  }

  @override
  void dispose() {
    _allocationController.dispose();
    _dailyLimitController.dispose();
    _monthlyLimitController.dispose();
    _perTransactionLimitController.dispose();
    super.dispose();
  }

  void _submitStep() {
    if (_formKey.currentState!.validate()) {
      widget.onNext({
        'initialAllocation':
            double.tryParse(_allocationController.text) ?? 0.0,
        'role': _selectedRole,
        'noLimits': _noLimits,
        'dailyLimit': _noLimits
            ? 0.0
            : (double.tryParse(_dailyLimitController.text) ?? 0.0),
        'monthlyLimit': _noLimits
            ? 0.0
            : (double.tryParse(_monthlyLimitController.text) ?? 0.0),
        'perTransactionLimit': _noLimits
            ? 0.0
            : (double.tryParse(_perTransactionLimitController.text) ?? 0.0),
        'allocationPercentageCap':
            _noLimits ? 100.0 : _allocationPercentageCap,
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
              'Set allocation, role\n& limits',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Configure how much they can access and spend',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 24.h),

            // --- Initial Allocation ---
            _buildSectionLabel('Initial Allocation'),
            SizedBox(height: 4.h),
            Text(
              'Amount to allocate from the family pool',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
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
                      color: Colors.white,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      prefixText: '\$ ',
                      prefixStyle: TextStyle(
                        color: const Color(0xFF3B82F6),
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
                  SizedBox(height: 4.h),
                  Text(
                    'Enter 0 to invite without initial funds',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // --- Role Selection ---
            _buildSectionLabel('Member Role'),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildCompactRoleCard(
                    role: 'member',
                    icon: Icons.person_outline,
                    title: 'Member',
                    subtitle: 'Can spend & view balance',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildCompactRoleCard(
                    role: 'admin',
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'Admin',
                    subtitle: 'Full management access',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // --- Spending Limits ---
            _buildSectionLabel('Spending Limits'),
            SizedBox(height: 12.h),

            // No Limits Toggle
            GestureDetector(
              onTap: () => setState(() => _noLimits = !_noLimits),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: _noLimits
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.08)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _noLimits
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF2D2D2D),
                    width: _noLimits ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.all_inclusive,
                      color: _noLimits
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF9CA3AF),
                      size: 22.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'No Spending Limits',
                        style: TextStyle(
                          color: _noLimits
                              ? const Color(0xFF3B82F6)
                              : Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Switch(
                      value: _noLimits,
                      onChanged: (v) => setState(() => _noLimits = v),
                      activeThumbColor: const Color(0xFF3B82F6),
                    ),
                  ],
                ),
              ),
            ),

            // Limit fields (shown only when limits enabled)
            if (!_noLimits) ...[
              SizedBox(height: 16.h),
              _buildLimitInput(
                controller: _dailyLimitController,
                icon: Icons.today_outlined,
                label: 'Daily Limit',
              ),
              SizedBox(height: 12.h),
              _buildLimitInput(
                controller: _monthlyLimitController,
                icon: Icons.calendar_month_outlined,
                label: 'Monthly Limit',
              ),
              SizedBox(height: 12.h),
              _buildLimitInput(
                controller: _perTransactionLimitController,
                icon: Icons.payment_outlined,
                label: 'Per-Transaction Limit',
              ),
              SizedBox(height: 16.h),

              // Allocation Percentage Cap
              Text(
                'Allocation Cap: ${_allocationPercentageCap.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Maximum percentage of total pool this member can have',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 8.h),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: const Color(0xFF3B82F6),
                  inactiveTrackColor: const Color(0xFF2D2D2D),
                  thumbColor: const Color(0xFF3B82F6),
                  overlayColor:
                      const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  trackHeight: 6.h,
                  thumbShape:
                      RoundSliderThumbShape(enabledThumbRadius: 10.r),
                ),
                child: Slider(
                  value: _allocationPercentageCap,
                  min: 1,
                  max: 100,
                  divisions: 99,
                  onChanged: (value) {
                    setState(() => _allocationPercentageCap = value);
                  },
                ),
              ),
            ],
            SizedBox(height: 32.h),

            // Continue Button
            _buildContinueButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCompactRoleCard({
    required String role,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.08)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                    : const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF9CA3AF),
                size: 22.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              SizedBox(height: 6.h),
              Icon(
                Icons.check_circle,
                color: const Color(0xFF3B82F6),
                size: 18.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLimitInput({
    required TextEditingController controller,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3B82F6), size: 20.sp),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 100.w,
            child: TextFormField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 14.sp,
                ),
                hintText: '0',
                hintStyle: TextStyle(
                  color: const Color(0xFFCCCCCC),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
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
