import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';

class EnableBiometricVerification extends StatefulWidget {
  const EnableBiometricVerification({super.key});

  @override
  State<EnableBiometricVerification> createState() =>
      _EnableBiometricVerificationState();
}

class _EnableBiometricVerificationState
    extends State<EnableBiometricVerification>
    with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();

  // Existing fields
  double scanProgress = 0.0;
  bool isScanning = false;
  late AnimationController _controller;
  bool isPasswordObscured = true;

  // Updated field: Use TextEditingController instead of an immutable String
  final TextEditingController _passcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _passcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.only(top: responsiveController.screenHeight * 0.2),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Enable Biometric Access',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColors.primaryFont,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        textAlign: TextAlign.center,
                        'Login quickly and securely with the fingerprint stored on this device',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                          color: AppColors.secondaryFont,
                        ),
                      ),
                      SizedBox(height: 50.0.h),
                      Center(
                        child: UniversalImageLoader(
                          imagePath: 'assets/images/enable-fingerprint.png',
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsiveController.screenHeight * 0.2),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 32.0,
                      ),
                      minimumSize: Size(double.infinity, 36.h),
                    ),
                    onPressed: () =>
                        Get.toNamed(AppRoutes.facialBiometricVerification),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  TextButton(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.facialBiometricVerification),
                    child: Text("I'll do this later",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
