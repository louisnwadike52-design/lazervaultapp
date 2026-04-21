import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';

/// Pending screen for VTU Africa airtime-to-cash conversion.
/// Shown while waiting for webhook confirmation after airtime transfer.
class AirtimeToCashPendingScreen extends StatefulWidget {
  const AirtimeToCashPendingScreen({super.key});

  @override
  State<AirtimeToCashPendingScreen> createState() =>
      _AirtimeToCashPendingScreenState();
}

class _AirtimeToCashPendingScreenState
    extends State<AirtimeToCashPendingScreen> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final message = args['message'] as String? ?? 'Processing your conversion...';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated loader
                      _buildAnimatedLoader(),
                      SizedBox(height: 32.h),
                      // Title
                      Text(
                        'Transfer Received',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Message
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'This usually takes 2-5 minutes.',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF4E03D0),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // Info card
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: const Color(0xFF9CA3AF),
                                  size: 18.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'What happens next?',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            _buildStep('1', 'VTU Africa verifies the airtime transfer'),
                            SizedBox(height: 8.h),
                            _buildStep('2', 'Webhook confirms successful conversion'),
                            SizedBox(height: 8.h),
                            _buildStep('3', 'Your wallet is credited automatically'),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // Note
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_none,
                              color: const Color(0xFF4E03D0),
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'You will receive a notification when your wallet is credited.',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // Home button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          // "Wait in Background" takes the user back to
                          // where they started the A2C flow — the airtime
                          // landing under utilities. offNamedUntil with
                          // route.isFirst pops to the navigator root and
                          // pushes the airtime landing, keeping the home
                          // dashboard in the stack so the system back
                          // gesture and tab navigation stay sensible.
                          // offAllNamed('/home') previously landed on the
                          // onboarding shell when /home wasn't registered.
                          onPressed: () => Get.offNamedUntil(
                            AppRoutes.airtime,
                            (route) => route.isFirst,
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF9CA3AF),
                            side: const BorderSide(color: Color(0xFF2D2D2D)),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          child: Text(
                            'Wait in Background',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLoader() {
    return SizedBox(
      width: 100.w,
      height: 100.w,
      child: Stack(
        children: [
          // Outer ring
          SizedBox(
            width: 100.w,
            height: 100.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFF4E03D0).withValues(alpha: 0.3),
              ),
            ),
          ),
          // Inner icon
          Center(
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.hourglass_empty,
                color: const Color(0xFF4E03D0),
                size: 30.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4E03D0),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
