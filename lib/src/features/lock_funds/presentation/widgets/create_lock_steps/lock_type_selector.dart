import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/lock_fund_entity.dart';
import '../../cubit/create_lock_cubit.dart';

/// Lock type selection screen - Step 1 of 5
///
/// Displays rates dynamically from backend PiggyVault configs.
/// Falls back to hardcoded enum values when backend is unavailable.
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
                'Select a PiggyVault that suits your financial goals',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),
              // Build cards dynamically from available lock types
              // Only show active types from backend config
              for (final entry in [
                (LockType.savings, Icons.savings_rounded, false),
                (LockType.investment, Icons.trending_up_rounded, true),
                (LockType.emergencyFund, Icons.emergency_rounded, false),
                (LockType.goalBased, Icons.flag_rounded, false),
              ]) ...[
                if (cubit.isTypeActive(entry.$1))
                  _buildLockTypeCard(
                    context: context,
                    lockType: entry.$1,
                    icon: entry.$2,
                    // All display values come from cubit (backend config → fallback)
                    title: cubit.getDisplayName(entry.$1),
                    description: cubit.getDescription(entry.$1),
                    baseRate: cubit.getBaseRate(entry.$1),
                    maxRate: cubit.getMaxRate(entry.$1),
                    isPremium: entry.$3,
                    isSelected: selectedType == entry.$1,
                    onTap: () => cubit.updateLockType(entry.$1),
                  ),
                if (cubit.isTypeActive(entry.$1))
                  SizedBox(height: 16.h),
              ],
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
    double? maxRate,
    bool isPremium = false,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final rateText = maxRate != null && maxRate != baseRate
        ? '${baseRate.toStringAsFixed(0)}-${maxRate.toStringAsFixed(0)}%'
        : '${baseRate.toStringAsFixed(0)}%';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)]
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
                            color: isPremium
                                ? const Color(0xFFF59E0B).withValues(alpha: isSelected ? 0.3 : 0.2)
                                : const Color(0xFF10B981).withValues(alpha: isSelected ? 0.3 : 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '$rateText p.a.',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: isPremium
                                  ? const Color(0xFFF59E0B)
                                  : const Color(0xFF10B981),
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
