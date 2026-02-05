import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/group_entities.dart';
import '../../cubit/create_contribution_cubit.dart';
import '../../cubit/create_contribution_state.dart';

/// Step 5: Review all entered data before submission
class Step5Review extends StatelessWidget {
  const Step5Review({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContributionCubit, CreateContributionState>(
      builder: (context, state) {
        final cubit = context.read<CreateContributionCubit>();
        final formState = state is CreateContributionFormUpdated ? state : null;

        if (formState == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review Contribution',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please review the details before creating',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 32.h),

              // Type Section
              _buildReviewSection(
                title: 'Contribution Type',
                icon: Icons.category,
                iconColor: const Color(0xFF3B82F6),
                children: [
                  _buildReviewItem('Type', formState.type.displayName),
                ],
              ),
              SizedBox(height: 20.h),

              // Details Section
              _buildReviewSection(
                title: 'Details',
                icon: Icons.info_outline,
                iconColor: const Color(0xFF8B5CF6),
                children: [
                  _buildReviewItem('Title', formState.title),
                  _buildReviewItem('Description', formState.description, isLong: true),
                  _buildReviewItem(
                    'Target Amount',
                    '${formState.currency} ${_formatAmount(formState.targetAmount ?? 0)}',
                  ),
                  _buildReviewItem(
                    'Deadline',
                    DateFormat('MMM dd, yyyy').format(formState.deadline),
                  ),
                ],
              ),

              // Schedule Section (only for non-one-time)
              if (formState.type != ContributionType.oneTime) ...[
                SizedBox(height: 20.h),
                _buildReviewSection(
                  title: 'Payment Schedule',
                  icon: Icons.schedule,
                  iconColor: const Color(0xFF10B981),
                  children: [
                    _buildReviewItem(
                      'Frequency',
                      formState.frequency?.displayName ?? 'Not set',
                    ),
                    _buildReviewItem(
                      'Regular Amount',
                      formState.regularAmount != null
                          ? '${formState.currency} ${_formatAmount(formState.regularAmount!)}'
                          : 'Not set',
                    ),
                    if (formState.startDate != null)
                      _buildReviewItem(
                        'Start Date',
                        DateFormat('MMM dd, yyyy').format(formState.startDate!),
                      ),
                    if (formState.totalCycles != null)
                      _buildReviewItem(
                        'Total Cycles',
                        formState.totalCycles.toString(),
                      ),
                  ],
                ),
              ],

              // Payout Rotation (only for rotating savings)
              if (formState.type == ContributionType.rotatingSavings &&
                  formState.memberRotationOrder.isNotEmpty) ...[
                SizedBox(height: 20.h),
                _buildReviewSection(
                  title: 'Payout Rotation',
                  icon: Icons.sync,
                  iconColor: const Color(0xFFF59E0B),
                  children: [
                    _buildRotationList(cubit, formState.memberRotationOrder),
                  ],
                ),
              ],

              // Settings Section
              SizedBox(height: 20.h),
              _buildReviewSection(
                title: 'Settings',
                icon: Icons.settings,
                iconColor: const Color(0xFF6366F1),
                children: [
                  _buildReviewItem(
                    'Auto-Pay',
                    formState.autoPayEnabled ? 'Enabled' : 'Disabled',
                    valueColor: formState.autoPayEnabled
                        ? const Color(0xFF10B981)
                        : Colors.grey[400],
                  ),
                  _buildReviewItem(
                    'Partial Payments',
                    formState.allowPartialPayments ? 'Allowed' : 'Not Allowed',
                    valueColor: formState.allowPartialPayments
                        ? const Color(0xFF10B981)
                        : Colors.grey[400],
                  ),
                  if (formState.penaltyAmount != null)
                    _buildReviewItem(
                      'Late Penalty',
                      '${formState.currency} ${_formatAmount(formState.penaltyAmount!)}',
                    ),
                  if (formState.gracePeriodDays != null)
                    _buildReviewItem(
                      'Grace Period',
                      '${formState.gracePeriodDays} days',
                    ),
                  if (formState.minimumBalance != null)
                    _buildReviewItem(
                      'Min Balance for Payout',
                      '${formState.currency} ${_formatAmount(formState.minimumBalance!)}',
                    ),
                ],
              ),

              SizedBox(height: 40.h),

              // Confirmation Note
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: const Color(0xFF10B981),
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'All details look good! Click "Create Contribution" to continue.',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF10B981),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReviewSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFF2D2D2D),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(
    String label,
    String value, {
    bool isLong = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: isLong
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: valueColor ?? Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: valueColor ?? Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRotationList(
    CreateContributionCubit cubit,
    List<String> memberOrder,
  ) {
    final groupMembers = cubit.groupMembers;

    return Column(
      children: memberOrder.asMap().entries.map((entry) {
        final index = entry.key;
        final userId = entry.value;
        final member = groupMembers.firstWhere(
          (m) => m.userId == userId,
          orElse: () => groupMembers.first,
        );

        return Padding(
          padding: EdgeInsets.only(bottom: index < memberOrder.length - 1 ? 8.h : 0),
          child: Row(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              CircleAvatar(
                radius: 14.r,
                backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.3),
                child: Text(
                  member.userName.isNotEmpty
                      ? member.userName[0].toUpperCase()
                      : 'U',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  member.userName,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              if (index == 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'First',
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }
}
