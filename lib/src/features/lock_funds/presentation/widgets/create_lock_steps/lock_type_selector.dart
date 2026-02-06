import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/lock_fund_entity.dart';
import '../../cubit/create_lock_cubit.dart';

/// Lock type selection screen - Step 1 of 5
///
/// Allows user to select from 4 lock types with interest rates displayed
class LockTypeSelector extends StatelessWidget {
  const LockTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, state) {
        final cubit = context.read<CreateLockCubit>();
        final selectedType = cubit.lockType;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Lock Type',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Select the type of lock fund that suits your financial goals',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),
              _buildLockTypeCard(
                context: context,
                lockType: LockType.savings,
                icon: Icons.savings_rounded,
                title: 'Savings Lock',
                description: 'Safe and steady growth for your savings',
                baseRate: LockType.savings.baseInterestRate,
                isSelected: selectedType == LockType.savings,
                onTap: () => cubit.updateLockType(LockType.savings),
              ),
              SizedBox(height: 16.h),
              _buildLockTypeCard(
                context: context,
                lockType: LockType.investment,
                icon: Icons.trending_up_rounded,
                title: 'Investment Lock',
                description: 'Higher returns for long-term wealth building',
                baseRate: LockType.investment.baseInterestRate,
                isSelected: selectedType == LockType.investment,
                onTap: () => cubit.updateLockType(LockType.investment),
              ),
              SizedBox(height: 16.h),
              _buildLockTypeCard(
                context: context,
                lockType: LockType.emergencyFund,
                icon: Icons.emergency_rounded,
                title: 'Emergency Fund',
                description: 'Quick access with minimal penalty for emergencies',
                baseRate: LockType.emergencyFund.baseInterestRate,
                isSelected: selectedType == LockType.emergencyFund,
                onTap: () => cubit.updateLockType(LockType.emergencyFund),
              ),
              SizedBox(height: 16.h),
              _buildLockTypeCard(
                context: context,
                lockType: LockType.goalBased,
                icon: Icons.flag_rounded,
                title: 'Goal-Based Lock',
                description: 'Save for specific goals like vacation or gadgets',
                baseRate: LockType.goalBased.baseInterestRate,
                isSelected: selectedType == LockType.goalBased,
                onTap: () => cubit.updateLockType(LockType.goalBased),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLockTypeCard({
    required BuildContext context,
    required LockType lockType,
    required IconData icon,
    required String title,
    required String description,
    required double baseRate,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
                : [const Color(0xFF2A2A3E), const Color(0xFF1F1F35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: isSelected ? 20 : 16,
              offset: Offset(0, isSelected ? 10 : 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: isSelected ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 32.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981)
                                .withValues(alpha: isSelected ? 0.3 : 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '${baseRate.toStringAsFixed(1)}% APY',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.9)
                          : const Color(0xFF9CA3AF),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
