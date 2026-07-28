import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/plan_my_day_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/sprayme_home_screen.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';

// ─── Main Screen ───────────────────────────────────────────────────────────────
class NewLifestyleScreen extends StatefulWidget {
  /// Optional callback to switch the parent dashboard to a specific tab.
  final void Function(int tabIndex)? onSwitchTab;

  const NewLifestyleScreen({super.key, this.onSwitchTab});

  @override
  State<NewLifestyleScreen> createState() => _NewLifestyleScreenState();
}

class _NewLifestyleScreenState extends State<NewLifestyleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          children: [
            // Title row — support entry pinned to the header's top right.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lifestyle',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Celebrate together and stay on top of your day',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                // P2P messages → financial connections (Get.toNamed pushes it,
                // so Back returns here to Lifestyle).
                IconButton(
                  tooltip: 'Messages',
                  icon: Icon(
                    Icons.forum_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 24.sp,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Get.toNamed(AppRoutes.financialConnections);
                  },
                ),
                IconButton(
                  tooltip: 'Contact support',
                  icon: Icon(
                    Icons.support_agent_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 24.sp,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SupportTicketsScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // SprayMe entry banner
            _buildSprayMeBanner(),
            SizedBox(height: 16.h),

            // Plan My Day entry banner
            _buildPlanMyDayBanner(),

            // Bottom padding for nav bar
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  // ── SprayMe banner ─────────────────────────────────────────────────────────

  Widget _buildSprayMeBanner() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push<int>(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => serviceLocator<SprayMeCubit>(),
              child: const SprayMeHomeScreen(),
            ),
          ),
        ).then((tabIndex) {
          if (tabIndex != null && widget.onSwitchTab != null) {
            widget.onSwitchTab!(tabIndex);
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B00), Color(0xFFFF2D87)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B00).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lazerspray',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Spray money, send gifts & celebrate together in real-time',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '\u{1F389}',
                style: TextStyle(fontSize: 28.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Plan My Day banner ─────────────────────────────────────────────────────────

  Widget _buildPlanMyDayBanner() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => serviceLocator<PlanMyDayCubit>(),
              child: const PlanMyDayScreen(),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plan My Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Organize tasks, events & boost your productivity',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '\u{1F4C5}',
                style: TextStyle(fontSize: 28.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
