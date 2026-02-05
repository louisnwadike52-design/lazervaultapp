import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/group_entities.dart';
import '../../cubit/create_contribution_cubit.dart';
import '../../cubit/create_contribution_state.dart';

/// Step 1: Contribution Type Selection
class Step1TypeSelection extends StatelessWidget {
  const Step1TypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContributionCubit, CreateContributionState>(
      builder: (context, state) {
        final selectedType = state is CreateContributionFormUpdated
            ? state.type
            : ContributionType.oneTime;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What type of contribution?',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose the type that best fits your group\'s needs',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 32.h),
              ...ContributionType.values.map(
                (type) => _buildTypeCard(context, type, selectedType),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypeCard(
    BuildContext context,
    ContributionType type,
    ContributionType selectedType,
  ) {
    final isSelected = type == selectedType;
    final cubit = context.read<CreateContributionCubit>();

    IconData icon;
    Color iconColor;
    switch (type) {
      case ContributionType.oneTime:
        icon = Icons.flag;
        iconColor = const Color(0xFF3B82F6);
        break;
      case ContributionType.rotatingSavings:
        icon = Icons.sync;
        iconColor = const Color(0xFF10B981);
        break;
      case ContributionType.investmentPool:
        icon = Icons.trending_up;
        iconColor = const Color(0xFFF59E0B);
        break;
      case ContributionType.recurringGoal:
        icon = Icons.repeat;
        iconColor = const Color(0xFF8B5CF6);
        break;
    }

    return GestureDetector(
      onTap: () => cubit.updateType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: isSelected
              ? iconColor.withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? iconColor : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: iconColor.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: isSelected ? 0.3 : 0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    type.description,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.grey[400],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: iconColor,
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
                height: 24.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
