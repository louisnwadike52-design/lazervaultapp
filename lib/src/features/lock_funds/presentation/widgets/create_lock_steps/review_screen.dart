import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/lock_fund_entity.dart';
import '../../cubit/create_lock_cubit.dart';
import '../../cubit/lock_funds_cubit.dart';
import '../../cubit/lock_funds_state.dart';

/// Review screen - Step 4 of 5
///
/// Shows all selected details with interest calculation breakdown
/// Allows toggling auto-renew option
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, createState) {
        final cubit = context.read<CreateLockCubit>();
        final lockType = cubit.lockType;
        final amount = cubit.amount;
        final currency = cubit.currency;
        final durationDays = cubit.lockDurationDays;
        final autoRenew = cubit.autoRenew;
        final goalName = cubit.goalName;
        final goalDescription = cubit.goalDescription;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review Your Lock',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Review all details before proceeding to payment',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),

              // Lock Details Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            _getLockTypeIcon(lockType),
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lockType?.displayName ?? 'Unknown',
                                style: GoogleFonts.inter(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              if (goalName != null)
                                Text(
                                  goalName,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF6366F1),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (goalDescription != null) ...[
                      SizedBox(height: 12.h),
                      Text(
                        goalDescription,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    Divider(color: Colors.white.withValues(alpha: 0.1)),
                    SizedBox(height: 16.h),
                    _buildDetailRow('Lock Amount', '$currency ${amount?.toStringAsFixed(2)}'),
                    SizedBox(height: 12.h),
                    _buildDetailRow(
                      'Lock Duration',
                      '$durationDays ${durationDays == 1 ? 'day' : 'days'}',
                    ),
                    SizedBox(height: 12.h),
                    _buildDetailRow(
                      'Maturity Date',
                      DateFormat('MMM dd, yyyy').format(
                        DateTime.now().add(Duration(days: durationDays ?? 0)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Interest Calculation Card
              BlocBuilder<LockFundsCubit, LockFundsState>(
                builder: (context, lockState) {
                  if (lockState is InterestCalculated) {
                    final calc = lockState.calculation;
                    return Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF10B981).withValues(alpha: 0.2),
                            const Color(0xFF10B981).withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calculate_rounded,
                                color: const Color(0xFF10B981),
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Interest Breakdown',
                                style: GoogleFonts.inter(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          _buildCalculationRow(
                            'Principal Amount',
                            '$currency ${calc.principalAmount.toStringAsFixed(2)}',
                          ),
                          SizedBox(height: 12.h),
                          _buildCalculationRow(
                            'Interest Rate',
                            '${calc.interestRate.toStringAsFixed(2)}% APY',
                          ),
                          SizedBox(height: 12.h),
                          _buildCalculationRow(
                            'Duration',
                            '$durationDays ${durationDays == 1 ? 'day' : 'days'}',
                          ),
                          SizedBox(height: 12.h),
                          _buildCalculationRow(
                            'Interest Earned',
                            '$currency ${calc.interestAmount.toStringAsFixed(2)}',
                            valueColor: const Color(0xFF10B981),
                          ),
                          SizedBox(height: 16.h),
                          Divider(color: Colors.white.withValues(alpha: 0.2)),
                          SizedBox(height: 16.h),
                          _buildCalculationRow(
                            'Total at Maturity',
                            '$currency ${calc.totalAmount.toStringAsFixed(2)}',
                            isTotal: true,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 20.h),

              // Auto-Renew Toggle
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: autoRenew
                            ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.repeat_rounded,
                        color: autoRenew ? const Color(0xFF6366F1) : const Color(0xFF9CA3AF),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Auto-Renew',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Automatically renew this lock when it matures',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: autoRenew,
                      onChanged: (value) {
                        cubit.updateAutoRenew(value);
                      },
                      activeColor: const Color(0xFF6366F1),
                      activeTrackColor: const Color(0xFF6366F1).withValues(alpha: 0.5),
                      inactiveThumbColor: const Color(0xFF9CA3AF),
                      inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Important Notes
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: const Color(0xFFF59E0B),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Important Notes',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF59E0B),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    _buildNoteItem('Funds will be locked until the maturity date'),
                    _buildNoteItem('Early withdrawal may incur penalties'),
                    _buildNoteItem('Interest is calculated daily and compounded'),
                    if (autoRenew)
                      _buildNoteItem('Lock will automatically renew at maturity'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getLockTypeIcon(LockType? type) {
    switch (type) {
      case LockType.savings:
        return Icons.savings_rounded;
      case LockType.investment:
        return Icons.trending_up_rounded;
      case LockType.emergencyFund:
        return Icons.emergency_rounded;
      case LockType.goalBased:
        return Icons.flag_rounded;
      default:
        return Icons.lock_rounded;
    }
  }

  Widget _buildDetailRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value ?? 'N/A',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationRow(
    String label,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 20.sp : 14.sp,
            fontWeight: FontWeight.w700,
            color: valueColor ?? (isTotal ? const Color(0xFF10B981) : Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h),
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFF59E0B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
