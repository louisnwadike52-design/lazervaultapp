import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/dashboard/managers/voice_setup_manager.dart';

/// Voice Setup Banner
/// Displays a persistent banner on dashboard when voice setup is pending
/// Can be dismissed or clicked to navigate to setup
class VoiceSetupBanner extends StatelessWidget {
  final VoiceSetupManager setupManager;
  final VoidCallback onSetupTap;
  final VoidCallback? onDismiss;

  const VoiceSetupBanner({
    super.key,
    required this.setupManager,
    required this.onSetupTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VoiceSetupStatus>(
      future: setupManager.checkVoiceSetupStatus(),
      builder: (context, snapshot) {
        // Only show banner for pending status (not mandatory)
        if (snapshot.data == VoiceSetupStatus.pending) {
          return FutureBuilder<int>(
            future: setupManager.getSkipCount(),
            builder: (context, skipCountSnapshot) {
              final skipCount = skipCountSnapshot.data ?? 0;

              return Container(
                margin: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF6366F1),
                      const Color(0xFF8B5CF6),
                    ],
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onSetupTap,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          // Icon
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.mic_rounded,
                              color: Colors.white,
                              size: 26.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),

                          // Text content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Secure your account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Set up voice banking in 2 minutes',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (skipCount > 0) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    '$skipCount/3 reminders',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Setup button
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Setup',
                                  style: TextStyle(
                                    color: const Color(0xFF6366F1),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: const Color(0xFF6366F1),
                                  size: 18.sp,
                                ),
                              ],
                            ),
                          ),

                          // Dismiss button (if allowed)
                          if (onDismiss != null) ...[
                            SizedBox(width: 8.w),
                            IconButton(
                              onPressed: onDismiss,
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 20.sp,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(
                                minWidth: 32.w,
                                minHeight: 32.w,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        // Don't show banner for other statuses
        return const SizedBox.shrink();
      },
    );
  }
}
