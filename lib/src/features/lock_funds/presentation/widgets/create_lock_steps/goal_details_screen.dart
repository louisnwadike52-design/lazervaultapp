import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/lock_fund_entity.dart';
import '../../cubit/create_lock_cubit.dart';

/// Goal details screen - Step 3 of 5
///
/// Allows user to enter goal name and description (only for goal-based locks)
/// Can be skipped if lock type is not goal-based
class GoalDetailsScreen extends StatefulWidget {
  const GoalDetailsScreen({super.key});

  @override
  State<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends State<GoalDetailsScreen> {
  final TextEditingController _goalNameController = TextEditingController();
  final TextEditingController _goalDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateLockCubit>();
    if (cubit.goalName != null) {
      _goalNameController.text = cubit.goalName!;
    }
    if (cubit.goalDescription != null) {
      _goalDescriptionController.text = cubit.goalDescription!;
    }
  }

  @override
  void dispose() {
    _goalNameController.dispose();
    _goalDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, state) {
        final cubit = context.read<CreateLockCubit>();
        final isGoalBased = cubit.lockType == LockType.goalBased;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isGoalBased ? 'Set Your Goal' : 'Goal Details (Optional)',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                isGoalBased
                    ? 'Tell us about your financial goal to keep you motivated'
                    : 'You can skip this step or add a goal for motivation',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 32.h),

              // Goal Icon Illustration
              Center(
                child: Container(
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6366F1).withValues(alpha: 0.2),
                        const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Icon(
                    Icons.flag_rounded,
                    size: 64.sp,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Goal Name Input
              Text(
                'Goal Name ${isGoalBased ? '*' : '(Optional)'}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _goalNameController,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g., New Laptop, Vacation, Emergency Fund',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    icon: Icon(
                      Icons.edit_rounded,
                      color: const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                  ),
                  onChanged: (value) {
                    cubit.updateGoalName(value.isNotEmpty ? value : null);
                  },
                ),
              ),
              SizedBox(height: 24.h),

              // Goal Description Input
              Text(
                'Description (Optional)',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _goalDescriptionController,
                  maxLines: 5,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        'Add more details about your goal to stay motivated...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  onChanged: (value) {
                    cubit.updateGoalDescription(value.isNotEmpty ? value : null);
                  },
                ),
              ),
              SizedBox(height: 24.h),

              // Goal Suggestions
              if (isGoalBased) ...[
                Text(
                  'Popular Goals',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [
                    _buildGoalSuggestion('Vacation Trip', Icons.flight_rounded),
                    _buildGoalSuggestion('New Laptop', Icons.laptop_rounded),
                    _buildGoalSuggestion('Emergency Fund', Icons.emergency_rounded),
                    _buildGoalSuggestion('New Phone', Icons.phone_iphone_rounded),
                    _buildGoalSuggestion('Home Upgrade', Icons.home_rounded),
                    _buildGoalSuggestion('Education', Icons.school_rounded),
                  ],
                ),
              ],

              if (!isGoalBased) ...[
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: const Color(0xFF6366F1),
                        size: 20.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Adding a goal can help you stay motivated!',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildGoalSuggestion(String name, IconData icon) {
    return GestureDetector(
      onTap: () {
        _goalNameController.text = name;
        context.read<CreateLockCubit>().updateGoalName(name);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: const Color(0xFF6366F1),
            ),
            SizedBox(width: 8.w),
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
