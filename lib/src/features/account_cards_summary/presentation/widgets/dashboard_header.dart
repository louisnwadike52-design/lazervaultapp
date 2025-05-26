import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/presentation/views/notification_screen.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class DashboardHeader extends StatelessWidget {
  final User? currentUser; // Accept optional user data

  const DashboardHeader({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
     // Use user?.avatar or similar if available, otherwise fallback
    final profileImagePath = /* currentUser?.avatar ?? */ AppData.dp; // Placeholder until avatar is available

    return Row(
      children: [
        // Profile Picture
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: UniversalImageLoader(
              imagePath: profileImagePath,
              height: 40.h,
              width: 40.w,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Search Bar
        Expanded(
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search transactions',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.white.withOpacity(0.5),
                  size: 20.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h, 
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Action Icons
        _buildIconButton(Icons.notifications_outlined, context),
        SizedBox(width: 12.w),
        _buildIconButton(Icons.mic_rounded, context),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20.sp),
        onPressed: () {
          if (icon == Icons.notifications_outlined) {
            _showNotifications(context);
          } else if (icon == Icons.mic_rounded) {
            _showVoiceCommandSheet(context);
          }
        },
        padding: EdgeInsets.zero, 
        constraints: const BoxConstraints(), 
      ),
    );
  }

  void _showNotifications(BuildContext context) {
     Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              const Expanded(
                child: NotificationScreen(),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );
  }

  void _showVoiceCommandSheet(BuildContext context) {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }
} 