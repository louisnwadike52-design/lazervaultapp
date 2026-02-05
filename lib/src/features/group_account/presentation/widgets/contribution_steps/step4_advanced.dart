import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/group_entities.dart';
import '../../cubit/create_contribution_cubit.dart';
import '../../cubit/create_contribution_state.dart';

/// Step 4: Advanced Settings with collapsible optional fields
class Step4Advanced extends StatefulWidget {
  const Step4Advanced({super.key});

  @override
  State<Step4Advanced> createState() => _Step4AdvancedState();
}

class _Step4AdvancedState extends State<Step4Advanced> {
  late TextEditingController _penaltyAmountController;
  late TextEditingController _gracePeriodController;
  late TextEditingController _minimumBalanceController;

  // Track which optional fields are visible
  bool _showPenaltyFields = false;
  bool _showMinimumBalance = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateContributionCubit>();
    _penaltyAmountController = TextEditingController(
      text: cubit.penaltyAmount?.toStringAsFixed(2) ?? '',
    );
    _gracePeriodController = TextEditingController(
      text: cubit.gracePeriodDays?.toString() ?? '',
    );
    _minimumBalanceController = TextEditingController(
      text: cubit.minimumBalance?.toStringAsFixed(2) ?? '',
    );

    // Show fields if they have values
    _showPenaltyFields = cubit.penaltyAmount != null || cubit.gracePeriodDays != null;
    _showMinimumBalance = cubit.minimumBalance != null;
  }

  @override
  void dispose() {
    _penaltyAmountController.dispose();
    _gracePeriodController.dispose();
    _minimumBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContributionCubit, CreateContributionState>(
      builder: (context, state) {
        final cubit = context.read<CreateContributionCubit>();
        final formState = state is CreateContributionFormUpdated ? state : null;
        final isRotatingSavings = formState?.type == ContributionType.rotatingSavings;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Advanced Settings',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Fine-tune your contribution settings',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 32.h),

              // Core Settings Section
              _buildSectionTitle('Core Settings'),
              SizedBox(height: 16.h),

              // Auto-Pay Switch
              _buildSwitchTile(
                title: 'Auto-Pay',
                subtitle: isRotatingSavings
                    ? 'Disabled for rotating savings transparency'
                    : 'Automatically process payments when due',
                value: formState?.autoPayEnabled ?? false,
                enabled: !isRotatingSavings,
                onChanged: (value) => cubit.updateAutoPayEnabled(value),
                icon: Icons.payment,
              ),
              SizedBox(height: 12.h),

              // Allow Partial Payments Switch
              _buildSwitchTile(
                title: 'Allow Partial Payments',
                subtitle: 'Members can pay less than the full amount',
                value: formState?.allowPartialPayments ?? true,
                enabled: true,
                onChanged: (value) => cubit.updateAllowPartialPayments(value),
                icon: Icons.pie_chart_outline,
              ),

              SizedBox(height: 32.h),

              // Optional Fields Section
              _buildSectionTitle('Additional Options'),
              SizedBox(height: 8.h),
              Text(
                'Click to add more configuration options',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 16.h),

              // Pills for Optional Fields
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _buildOptionPill(
                    label: 'Late Payment Penalty',
                    icon: Icons.warning_amber_outlined,
                    isActive: _showPenaltyFields,
                    onTap: () {
                      setState(() {
                        _showPenaltyFields = !_showPenaltyFields;
                        if (!_showPenaltyFields) {
                          cubit.updatePenaltyAmount(null);
                          cubit.updateGracePeriodDays(null);
                          _penaltyAmountController.clear();
                          _gracePeriodController.clear();
                        }
                      });
                    },
                  ),
                  _buildOptionPill(
                    label: 'Minimum Balance',
                    icon: Icons.account_balance_wallet_outlined,
                    isActive: _showMinimumBalance,
                    onTap: () {
                      setState(() {
                        _showMinimumBalance = !_showMinimumBalance;
                        if (!_showMinimumBalance) {
                          cubit.updateMinimumBalance(null);
                          _minimumBalanceController.clear();
                        }
                      });
                    },
                  ),
                ],
              ),

              // Penalty Fields (collapsible)
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: _showPenaltyFields
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _buildPenaltySection(cubit),
                secondChild: const SizedBox.shrink(),
              ),

              // Minimum Balance Field (collapsible)
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: _showMinimumBalance
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _buildMinimumBalanceSection(cubit),
                secondChild: const SizedBox.shrink(),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: (enabled && value)
                  ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: (enabled && value)
                  ? const Color(0xFF6366F1)
                  : Colors.grey[500],
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
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: enabled ? Colors.white : Colors.grey[500],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: const Color(0xFF6366F1),
            activeTrackColor: const Color(0xFF6366F1).withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionPill({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF6366F1).withValues(alpha: 0.2)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isActive ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? Icons.check_circle : icon,
              color: isActive ? const Color(0xFF6366F1) : Colors.grey[400],
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? const Color(0xFF6366F1) : Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPenaltySection(CreateContributionCubit cubit) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: const Color(0xFFF59E0B),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Late Payment Penalty',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penalty Amount',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _buildAmountField(
                      controller: _penaltyAmountController,
                      hint: '0.00',
                      onChanged: (value) {
                        final amount = double.tryParse(value);
                        cubit.updatePenaltyAmount(amount);
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
                    Text(
                      'Grace Period (Days)',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _buildIntegerField(
                      controller: _gracePeriodController,
                      hint: '0',
                      onChanged: (value) {
                        final days = int.tryParse(value);
                        cubit.updateGracePeriodDays(days);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMinimumBalanceSection(CreateContributionCubit cubit) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: const Color(0xFF10B981),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Minimum Balance for Payout',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Minimum amount that must be collected before any payout can occur',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 12.h),
          _buildAmountField(
            controller: _minimumBalanceController,
            hint: '0.00',
            onChanged: (value) {
              final amount = double.tryParse(value);
              cubit.updateMinimumBalance(amount);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        color: Colors.white,
      ),
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildIntegerField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        color: Colors.white,
      ),
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }
}
